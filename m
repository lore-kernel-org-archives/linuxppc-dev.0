Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19CB1B808B
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:31:57 +1100 (EST)
Message-Id: <20100218122000.265263872@linutronix.de>
Date: Thu, 18 Feb 2010 12:22:35 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 04/15] powerpc: Convert native_tlbie_lock to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

native_tlbie_lock needs to be a real spinlock in RT. Convert it to
raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/mm/hash_native_64.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6-tip/arch/powerpc/mm/hash_native_64.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/mm/hash_native_64.c
+++ linux-2.6-tip/arch/powerpc/mm/hash_native_64.c
@@ -37,7 +37,7 @@
 
 #define HPTE_LOCK_BIT 3
 
-static DEFINE_SPINLOCK(native_tlbie_lock);
+static DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 
 static inline void __tlbie(unsigned long va, int psize, int ssize)
 {
@@ -104,7 +104,7 @@ static inline void tlbie(unsigned long v
 	if (use_local)
 		use_local = mmu_psize_defs[psize].tlbiel;
 	if (lock_tlbie && !use_local)
-		spin_lock(&native_tlbie_lock);
+		raw_spin_lock(&native_tlbie_lock);
 	asm volatile("ptesync": : :"memory");
 	if (use_local) {
 		__tlbiel(va, psize, ssize);
@@ -114,7 +114,7 @@ static inline void tlbie(unsigned long v
 		asm volatile("eieio; tlbsync; ptesync": : :"memory");
 	}
 	if (lock_tlbie && !use_local)
-		spin_unlock(&native_tlbie_lock);
+		raw_spin_unlock(&native_tlbie_lock);
 }
 
 static inline void native_lock_hpte(struct hash_pte *hptep)
@@ -434,7 +434,7 @@ static void native_hpte_clear(void)
 	/* we take the tlbie lock and hold it.  Some hardware will
 	 * deadlock if we try to tlbie from two processors at once.
 	 */
-	spin_lock(&native_tlbie_lock);
+	raw_spin_lock(&native_tlbie_lock);
 
 	slots = pteg_count * HPTES_PER_GROUP;
 
@@ -458,7 +458,7 @@ static void native_hpte_clear(void)
 	}
 
 	asm volatile("eieio; tlbsync; ptesync":::"memory");
-	spin_unlock(&native_tlbie_lock);
+	raw_spin_unlock(&native_tlbie_lock);
 	local_irq_restore(flags);
 }
 
@@ -521,7 +521,7 @@ static void native_flush_hash_range(unsi
 		int lock_tlbie = !cpu_has_feature(CPU_FTR_LOCKLESS_TLBIE);
 
 		if (lock_tlbie)
-			spin_lock(&native_tlbie_lock);
+			raw_spin_lock(&native_tlbie_lock);
 
 		asm volatile("ptesync":::"memory");
 		for (i = 0; i < number; i++) {
@@ -536,7 +536,7 @@ static void native_flush_hash_range(unsi
 		asm volatile("eieio; tlbsync; ptesync":::"memory");
 
 		if (lock_tlbie)
-			spin_unlock(&native_tlbie_lock);
+			raw_spin_unlock(&native_tlbie_lock);
 	}
 
 	local_irq_restore(flags);
