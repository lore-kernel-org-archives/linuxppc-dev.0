Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10CC167C29
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 15:45:03 +1100 (EST)
Date: Tue, 12 Dec 2006 13:44:58 +0900 (JST)
Message-Id: <200612120444.kBC4iwV7006457@toshiba.co.jp>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 15/15] powerpc: TLB insert
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

This patch changes handling return value of ppc_md.hpte_insert() into
the same way as __hash_page_*().

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/mm/hugetlbpage.c
diff -u linux-powerpc-git/arch/powerpc/mm/hugetlbpage.c:1.1.1.1 linux-powerpc-git/arch/powerpc/mm/hugetlbpage.c:1.2
--- linux-powerpc-git/arch/powerpc/mm/hugetlbpage.c:1.1.1.1	Wed Dec  6 08:25:43 2006
+++ linux-powerpc-git/arch/powerpc/mm/hugetlbpage.c	Wed Dec  6 08:43:15 2006
@@ -1009,7 +1009,6 @@
 
 		/* Primary is full, try the secondary */
 		if (unlikely(slot == -1)) {
-			new_pte |= _PAGE_F_SECOND;
 			hpte_group = ((~hash & htab_hash_mask) *
 				      HPTES_PER_GROUP) & ~0x7UL; 
 			slot = ppc_md.hpte_insert(hpte_group, va, pa, rflags,
@@ -1028,7 +1027,7 @@
 		if (unlikely(slot == -2))
 			panic("hash_huge_page: pte_insert failed\n");
 
-		new_pte |= (slot << 12) & _PAGE_F_GIX;
+		new_pte |= (slot << 12) & (_PAGE_F_SECOND | _PAGE_F_GIX);
 	}
 
 	/*
