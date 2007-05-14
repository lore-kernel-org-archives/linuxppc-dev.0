Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6596CDDEA0
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 14:11:37 +1000 (EST)
Date: Mon, 14 May 2007 14:11:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] fix non HUGETLB_PAGE build warning
Message-Id: <20070514141136.39a76d32.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/mm/mmu_context_64.c: In function 'init_new_context':
arch/powerpc/mm/mmu_context_64.c:31: warning: unused variable 'new_context'

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/mmu_context_64.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/mm/mmu_context_64.c b/arch/powerpc/mm/mmu_context_64.c
index 7a78cdc..d263f88 100644
--- a/arch/powerpc/mm/mmu_context_64.c
+++ b/arch/powerpc/mm/mmu_context_64.c
@@ -28,7 +28,9 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	int index;
 	int err;
+#ifdef CONFIG_PPC_MM_SLICES
 	int new_context = (mm->context.id == 0);
+#endif
 
 again:
 	if (!idr_pre_get(&mmu_context_idr, GFP_KERNEL))
-- 
1.5.1.4
