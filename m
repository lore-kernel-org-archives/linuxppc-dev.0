Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E29D6DE248
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 06:33:36 +1000 (EST)
Date: Wed, 23 Apr 2008 15:29:36 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] Clean up access to thread_info in assembly
Message-ID: <Pine.LNX.4.64.0804231525290.5418@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use (31-THREAD_SHIFT) to get to thread_info from stack pointer.  This makes
the code a bit easier to read and more robust if we ever change THREAD_SHIFT.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/misc_32.S |    6 +++---
 arch/powerpc/mm/hash_low_32.S |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 9d2c566..92ccc6f 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -152,7 +152,7 @@ _GLOBAL(low_choose_750fx_pll)
 	mtspr	SPRN_HID1,r4

 	/* Store new HID1 image */
-	rlwinm	r6,r1,0,0,18
+	rlwinm	r6,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r6,TI_CPU(r6)
 	slwi	r6,r6,2
 	addis	r6,r6,nap_save_hid1@ha
@@ -281,7 +281,7 @@ _GLOBAL(_tlbia)
 #endif /* CONFIG_SMP */
 #else /* !(CONFIG_40x || CONFIG_44x || CONFIG_FSL_BOOKE) */
 #if defined(CONFIG_SMP)
-	rlwinm	r8,r1,0,0,18
+	rlwinm	r8,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r8,TI_CPU(r8)
 	oris	r8,r8,10
 	mfmsr	r10
@@ -377,7 +377,7 @@ _GLOBAL(_tlbie)
 #endif /* CONFIG_SMP */
 #else /* !(CONFIG_40x || CONFIG_44x || CONFIG_FSL_BOOKE) */
 #if defined(CONFIG_SMP)
-	rlwinm	r8,r1,0,0,18
+	rlwinm	r8,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r8,TI_CPU(r8)
 	oris	r8,r8,11
 	mfmsr	r10
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index e10d76a..ddeaf9e 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -191,7 +191,7 @@ _GLOBAL(add_hash_page)
 	add	r3,r3,r0		/* note create_hpte trims to 24 bits */

 #ifdef CONFIG_SMP
-	rlwinm	r8,r1,0,0,18		/* use cpu number to make tag */
+	rlwinm	r8,r1,0,0,(31-THREAD_SHIFT) /* use cpu number to make tag */
 	lwz	r8,TI_CPU(r8)		/* to go in mmu_hash_lock */
 	oris	r8,r8,12
 #endif /* CONFIG_SMP */
@@ -526,7 +526,7 @@ _GLOBAL(flush_hash_pages)
 #ifdef CONFIG_SMP
 	addis	r9,r7,mmu_hash_lock@ha
 	addi	r9,r9,mmu_hash_lock@l
-	rlwinm	r8,r1,0,0,18
+	rlwinm	r8,r1,0,0,(31-THREAD_SHIFT)
 	add	r8,r8,r7
 	lwz	r8,TI_CPU(r8)
 	oris	r8,r8,9
-- 
1.5.4.1
