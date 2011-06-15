Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F170EB6F76
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 19:22:05 +1000 (EST)
In-Reply-To: <792A171E-D1E1-4F35-8AC2-40C5A7519D78@digitaldans.com>
References: <1308059700-10839-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1308059700-10839-7-git-send-email-Joakim.Tjernlund@transmode.se>
	<53DBBA1E-BD8C-4856-9E35-028C8BB0911F@digitaldans.com>
	<OF75A64D65.5ABAA9A9-ONC12578AF.0062124A-C12578AF.0062E416@transmode.se>
	<792A171E-D1E1-4F35-8AC2-40C5A7519D78@digitaldans.com>
Subject: Re: [PATCH 06/15] 8xx: Always pin kernel instruction TLB
To: Dan Malek <ppc6dev@digitaldans.com>
Message-ID: <OF949E8D99.19E0C41B-ONC12578B0.00332603-C12578B0.003373B3@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 15 Jun 2011 11:21:59 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Willy Tarreau <w@1wt.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan Malek <ppc6dev@digitaldans.com> wrote on 2011/06/14 20:11:18:
>
> Hi Joakim.
>
> On Jun 14, 2011, at 11:00 AM, Joakim Tjernlund wrote:
>
> > I don't have a mpc850, do you?
>
> I have to say I do :-)
>
> > Probably but that is another matter. You could continue with that
> > if you like but I am stopping here ATM.
>
> Oh, come on...  I've been thinking about this for years, wouldn't
> you like to work on it?  It will be fun :-)

OK, it was fun :) This is a quick impl. for kernel ITLBs. What do
you think?

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 0f9080c..88278b4 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -33,6 +33,7 @@
 #include <asm/ppc_asm.h>
 #include "ppc_defs.h"

+#undef CONFIG_PIN_TLB
 /* Macro to make the code more readable. */
 #ifdef CONFIG_8xx_CPU6
   #define DO_8xx_CPU6(val, reg) \
@@ -357,17 +358,23 @@ InstructionTLBMiss:
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-#ifdef CONFIG_MODULES
-	/* Since we PIN the first 8MB text, we only get ITLB misses
-	 * for modules
-	 */
 	andi.	r21, r20, 0x0800	/* Address >= 0x80000000 */
 	beq	3f
+#ifdef CONFIG_MODULES
 	lis	r21, swapper_pg_dir@h
 	ori	r21, r21, swapper_pg_dir@l
 	rlwimi	r20, r21, 0, 2, 19
-3:
+	lwz	r21, 0(r20)	/* Get the level 1 entry */
+	tophys(r21,r21)
+	ori	r21, r21, MI_PS8MEG | MI_SVALID	/* Set 8M byte page */
+#else
+	li	r21, MI_PS8MEG | MI_SVALID	/* Set 8M byte page */
 #endif
+	DO_8xx_CPU6(0x2b80, r3)
+	mtspr	MI_TWC, r21		/* Set segment attributes */
+	li	r20, MI_BOOTINIT
+	b	5f
+3:
 	lwz	r21, 0(r20)	/* Get the level 1 entry */
 	rlwinm.	r20, r21,0,0,19	/* Extract page descriptor page address */

@@ -401,7 +408,7 @@ InstructionTLBMiss:
 	 */
 2:	li	r21, 0x00f0
 	rlwimi	r20, r21, 0, 0x07f8	/* Set 24-27, clear 21-23,28 */
-	DO_8xx_CPU6(0x2d80, r3)
+5:	DO_8xx_CPU6(0x2d80, r3)
 	mtspr	MI_RPN, r20	/* Update TLB entry */

 	mfspr	r20, M_TW	/* Restore registers */
@@ -942,13 +949,16 @@ start_here:
  */
 initial_mmu:
 	tlbia			/* Invalidate all TLB entries */
-
+#ifdef CONFIG_PIN_TLB
+//#if 1
 /* Always pin the first 8 MB ITLB to prevent ITLB
    misses while mucking around with SRR0/SRR1 in asm
 */
 	lis	r8, MI_RSV4I@h
 	ori	r8, r8, 0x1c00
-
+#else
+	li	r8, 0
+#endif
 	mtspr	MI_CTR, r8	/* Set instruction MMU control */

 #ifdef CONFIG_PIN_TLB
