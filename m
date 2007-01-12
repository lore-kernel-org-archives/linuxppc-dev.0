Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5464DDF6C
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 11:54:46 +1100 (EST)
Date: Fri, 12 Jan 2007 09:54:39 +0900 (JST)
Message-Id: <200701120054.l0C0seP3020314@toshiba.co.jp>
Subject: [PATCH 2/19] powerpc: TLB insertion cleanup
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

This patch changes handling return value of ppc_md.hpte_insert() into
the same way as __hash_page_*().

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Index: linux-powerpc-git/arch/powerpc/mm/hugetlbpage.c
diff -u linux-powerpc-git/arch/powerpc/mm/hugetlbpage.c:1.1.1.3 linux-powerpc-git/arch/powerpc/mm/hugetlbpage.c:1.4
--- linux-powerpc-git/arch/powerpc/mm/hugetlbpage.c:1.1.1.3	Thu Jan 11 11:16:30 2007
+++ linux-powerpc-git/arch/powerpc/mm/hugetlbpage.c	Thu Jan 11 13:50:43 2007
@@ -1014,7 +1014,6 @@
 
 		/* Primary is full, try the secondary */
 		if (unlikely(slot == -1)) {
-			new_pte |= _PAGE_F_SECOND;
 			hpte_group = ((~hash & htab_hash_mask) *
 				      HPTES_PER_GROUP) & ~0x7UL; 
 			slot = ppc_md.hpte_insert(hpte_group, va, pa, rflags,
@@ -1033,7 +1032,7 @@
 		if (unlikely(slot == -2))
 			panic("hash_huge_page: pte_insert failed\n");
 
-		new_pte |= (slot << 12) & _PAGE_F_GIX;
+		new_pte |= (slot << 12) & (_PAGE_F_SECOND | _PAGE_F_GIX);
 	}
 
 	/*
