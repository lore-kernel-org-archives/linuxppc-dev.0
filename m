Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 054BD68207
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Sep 2005 01:14:17 +1000 (EST)
Date: Thu, 8 Sep 2005 08:14:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, linuxppc-embedded@ozlabs.org
Message-ID: <20050908151416.GK3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 2.6.13] ppc32: Kill PVR_440* defines
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The following patch changes the usages of PVR_440* into strcmp's with
the cpu_name field, and removes the defines altogether.  The Ebony
portion was briefly tested long ago.  One benefit of moving from
PVR-tests to string tests in general is that not all CPUs can be
differentiated by PVR type, but we could otherwise know which one we're
on and be able to do this type of comparison.

See http://patchwork.ozlabs.org/linuxppc/patch?id=1250 for the original
thread.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Index: linux-2.6/arch/ppc/platforms/4xx/ebony.c
===================================================================
--- linux-2.6.orig/arch/ppc/platforms/4xx/ebony.c
+++ linux-2.6/arch/ppc/platforms/4xx/ebony.c
@@ -91,15 +91,10 @@ ebony_calibrate_decr(void)
 	 * on Rev. C silicon then errata forces us to
 	 * use the internal clock.
 	 */
-	switch (PVR_REV(mfspr(SPRN_PVR))) {
-		case PVR_REV(PVR_440GP_RB):
-			freq = EBONY_440GP_RB_SYSCLK;
-			break;
-		case PVR_REV(PVR_440GP_RC1):
-		default:
-			freq = EBONY_440GP_RC_SYSCLK;
-			break;
-	}
+	if (strcmp(cur_cpu_spec[0]->cpu_name, "440GP Rev. B") == 0)
+		freq = EBONY_440GP_RB_SYSCLK;
+	else
+		freq = EBONY_440GP_RC_SYSCLK;
 
 	ibm44x_calibrate_decr(freq);
 }
Index: linux-2.6/arch/ppc/syslib/ibm440gx_common.c
===================================================================
--- linux-2.6.orig/arch/ppc/syslib/ibm440gx_common.c
+++ linux-2.6/arch/ppc/syslib/ibm440gx_common.c
@@ -236,9 +236,10 @@ void __init ibm440gx_l2c_setup(struct ib
 	/* Disable L2C on rev.A, rev.B and 800MHz version of rev.C,
 	   enable it on all other revisions
 	 */
-	u32 pvr = mfspr(SPRN_PVR);
-	if (pvr == PVR_440GX_RA || pvr == PVR_440GX_RB ||
-	    (pvr == PVR_440GX_RC && p->cpu > 667000000))
+	if (strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. A") == 0 ||
+			strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. B") == 0
+			|| (strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. C")
+				== 0 && p->cpu > 667000000))
 		ibm440gx_l2c_disable();
 	else
 		ibm440gx_l2c_enable();
Index: linux-2.6/include/asm-ppc/reg.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/reg.h
+++ linux-2.6/include/asm-ppc/reg.h
@@ -366,12 +366,6 @@
 #define PVR_STB03XXX	0x40310000
 #define PVR_NP405H	0x41410000
 #define PVR_NP405L	0x41610000
-#define PVR_440GP_RB	0x40120440
-#define PVR_440GP_RC1	0x40120481
-#define PVR_440GP_RC2	0x40200481
-#define PVR_440GX_RA	0x51b21850
-#define PVR_440GX_RB	0x51b21851
-#define PVR_440GX_RC	0x51b21892
 #define PVR_601		0x00010000
 #define PVR_602		0x00050000
 #define PVR_603		0x00030000

-- 
Tom Rini
http://gate.crashing.org/~trini/
