Return-Path: <linuxppc-dev+bounces-25516-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B36BC5AC67
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 18:37:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGGGY01hJz3byh;
	Fri, 07 Aug 2026 04:37:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786041428;
	cv=none; b=YNjfigtpVbUaAW7v0JGTwDFpwPR56d7jB3BuCW0h8QqP2yJ2pEB2FSIqXjSlZ0lUsdgkWTsea15ikfjfaHv4fDhX0SdJR7nmyox5ihP7Exn7UHEsP3F2yU324kAe/Nkyi9LO9ZjmU9snrZow2/O1ngoT9b7Ob70Aymo4hDrGPkUMvhZiIOnECrncjytcXr5ywVztoiQ0pR0zYhtLp5Pf1g81bWAnBnAMEYIRDRRNOqzrVc4E+gpbVLkDFbd1Lcewn8NgJXFFF8cdssDC/lwtIg2AYqIAnVSYFiDnvhstw074EiI1moWatbe+zsJkoduUm7Os+Zca7AH7w9XUfbjDww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786041428; c=relaxed/relaxed;
	bh=CnhGS3BrNb0/ghDK+6g25kaQq2VEHr155B30XJE1rZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUVjjUD4YB1oodRrWu966IZzl05HRyV8l2bD5KJmcqzEzZBKRbfvzOSlqlQli344DJxCo0SgwcR/UOFR+eaAM+yMiynM549IgCLdO4H4MUJico2ATWEm8QG6HkVHJybq8pLkwWrasOz16UkYrQXS/YgPqyJCMgf/f9YYoGFj8Ty3KWYy/H9yPlj+mONPN6pdkVh8IH93zzI9gAbiTeEpsnME6yTj2bXjQqWpTcb49chZmn/LPfiNMeX49RyzHycfypOV4zearBIkPd0ja0UOBn6dToggRBrrDE9faQu6rN8zvO0zGJEZ2PKjLZh1YZhguEx9GvU2+Dx8H1Wi7Vtwvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBmW791L; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBmW791L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGGGV0zWrz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 04:37:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EB2DA60A97;
	Thu,  6 Aug 2026 18:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231D91F000E9;
	Thu,  6 Aug 2026 18:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041423;
	bh=CnhGS3BrNb0/ghDK+6g25kaQq2VEHr155B30XJE1rZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hBmW791Lo6H1eZ1doTkvr3622RiJJchSASYd3qcsg6TRQCkJlOHDGp7zH0ygvOzqQ
	 6ycq4Z7ryLN1bQEsQpViuHEyH1pB0dn+wPwhgWR218vPh0AkMQDEe8TeA4OJ34sRIz
	 JGQeZ7Xh5NMg9piMIqKKSYwO0q5nMZUtA1NwD43qfHHzqTp5w13yBc5s3q7pWV5vg/
	 bF8G8wwllvGC2IkmLI7K8JCgGbpX+JLeEKZ6PDo8los+LbgM/m54f5qBN0LGDN2v5R
	 jy9oss/7bCRT4zQTaxyeHh6fa/nJS0KkGa7Q+2XIUBC04hXXoy/qkDq0a++Wge5XVh
	 zU3a1UGkH5Ivg==
From: Jakub Kicinski <kuba@kernel.org>
To: mmc@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	horms@kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	simon.horman@corigine.com,
	shaik.abdulla1@ibm.com,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v4 04/14] ibmveth: Refactor buffer pool management for per-queue MQ RX
Date: Thu,  6 Aug 2026 11:37:02 -0700
Message-ID: <20260806183702.3175208-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e22471625e6a04bee87f099f467d575bcfd0c2c6.1785457143.git.mmc@linux.ibm.com>
References: <e22471625e6a04bee87f099f467d575bcfd0c2c6.1785457143.git.mmc@linux.ibm.com>
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ibmveth: Refactor buffer pool management for per-queue MQ RX

This reworks the five RX buffer pools into per-queue arrays
(rx_buff_pool[queue][pool]) with new alloc/free helpers, wires those
helpers into ibmveth_open()/ibmveth_close(), and clones pool geometry from
queue 0 to queues 1..N.  It also flips the default active flag of the
64 KiB pool to 0.

A few questions below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 1007dd95cde02..7a2ed49cad4f1 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -625,6 +625,145 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
>  	}
>  }
>  
> +/**
> + * ibmveth_alloc_queue_buffer_pools - Allocate buffer pools for a single queue
> + * @adapter: ibmveth adapter structure
> + * @queue: queue index
> + *
> + * Allocates all active buffer pools for the specified queue.
> + * Pool metadata must be initialized before calling this function.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int ibmveth_alloc_queue_buffer_pools(struct ibmveth_adapter *adapter,
> +					    int queue)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	int i;
> +
> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> +		struct ibmveth_buff_pool *bpool =
> +			&adapter->rx_buff_pool[queue][i];
> +
> +		if (!bpool->active)
> +			continue;
> +
> +		if (ibmveth_alloc_buffer_pool(bpool)) {
> +			netdev_err(netdev,
> +				   "pool %d/%d alloc failed (size=%u count=%u)\n",
> +				   i, queue,
> +				   bpool->buff_size,
> +				   bpool->size);
> +			bpool->active = 0;
> +
> +			/* Free pools allocated so far for this queue */
> +			while (--i >= 0) {
> +				struct ibmveth_buff_pool *fpool =
> +					&adapter->rx_buff_pool[queue][i];
> +
> +				if (fpool->active)
> +					ibmveth_free_buffer_pool(adapter,
> +								 fpool);
> +			}

