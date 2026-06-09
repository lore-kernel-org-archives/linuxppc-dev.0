Return-Path: <linuxppc-dev+bounces-22337-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C71CD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:25:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZV5b5Xxlz2ytV;
	Tue, 09 Jun 2026 23:25:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781011523;
	cv=none; b=kXvib5AKgMsENdR6ahcfREaVngujoSk9WVfj7xFnjCUbfyDvq/LxpUHeha5oYg0DByy7rQ3ZGvgsOm+fcSshHdHW/GgmRK3Ucac/fAv/stUHBa4fqaQPRQFen1+CV5QJbFCver7KBDOcCo2eVPE6jUXgnqtxo9Q4fxSPXQ4/AeHDH2oImswkw/LqLc8iSeWDz0U5hAe+hlMK+5+uFguiqb8Js9NB2ujnIn43+icOMlD0A/axFTGmb66JG/vbeKEyKR9ypOmI5+dpm/sDx0IvBWBkOLK+U+5H+oeRYbXTCT+2KQieymHL3624DTStDrf4Xr+PU0Ao075iIbU3A2wWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781011523; c=relaxed/relaxed;
	bh=k7v0vfpWbXL2tO4K5nU3J31VniWsuUDENERYOQ4A7IA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHjsWeeT7hDUBE1gcEZA2V4bBnMFR/sTNeodCU1wHZjUnLGO/4FKjRgtDPLIkNWx6K+ihbaLmW90j4WtJiKKjVeDhsO4M2RDAFwH3z+WnrZStlpDQ8kg8k8Kvf8ggEAv0fnbcAoSiCC3zaEjQnnzKr/rXZllexb4zFijSbNFwhGekTk9gXigPV3t6A6CsFX2es3fCx+DWzxlBzA/fKiiuPq6jO1r5TM1htFPQVt9OxOoW8kLKPye5EyfCuhCaGPmdsE3LzyrzV7l8cXanYIWydWKLrVTBTdug3CRFaZILm5ZU14T6kJgEv+2gdl/SD98mIkk6zQmGqZvDlrCxSImZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=eR1ZDTD4; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=eR1ZDTD4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZV5Z3fXkz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:25:21 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-490c737bcafso2162735e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 06:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781011519; x=1781616319; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7v0vfpWbXL2tO4K5nU3J31VniWsuUDENERYOQ4A7IA=;
        b=eR1ZDTD4h6LLkBB+ABKtDwYV+HzGOnZmwaJtrxkEpCluhOXsq1t5WkhX5JDxeCjJfF
         RdmxaJCc0HYInZ5GztNqrYu0Ezd4bkLIJQcr/nOtSh1KQ37/2ZEW8PlwQ8SR8mroALxM
         CuvaS63J+9mW07cs9USAn2ZH8cMy4+dLeD04Armr36RHI+u/ToRQVgjonYOJIk/y5t5z
         N07jX+t/yonERSl62HQdoC6N+Rq5bSypxF9RzRnwJ8hMkEELE70O8TqGcqu0VibygltL
         EbBMaLKHfATFLaKTfKUg9ZIVB831kgMSkY78yfbs4XkZfTuOLl/MZqiIt+NEeHruZhAz
         8Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011519; x=1781616319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k7v0vfpWbXL2tO4K5nU3J31VniWsuUDENERYOQ4A7IA=;
        b=WAU1Z/7JHAfSb1j4XPJGacLkXbRDCeWiS/3jSI4nOJojqZOWGq/zxsQMCYUXjDydUH
         aMBr1goWpjKVSk5WnguRsiMWq2f6D+4fn/ku1dyBDkaS6FB/2sRJ3MQrEzpG83qaHUdj
         DUUlUs8cASc7jCaS+f28se1LpXvfWFEVEQHNO6NzDJRn3C3/j14iI9kv+aQLVSscgDgB
         YoW26ont6AHTGkeU9MOI+LDuASNXfOHNHqdLWNqQrCu+7pCMIarecQg9qFW4bAVqLeWf
         jlNs/ksv3ykmAVO2eQI0ehMEtteOurm/wMGxCD2BDNPHKsdncqn/EjM/0LFCGiKXGH/F
         8DIg==
X-Forwarded-Encrypted: i=1; AFNElJ/36H33WZUFKcbjv28zNhyk6opW1sRF8lwOxMg+mceqdrSklfnqptAP2hAYH8UgCN3ypVadWq/hC5riEUI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx1U5st3lftiXLTVeI1xRJQH5z2I7F8+VXXx2/fkIYuMVWtHENO
	Emr1PmD9lR+5NgZRtTQvbhGy4Pekapf7v6cA72uww+wo35kCfsrVce/WpCxIx0uC8lg=
X-Gm-Gg: Acq92OHHviQ42SRc+JhuYUgfFX4WCt3jBZeWQYuLzHbT+1+PwWw34P+lNNnzn0FQ+rs
	oBYuiSjtCRP7KFs9ki7VnucDqk5Mp71vvkYDznrksg3cIZnwwxrLJjvCIEPDW+1EK35Hd7EAQR1
	33Pp7IB8QE7vEvqKXAV32YZL82N56tQTwb9w7mBPHDDQIJ9oMdz9heycBq2C2ekOhTsdvbt7gCQ
	uAY5XUKW4mXi/90mgdkbkriGatcLgOiIG3r/YiCu3TfpeFSSgiRYZJXxfwAb/lrKjNo/eQ9Du6Y
	7DmbYhHhhzVRpIPCnHn0lVSiWfORg4D+D/DzDZetz3jIkRMEeyCYVdjvMJmxuRtnmMi4P7KCydK
	AOzn62avTFDkRPOfowZs8KIhMVFiJs5LxABQfMpJQcVv0XaxN8lK+NK8CCKb7l9lbMyACLvsk9K
	CfK7+He/quG5oZiFDQfneZB40=
