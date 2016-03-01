Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C45AA1A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 18:29:45 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Mar 2016 00:29:43 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6EB7719D803F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 00:17:37 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u217TfFx37879810
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 00:29:41 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u217TdsV016327
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 00:29:40 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/8] powerpc/mm: add _PAGE_HASHPTE similar to 4K hash
Date: Tue,  1 Mar 2016 12:59:18 +0530
Message-Id: <1456817364-3329-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1456817364-3329-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1456817364-3329-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't need to update linux page table entry with _PAGE_HASHPTE early
in hash pte fault. A parallel pte update will loop via _PAGE_BUSY
and look at _PAGE_HASHPTE for a required hpte flush only if
_PAGE_BUSY is cleared. That ensures a pte update will wait for a
parallel hpte insert to finish before looking at _PAGE_HASHPTE bit.

To avoid further confusion drop setting _PAGE_HASHPTE in cmpxchg in __hash_page_4K.

commit 41743a4e34f0 ("powerpc: Free a PTE bit on ppc64 with 64K pages")
did similar change for 64K config

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash64_4k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index e3e76b929f33..47d1b26effc6 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -44,7 +44,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * a write access. Since this is 4K insert of 64K page size
 		 * also add _PAGE_COMBO
 		 */
-		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_HASHPTE;
+		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
 	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
-- 
2.5.0
