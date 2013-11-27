Return-Path: <zhouzhouyi@gmail.com>
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 740372C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2013 21:51:22 +1100 (EST)
Received: by mail-pd0-f181.google.com with SMTP id p10so9561210pdj.26
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2013 02:51:18 -0800 (PST)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: Zhouyi Zhou <yizhouzhou@ict.ac.cn>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <kvm-ppc@vger.kernel.org>,
 <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/1] kernel code that do not handle NULL return of
 kmem_cache_zalloc
Date: Wed, 27 Nov 2013 18:51:05 +0800
Message-Id: <1385549465-15945-1-git-send-email-yizhouzhou@ict.ac.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I do a grep for kmem_cache_zalloc and kmem_cache_alloc
in kernel tree, and find some code do not handle NULL
return of kmem_cache_zalloc correctly


Signed-off-by: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
---
 arch/powerpc/kvm/book3s_32_mmu_host.c |    5 +++++
 drivers/iommu/omap-iommu.c            |    3 ++-
 fs/jffs2/malloc.c                     |    4 ++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
index 3a0abd2..5fac89d 100644
--- a/arch/powerpc/kvm/book3s_32_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
@@ -243,6 +243,11 @@ next_pteg:
 	/* Now tell our Shadow PTE code about the new page */
 
 	pte = kvmppc_mmu_hpte_cache_next(vcpu);
+	if (!pte) {
+		kvm_release_pfn_clean(hpaddr >> PAGE_SHIFT);
+		r = -EAGAIN;
+		goto out;
+	}
 
 	dprintk_mmu("KVM: %c%c Map 0x%llx: [%lx] 0x%llx (0x%llx) -> %lx\n",
 		    orig_pte->may_write ? 'w' : '-',
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index bcd78a7..5155714 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -551,7 +551,8 @@ static u32 *iopte_alloc(struct omap_iommu *obj, u32 *iopgd, u32 da)
 		dev_vdbg(obj->dev, "%s: a new pte:%p\n", __func__, iopte);
 	} else {
 		/* We raced, free the reduniovant table */
-		iopte_free(iopte);
+		if (iopte)
+			iopte_free(iopte);
 	}
 
 pte_ready:
diff --git a/fs/jffs2/malloc.c b/fs/jffs2/malloc.c
index 4f47aa2..58e2336 100644
--- a/fs/jffs2/malloc.c
+++ b/fs/jffs2/malloc.c
@@ -287,6 +287,8 @@ struct jffs2_xattr_datum *jffs2_alloc_xattr_datum(void)
 {
 	struct jffs2_xattr_datum *xd;
 	xd = kmem_cache_zalloc(xattr_datum_cache, GFP_KERNEL);
+	if (!xd)
+		return NULL;
 	dbg_memalloc("%p\n", xd);
 
 	xd->class = RAWNODE_CLASS_XATTR_DATUM;
@@ -305,6 +307,8 @@ struct jffs2_xattr_ref *jffs2_alloc_xattr_ref(void)
 {
 	struct jffs2_xattr_ref *ref;
 	ref = kmem_cache_zalloc(xattr_ref_cache, GFP_KERNEL);
+	if (!ref)
+		return NULL;
 	dbg_memalloc("%p\n", ref);
 
 	ref->class = RAWNODE_CLASS_XATTR_REF;
-- 
1.7.10.4
