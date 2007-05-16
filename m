Return-Path: <kniht@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 181C7DDF6A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 04:43:05 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4GIh3IZ028656
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 14:43:03 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4GIh39n552658
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 14:43:03 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4GIh3F8031833
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 14:43:03 -0400
Received: from [9.67.216.160] (wecm-9-67-216-160.wecm.ibm.com [9.67.216.160])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l4GIh2QC031808
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 14:43:02 -0400
Message-ID: <464B50B6.3090300@us.ibm.com>
Date: Wed, 16 May 2007 13:43:02 -0500
From: Jon Tollefson <kniht@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix #endif comment
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: kniht@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix up comment on #endif to match #if.

Signed-off-by: Jon Tollefson <kniht@linux.vnet.ibm.com>
----

 hash_utils_64.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 028ba4e..4f2f453 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -430,7 +430,7 @@ static void __init htab_finish_init(void)
        make_bl(ht64_call_hpte_insert2, ppc_md.hpte_insert);
        make_bl(ht64_call_hpte_remove, ppc_md.hpte_remove);
        make_bl(ht64_call_hpte_updatepp, ppc_md.hpte_updatepp);
-#endif /* CONFIG_PPC_64K_PAGES */
+#endif /* CONFIG_PPC_HAS_HASH_64K */
 
        make_bl(htab_call_hpte_insert1, ppc_md.hpte_insert);
        make_bl(htab_call_hpte_insert2, ppc_md.hpte_insert);
@@ -837,7 +837,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
        if (mm->context.user_psize == MMU_PAGE_64K)
                __hash_page_64K(ea, access, vsid, ptep, trap, local);
        else
-#endif /* CONFIG_PPC_64K_PAGES */
+#endif /* CONFIG_PPC_HAS_HASH_64K */
                __hash_page_4K(ea, access, vsid, ptep, trap, local);
 
        local_irq_restore(flags);
