Return-Path: <linuxppc-dev+bounces-20778-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786EDCD4855
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 09:06:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF9gq1RcMz2ytV;
	Tue, 12 May 2026 19:06:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778576791;
	cv=none; b=nWnJijkVCxqVh1BXdA4HOgsQcoLcIqbL0y1JheBXfJH96GdsBtQrOjLNxyND8vT+k0dIHhJYOaxCW3athhK2xv8s0OFQAV1KxZVTPOVmrMgu4uPJctZw1Me5BuzhZczihzpTxk1FHOfBt/pQX9NZXTZ52BY02RjHUUo9ZtQ5Xtl+GiPkdqtAMj3xlyzPr+UKkX2rmYxzhonIr7jTMUchJtmack03XgptZTd2mnbXGiXgS3EvOf/J4wlNROA9VxLzSj5dOWBEMWdcLkDKV3RltkuOcD5plKZI4zUJAri9FfPkxexqQtf99K6tVfF+zagyX2NpW2Wpf7uskhwNcIwj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778576791; c=relaxed/relaxed;
	bh=piaqFytxUkR7fwUD1Gmkhx+SmTmed3hfV993jUzNySY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dq6e+ZO60gMT/UwfnG7RzpAepwA5zsdSM7+vPCmq2ojEoxyO8Fd+/E4Wxf5n5l3RLstBNs2KSUvj5U/glEnAhcqMCbApzBN6NXqf4RQIWXa8jrHKdLGzpMHnSLOzfZR5DWNbDIcCAO/UBcTU08cgvqyUmpqaMWt/i/n1ZbtORw/3uVATjsJqy7tPvuEzQ/9OBMx/Gkm8HW3cXaczZfmt3zCwp1gRhhbElcjdcejYcBVl1yhe2PMZRHNOnN/d+osABkLfVaDXZzS9gHEUzhowIFwu+KFy1TIjWPWxBSDJD7zsQ0CgEioFaLJqdsCE5lv/JedLD7TdQHGEuqg73jxQ5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hfEmbaD1; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hfEmbaD1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF9gp4SFMz2yqP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 19:06:30 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B8141600CB;
	Tue, 12 May 2026 09:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C140BC2BCC7;
	Tue, 12 May 2026 09:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778576788;
	bh=veSEmK9Ug4szH3v0qgbFOODgpY5EJGxq5OFtSmQEZoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hfEmbaD1vx0OtPyt/2zEwcfXvzz2enHIUHpU/ddgBvzPmsG0FKkM8cGvnL6yBHpxk
	 4jHpHHoYShzlZH9rztYvxJBggVXmDlGdmaU2VTP1Twa68ti+ABZKBLBjOyGE2Glmva
	 4eLsOWHe3HEgbKtQeVTPtBwyxACwv0llrWmj024jJKEohKuYvakIwLhtsSCD/y7/Z+
	 0Alxpd03yhdikbAyeOllS8BT/tFi2PamwbpCUvLLoPmv81EyPHdPMxORvnuulZP/8B
	 v3ozOATeqYxIv/FKeuK5uxsHLgCPQeZgin3CqA4AOi9eOLu3iXFg7ZWbifu1AU0/gT
	 cmtPif0ZHnFIw==
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
Subject: [PATCH v4 10/13] dma-pool: fix page leak in atomic_pool_expand() cleanup
Date: Tue, 12 May 2026 14:34:05 +0530
Message-ID: <20260512090408.794195-11-aneesh.kumar@kernel.org>
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

atomic_pool_expand() frees the allocated pages from the remove_mapping
error path only when CONFIG_DMA_DIRECT_REMAP is enabled.

When CONFIG_DMA_DIRECT_REMAP is disabled, failures after page allocation,
such as gen_pool_add_virt(), jump to remove_mapping and return without
freeing the pages.

Move __free_pages(page, order) out of the CONFIG_DMA_DIRECT_REMAP block so
that cleanup paths always release the allocation.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 75f0eba48a23..5abd30c5119f 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -149,8 +149,8 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
 free_page:
-	__free_pages(page, order);
 #endif
+	__free_pages(page, order);
 out:
 	return ret;
 }
-- 
2.43.0


