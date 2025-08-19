Return-Path: <linuxppc-dev+bounces-11146-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782DECA0EE6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Aug 2025 17:39:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c5xfB6f5Cz3dLQ;
	Wed, 20 Aug 2025 03:39:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755625154;
	cv=none; b=DYS367MzFkr6Q58CjgNDeV2pzfxeNfHYVfyEHhWiUQqpGbungoVZtNvTLd5qPBRf8RzCeBVjYPG11EsfOaKadPux4nVwNXyvNLlFLo8GCMOEP95tC8JOKhmiuvFn8jiOi/LZfzfH0OuVqdPAHrI2zkmaRJznAhm+HfAUU3RwecA72dgC0MlGr/pdqxNPNy4Ca1Hb389UZNgg+6vwqWDI2Abzhn73x86Qo29JgiSjIg9o+MqW2Bzqhf+wOg8yepCMMc+2ycxp7g6V10onKkCMMpab3Ggp0Pjb8A5VU3xaXUghgqzOglJCoMJWIYiu81IwcinfA6Yk4QXoZF+3dpcO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755625154; c=relaxed/relaxed;
	bh=o2CfBR34rERHeCycfJu/oeNhZ6WULnoBhGEgp0otVxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUek0SzzhtEjCHkfxhv1FhZOpvcX51g16m30Mq7eQQxAwO0Pg8qm0Iz0FXYMiKhcKLi6FJ+k8myJSPEAscJ0KtX6B7xEbeqUFAEVzzipAQP1bN+oF0VtIFnJNOUqbFUE9tqoUnkxaqnHyWpOZxOxB9Jy3TdHbdJSMQrJ8pBNme8u7mI+sQN63ZVSqvHFo2ItXBWy5ozdUrcRtn2hwBHcevdMMDeJAqHOwFaP5iFLs9Vrc7rX4qBShGlL48CubnR2yTk9qsoIs5/S8qrX9W0QovddieCxQraL5NGeIWGAhXrT31wgYJAURkx+cVF3lxRNwBLnDZTh81ihy1f7orwojw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hP0G8Q00; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hP0G8Q00;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c5xfB28p4z3dLG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2025 03:39:14 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5A73A61437;
	Tue, 19 Aug 2025 17:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44ECC113D0;
	Tue, 19 Aug 2025 17:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755625141;
	bh=shzOb9LxCd4j9ffIAYJARd3Ll/bIHN63Rdsm8jF6HN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hP0G8Q00yNTh5FfM8EvmXjWXPCW1VAkoQrIqWO2opf8nY5Pp8kyRoAQ5sJbskFxHe
	 Dpw2oE6bb6R9DP3zDSAoqrpgkr4LknFTjksf2ZVtrQBA00wb60mjNgoeDWPO1iTMvR
	 mOZkqJAPBVE7i3vpf3SqAKzTQw9K5Rc7DptngH5viddKvezFNMaYxTj51UPsnXjIa2
	 zH66GE5Ky5jjWEuNnqpxi+DfDo3WTnC7VWe1CnDp489D3vz6rDN4s4/RlMVvekkmmH
	 q8YXIBSj9tnBwBYbvKw41cRhfgSA56D3XB40ha8nKdeMey7WqJRapAA4sbPWPZyDe2
	 vdbwCoOpeQYmA==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nvme@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v4 16/16] nvme-pci: unmap MMIO pages with appropriate interface
Date: Tue, 19 Aug 2025 20:37:00 +0300
Message-ID: <545fffb8c364f36102919a5a1d57137731409f3c.1755624249.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755624249.git.leon@kernel.org>
References: <cover.1755624249.git.leon@kernel.org>
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

From: Leon Romanovsky <leonro@nvidia.com>

Block layer maps MMIO memory through dma_map_phys() interface
with help of DMA_ATTR_MMIO attribute. There is a need to unmap
that memory with the appropriate unmap function, something which
wasn't possible before adding new REQ attribute to block layer in
previous patch.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/pci.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2c6d9506b172..f8ecc0e0f576 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -682,11 +682,15 @@ static void nvme_free_prps(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	unsigned int attrs = 0;
 	unsigned int i;
 
+	if (req->cmd_flags & REQ_MMIO)
+		attrs = DMA_ATTR_MMIO;
+
 	for (i = 0; i < iod->nr_dma_vecs; i++)
-		dma_unmap_page(nvmeq->dev->dev, iod->dma_vecs[i].addr,
-				iod->dma_vecs[i].len, rq_dma_dir(req));
+		dma_unmap_phys(nvmeq->dev->dev, iod->dma_vecs[i].addr,
+				iod->dma_vecs[i].len, rq_dma_dir(req), attrs);
 	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
 }
 
@@ -699,15 +703,19 @@ static void nvme_free_sgls(struct request *req)
 	unsigned int sqe_dma_len = le32_to_cpu(iod->cmd.common.dptr.sgl.length);
 	struct nvme_sgl_desc *sg_list = iod->descriptors[0];
 	enum dma_data_direction dir = rq_dma_dir(req);
+	unsigned int attrs = 0;
+
+	if (req->cmd_flags & REQ_MMIO)
+		attrs = DMA_ATTR_MMIO;
 
 	if (iod->nr_descriptors) {
 		unsigned int nr_entries = sqe_dma_len / sizeof(*sg_list), i;
 
 		for (i = 0; i < nr_entries; i++)
-			dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
-				le32_to_cpu(sg_list[i].length), dir);
+			dma_unmap_phys(dma_dev, le64_to_cpu(sg_list[i].addr),
+				le32_to_cpu(sg_list[i].length), dir, attrs);
 	} else {
-		dma_unmap_page(dma_dev, sqe_dma_addr, sqe_dma_len, dir);
+		dma_unmap_phys(dma_dev, sqe_dma_addr, sqe_dma_len, dir, attrs);
 	}
 }
 
-- 
2.50.1


