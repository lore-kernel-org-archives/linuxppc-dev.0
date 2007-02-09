Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA355DDE48
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 18:53:09 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l197r5gS010682
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Feb 2007 16:53:05 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l197r6J5009996
	for linuxppc-dev@ozlabs.org; Fri, 9 Feb 2007 16:53:06 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l197r5wT014269
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Feb 2007 16:53:05 +0900 (JST)
Message-Id: <200702090753.l197r4Pr007623@toshiba.co.jp>
MIME-Version: 1.0
Date: Fri, 09 Feb 2007 16:53:59 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH] Celleb: improve htab lock
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Disabling IRQ is required only in invalidation. Replace
"spin_lock_irqsave" to "spin_lock" in other ops.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c
diff -u linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c:1.1.1.1 linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c:1.10
--- linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c:1.1.1.1	Thu Feb  8 11:38:20 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c	Fri Feb  9 13:44:18 2007
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
