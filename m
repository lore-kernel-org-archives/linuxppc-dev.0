Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1204FB7CE7
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:31:47 +1100 (EST)
Message-Id: <20100218122000.354221871@linutronix.de>
Date: Thu, 18 Feb 2010 12:22:44 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 06/15] powerpc: Convert tlbivax_lock to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tlbivax_lock needs to be a real spinlock in RT. Convert it to
raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/mm/tlb_nohash.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6-tip/arch/powerpc/mm/tlb_nohash.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/mm/tlb_nohash.c
+++ linux-2.6-tip/arch/powerpc/mm/tlb_nohash.c
@@ -150,7 +150,7 @@ EXPORT_SYMBOL(local_flush_tlb_page);
  */
 #ifdef CONFIG_SMP
 
-static DEFINE_SPINLOCK(tlbivax_lock);
+static DEFINE_RAW_SPINLOCK(tlbivax_lock);
 
 static int mm_is_core_local(struct mm_struct *mm)
 {
@@ -232,10 +232,10 @@ void __flush_tlb_page(struct mm_struct *
 		if (mmu_has_feature(MMU_FTR_USE_TLBIVAX_BCAST)) {
 			int lock = mmu_has_feature(MMU_FTR_LOCK_BCAST_INVAL);
 			if (lock)
-				spin_lock(&tlbivax_lock);
+				raw_spin_lock(&tlbivax_lock);
 			_tlbivax_bcast(vmaddr, pid, tsize, ind);
 			if (lock)
-				spin_unlock(&tlbivax_lock);
+				raw_spin_unlock(&tlbivax_lock);
 			goto bail;
 		} else {
 			struct tlb_flush_param p = {
