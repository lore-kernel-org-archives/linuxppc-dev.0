Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ECDCBDDEAB
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 04:32:19 +1000 (EST)
Date: Thu, 25 Oct 2007 22:16:40 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] [PATCH] PowerPC: Workaround for the 440EP(x)/GR(x) processors
	identical PVR issue.
Message-ID: <20071025181640.GA18933@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PowerPC 440EP(x) 440GR(x) processors have the same PVR values, since
they have identical cores. However, FPU is not supported on GR(x) and
enabling APU instruction broadcast in the CCR0 register (to enable FPU)
may cause unpredictable results. There's no safe way to detect FPU
support at runtime. This patch provides a workarund for the issue.
We use a POWER6 "logical PVR approach". First, we identify all EP(x)
and GR(x) processors as GR(x) ones (which is safe). Then we check 
the device tree cpu path. If we have a EP(x) processor entry,
we call identify_cpu again with PVR | 0x8. This bit is always 0
in the real PVR. This way we enable FPU only for 440EP(x).

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/kernel/cputable.c |   36 ++++++++++++++++++++++++++++--------
 arch/powerpc/kernel/prom.c     |   12 ++++++++++++
 2 files changed, 40 insertions(+), 8 deletions(-)

diff -pruN linux-2.6.orig/arch/powerpc/kernel/cputable.c linux-2.6/arch/powerpc/kernel/cputable.c
--- linux-2.6.orig/arch/powerpc/kernel/cputable.c	2007-10-25 19:19:35.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/cputable.c	2007-10-25 21:11:59.000000000 +0400
@@ -1104,6 +1104,16 @@ static struct cpu_spec __initdata cpu_sp
 	{
 		.pvr_mask		= 0xf0000fff,
 		.pvr_value		= 0x40000850,
+		.cpu_name		= "440GR Rev. A",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.platform		= "ppc440",
+	},
+	{ /* Use logical PVR for 440EP (logical pvr = pvr | 0x8) */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x40000858,
 		.cpu_name		= "440EP Rev. A",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
@@ -1115,28 +1125,27 @@ static struct cpu_spec __initdata cpu_sp
 	{
 		.pvr_mask		= 0xf0000fff,
 		.pvr_value		= 0x400008d3,
-		.cpu_name		= "440EP Rev. B",
+		.cpu_name		= "440GR Rev. B",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_440ep,
 		.platform		= "ppc440",
 	},
-	{ /* 440EPX */
-		.pvr_mask		= 0xf0000ffb,
-		.pvr_value		= 0x200008D0,
-		.cpu_name		= "440EPX",
+	{ /* Use logical PVR for 440EP (logical pvr = pvr | 0x8) */
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x400008db,
+		.cpu_name		= "440EP Rev. B",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_440epx,
+		.cpu_setup		= __setup_cpu_440ep,
 		.platform		= "ppc440",
 	},
 	{ /* 440GRX */
 		.pvr_mask		= 0xf0000ffb,
-		.pvr_value		= 0x200008D8,
+		.pvr_value		= 0x200008D0,
 		.cpu_name		= "440GRX",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
@@ -1145,6 +1154,17 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_setup		= __setup_cpu_440grx,
 		.platform		= "ppc440",
 	},
+	{ /* Use logical PVR for 440EPx (logical pvr = pvr | 0x8) */
+		.pvr_mask		= 0xf0000ffb,
+		.pvr_value		= 0x200008D8,
+		.cpu_name		= "440EPX",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440epx,
+		.platform		= "ppc440",
+	},
 	{	/* 440GP Rev. B */
 		.pvr_mask		= 0xf0000fff,
 		.pvr_value		= 0x40000440,
diff -pruN linux-2.6.orig/arch/powerpc/kernel/prom.c linux-2.6/arch/powerpc/kernel/prom.c
--- linux-2.6.orig/arch/powerpc/kernel/prom.c	2007-10-25 19:19:35.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/prom.c	2007-10-25 21:11:59.000000000 +0400
@@ -697,6 +697,18 @@ static int __init early_init_dt_scan_cpu
 		prop = of_get_flat_dt_prop(node, "cpu-version", NULL);
 		if (prop && (*prop & 0xff000000) == 0x0f000000)
 			identify_cpu(0, *prop);
+#if defined(CONFIG_44x) && defined(CONFIG_PPC_FPU)
+		/*
+		 * Since 440GR(x)/440EP(x) processors have the same pvr,
+		 * we check the node path and set bit 28 in the cur_cpu_spec
+		 * pvr for EP(x) processor version. This bit is always 0 in
+		 * the "real" pvr. Then we call identify_cpu again with
+		 * the new logical pvr to enable FPU support.
+		 */
+		if (strstr(uname, "440EP")) {
+			identify_cpu(0, cur_cpu_spec->pvr_value | 0x8);
+		}
+#endif
 	}
 
 	check_cpu_feature_properties(node);
