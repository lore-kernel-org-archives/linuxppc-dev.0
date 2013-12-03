Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 50DD32C0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2013 19:33:48 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 2 Dec 2013 18:33:28 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 965722CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2013 19:33:26 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB28FF9I3080636
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Dec 2013 19:15:16 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB28XPb7021349
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Dec 2013 19:33:25 +1100
Message-ID: <1386059589.2578.16.camel@ThinkPad-T5421>
Subject: [RFC PATCH powerpc 2/2] adjust the variable type and name in
 __pte_free_tlb()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 03 Dec 2013 16:33:09 +0800
In-Reply-To: <1386059435.2578.13.camel@ThinkPad-T5421>
References: <1386059435.2578.13.camel@ThinkPad-T5421>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adjusts the variable type and name for page in
__pte_free_tlb(), which now seems a little confusing. 

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgalloc-64.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index d7543c2..1580f9e 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -148,11 +148,11 @@ static inline void pgtable_free_tlb(struct mmu_gather *tlb,
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
-	struct page *page = page_address(table);
+	void *page_addr = page_address(table);
 
 	tlb_flush_pgtable(tlb, address);
 	pgtable_page_dtor(table);
-	pgtable_free_tlb(tlb, page, 0);
+	pgtable_free_tlb(tlb, page_addr, 0);
 }
 
 #else /* if CONFIG_PPC_64K_PAGES */
