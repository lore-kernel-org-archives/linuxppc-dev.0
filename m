Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 24447B6FB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 May 2011 13:41:47 +1000 (EST)
Date: Thu, 5 May 2011 13:41:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the final tree (powerpc
	tree related)
Message-Id: <20110505134142.3a1cb1f9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michael Ellerman <michael@ozlabs.org>,
	"Tseng-Hui \(Frank\) Lin" <thlin@linux.vnet.ibm.com>,
	Sonny Rao <sonnyrao@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

After merging the final tree, today's linux-next build (powerpc
allyesconfig) failed like this:

arch/powerpc/mm/mmu_context_hash64.c: In function 'init_new_context':
arch/powerpc/mm/mmu_context_hash64.c:282: error: 'NO_CONTEXT' undeclared (first use in this function)

Presumably caused by commit 851d2e2fe8db ("powerpc: Add Initiate
Coprocessor Store Word (icswx) support") interacting with commit
5e8e7b404ac9 ("powerpc/mm: Standardise on MMU_NO_CONTEXT").

I added the below patch for today.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 5 May 2011 13:32:02 +1000
Subject: [PATCH] powerpc: fix up mismerge in mmu_context_hash64.c

NO_CONTEXT was changed to MMU_NO_CONTEXT.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/mmu_context_hash64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index c517815..3bafc3d 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -279,7 +279,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	if (!mm->context.cop_lockp) {
 		__destroy_context(index);
 		subpage_prot_free(mm);
-		mm->context.id = NO_CONTEXT;
+		mm->context.id = MMU_NO_CONTEXT;
 		return -ENOMEM;
 	}
 	spin_lock_init(mm->context.cop_lockp);
-- 
1.7.4.4
