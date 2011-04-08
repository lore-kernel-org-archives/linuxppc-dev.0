Return-Path: <michael@ozlabs.org>
To: <linux-kernel@vger.kernel.org>
Message-Id: <10e5cbf67c850b6ae511979bdbad1761236ad9b0.1302247435.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] mm: Check we have the right vma in __access_remote_vm()
Date: Fri,  8 Apr 2011 17:24:01 +1000 (EST)
Cc: aarcange@redhat.com, Andrew Morton <akpm@osdl.org>, riel@redhat.com,
	linuxppc-dev@ozlabs.org, hughd@google.com, linux-mm@kvack.org,
	walken@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In __access_remote_vm() we need to check that we have found the right
vma, not the following vma, before we try to access it. Otherwise we
might call the vma's access routine with an address which does not
fall inside the vma.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 mm/memory.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 9da8cab..ce999ca 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3678,7 +3678,7 @@ static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 			 */
 #ifdef CONFIG_HAVE_IOREMAP_PROT
 			vma = find_vma(mm, addr);
-			if (!vma)
+			if (!vma || vma->vm_start > addr)
 				break;
 			if (vma->vm_ops && vma->vm_ops->access)
 				ret = vma->vm_ops->access(vma, addr, buf,
-- 
1.7.1