[Severity: Low]

Is the free predicate here meant to differ from the one used by the sibling
helper added in the same patch?

This unwind path keys off fpool->active, while
ibmveth_free_queue_buffer_pools() deliberately frees by allocation
presence:

	if (pool->free_map || pool->dma_addr || pool->skbuff)
		ibmveth_free_buffer_pool(adapter, pool);

and the changelog states "free paths release by real allocations
(free_map/dma_addr/skbuff), not only pool->active".

So on the queue that fails, a pool holding allocations with active == 0 is
never released, which is exactly the case the allocation-based predicate
was added for.  Since a failing ndo_open means ibmveth_close() is never
called, would those free_map/dma_addr/skbuff arrays be leaked?

ibmveth_free_buffer_pool() already NULLs all three pointers and is
idempotent, so could the unwind just call ibmveth_free_queue_buffer_pools()
on the same queue (or use the same predicate)?  The same helper is reused
by the incremental resize path later in the series, where pools can hold
memory while active is clear.

> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ibmveth_free_queue_buffer_pools - Free buffer pools for a single queue
> + * @adapter: ibmveth adapter structure
> + * @queue: queue index
> + *
> + * Frees all active buffer pools for the specified queue.
       ^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]

The kernel-doc summary says "all active buffer pools", but the body
intentionally ignores the active flag and frees on allocation presence, and
the in-body comment says the opposite of the summary.  Could the summary be
reworded to say pools that have allocations?  Later MQ patches reuse this
helper and depend on that distinction.

> + */
> +static void ibmveth_free_queue_buffer_pools(struct ibmveth_adapter *adapter,
> +					    int queue)
> +{
> +	int i;
> +
> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> +		struct ibmveth_buff_pool *pool =
> +			&adapter->rx_buff_pool[queue][i];
> +
> +		/* Free pool if it has allocated memory, regardless of
> +		 * active flag. Pools may have memory allocated but not
> +		 * marked active during queue scale-up, so we must check
> +		 * for actual allocations.
> +		 */
> +		if (pool->free_map || pool->dma_addr || pool->skbuff)
> +			ibmveth_free_buffer_pool(adapter, pool);
> +	}
> +}
> +

[ ... ]

> +static int
> +ibmveth_alloc_buffer_pools(struct ibmveth_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	int i, q, rc;
> +
> +	/* Initialize pool metadata for queues 1-15 from queue 0 settings */
                                            ^^^^^^^^^^

[Severity: Low]

IBMVETH_MAX_RX_QUEUES is 1U at this commit, so queues 1-15 do not exist yet
and this loop body cannot run.  Should the comment say "queues 1..N" until
the bound is raised later in the series?

> +	for (q = 1; q < adapter->num_rx_queues; q++) {
> +		for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> +			struct ibmveth_buff_pool *src =
> +				&adapter->rx_buff_pool[0][i];
> +			struct ibmveth_buff_pool *dst =
> +				&adapter->rx_buff_pool[q][i];
> +
> +			dst->size = src->size;
> +			dst->index = src->index;
> +			dst->buff_size = src->buff_size;
> +			dst->threshold = src->threshold;
> +			dst->active = src->active;
> +		}
> +	}

[Severity: Low]

This turns the per-pool sysfs knobs into a per-queue template.  Is that
intended to stay undocumented?

Only queue 0 gets sysfs objects, in ibmveth_probe():

	struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
	...
	error = kobject_init_and_add(kobj, &ktype_veth_pool, &dev->dev.kobj,
				     "pool%d", i);

and veth_pool_show()/veth_pool_store() read and write that single instance.
After this change the queue-0 values are cloned above and each queue
allocates its own copy, so writing num = 4096 to one pool multiplies the
real allocation by adapter->num_rx_queues while sysfs still reports the
single-queue value.

The multiplier is 1 everywhere in this series (IBMVETH_DEFAULT_RX_QUEUES is
1), so nothing changes today.  Should these knobs stay adapter-wide (counts
divided across queues), gain per-queue nodes, or should the multiplier be
documented?

> +
> +	/* Allocate actual buffers for all queues */
> +	for (q = 0; q < adapter->num_rx_queues; q++) {
> +		rc = ibmveth_alloc_queue_buffer_pools(adapter, q);
> +		if (rc) {
> +			/* Free pools for all previous queues */
> +			while (--q >= 0)
> +				ibmveth_free_queue_buffer_pools(adapter, q);
> +			return rc;
> +		}
> +	}
> +
> +	netdev_dbg(netdev, "allocated buffer pools for %d queue(s)\n",
> +		   adapter->num_rx_queues);
> +	return 0;
> +}
> +

