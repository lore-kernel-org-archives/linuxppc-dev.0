Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25074DE033
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:33:24 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1XJKb018538
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:33:19 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1XIQ6001245
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:18 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I18bxC007859
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:08:37 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id B21EDAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:17 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1XHFD015305
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:33:17 -0500
Date: Tue, 17 Jul 2007 20:33:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 16/61] bootwrapper: Add CPM serial driver.
Message-ID: <20070718013317.GO15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/Makefile     |    3 +-
 arch/powerpc/boot/cpm-serial.c |  247 ++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/ops.h        |    1 +
 arch/powerpc/boot/serial.c     |    2 +
 4 files changed, 252 insertions(+), 1 deletions(-)
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
index 0000000..2794d1c
--- /dev/null
+++ b/arch/powerpc/boot/cpm-serial.c
@@ -0,0 +1,247 @@
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
+int is_cpm2;
+
+void cpm1_cmd(int op)
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
+void cpm2_cmd(int op)
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
+void do_cmd(int op)
+{
+	if (is_cpm2)
+		cpm2_cmd(op);
+	else
+		cpm1_cmd(op);
+}
+
+void disable_port(void)
+{
+	do_cmd(4); /* STOP TX */
+
+	if (smc)
+		out_be16(&smc->smcmr, in_be16(&smc->smcmr) & ~3);
+	else
+		out_be32(&scc->gsmrl, in_be32(&scc->gsmrl) & ~0x30);
+}
+
+void enable_port(void)
+{
+	if (smc)
+		out_be16(&smc->smcmr, in_be16(&smc->smcmr) | 3);
+	else
+		out_be32(&scc->gsmrl, in_be32(&scc->gsmrl) | 0x30);
+
+	do_cmd(6); /* RESTART TX */
+}
+
+static int serial_open(void)
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
+	asm volatile("sync" : : : "memory");
+	out_be16(&param->rbase, dpaddr);
+	out_be16(&param->tbase, dpaddr + sizeof(struct cpm_bd));
+
+	do_cmd(0); /* INIT RX AND TX PARAMS */
+
+	enable_port();
+	return 0;
+}
+
+void serial_close(void)
+{
+	/* Disable RX, but leave TX on for early console output. */
+
+	if (smc)
+		out_be16(&smc->smcmr, in_be16(&smc->smcmr) & ~1);
+	else
+		out_be32(&scc->gsmrl, in_be32(&scc->gsmrl) & ~0x20);
+}
+
+void serial_putc(unsigned char c)
+{
+	while (tbdf->sc & 0x8000)
+		asm volatile("" : : : "memory");
+
+	asm volatile("sync" : : : "memory");
+
+	tbdf->addr[0] = c;
+	asm volatile("eieio" : : : "memory");
+	tbdf->sc |= 0x8000;
+}
+
+unsigned char serial_tstc(void)
+{
+	asm volatile("" : : : "memory");
+	return !(rbdf->sc & 0x8000);
+}
+
+unsigned char serial_getc(void)
+{
+	unsigned char c;
+
+	while (!serial_tstc())
+		;
+
+	asm volatile("sync" : : : "memory");
+	c = rbdf->addr[0];
+	asm volatile("eieio" : : : "memory");
+	rbdf->sc |= 0x8000;
+
+	return c;
+}
+
+int cpm_console_init(void *devp, struct serial_console_data *scdp)
+{
+	void *reg_virt[2];
+	int is_smc, n;
+	unsigned long reg_phys;
+	void *parent;
+
+	if (dt_is_compatible(devp, "fsl,cpm-smc-uart"))
+		is_smc = 1;
+	else if (dt_is_compatible(devp, "fsl,cpm-scc-uart"))
+		is_smc = 0;
+	else
+		return -1;
+
+	if (dt_is_compatible(devp, "fsl,cpm2-uart"))
+		is_cpm2 = 1;
+	else if (!dt_is_compatible(devp, "fsl,cpm1-uart"))
+		return -1;
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
+	scdp->open = serial_open;
+	scdp->close = serial_close;
+	scdp->putc = serial_putc;
+	scdp->getc = serial_getc;
+	scdp->tstc = serial_tstc;
+
+	return 0;
+}
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index c48e8ed..453800e 100644
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
index 441151f..3d96cd2 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -121,6 +121,8 @@ int serial_console_init(void)
 		rc = ns16550_console_init(devp, &serial_cd);
 	else if (dt_is_compatible(devp, "marvell,mpsc"))
 		rc = mpsc_console_init(devp, &serial_cd);
+	else if (dt_is_compatible(devp, "fsl,cpm-uart"))
+		rc = cpm_console_init(devp, &serial_cd);
 
 	/* Add other serial console driver calls here */
 
-- 
1.5.0.3
