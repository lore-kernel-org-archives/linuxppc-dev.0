Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F02F8B832A
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:32:07 +1100 (EST)
Message-Id: <20100218122000.390998094@linutronix.de>
Date: Thu, 18 Feb 2010 12:22:47 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 07/15] powerpc: Convert beat_htab_lock to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

beat_htab_lock needs to be a real spinlock in RT. Convert it to
raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/cell/beat_htab.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

Index: linux-2.6-tip/arch/powerpc/platforms/cell/beat_htab.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/cell/beat_htab.c
+++ linux-2.6-tip/arch/powerpc/platforms/cell/beat_htab.c
@@ -40,7 +40,7 @@
 #define DBG_LOW(fmt...) do { } while (0)
 #endif
 
-static DEFINE_SPINLOCK(beat_htab_lock);
+static DEFINE_RAW_SPINLOCK(beat_htab_lock);
 
 static inline unsigned int beat_read_mask(unsigned hpte_group)
 {
@@ -114,18 +114,18 @@ static long beat_lpar_hpte_insert(unsign
 	if (rflags & _PAGE_NO_CACHE)
 		hpte_r &= ~_PAGE_COHERENT;
 
-	spin_lock(&beat_htab_lock);
+	raw_spin_lock(&beat_htab_lock);
 	lpar_rc = beat_read_mask(hpte_group);
 	if (lpar_rc == 0) {
 		if (!(vflags & HPTE_V_BOLTED))
 			DBG_LOW(" full\n");
-		spin_unlock(&beat_htab_lock);
+		raw_spin_unlock(&beat_htab_lock);
 		return -1;
 	}
 
 	lpar_rc = beat_insert_htab_entry(0, hpte_group, lpar_rc << 48,
 		hpte_v, hpte_r, &slot);
-	spin_unlock(&beat_htab_lock);
+	raw_spin_unlock(&beat_htab_lock);
 
 	/*
 	 * Since we try and ioremap PHBs we don't own, the pte insert
@@ -198,17 +198,17 @@ static long beat_lpar_hpte_updatepp(unsi
 		"avpnv=%016lx, slot=%016lx, psize: %d, newpp %016lx ... ",
 		want_v & HPTE_V_AVPN, slot, psize, newpp);
 
-	spin_lock(&beat_htab_lock);
+	raw_spin_lock(&beat_htab_lock);
 	dummy0 = beat_lpar_hpte_getword0(slot);
 	if ((dummy0 & ~0x7FUL) != (want_v & ~0x7FUL)) {
 		DBG_LOW("not found !\n");
-		spin_unlock(&beat_htab_lock);
+		raw_spin_unlock(&beat_htab_lock);
 		return -1;
 	}
 
 	lpar_rc = beat_write_htab_entry(0, slot, 0, newpp, 0, 7, &dummy0,
 					&dummy1);
-	spin_unlock(&beat_htab_lock);
+	raw_spin_unlock(&beat_htab_lock);
 	if (lpar_rc != 0 || dummy0 == 0) {
 		DBG_LOW("not found !\n");
 		return -1;
@@ -262,13 +262,13 @@ static void beat_lpar_hpte_updateboltedp
 	vsid = get_kernel_vsid(ea, MMU_SEGSIZE_256M);
 	va = (vsid << 28) | (ea & 0x0fffffff);
 
-	spin_lock(&beat_htab_lock);
+	raw_spin_lock(&beat_htab_lock);
 	slot = beat_lpar_hpte_find(va, psize);
 	BUG_ON(slot == -1);
 
 	lpar_rc = beat_write_htab_entry(0, slot, 0, newpp, 0, 7,
 		&dummy0, &dummy1);
-	spin_unlock(&beat_htab_lock);
+	raw_spin_unlock(&beat_htab_lock);
 
 	BUG_ON(lpar_rc != 0);
 }
@@ -285,18 +285,18 @@ static void beat_lpar_hpte_invalidate(un
 		slot, va, psize, local);
 	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
 
-	spin_lock_irqsave(&beat_htab_lock, flags);
+	raw_spin_lock_irqsave(&beat_htab_lock, flags);
 	dummy1 = beat_lpar_hpte_getword0(slot);
 
 	if ((dummy1 & ~0x7FUL) != (want_v & ~0x7FUL)) {
 		DBG_LOW("not found !\n");
-		spin_unlock_irqrestore(&beat_htab_lock, flags);
+		raw_spin_unlock_irqrestore(&beat_htab_lock, flags);
 		return;
 	}
 
 	lpar_rc = beat_write_htab_entry(0, slot, 0, 0, HPTE_V_VALID, 0,
 		&dummy1, &dummy2);
-	spin_unlock_irqrestore(&beat_htab_lock, flags);
+	raw_spin_unlock_irqrestore(&beat_htab_lock, flags);
 
 	BUG_ON(lpar_rc != 0);
 }
