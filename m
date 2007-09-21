Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 606BADDE05
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 00:51:16 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l8LEo9gw004332
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 18:50:09 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l8LEo9A6004329
	for linuxppc-dev@ozlabs.org; Fri, 21 Sep 2007 18:50:09 +0400
Date: Fri, 21 Sep 2007 18:50:09 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] PowerPC: 440EPx/GRx incorrect write to DDR SDRAM errata
	workaround
Message-ID: <20070921145009.GA4298@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070921144149.GA4150@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a workaround for PowerPC 440EPx/GRx incorrect write to 
DDR SDRAM errata. Data can be written to wrong address 
in SDRAM when write pipelining enabled on plb0. We disable
it in the cpu_setup for these processors at early init.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/kernel/cpu_setup_44x.S |   25 ++++++++++++++++++++++++-
 arch/powerpc/kernel/cputable.c      |    3 +++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff -ruN linux-2.6.orig/arch/powerpc/kernel/cpu_setup_44x.S linux-2.6/arch/powerpc/kernel/cpu_setup_44x.S
--- linux-2.6.orig/arch/powerpc/kernel/cpu_setup_44x.S	2007-09-21 15:31:14.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/cpu_setup_44x.S	2007-09-21 16:07:12.000000000 +0400
@@ -20,7 +20,14 @@
 _GLOBAL(__setup_cpu_440ep)
 	b	__init_fpu_44x
 _GLOBAL(__setup_cpu_440epx)
-	b	__init_fpu_44x
+	mflr	r4
+	bl	__init_fpu_44x
+	bl	__plb_disable_wrp
+	mtlr	r4
+	blr
+_GLOBAL(__setup_cpu_440grx)
+	b	__plb_disable_wrp
+
 
 /* enable APU between CPU and FPU */
 _GLOBAL(__init_fpu_44x)
@@ -31,3 +38,19 @@
 	isync
 	blr
 
+/*
+ * Workaround for the incorrect write to DDR SDRAM errata.
+ * The write address can be corrupted during writes to
+ * DDR SDRAM when write pipelining is enabled on PLB0.
+ * Disable write pipelining here.
+ */
+#define DCRN_PLB4A0_ACR	0x81
+
+_GLOBAL(__plb_disable_wrp)
+	mfdcr	r3,DCRN_PLB4A0_ACR
+	/* clear WRP bit in PLB4A0_ACR */
+	rlwinm	r3,r3,0,8,6
+	mtdcr	DCRN_PLB4A0_ACR,r3
+	isync
+	blr
+
diff -ruN linux-2.6.orig/arch/powerpc/kernel/cputable.c linux-2.6/arch/powerpc/kernel/cputable.c
--- linux-2.6.orig/arch/powerpc/kernel/cputable.c	2007-09-21 15:55:23.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/cputable.c	2007-09-21 16:08:23.000000000 +0400
@@ -33,6 +33,7 @@
 #ifdef CONFIG_PPC32
 extern void __setup_cpu_440ep(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440epx(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_440grx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
@@ -1146,6 +1147,8 @@
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440grx,
+		.platform		= "ppc440",
 	},
 	{	/* 440GP Rev. B */
 		.pvr_mask		= 0xf0000fff,
