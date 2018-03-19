Return-Path: <oohall@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404PQH0RCfzF1dw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 16:15:02 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id p9-v6so7044899pls.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 22:15:02 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 3/5] powerpc/zImage: Check compatible at driver init
Date: Mon, 19 Mar 2018 16:14:01 +1100
Message-Id: <20180319051403.23275-3-oohall@gmail.com>
In-Reply-To: <20180319051403.23275-1-oohall@gmail.com>
References: <20180319051403.23275-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Have each driver's init function check the compatible string
of the node given by the stdout path. This gives the drivers
a more traditional probe-also-inits structure.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/boot/cpm-serial.c  | 2 ++
 arch/powerpc/boot/mpc52xx-psc.c | 3 +++
 arch/powerpc/boot/mpsc.c        | 3 +++
 arch/powerpc/boot/ns16550.c     | 4 ++++
 arch/powerpc/boot/opal.c        | 3 +++
 arch/powerpc/boot/uartlite.c    | 5 +++++
 6 files changed, 20 insertions(+)

diff --git a/arch/powerpc/boot/cpm-serial.c b/arch/powerpc/boot/cpm-serial.c
index dfb56829cace..f6b1cf23946e 100644
--- a/arch/powerpc/boot/cpm-serial.c
+++ b/arch/powerpc/boot/cpm-serial.c
@@ -212,6 +212,8 @@ int cpm_console_init(void *devp, struct serial_console_data *scdp)
 	} else if (dt_is_compatible(devp, "fsl,cpm2-smc-uart")) {
 		is_cpm2 = 1;
 		is_smc = 1;
+	} else if (!dt_is_compatible(devp, "fsl,cpm1-scc-uart")) {
+		return 1; /* not compatible */
 	}
 
 	if (is_smc) {
diff --git a/arch/powerpc/boot/mpc52xx-psc.c b/arch/powerpc/boot/mpc52xx-psc.c
index c2c08633ee35..75470936e661 100644
--- a/arch/powerpc/boot/mpc52xx-psc.c
+++ b/arch/powerpc/boot/mpc52xx-psc.c
@@ -52,6 +52,9 @@ static unsigned char psc_getc(void)
 
 int mpc5200_psc_console_init(void *devp, struct serial_console_data *scdp)
 {
+	if (!dt_is_compatible(devp, "fsl,mpc5200-psc-uart"))
+		return 1;
+
 	/* Get the base address of the psc registers */
 	if (dt_get_virtual_reg(devp, &psc, 1) < 1)
 		return -1;
diff --git a/arch/powerpc/boot/mpsc.c b/arch/powerpc/boot/mpsc.c
index 425ad88cce8d..59e23e886440 100644
--- a/arch/powerpc/boot/mpsc.c
+++ b/arch/powerpc/boot/mpsc.c
@@ -128,6 +128,9 @@ int mpsc_console_init(void *devp, struct serial_console_data *scdp)
 	int n, reg_set;
 	volatile char *sdma_base;
 
+	if (!dt_is_compatible(devp, "marvell,mv64360-mpsc"))
+		return 1;
+
 	n = getprop(devp, "virtual-reg", &v, sizeof(v));
 	if (n != sizeof(v))
 		goto err_out;
diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
index b0da4466d419..0e7bd5284255 100644
--- a/arch/powerpc/boot/ns16550.c
+++ b/arch/powerpc/boot/ns16550.c
@@ -58,6 +58,10 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)
 	int n;
 	u32 reg_offset;
 
+	if (!dt_is_compatible(devp, "ns16550") &&
+	    !dt_is_compatible(devp, "pnpPNP,501"))
+		return 1;
+
 	if (dt_get_virtual_reg(devp, (void **)&reg_base, 1) < 1)
 		return -1;
 
diff --git a/arch/powerpc/boot/opal.c b/arch/powerpc/boot/opal.c
index dfb199ef5b94..0e92537536b9 100644
--- a/arch/powerpc/boot/opal.c
+++ b/arch/powerpc/boot/opal.c
@@ -83,6 +83,9 @@ static void opal_init(void)
 
 int opal_console_init(void *devp, struct serial_console_data *scdp)
 {
+	if (!dt_is_compatible(devp, "ibm,opal-console-raw"))
+		return 1;
+
 	opal_init();
 
 	if (devp) {
diff --git a/arch/powerpc/boot/uartlite.c b/arch/powerpc/boot/uartlite.c
index 46bed69b4169..fc66a5fcea66 100644
--- a/arch/powerpc/boot/uartlite.c
+++ b/arch/powerpc/boot/uartlite.c
@@ -62,6 +62,11 @@ int uartlite_console_init(void *devp, struct serial_console_data *scdp)
 	int n;
 	unsigned long reg_phys;
 
+
+	if (!dt_is_compatible(devp, "xlnx,opb-uartlite-1.00.b") &&
+	    !dt_is_compatible(devp, "xlnx,xps-uartlite-1.00.a"))
+		return 1;
+
 	n = getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
 	if (n != sizeof(reg_base)) {
 		if (!dt_xlate_reg(devp, 0, &reg_phys, NULL))
-- 
2.9.5
