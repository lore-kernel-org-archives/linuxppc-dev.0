Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F8LS3MWRzF3FL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 02:57:36 +1000 (AEST)
Message-Id: <7efec0c76fa692513c806871151a7ae20e99fe05.1537288312.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537288312.git.christophe.leroy@c-s.fr>
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 15/20] powerpc/mm: Avoid useless lock with single page
 fragments
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 18 Sep 2018 16:57:32 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no point in taking the page table lock as
pte_frag is always NULL when we have only one fragment.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable-frag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index bc924822dcd6..ab4910e92aaf 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -85,6 +85,9 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
 {
 	void *pte_frag, *ret;
 
+	if (PTE_FRAG_NR == 1)
+		return NULL;
+
 	spin_lock(&mm->page_table_lock);
 	ret = mm->context.pte_frag;
 	if (ret) {
-- 
2.13.3
