Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80B67DDF01
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 14:35:04 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	mB93Z1IX012042
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Dec 2008 20:35:01 -0700 (MST)
From: Trent Piepho <tpiepho@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] powerpc: booke: Remove num_tlbcam_entries
Date: Mon,  8 Dec 2008 19:34:56 -0800
Message-Id: <1228793699-23110-2-git-send-email-tpiepho@freescale.com>
In-Reply-To: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
References: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
Cc: Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a global variable defined in fsl_booke_mmu.c with a value that gets
initialized in assembly code in head_fsl_booke.S.

It's never used.

If some code ever does want to know the number of entries in TLB1, then
"numcams = mfspr(SPRN_TLB1CFG) & 0xfff", is a whole lot simpler than a
global initialized during kernel boot from assembly.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 arch/powerpc/kernel/head_fsl_booke.S |    4 ----
 arch/powerpc/mm/fsl_booke_mmu.c      |    1 -
 arch/powerpc/mm/mmu_decl.h           |    2 --
 3 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index c591acb..e33021f 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -389,10 +389,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
 #endif
 #endif
 
-	mfspr	r3,SPRN_TLB1CFG
-	andi.	r3,r3,0xfff
-	lis	r4,num_tlbcam_entries@ha
-	stw	r3,num_tlbcam_entries@l(r4)
 /*
  * Decide what sort of machine this is and initialize the MMU.
  */
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index c9ee59a..1971e4e 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -56,7 +56,6 @@
 
 extern void loadcam_entry(unsigned int index);
 unsigned int tlbcam_index;
-unsigned int num_tlbcam_entries;
 static unsigned long __cam0, __cam1, __cam2;
 
 #define NUM_TLBCAMS	(16)
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index f0d0aae..1db3c67 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -51,8 +51,6 @@ extern unsigned int rtas_data, rtas_size;
 struct hash_pte;
 extern struct hash_pte *Hash, *Hash_end;
 extern unsigned long Hash_size, Hash_mask;
-
-extern unsigned int num_tlbcam_entries;
 #endif
 
 extern unsigned long ioremap_bot;
-- 
1.5.4.1
