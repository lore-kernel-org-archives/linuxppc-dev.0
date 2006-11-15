Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ADB0667C86
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 21:00:24 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id kAFA0G8u017371
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 19:00:16 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id kAFA0HnA009651
	for linuxppc-dev@ozlabs.org; Wed, 15 Nov 2006 19:00:17 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id kAFA0GRi018459
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 19:00:16 +0900 (JST)
Date: Wed, 15 Nov 2006 19:00:14 +0900 (JST)
Message-Id: <200611151000.kAFA0Fxs012318@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/16] TLB insersion for Celleb
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch changes handling return value of ppc_md.hpte_insert() to 
the same way as __hash_page_*().

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-2.6.19/arch/powerpc/mm/hugetlbpage.c
diff -u linux-2.6.19/arch/powerpc/mm/hugetlbpage.c:1.1.1.1 linux-2.6.19/arch/powerpc/mm/hugetlbpage.c:1.2
--- linux-2.6.19/arch/powerpc/mm/hugetlbpage.c:1.1.1.1	Fri Oct  6 10:40:06 2006
+++ linux-2.6.19/arch/powerpc/mm/hugetlbpage.c	Wed Oct 11 20:45:10 2006
@@ -1008,7 +1008,6 @@
 
 		/* Primary is full, try the secondary */
 		if (unlikely(slot == -1)) {
-			new_pte |= _PAGE_F_SECOND;
 			hpte_group = ((~hash & htab_hash_mask) *
 				      HPTES_PER_GROUP) & ~0x7UL; 
 			slot = ppc_md.hpte_insert(hpte_group, va, pa, rflags,
@@ -1027,7 +1026,7 @@
 		if (unlikely(slot == -2))
 			panic("hash_huge_page: pte_insert failed\n");
 
-		new_pte |= (slot << 12) & _PAGE_F_GIX;
+		new_pte |= (slot << 12) & (_PAGE_F_SECOND | _PAGE_F_GIX);
 	}
 
 	/*
