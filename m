Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C3752C0323
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:36 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 18:52:08 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9524F2BB0050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:34 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K8kpbJ47579158
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 18:46:51 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K91XWK002051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:33 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V11 13/15] powerpc: split hugepage when using subpage
 protection
Date: Thu, 20 Jun 2013 14:30:25 +0530
Message-Id: <1371718827-15065-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1371718827-15065-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1371718827-15065-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We find all the overlapping vma and mark them such that we don't allocate
hugepage in that range. Also we split existing huge page so that the
normal page hash can be invalidated and new page faulted in with new
protection bits.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/subpage-prot.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index 7c415dd..aa74acb 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -130,6 +130,53 @@ static void subpage_prot_clear(unsigned long addr, unsigned long len)
 	up_write(&mm->mmap_sem);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int subpage_walk_pmd_entry(pmd_t *pmd, unsigned long addr,
+				  unsigned long end, struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->private;
+	split_huge_page_pmd(vma, addr, pmd);
+	return 0;
+}
+
+static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
+				    unsigned long len)
+{
+	struct vm_area_struct *vma;
+	struct mm_walk subpage_proto_walk = {
+		.mm = mm,
+		.pmd_entry = subpage_walk_pmd_entry,
+	};
+
+	/*
+	 * We don't try too hard, we just mark all the vma in that range
+	 * VM_NOHUGEPAGE and split them.
+	 */
+	vma = find_vma(mm, addr);
+	/*
+	 * If the range is in unmapped range, just return
+	 */
+	if (vma && ((addr + len) <= vma->vm_start))
+		return;
+
+	while (vma) {
+		if (vma->vm_start >= (addr + len))
+			break;
+		vma->vm_flags |= VM_NOHUGEPAGE;
+		subpage_proto_walk.private = vma;
+		walk_page_range(vma->vm_start, vma->vm_end,
+				&subpage_proto_walk);
+		vma = vma->vm_next;
+	}
+}
+#else
+static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
+				    unsigned long len)
+{
+	return;
+}
+#endif
+
 /*
  * Copy in a subpage protection map for an address range.
  * The map has 2 bits per 4k subpage, so 32 bits per 64k page.
@@ -168,6 +215,7 @@ long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
 		return -EFAULT;
 
 	down_write(&mm->mmap_sem);
+	subpage_mark_vma_nohuge(mm, addr, len);
 	for (limit = addr + len; addr < limit; addr = next) {
 		next = pmd_addr_end(addr, limit);
 		err = -ENOMEM;
-- 
1.8.1.2
