Return-Path: <linuxppc-dev+bounces-20773-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06D8CD4851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 09:05:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF9fh39ztz2yqs;
	Tue, 12 May 2026 19:05:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778576732;
	cv=none; b=oFSO1gSfJJteJpMtCptxAkbI+0NnzKaITgDjpWDDDeRkpa0AxN6xc5JNTtg2waN/Gd8rllM3mur20aP6Ld5FJ9QRbF5S35pHOu90zj/24GAgwRPGz/pVNC8DG7B0dSn324FIwp8SfaBnCNGIbSetuLzmBX7+ACjWH3oHWkpJRze7XOXi4MQYt8MyBzvVdGArMnrmryG43LMpNmNGEu8HHieL83Z+dV2Y9cMdNyTekGGxl2rVIJgIwfjY8mkOskbjCBaZXIPo63/k8KE51+VX8Tkyu29NiveAilGCU3Ae0+D0dbtsdKD715B8OBa5Ysr+2dwwg5GyHJvGU2V7oVf0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778576732; c=relaxed/relaxed;
	bh=cHkoIqOn+tRTxVyuZ6YpuR+upIrx+a6VyEiW8TBWung=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T18pI3qiKvV8STu3+boqlslMhUodivyEH/q16pJ4sMREeBSEs3340ONGrv3LByynt6U98/h5MIp6u5HYAsMrCv+bfWOjPK1M4i6TK7Hj3LRrt31e+enMR8LzrtIV47jAmFondRHrj0MISbbSDKdA4scRZG4jjnyJfr4BukYD1K0W/xFZfzTRqJYp4CgPl4PUMTdJjMMIeSfUMckNM6SCuCSx1SRH67knUd7+CilshA5YtPPu2taDseVMg5jVAbISVCJWuVzk+OpmiD8LCFuZveaAQLqfy/zBjZQp5l3/9IcDreC6y07M6us2kvS0wN0/8FDNycxdmRDV6aLoymqDOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PshDt4XM; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PshDt4XM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF9fg4kVXz2ygL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 19:05:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E525A43EDE;
	Tue, 12 May 2026 09:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907ECC2BCC7;
	Tue, 12 May 2026 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778576729;
	bh=9Mg/60FkAPiuc5fK1clRWn/J5QY6mHmOM4Gl+OW5I34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PshDt4XM1mvyyVNCfQLjWwIf61GnnlnERZolrSawcYkDpIfioObQLoAfIjMw/7M9Q
	 YTz8/cGsgsVdmSVFE/GDDmGWLQM5F4mbClisOqcvomviQfO7wGGvr66P5s7Yiwte+5
	 fybLHXIDwBOPobE+QScCdJAI7IZ0kpk0ywCc2LZ19NFx0yfONadhppdaHsCn2eAjh8
	 GG2JzF/vxM9xMkbcFyz8zC2oyR5p+10XySzCrgJhMLuYJFT1/jmjORHauK5wfh1zjO
	 /VYUPHV3+vGyJTDhUvmUU0I3RSZ8c0/PMsyqyLxd7jCDFGv0lm7o8rsAl39LxXz082
	 XDhYX9Ue6FRQA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org
Subject: [PATCH v4 05/13] dma-mapping: make dma_pgprot() honor DMA_ATTR_CC_SHARED
Date: Tue, 12 May 2026 14:34:00 +0530
Message-ID: <20260512090408.794195-6-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512090408.794195-1-aneesh.kumar@kernel.org>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fold encrypted/decrypted pgprot selection into dma_pgprot() so callers
do not need to adjust the page protection separately.

Update dma_pgprot() to apply pgprot_decrypted() when
DMA_ATTR_CC_SHARED is set and pgprot_encrypted() otherwise Convert
the dma-direct allocation and mmap paths to pass DMA_ATTR_CC_SHARED
instead of open-coding force_dma_unencrypted() handling around
dma_pgprot().

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c  |  8 +++-----
 kernel/dma/mapping.c | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 97ae4fa10521..ac315dd046c4 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -298,9 +298,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (remap) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
-		if (force_dma_unencrypted(dev))
-			prot = pgprot_decrypted(prot);
-
 		/* remove any dirty cache lines on the kernel alias */
 		arch_dma_prep_coherent(page, size);
 
@@ -603,9 +600,10 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn = PHYS_PFN(dma_to_phys(dev, dma_addr));
 	int ret = -ENXIO;
 
-	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
 	if (force_dma_unencrypted(dev))
-		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+		attrs |= DMA_ATTR_CC_SHARED;
+
+	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 23ed8eb9233e..44f715f3aa2d 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -543,13 +543,21 @@ EXPORT_SYMBOL(dma_get_sgtable_attrs);
  */
 pgprot_t dma_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
 {
+	pgprot_t dma_prot;
+
 	if (dev_is_dma_coherent(dev))
-		return prot;
+		dma_prot = prot;
 #ifdef CONFIG_ARCH_HAS_DMA_WRITE_COMBINE
-	if (attrs & DMA_ATTR_WRITE_COMBINE)
-		return pgprot_writecombine(prot);
+	else if (attrs & DMA_ATTR_WRITE_COMBINE)
+		dma_prot = pgprot_writecombine(prot);
 #endif
-	return pgprot_dmacoherent(prot);
+	else
+		dma_prot = pgprot_dmacoherent(prot);
+
+	if (attrs & DMA_ATTR_CC_SHARED)
+		return pgprot_decrypted(dma_prot);
+	else
+		return pgprot_encrypted(dma_prot);
 }
 #endif /* CONFIG_MMU */
 
-- 
2.43.0