[ ... ]

> @@ -927,14 +1055,10 @@ static int ibmveth_close(struct net_device *netdev)
>  
>  	ibmveth_update_rx_no_buffer(adapter);
>  
> +	ibmveth_free_buffer_pools(adapter);
>  	ibmveth_cleanup_rx_resources(adapter);
>  	ibmveth_free_filter_list(adapter);
>  
> -	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
> -		if (adapter->rx_buff_pool[0][i].active)
> -			ibmveth_free_buffer_pool(adapter,
> -						 &adapter->rx_buff_pool[0][i]);
> -

[Severity: Low]

The teardown order changed here, which the changelog does not mention (it
only says the helpers are wired into open()/close()).

Baseline:

	ibmveth_update_rx_no_buffer()
	ibmveth_cleanup_rx_resources()
	ibmveth_free_filter_list()
	free active pools

New:

	ibmveth_update_rx_no_buffer()
	ibmveth_free_buffer_pools()
	ibmveth_cleanup_rx_resources()
	ibmveth_free_filter_list()

h_free_logical_lan(), napi_disable() and free_irq() have all run by this
point, so neither PHYP nor NAPI still references the pool buffers or the RX
queue, and the swap looks safe.  Could the reorder be called out in the
changelog, since a future per-queue drain may need the RX completion queue
still present while pools are released?

>  	for (i = 0; i < netdev->real_num_tx_queues; i++)
>  		ibmveth_free_tx_ltb(adapter, i);
>  
> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
> index 8eaa3942fc40b..abcd4054c67e2 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.h
> +++ b/drivers/net/ethernet/ibm/ibmveth.h
> @@ -265,7 +265,7 @@ static inline long h_illan_attributes(unsigned long unit_address,
>  static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 * 64 };
>  static int pool_count[] = { 256, 512, 256, 256, 256 };
>  static int pool_count_cmo[] = { 256, 512, 256, 256, 64 };
> -static int pool_active[] = { 1, 1, 0, 0, 1};
> +static int pool_active[] = { 1, 1, 0, 0, 0};
                                          ^^^

[Severity: High]

Does this drop large-receive support for existing single-queue users?

Pools 2 (16 KiB) and 3 (32 KiB) are already inactive by default, so with
the 64 KiB pool off the largest buffer ever posted at MTU 1500 becomes
2048 bytes.  ibmveth_probe() seeds each pool from this array:

	ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
				 pool_count[i], pool_size[i], pool_active[i]);

and the new helper skips inactive pools, so nothing larger is handed to
PHYP:

	if (!bpool->active)
		continue;

ibmveth_poll() does receive hypervisor-aggregated frames longer than the
MTU:

	if ((length > netdev->mtu + ETH_HLEN) || lrg_pkt ||
	    iph_check == 0xffff) {
		ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
		adapter->rx_large_packets++;
	}

Those arrive as single non-scatter buffers, and TSO/large-send is enabled
by default in ibmveth_probe() when firmware reports
IBMVETH_ILLAN_LRG_SND_SUPPORT.  With no buffer larger than 2 KiB posted,
are such frames simply dropped by PHYP and counted in the no-buffer counter
read by ibmveth_update_rx_no_buffer()?

The changelog says:

    "MTU changes activate it when required; leaving it enabled would pin
    about 16 MiB per RX queue in MQ mode."

Is the first half accurate?  ibmveth_change_mtu() activates pools only up
to the first pool whose buff_size covers the new MTU:

	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
		adapter->rx_buff_pool[0][i].active = 1;
		if (new_mtu_oh <= adapter->rx_buff_pool[0][i].buff_size) {
			...
			return 0;
		}
	}

At MTU 1500 that stops at the 2 KiB pool, so the 64 KiB pool is never
re-enabled; ibmveth_set_tso() does not touch pool->active either.  Recovery
then requires a manual write to pool4/active in sysfs.

The second half describes MQ, but IBMVETH_DEFAULT_RX_QUEUES is 1 both at
this commit and at the end of the series (a3781f4ae789 still has
pool_active[] = { 1, 1, 0, 0, 0}), so the only configurations affected are
today's single-queue ones.  Would it be better to keep the default at 1 and
scale the 64 KiB count (or deactivate it) when RX queues are actually
scaled up?

Note also that commit cd7c7ec3687986 ("ibmveth: change rx buffer default
allocation for CMO") enabled this pool on purpose and added
pool_count_cmo[] = { 256, 512, 256, 256, 64 } specifically to reduce the
64 KiB count under CMO, which suggests the default was deliberate.

As a side effect, ibmveth_get_desired_dma() sums only active pools:

	if (adapter->rx_buff_pool[0][i].active)
		ret += adapter->rx_buff_pool[0][i].size *
		       IOMMU_PAGE_ALIGN(adapter->rx_buff_pool[0][i].buff_size,
					tbl);

so does the CMO entitlement the driver requests shrink silently as well?

>  
>  #define IBM_VETH_INVALID_MAP ((u16)0xffff)
>