X-Received: by 2002:a05:600c:1c1e:b0:48a:56d4:7274 with SMTP id 5b1f17b1804b1-490c25e7e1amr167118665e9.3.1781011519006;
        Tue, 09 Jun 2026 06:25:19 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm574197205e9.9.2026.06.09.06.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:25:18 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:23:53 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, Michael Kelley
 <mhklinux@outlook.com>
Subject: Re: [PATCH v6 16/20] dma: swiotlb: free dynamic pools from process
 context
Message-ID: <20260609152353.6a9f60f8@mordecai>
In-Reply-To: <20260604083959.1265923-17-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-17-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:55 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> swiotlb_dyn_free() is used after removing a dynamic swiotlb pool from
> RCU-protected lists. It can call swiotlb_free_tlb(), which may need to
> restore the encryption state of an unencrypted pool with
> set_memory_encrypted() before freeing the pages.
> 
> RCU callbacks run in atomic context, but set_memory_encrypted() is not
> guaranteed to be atomic-safe on all architectures. For example, page
> attribute updates may allocate page tables or take sleeping locks.

Good catch!

> Use queue_rcu_work() for dynamic pool freeing instead. This keeps the RCU
> grace period before freeing a published pool, while running the actual pool
> teardown from workqueue context. Use the same helper for the transient-pool
> error path, since that path may also be reached from atomic DMA mapping
> context.

Strictly speaking, it's not necessary, because this is in the error
path just after allocating a transient pool. There are only two
possible scenarios:

a. The transient buffer was allocated from a sleeping context, and then
   it's also OK to decrypt memory.

b. The transient buffer was allocated in atomic context, but then it was
   allocated from a coherent pool and it is returned to that pool
   rather than decrypted.

However, it's also fine to queue an RCU work. The logic is definitely
cleaner and easier to maintain.

> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  include/linux/swiotlb.h |  4 ++--
>  kernel/dma/swiotlb.c    | 19 +++++++++++--------
>  2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 4dcbf3931be1..526f82e9da45 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -64,7 +64,7 @@ extern void __init swiotlb_update_mem_attributes(void);
>   * @areas:	Array of memory area descriptors.
>   * @slots:	Array of slot descriptors.
>   * @node:	Member of the IO TLB memory pool list.
> - * @rcu:	RCU head for swiotlb_dyn_free().
> + * @dyn_free:	RCU work item used to free the pool from process context.
>   * @transient:  %true if transient memory pool.
>   */
>  struct io_tlb_pool {
> @@ -79,7 +79,7 @@ struct io_tlb_pool {
>  	struct io_tlb_slot *slots;
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  	struct list_head node;
> -	struct rcu_head rcu;
> +	struct rcu_work dyn_free;
>  	bool transient;
>  	bool unencrypted;
>  #endif
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index f4e8b241a1c4..4c56f64602ea 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -774,13 +774,10 @@ static void swiotlb_dyn_alloc(struct work_struct *work)
>  	add_mem_pool(mem, pool);
>  }
>  
> -/**
> - * swiotlb_dyn_free() - RCU callback to free a memory pool
> - * @rcu:	RCU head in the corresponding struct io_tlb_pool.
> - */
> -static void swiotlb_dyn_free(struct rcu_head *rcu)
> +static void swiotlb_dyn_free_work(struct work_struct *work)
>  {
> -	struct io_tlb_pool *pool = container_of(rcu, struct io_tlb_pool, rcu);
> +	struct io_tlb_pool *pool =
> +		container_of(to_rcu_work(work), struct io_tlb_pool, dyn_free);
>  	size_t slots_size = array_size(sizeof(*pool->slots), pool->nslabs);
>  	size_t tlb_size = pool->end - pool->start;
>  
> @@ -789,6 +786,12 @@ static void swiotlb_dyn_free(struct rcu_head *rcu)
>  	kfree(pool);
>  }
>  
> +static void swiotlb_schedule_dyn_free(struct io_tlb_pool *pool)
> +{
> +	INIT_RCU_WORK(&pool->dyn_free, swiotlb_dyn_free_work);
> +	queue_rcu_work(system_wq, &pool->dyn_free);
> +}
> +
>  /**
>   * __swiotlb_find_pool() - find the IO TLB pool for a physical address
>   * @dev:        Device which has mapped the DMA buffer.
> @@ -835,7 +838,7 @@ static void swiotlb_del_pool(struct device *dev, struct io_tlb_pool *pool)
>  	list_del_rcu(&pool->node);
>  	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
>  
> -	call_rcu(&pool->rcu, swiotlb_dyn_free);
> +	swiotlb_schedule_dyn_free(pool);
>  }
>  
>  #endif	/* CONFIG_SWIOTLB_DYNAMIC */
> @@ -1276,7 +1279,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  	index = swiotlb_search_pool_area(dev, pool, 0, orig_addr, tbl_dma_addr,
>  					 alloc_size, alloc_align_mask);
>  	if (index < 0) {
> -		swiotlb_dyn_free(&pool->rcu);
> +		swiotlb_schedule_dyn_free(pool);
>  		return -1;
>  	}
>  


