Return-Path: <linuxppc-dev+bounces-23267-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066F4C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 05:53:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqq1y5DVqz2yr9;
	Wed, 01 Jul 2026 15:53:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782885206;
	cv=none; b=QjXfpqDvPNsJ5+zzf57owmu29+9nLeI0pmMdnwkfEVyO6gYJXa2mkWEHhTeGVxNkH6U3mSRm42yBTiL7cKCPxaT+0eRdVfoLwjtL8RUd69CwrdcZhWY9wp3tpeMI6K30dkce164O9ngwf8RBs3/CZcnfInLI26+RVozQpZOt0hWFJF3/T1cRZ4xJ/5DN1A+1iVpf9ciw9IrNtJV4ucHdFp0lzIMZ5kMkegkNEfP8mxIy328uyzVmCHW47mcBCCDgjcpJa6tqOQsTuOZT8qTiyIdFOkje4yI3djnrW/WG4Ej5KjxTMEL9L2WrOEndq9+mp1ASkN4JxO0bopMentAZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782885206; c=relaxed/relaxed;
	bh=+N7VVODChZxFmZKynUomGOW/L3aQ1CGwQqBrr7RD6DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6Emrlu1/ZHBUrC74TU2ICxPyQf2HQLknD+gwOYV3x5PResQuAM/NpoXJB7M8NPGcIbqF7WS/f2D8KTZ9HlGg/iH8Qfp0bYJugRUgB/eyp+G07qMWS/gLkYqrWKwwBi8MP5TzpedVqHN+delsurKNHYl56VJlymYuV9uXCKwbFi7LuDIRl//RG3MaCxSZnwYWL3OExMBKG1ctYRo4unCpZMvFVVhiux46GtcYbw3LHiyYHcYOoRwSHgNnIUHKr8R2rAtKTSICJ+VH9kni/EXtck8mzb3ECzNL6S/g1rQCZbOHu9voBQjMtuypML6nEQ9p9Q6pTTPx1aq6vQD9aSIUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRCzDK55; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRCzDK55;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqq1y0Clpz2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 15:53:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 817374114B;
	Wed,  1 Jul 2026 05:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4274C1F000E9;
	Wed,  1 Jul 2026 05:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885204;
	bh=+N7VVODChZxFmZKynUomGOW/L3aQ1CGwQqBrr7RD6DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dRCzDK55Bn+hAxfCj6J/6cTWJDixbKne2+kMs0bwH03lOop6QVmHWrm44g+yanT1G
	 dn2PJXeyEtP9NIN2P8iT2D/cPnmidpVOT1r5Fc+T2I3uH+0EerDXS+ueCyyXl61rCa
	 YxogkiNkyhaYuORE90YZ9cDhFYyrfCQjFHxUNxNIDRkAHHfunm95D/8Hh1yalr7Gl4
	 SZFql5vjZ7k1KLw1StlSNhZtH8O4YnU2sfOR/i3ME0hHMgHQs/g/wD4VCs89vt3clW
	 /tj90gzI5fQKa+joMNiGMN+1li5oXKGt/860klTzIH6/GliNNLQl7r7NaPAEj5lzvF
	 scl8J9G0WrGIg==
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
	x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v7 20/22] dma: swiotlb: free dynamic pools from process context
Date: Wed,  1 Jul 2026 11:19:24 +0530
Message-ID: <20260701054926.825925-21-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701054926.825925-1-aneesh.kumar@kernel.org>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
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

swiotlb_dyn_free() is used after removing a dynamic swiotlb pool from
RCU-protected lists. It can call swiotlb_free_tlb(), which may need to
restore the encryption state of an unencrypted pool with
set_memory_encrypted() before freeing the pages.

RCU callbacks run in atomic context, but set_memory_encrypted() is not
guaranteed to be atomic-safe on all architectures. For example, page
attribute updates may allocate page tables or take sleeping locks.

Use queue_rcu_work() for dynamic pool freeing instead. This keeps the RCU
grace period before freeing a published pool, while running the actual pool
teardown from workqueue context. Use the same helper for the transient-pool
error path, since that path may also be reached from atomic DMA mapping
context.

Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 include/linux/swiotlb.h |  4 ++--
 kernel/dma/swiotlb.c    | 19 +++++++++++--------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index ee42f7588847..c3bf7ed6f7a6 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -64,7 +64,7 @@ extern void __init swiotlb_update_mem_attributes(void);
  * @areas:	Array of memory area descriptors.
  * @slots:	Array of slot descriptors.
  * @node:	Member of the IO TLB memory pool list.
- * @rcu:	RCU head for swiotlb_dyn_free().
+ * @dyn_free:	RCU work item used to free the pool from process context.
  * @transient:  %true if transient memory pool.
  * @cc_shared:	%true if the pool memory is shared for confidential computing.
  */
@@ -80,7 +80,7 @@ struct io_tlb_pool {
 	struct io_tlb_slot *slots;
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	struct list_head node;
-	struct rcu_head rcu;
+	struct rcu_work dyn_free;
 	bool transient;
 	bool cc_shared;
 #endif
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b5960c2e98d8..4d0f2c04d891 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -779,13 +779,10 @@ static void swiotlb_dyn_alloc(struct work_struct *work)
 	add_mem_pool(mem, pool);
 }
 
-/**
- * swiotlb_dyn_free() - RCU callback to free a memory pool
- * @rcu:	RCU head in the corresponding struct io_tlb_pool.
- */
-static void swiotlb_dyn_free(struct rcu_head *rcu)
+static void swiotlb_dyn_free_work(struct work_struct *work)
 {
-	struct io_tlb_pool *pool = container_of(rcu, struct io_tlb_pool, rcu);
+	struct io_tlb_pool *pool =
+		container_of(to_rcu_work(work), struct io_tlb_pool, dyn_free);
 	size_t slots_size = array_size(sizeof(*pool->slots), pool->nslabs);
 	size_t tlb_size = pool->end - pool->start;
 
@@ -794,6 +791,12 @@ static void swiotlb_dyn_free(struct rcu_head *rcu)
 	kfree(pool);
 }
 
+static void swiotlb_schedule_dyn_free(struct io_tlb_pool *pool)
+{
+	INIT_RCU_WORK(&pool->dyn_free, swiotlb_dyn_free_work);
+	queue_rcu_work(system_wq, &pool->dyn_free);
+}
+
 /**
  * __swiotlb_find_pool() - find the IO TLB pool for a physical address
  * @dev:        Device which has mapped the DMA buffer.
@@ -840,7 +843,7 @@ static void swiotlb_del_pool(struct device *dev, struct io_tlb_pool *pool)
 	list_del_rcu(&pool->node);
 	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
 
-	call_rcu(&pool->rcu, swiotlb_dyn_free);
+	swiotlb_schedule_dyn_free(pool);
 }
 
 #endif	/* CONFIG_SWIOTLB_DYNAMIC */
@@ -1281,7 +1284,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	index = swiotlb_search_pool_area(dev, pool, 0, orig_addr, tbl_dma_addr,
 					 alloc_size, alloc_align_mask);
 	if (index < 0) {
-		swiotlb_dyn_free(&pool->rcu);
+		swiotlb_schedule_dyn_free(pool);
 		return -1;
 	}
 
-- 
2.43.0


