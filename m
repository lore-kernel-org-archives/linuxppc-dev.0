Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 100A1DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 17:26:03 +1100 (EST)
Date: Thu, 08 Feb 2007 15:18:33 +0900 (JST)
Message-Id: <200702080618.l186InGM014774@toshiba.co.jp>
Subject: [PATCH] Celleb: improve htab lock
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Disabling IRQ is required only in invalidation.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---


Index: linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c
diff -u linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c:1.1.1.1 linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c:1.9
--- linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c:1.1.1.1	Thu Feb  8 11:38:20 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c	Wed Feb  7 11:49:17 2007
@@ -95,7 +95,6 @@
 	unsigned long lpar_rc;
 	unsigned long slot;
 	unsigned long hpte_v, hpte_r;
-	unsigned long flags;
 
 	/* same as iseries */
 	if (vflags & HPTE_V_SECONDARY)
@@ -115,17 +114,17 @@
 	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
 		hpte_r &= ~_PAGE_COHERENT;
 
-	spin_lock_irqsave(&beat_htab_lock, flags);
+	spin_lock(&beat_htab_lock);
 	if ((lpar_rc = beat_read_mask(hpte_group)) == 0) {
 		if (!(vflags & HPTE_V_BOLTED))
 			DBG_LOW(" full\n");
-		spin_unlock_irqrestore(&beat_htab_lock, flags);
+		spin_unlock(&beat_htab_lock);
 		return -1;
 	}
 
 	lpar_rc = beat_insert_htab_entry(0, hpte_group, lpar_rc << 48,
 		hpte_v, hpte_r, &slot);
-	spin_unlock_irqrestore(&beat_htab_lock, flags);
+	spin_unlock(&beat_htab_lock);
 
 	/*
 	 * Since we try and ioremap PHBs we don't own, the pte insert
@@ -189,7 +188,6 @@
 {
 	unsigned long lpar_rc;
 	unsigned long dummy0, dummy1, want_v;
-	unsigned long flags;
 
 	want_v = hpte_encode_v(va, psize);
 
@@ -197,17 +195,17 @@
 		"avpnv=%016lx, slot=%016lx, psize: %d, newpp %016lx ... ",
 		want_v & HPTE_V_AVPN, slot, psize, newpp);
 
-	spin_lock_irqsave(&beat_htab_lock, flags);
+	spin_lock(&beat_htab_lock);
 	dummy0 = beat_lpar_hpte_getword0(slot);
 	if ((dummy0 & ~0x7FUL) != (want_v & ~0x7FUL)) {
 		DBG_LOW("not found !\n");
-		spin_unlock_irqrestore(&beat_htab_lock, flags);
+		spin_unlock(&beat_htab_lock);
 		return -1;
 	}
 
 	lpar_rc = beat_write_htab_entry(0, slot, 0, newpp, 0, 7, &dummy0,
 					&dummy1);
-	spin_unlock_irqrestore(&beat_htab_lock, flags);
+	spin_unlock(&beat_htab_lock);
 	if (lpar_rc != 0 || dummy0 == 0) {
 		DBG_LOW("not found !\n");
 		return -1;
@@ -256,18 +254,17 @@
 					  int psize)
 {
 	unsigned long lpar_rc, slot, vsid, va, dummy0, dummy1;
-	unsigned long flags;
 
 	vsid = get_kernel_vsid(ea);
 	va = (vsid << 28) | (ea & 0x0fffffff);
 
-	spin_lock_irqsave(&beat_htab_lock, flags);
+	spin_lock(&beat_htab_lock);
 	slot = beat_lpar_hpte_find(va, psize);
 	BUG_ON(slot == -1);
 
 	lpar_rc = beat_write_htab_entry(0, slot, 0, newpp, 0, 7,
 		&dummy0, &dummy1);
-	spin_unlock_irqrestore(&beat_htab_lock, flags);
+	spin_unlock(&beat_htab_lock);
 
 	BUG_ON(lpar_rc != 0);
 }
@@ -284,18 +281,21 @@
 		slot, va, psize, local);
 	want_v = hpte_encode_v(va, psize);
 
-	spin_lock_irqsave(&beat_htab_lock, flags);
+	local_irq_save(flags);
+	spin_lock(&beat_htab_lock);
 	dummy1 = beat_lpar_hpte_getword0(slot);
 
 	if ((dummy1 & ~0x7FUL) != (want_v & ~0x7FUL)) {
 		DBG_LOW("not found !\n");
-		spin_unlock_irqrestore(&beat_htab_lock, flags);
+		spin_unlock(&beat_htab_lock);
+		local_irq_restore(flags);
 		return;
 	}
 
 	lpar_rc = beat_write_htab_entry(0, slot, 0, 0, HPTE_V_VALID, 0,
 		&dummy1, &dummy2);
-	spin_unlock_irqrestore(&beat_htab_lock, flags);
+	spin_unlock(&beat_htab_lock);
+	local_irq_restore(flags);
 
 	BUG_ON(lpar_rc != 0);
 }
