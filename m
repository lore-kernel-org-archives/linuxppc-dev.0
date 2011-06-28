Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD9F1B6F5A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 05:56:55 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] fs/hugetlbfs/inode.c: Fix pgoff alignment checking on
	32-bit
Date: Tue, 28 Jun 2011 14:54:44 -0500
Message-Id: <13092909493748-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <1309290888309-git-send-email-beckyb@kernel.crashing.org>
References: <1309290888309-git-send-email-beckyb@kernel.crashing.org>
Cc: wli@holomorphy.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

This:

vma->vm_pgoff & ~(huge_page_mask(h) >> PAGE_SHIFT)

is incorrect on 32-bit.  It causes us to & the pgoff with
something that looks like this (for a 4m hugepage): 0xfff003ff.
The mask should be flipped and *then* shifted, to give you
0x0000_03fff.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 fs/hugetlbfs/inode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7aafeb8..537a209 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -94,7 +94,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_HUGETLB | VM_RESERVED;
 	vma->vm_ops = &hugetlb_vm_ops;
 
-	if (vma->vm_pgoff & ~(huge_page_mask(h) >> PAGE_SHIFT))
+	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
 		return -EINVAL;
 
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
-- 
1.5.6.5
