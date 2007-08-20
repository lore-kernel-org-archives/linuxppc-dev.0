Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E16A8DDE40
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:40:14 +1000 (EST)
Date: Mon, 20 Aug 2007 12:39:57 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 10/20] bootwrapper: Add CPM serial driver.
Message-ID: <20070820173957.GI30562@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This serial port is used on all 8xx, many 82xx, and some 85xx chips.

The driver requires that the port has already been set up by the firmware
and/or platform code.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/Makefile     |    3 +-
 arch/powerpc/boot/cpm-serial.c |  249 ++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/ops.h        |    1 +
 arch/powerpc/boot/serial.c     |    5 +
 4 files changed, 257 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/cpm-serial.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 61a6f34..997980f 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -44,7 +44,8 @@ $(addprefix $(obj)/,$(zlib) gunzip_util.o main.o): \
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
-		44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c
+		44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c \
+		cpm-serial.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c
diff --git a/arch/powerpc/boot/cpm-serial.c b/arch/powerpc/boot/cpm-serial.c
new file mode 100644
index 0000000..fcb8b5e
--- /dev/null
+++ b/arch/powerpc/boot/cpm-serial.c
@@ -0,0 +1,249 @@
+/*
+ * CPM serial console support.
+ *
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * It is assumed that the firmware (or the platform file) has already set
+ * up the port.
+ */
+
+#include "types.h"
+#include "io.h"
+#include "ops.h"
+
+struct cpm_scc {
+	u32 gsmrl;
+	u32 gsmrh;
+	u16 psmr;
+	u8 res1[2];
+	u16 todr;
+	u16 dsr;
+	u16 scce;
+	u8 res2[2];
+	u16 sccm;
+	u8 res3;
+	u8 sccs;
+	u8 res4[8];
+};
+
+struct cpm_smc {
+	u8 res1[2];
+	u16 smcmr;
+	u8 res2[2];
+	u8 smce;
+	u8 res3[3];
+	u8 smcm;
+	u8 res4[5];
+};
+
+struct cpm_param {
+	u16 rbase;
+	u16 tbase;
+	u8 rfcr;
+	u8 tfcr;
+};
+
+struct cpm_bd {
+	u16 sc;   /* Status and Control */
+	u16 len;  /* Data length in buffer */
+	u8 *addr; /* Buffer address in host memory */
+};
+
+static void *cpcr;
+static struct cpm_param *param;
+static struct cpm_smc *smc;
+static struct cpm_scc *scc;
+struct cpm_bd *tbdf, *rbdf;
+static u32 cpm_cmd;
+static u8 *dpram_start;
+
+static void (*do_cmd)(int op);
+static void (*enable_port)(void);
+static void (*disable_port)(void);
+
+#define CPM_CMD_STOP_TX     4
+#define CPM_CMD_RESTART_TX  6
+#define CPM_CMD_INIT_RX_TX  0
+
+static void cpm1_cmd(int op)
+{
+	while (in_be16(cpcr) & 1)
+		;
+
+	out_be16(cpcr, (op << 8) | cpm_cmd | 1);
+
+	while (in_be16(cpcr) & 1)
+		;
+}
+
+static void cpm2_cmd(int op)
+{
+	while (in_be32(cpcr) & 0x10000)
+		;
+
+	out_be32(cpcr, op | cpm_cmd | 0x10000);
+
+	while (in_be32(cpcr) & 0x10000)
+		;
+}
+
+static void smc_disable_port(void)
+{
+	do_cmd(CPM_CMD_STOP_TX);
+	out_be16(&smc->smcmr, in_be16(&smc->smcmr) & ~3);
+}
+
+static void scc_disable_port(void)
+{
+	do_cmd(CPM_CMD_STOP_TX);
+	out_be32(&scc->gsmrl, in_be32(&scc->gsmrl) & ~0x30);
+}
+
+static void smc_enable_port(void)
+{
+	out_be16(&smc->smcmr, in_be16(&smc->smcmr) | 3);
+	do_cmd(CPM_CMD_RESTART_TX);
+}
+
+static void scc_enable_port(void)
+{
+	out_be32(&scc->gsmrl, in_be32(&scc->gsmrl) | 0x30);
+	do_cmd(CPM_CMD_RESTART_TX);
+}
+
+static int cpm_serial_open(void)
+{
+	int dpaddr = 0x800;
+	disable_port();
+
+	out_8(&param->rfcr, 0x10);
+	out_8(&param->tfcr, 0x10);
+
+	rbdf = (struct cpm_bd *)(dpram_start + dpaddr);
+	rbdf->addr = (u8 *)(rbdf + 2);
+	rbdf->sc = 0xa000;
+	rbdf->len = 1;
+
+	tbdf = rbdf + 1;
+	tbdf->addr = (u8 *)(rbdf + 2) + 1;
+	tbdf->sc = 0x2000;
+	tbdf->len = 1;
+
+	sync();
+	out_be16(&param->rbase, dpaddr);
+	out_be16(&param->tbase, dpaddr + sizeof(struct cpm_bd));
+
+	do_cmd(CPM_CMD_INIT_RX_TX);
+
+	enable_port();
+	return 0;
+}
+
+static void cpm_serial_putc(unsigned char c)
+{
+	while (tbdf->sc & 0x8000)
+		barrier();
+
+	sync();
+
+	tbdf->addr[0] = c;
+	eieio();
+	tbdf->sc |= 0x8000;
+}
+
+static unsigned char cpm_serial_tstc(void)
+{
+	barrier();
+	return !(rbdf->sc & 0x8000);
+}
+
+static unsigned char cpm_serial_getc(void)
+{
+	unsigned char c;
+
+	while (!cpm_serial_tstc())
+		;
+
+	sync();
+	c = rbdf->addr[0];
+	eieio();
+	rbdf->sc |= 0x8000;
+
+	return c;
+}
+
+int cpm_console_init(void *devp, struct serial_console_data *scdp)
+{
+	void *reg_virt[2];
+	int is_smc = 0, is_cpm2 = 0, n;
+	unsigned long reg_phys;
+	void *parent;
+
+	if (dt_is_compatible(devp, "fsl,cpm1-smc-uart")) {
+		is_smc = 1;
+	} else if (dt_is_compatible(devp, "fsl,cpm2-scc-uart")) {
+		is_cpm2 = 1;
+	} else if (dt_is_compatible(devp, "fsl,cpm2-smc-uart")) {
+		is_cpm2 = 1;
+		is_smc = 1;
+	}
+
+	if (is_smc) {
+		enable_port = smc_enable_port;
+		disable_port = smc_disable_port;
+	} else {
+		enable_port = scc_enable_port;
+		disable_port = scc_disable_port;
+	}
+
+	if (is_cpm2)
+		do_cmd = cpm2_cmd;
+	else
+		do_cmd = cpm1_cmd;
+
+	n = getprop(devp, "fsl,cpm-command", &cpm_cmd, 4);
+	if (n < 4)
+		return -1;
+
+	n = getprop(devp, "virtual-reg", reg_virt, sizeof(reg_virt));
+	if (n < (int)sizeof(reg_virt)) {
+		for (n = 0; n < 2; n++) {
+			if (!dt_xlate_reg(devp, n, &reg_phys, NULL))
+				return -1;
+
+			reg_virt[n] = (void *)reg_phys;
+		}
+	}
+
+	if (is_smc)
+		smc = reg_virt[0];
+	else
+		scc = reg_virt[0];
+
+	param = reg_virt[1];
+
+	parent = get_parent(devp);
+	if (!parent)
+		return -1;
+
+	n = getprop(parent, "virtual-reg", reg_virt, sizeof(reg_virt));
+	if (n < (int)sizeof(reg_virt)) {
+		for (n = 0; n < 2; n++) {
+			if (!dt_xlate_reg(parent, n, &reg_phys, NULL))
+				return -1;
+
+			reg_virt[n] = (void *)reg_phys;
+		}
+	}
+
+	cpcr = reg_virt[0];
+	dpram_start = reg_virt[1];
+
+	scdp->open = cpm_serial_open;
+	scdp->putc = cpm_serial_putc;
+	scdp->getc = cpm_serial_getc;
+	scdp->tstc = cpm_serial_tstc;
+
+	return 0;
+}
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index e45b364..2bc2f02 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -82,6 +82,7 @@ int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device);
 int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
 int mpsc_console_init(void *devp, struct serial_console_data *scdp);
+int cpm_console_init(void *devp, struct serial_console_data *scdp);
 void *simple_alloc_init(char *base, unsigned long heap_size,
 			unsigned long granularity, unsigned long max_allocs);
 extern void flush_cache(void *, unsigned long);
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index 944f0ee..d47f8e0 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -121,6 +121,11 @@ int serial_console_init(void)
 		rc = ns16550_console_init(devp, &serial_cd);
 	else if (dt_is_compatible(devp, "marvell,mpsc"))
 		rc = mpsc_console_init(devp, &serial_cd);
+	else if (dt_is_compatible(devp, "fsl,cpm1-scc-uart") ||
+	         dt_is_compatible(devp, "fsl,cpm1-smc-uart") ||
+	         dt_is_compatible(devp, "fsl,cpm2-scc-uart") ||
+	         dt_is_compatible(devp, "fsl,cpm2-smc-uart"))
+		rc = cpm_console_init(devp, &serial_cd);
 
 	/* Add other serial console driver calls here */
 
-- 
1.5.0.3
