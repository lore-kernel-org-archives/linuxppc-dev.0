Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 42665DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 16:03:40 +1000 (EST)
Date: Thu, 17 May 2007 16:03:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] fix non HUGETLB_PAGE build warning
Message-Id: <20070517160338.c8170865.sfr@canb.auug.org.au>
In-Reply-To: <17995.58640.165251.501487@cargo.ozlabs.ibm.com>
References: <20070514141136.39a76d32.sfr@canb.auug.org.au>
	<17995.58640.165251.501487@cargo.ozlabs.ibm.com>
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
 arch/powerpc/mm/mmu_context_64.c |    5 ++---
 arch/powerpc/mm/slice.c          |    1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

On Thu, 17 May 2007 15:16:00 +1000 Paul Mackerras <paulus@samba.org> wrote:
>
> Could we use __unused to suppress the warning instead?

New version gets rid of the variabled completely.  Benh says this is ok.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/mm/mmu_context_64.c b/arch/powerpc/mm/mmu_context_64.c
index 7a78cdc..901ea76 100644
--- a/arch/powerpc/mm/mmu_context_64.c
+++ b/arch/powerpc/mm/mmu_context_64.c
@@ -28,7 +28,6 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	int index;
 	int err;
-	int new_context = (mm->context.id == 0);
 
 again:
 	if (!idr_pre_get(&mmu_context_idr, GFP_KERNEL))
@@ -50,19 +49,19 @@ again:
 		return -ENOMEM;
 	}
 
-	mm->context.id = index;
 #ifdef CONFIG_PPC_MM_SLICES
 	/* The old code would re-promote on fork, we don't do that
 	 * when using slices as it could cause problem promoting slices
 	 * that have been forced down to 4K
 	 */
-	if (new_context)
+	if (mm->context.id == 0)
 		slice_set_user_psize(mm, mmu_virtual_psize);
 #else
 	mm->context.user_psize = mmu_virtual_psize;
 	mm->context.sllp = SLB_VSID_USER |
 		mmu_psize_defs[mmu_virtual_psize].sllp;
 #endif
+	mm->context.id = index;
 
 	return 0;
 }
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index f833dba..cde1439 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -549,6 +549,7 @@ EXPORT_SYMBOL_GPL(get_slice_psize);
  *
  * This is also called in init_new_context() to change back the user
  * psize from whatever the parent context had it set to
+ * N.B. This may be called before mm->context.id has been set.
  *
  * This function will only change the content of the {low,high)_slice_psize
  * masks, it will not flush SLBs as this shall be handled lazily by the
-- 
1.5.1.4
