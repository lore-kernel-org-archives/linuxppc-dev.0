Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 2D67E67A78
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 02:27:31 +1100 (EST)
Date: Mon, 21 Mar 2005 08:27:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-embedded@ozlabs.org
Message-ID: <20050321152728.GS8345@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] ppc44x: Remove PVR_440G* and change usages
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
portion was briefly tested.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

 arch/ppc/platforms/4xx/ebony.c    |   13 ++++---------
 arch/ppc/syslib/ibm440gx_common.c |    7 ++++---
 include/asm-ppc/reg.h             |    6 ------
 3 files changed, 8 insertions(+), 18 deletions(-)
--- 1.11/arch/ppc/platforms/4xx/ebony.c	2005-03-04 23:41:48 -07:00
+++ edited/arch/ppc/platforms/4xx/ebony.c	2005-03-08 15:22:19 -07:00
@@ -97,15 +97,10 @@
 	 * on Rev. C silicon then errata forces us to
 	 * use the internal clock.
 	 */
-	switch (PVR_REV(mfspr(PVR))) {
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
--- 1.3/arch/ppc/syslib/ibm440gx_common.c	2004-11-07 19:08:31 -07:00
+++ edited/arch/ppc/syslib/ibm440gx_common.c	2005-03-21 08:20:17 -07:00
@@ -221,9 +221,10 @@
 	/* Disable L2C on rev.A, rev.B and 800MHz version of rev.C,
 	   enable it on all other revisions
 	 */
-	u32 pvr = mfspr(PVR);
-	if (pvr == PVR_440GX_RA || pvr == PVR_440GX_RB ||
-	    (pvr == PVR_440GX_RC && p->cpu > 667000000))
+	if (strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. A") == 0 ||
+			strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. B") == 0
+			|| (strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. C")
+				== 0 && p->cpu > 667000000))
 		ibm440gx_l2c_disable();
 	else
 		ibm440gx_l2c_enable();
--- 1.16/include/asm-ppc/reg.h	2005-03-04 23:41:17 -07:00
+++ edited/include/asm-ppc/reg.h	2005-03-21 08:21:22 -07:00
@@ -449,12 +449,6 @@
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
