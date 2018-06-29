Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Gxsp2160zF1LS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 10:12:14 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, rashmica.g@gmail.com,
 anton@ozlabs.org
Subject: [PATCH] powerpc: Remove memtrace mmap
Date: Fri, 29 Jun 2018 10:12:09 +1000
Message-Id: <20180629001209.18523-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

debugfs doesn't support mmap, so this code is never used.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/platforms/powernv/memtrace.c | 29 -----------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index b99283df85..f73101119e 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -47,38 +47,9 @@ static ssize_t memtrace_read(struct file *filp, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, count, ppos, ent->mem, ent->size);
 }
 
-static bool valid_memtrace_range(struct memtrace_entry *dev,
-				 unsigned long start, unsigned long size)
-{
-	if ((start >= dev->start) &&
-	    ((start + size) <= (dev->start + dev->size)))
-		return true;
-
-	return false;
-}
-
-static int memtrace_mmap(struct file *filp, struct vm_area_struct *vma)
-{
-	unsigned long size = vma->vm_end - vma->vm_start;
-	struct memtrace_entry *dev = filp->private_data;
-
-	if (!valid_memtrace_range(dev, vma->vm_pgoff << PAGE_SHIFT, size))
-		return -EINVAL;
-
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-
-	if (remap_pfn_range(vma, vma->vm_start,
-			    vma->vm_pgoff + (dev->start >> PAGE_SHIFT),
-			    size, vma->vm_page_prot))
-		return -EAGAIN;
-
-	return 0;
-}
-
 static const struct file_operations memtrace_fops = {
 	.llseek = default_llseek,
 	.read	= memtrace_read,
-	.mmap	= memtrace_mmap,
 	.open	= simple_open,
 };
 
-- 
2.17.1
