Return-Path: <linuxppc-dev+bounces-25522-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAAAC5AC67
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 18:38:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGGGl0ZhFz3c4h;
	Fri, 07 Aug 2026 04:37:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786041439;
	cv=none; b=SngCdgrmXsiObyc/JV7zyV4BvctZq9GaZlCQIjU6hutSgJhlnroz8DsIeMfuk5iY8urx0tELMUPvRG9+jBj/hmqnzMsFrhzVTStAP/f0Zua8fi+OBW4vxd6AZFm/8fOSxvZa8hR8qZg9rFFh5G1D9L85Q4n6IfdzMD45OZzCdYBHtCuFOk5yvoLj8leboFhGA/4A+cE3thrH9IX/PCWdAne3AsSmDrEP7FSUDwJoOnEFQYS28wRpKAnDaIrLS7XvDMXCMnNVoNhsgCr/UeA2sqxTiKpKHfE1cnTIM5BYrvRs4Ljcyvr4zxsu7a2FvbrVnvNmIxE5uMHexgf2UfmFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786041439; c=relaxed/relaxed;
	bh=mEe3MkOYjUz6vAg0pEby70j2J5YnOMzD+UHH9K8AiuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Py903qx5bHqKouU+XIeyNlYlnemPgpI9zyTfeTwwJ7KqdJKbCEZ3oK/yRfW0ht0MzwtOkbhHSg7FsdhQyb2QZsfwYTKA6fx7DwxW/ADVAdZca3Bc/+J5Y69WuPzB6ZFgVwvciKLf3sfb+X2y30gJKl0f9Ogj2mi7NDGxReKZx1X4CYVopfu0QG1QFpJy+zaVi2C1zYr2QD33qtPQnRd+U44gMPzgw4o2oAipgiXVHPYAT9lJDo71Juwao/BK7jLQeNH7I1BxwBudmisjTh1cwNRUsNRFYU2CwivyPSopOtikmR+y2jz86NZgR1nTzQXkUWDrdKXsikP4zgFQBCKEqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCLy5nG8; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCLy5nG8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGGGZ5W0yz3c2F
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 04:37:10 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B41AC6004E;
	Thu,  6 Aug 2026 18:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27171F00A3D;
	Thu,  6 Aug 2026 18:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041428;
	bh=mEe3MkOYjUz6vAg0pEby70j2J5YnOMzD+UHH9K8AiuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VCLy5nG86nB7+/cDJ39KvMGutXzCKj4Y485SZF2aOBdHz8uPtyFSKnQyDuGve2vYV
	 C60ToPoBkfS3oLj6/w62+ba58qCb07SIb69z+aZKR2+lnAc5gz3wbhiDz8etavGFJQ
	 7nneLjqod3XxMi7SyIMpogon9DHJh31AzZBJGLEYa6ywlqnpCvIhPtVlcOk3cmhpdP
	 cb4svtWOeyqxsed7U+7iOQ79OcZxxqtG3j/3kqVgq1ouQ83eC+pLsH6ah9Aj4BAmWK
	 2+NfzzMLXq5K9x0bJMljc1Hr09tcY2/1hXIZr4R2az3CCguFmjG+YPfv/NkYVDh5en
	 aXCxD/4Jj/WzA==
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
Subject: Re: [PATCH net-next v4 08/14] ibmveth: Add queue-aware RX buffer submit helper for MQ
Date: Thu,  6 Aug 2026 11:37:07 -0700
Message-ID: <20260806183707.3175525-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <358f3660dbf83279a5218792d432746bc8b845ac.1785457143.git.mmc@linux.ibm.com>
References: <358f3660dbf83279a5218792d432746bc8b845ac.1785457143.git.mmc@linux.ibm.com>
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
ibmveth: Add queue-aware RX buffer submit helper for MQ

This adds ibmveth_add_logical_lan_buffers() to choose between the legacy
single/multi-buffer hcalls and the new per-queue buffer hcall, threads a
queue_index argument through the RX accessors, harvest and replenish
helpers, and adds a per-queue replenish_lock plus reworked H_FUNCTION
handling.

A few questions below about the new failure handling, the new lock and the
logging changes.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 9d1242dbcb19d..cb93659fc0576 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -588,11 +598,75 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)
>  		asm("dcbf %0,%1,1" :: "b" (addr), "r" (offset));
>  }
>  
> +/**
> + * ibmveth_add_logical_lan_buffers - Add receive buffers to hypervisor
> + * @adapter: ibmveth adapter structure
> + * @descs: array of buffer descriptors to add
> + * @filled: number of valid descriptors in the array
> + * @buff_size: size of each buffer (multi-queue mode only)
> + * @queue_index: RX queue index
> + *
> + * Return: hypervisor return code
> + */
> +static long ibmveth_add_logical_lan_buffers(struct ibmveth_adapter *adapter,
> +					    union ibmveth_buf_desc *descs,
> +					    int filled,
> +					    unsigned long buff_size,
> +					    int queue_index)
> +{
> +	struct vio_dev *vdev = adapter->vdev;
> +	unsigned long rc;
> +
> +	if (adapter->multi_queue) {

[ ... ]

> +		rc = h_add_logical_lan_buffers_queue(vdev->unit_address,
> +						     handle,
> +						     buffersznum,
> +						     ioba[0], ioba[1], ioba[2],
> +						     ioba[3], ioba[4], ioba[5]);
> +		adapter->hcall_stats.add_bufs_queue++;
> +	} else if (filled == 1) {
> +		rc = h_add_logical_lan_buffer(vdev->unit_address,
> +					      descs[0].desc);
> +		adapter->hcall_stats.add_buf++;
> +	} else {
> +		rc = h_add_logical_lan_buffers(vdev->unit_address,
> +					       descs[0].desc, descs[1].desc,
> +					       descs[2].desc, descs[3].desc,
> +					       descs[4].desc, descs[5].desc,
> +					       descs[6].desc, descs[7].desc);
> +		adapter->hcall_stats.add_bufs++;
> +	}

[Severity: Medium]

These hcall_stats fields are plain non-atomic u64 counters on the
adapter, but the only serialization this patch adds is the per-queue
rx_queue[i].replenish_lock taken in ibmveth_replenish_task().

Two NAPI instances replenishing different queues hold different locks, so
can these increments lose counts once MQ is enabled later in the series and
num_rx_queues becomes larger than 1?

The same question applies to the other adapter-wide counters reached from
this path:

	adapter->replenish_task_cycles++;
	adapter->replenish_add_buff_success += filled;
	adapter->replenish_add_buff_failure += filled;

and to ibmveth_update_rx_no_buffer(), which ibmveth_replenish_task() calls
while holding queue N's lock only, although it rewrites adapter-global
state for every queue:

	adapter->rx_no_buffer = 0;
	for (i = 0; i < adapter->num_rx_queues; i++) {
		...
		adapter->rx_qstats[i].no_buffer_drops = drops;
		adapter->rx_no_buffer += drops;
	}

Would rx_no_buffer and rx_qstats[].no_buffer_drops be clobbered when two
queues replenish concurrently?  ibmveth_close() calls the same helper with
no lock held at all.

>  /* replenish the buffers for a pool.  note that we don't need to
>   * skb_reserve these since they are used for incoming...
>   */
>  static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
> -					  struct ibmveth_buff_pool *pool)
> +					  struct ibmveth_buff_pool *pool,
> +					  int queue_index)
>  {
>  	union ibmveth_buf_desc descs[IBMVETH_MAX_RX_PER_HCALL] = {0};
>  	u32 remaining = pool->size - atomic_read(&pool->available);
> @@ -678,24 +752,16 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,

[ ... ]

> +		lpar_rc = ibmveth_add_logical_lan_buffers(adapter, descs,
> +							  filled,
> +							  pool->buff_size,
> +							  queue_index);
> +
>  		if (lpar_rc != H_SUCCESS) {
>  			dev_warn_ratelimited(dev,
> -					     "RX h_add_logical_lan failed: filled=%u, rc=%lu, batch=%u\n",
> +					     "RX h_add_logical_lan %s failed: filled=%u, rc=%lu, batch=%u\n",
> +					     adapter->multi_queue ?
> +					     "_queue" : "",
>  					     filled, lpar_rc, batch);
>  			goto hcall_failure;
>  		}

[Severity: Low]

The interpolated hcall name never matches an actual symbol.  In MQ mode
this prints

	RX h_add_logical_lan _queue failed: ...

with a stray space, and in legacy mode

	RX h_add_logical_lan  failed: ...

with a double space.  Would a full literal per branch read better?

The two new H_FUNCTION messages added below also print batch with %d,
although batch is declared u32 in this function ("u32 i, filled, batch;"),
while this warning uses %u for the same variable.

> @@ -736,24 +802,23 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>  		}
>  		adapter->replenish_add_buff_failure += filled;
>  
> -		/*
> -		 * If multi rx buffers hcall is no longer supported by FW
> -		 * e.g. in the case of Live Partition Migration
> -		 */
> -		if (batch > 1 && lpar_rc == H_FUNCTION) {
> -			/*
> -			 * Instead of retry submit single buffer individually
> -			 * here just set the max rx buffer per hcall to 1
> -			 * buffers will be respleshed next time
> -			 * when ibmveth_replenish_buffer_pool() is called again
> -			 * with single-buffer case
> -			 */
> -			netdev_info(adapter->netdev,
> -				    "RX Multi buffers not supported by FW, rc=%lu\n",
> -				    lpar_rc);
> -			adapter->rx_buffers_per_hcall = 1;
> -			netdev_info(adapter->netdev,
> -				    "Next rx replesh will fall back to single-buffer hcall\n");
> +		if (lpar_rc == H_FUNCTION) {
> +			if (adapter->multi_queue) {
> +				netdev_err(adapter->netdev,
> +					   "MQ buffer add H_FUNCTION (q=%d, batch=%d)\n",
> +					   queue_index, batch);
> +			} else if (batch > 1) {

[Severity: High]

The multi_queue arm logs and breaks without changing any state:
adapter->multi_queue stays set, rx_buffers_per_hcall is untouched, there is
no fallback to h_add_logical_lan_buffer()/h_add_logical_lan_buffers(), and
no schedule_work(&adapter->work).

ibmveth_add_logical_lan_buffers() picks the hcall purely on
adapter->multi_queue, and that field is only written in ibmveth_probe(),
which is not re-run on resume (ibmveth_resume() only calls
ibmveth_schedule_rx_queue()).

So once the hypervisor stops implementing H_ADD_LOGICAL_LAN_BUFFERS_QUEUE
- exactly the Live Partition Migration case the legacy arm below exists for
- can this queue ever post another RX buffer again?  pool->available stays
at 0, PHYP drops every inbound frame, and the interface still reports the
link up, so recovery would need an administrative down/up.

Every other unrecoverable condition in this driver schedules the reset
work (ibmveth_remove_buffer_from_pool(), ibmveth_rxq_get_buffer(), and the
new enable_irq failure path in ibmveth_poll()).  Should this arm do the
same, or fall back to the legacy hcalls the way the legacy arm downgrades
batch?

Separately, netdev_err() here is not rate limited, while the warning for
the same failure a few lines above uses dev_warn_ratelimited(), so a
dried-out pool can emit several console lines per poll cycle per pool.

This arm appears unchanged through the end of the series.

> +				/*
> +				 * Live Partition Migration may drop multi-
> +				 * buffer support. Fall back to single-buffer
> +				 * on the next replenish; do not continue with
> +				 * a stale local batch size (infinite loop).
> +				 */
> +				netdev_warn(adapter->netdev,
> +					    "Legacy batch add H_FUNCTION (batch=%d), fallback\n",
> +					    batch);
> +				adapter->rx_buffers_per_hcall = 1;
> +			}
>  		}
>  		break;
>  	}
> @@ -775,21 +840,33 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>  }
>  
>  /* replenish routine */
> -static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
> +static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
> +				   int queue_index)
>  {
> +	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
> +	unsigned long flags;
>  	int i;
>  
> +	if (queue_index >= adapter->num_rx_queues)
> +		return;
> +
>  	adapter->replenish_task_cycles++;
>  
> +	spin_lock_irqsave(&rxq->replenish_lock, flags);
> +
>  	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
> -		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
> +		struct ibmveth_buff_pool *pool =
> +			&adapter->rx_buff_pool[queue_index][i];
>  
>  		if (pool->active &&
>  		    (atomic_read(&pool->available) < pool->threshold))
> -			ibmveth_replenish_buffer_pool(adapter, pool);
> +			ibmveth_replenish_buffer_pool(adapter, pool,
> +						      queue_index);
>  	}
>  
>  	ibmveth_update_rx_no_buffer(adapter);
> +
> +	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
>  }

[Severity: High]

Can this lock deadlock against itself when netconsole runs over this
ibmveth device?

ibmveth_replenish_buffer_pool() printk()s from inside the locked region:
netdev_info() on an invalid map index, dev_warn_ratelimited() on hcall
failure, and the two new H_FUNCTION messages.  With netconsole on this
interface a printk from there re-enters the driver:

netconsole write_msg()
  netpoll_send_udp()
    netpoll_send_skb()
      __netpoll_send_skb()
        netpoll_poll_dev()
          ops->ndo_poll_controller()  ->  ibmveth_poll_controller()
            ibmveth_replenish_task(adapter, i)

__netpoll_send_skb() calls netpoll_poll_dev() whenever the xmit does not
go through on the first try, and netpoll_poll_dev() only declines when
down_trylock(&ni->dev_lock) fails, when !netif_running(dev), or when
netif_local_xmit_active(dev):

	if (!ni || down_trylock(&ni->dev_lock))
		return;

	if (!netif_running(dev) || netif_local_xmit_active(dev)) {
		up(&ni->dev_lock);
		return;
	}
	...
	if (ops->ndo_poll_controller)
		ops->ndo_poll_controller(dev);

None of those covers the replenish path, so ibmveth_poll_controller() loops
ibmveth_replenish_task() over every queue and re-takes the same
replenish_lock on the same CPU, with interrupts already disabled.

Before this patch ibmveth_poll_controller() also called
ibmveth_replenish_task(), but with no lock the recursion was harmless.

This code appears unchanged through the end of the series.

[Severity: Medium]

Does this need to be spin_lock_irqsave()?  The lock now brackets the whole
multi-pool loop, so every netdev_alloc_skb(), every dma_map_single() and
every H_ADD_LOGICAL_LAN_BUFFER[S][_QUEUE] hypervisor call for all five
pools runs with local interrupts hard-disabled.

On a cold fill from ibmveth_open() or the first NAPI poll that is roughly
768 allocations and DMA maps and around 96 hcalls per queue at the default
MTU (pool_count[] = { 256, 512, 256, 256, 256 }), and more when the large
pools are active.

None of the protected state is written from hardirq context, and the commit
message says the lock exists only "so later concurrent NAPI/resize paths
can serialize buffer posting", so would spin_lock_bh(), dropping and
re-acquiring per batch, or preparing buffers outside the critical section
be enough?

>  
>  /* empty and free ana buffer pool - also used to do cleanup in error paths */

[ ... ]

> @@ -1004,50 +1083,55 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,

[ ... ]

> -	free_index = adapter->rx_buff_pool[0][pool].producer_index;
> -	adapter->rx_buff_pool[0][pool].producer_index++;
> -	if (adapter->rx_buff_pool[0][pool].producer_index >=
> -	    adapter->rx_buff_pool[0][pool].size)
> -		adapter->rx_buff_pool[0][pool].producer_index = 0;
> -	adapter->rx_buff_pool[0][pool].free_map[free_index] = index;
> +	free_index = adapter->rx_buff_pool[queue_index][pool].producer_index;
> +	adapter->rx_buff_pool[queue_index][pool].producer_index++;
> +	if (adapter->rx_buff_pool[queue_index][pool].producer_index >=
> +	    adapter->rx_buff_pool[queue_index][pool].size)
> +		adapter->rx_buff_pool[queue_index][pool].producer_index = 0;
> +	adapter->rx_buff_pool[queue_index][pool].free_map[free_index] = index;
>  
>  	mb();
>  
> -	atomic_dec(&adapter->rx_buff_pool[0][pool].available);
> +	atomic_dec(&adapter->rx_buff_pool[queue_index][pool].available);

[Severity: High]

This isn't a bug introduced by this patch, but the new replenish_lock only
covers the producer half of this bookkeeping, so it is worth asking whether
the consumer half is still unprotected.

ibmveth_remove_buffer_from_pool() mutates free_map[], producer_index,
skbuff[], dma_addr[] and available for the same pool that
ibmveth_replenish_buffer_pool() mutates under replenish_lock, but takes no
lock:

producer: ibmveth_poll_controller()
            ibmveth_replenish_task()        /* holds replenish_lock */
              ibmveth_replenish_buffer_pool()

consumer: ibmveth_poll()                   /* holds nothing */
            ibmveth_rxq_harvest_buffer()
              ibmveth_remove_buffer_from_pool()

netpoll_poll_dev() serializes netpoll users against each other via
ni->dev_lock, and __napi_poll()'s netpoll_poll_lock() only stops netpoll
from re-polling a NAPI instance that is already running; neither prevents
ndo_poll_controller from running on one CPU while the same queue's NAPI
poll runs on another.

Can free_map[]/producer_index/consumer_index then hand the same pool index
out twice, so a buffer is posted to the hypervisor while its skb has
already gone up the stack, or lose a free index permanently?

Since the future work described in the commit message ("so later concurrent
NAPI/resize paths can serialize buffer posting") builds on this lock, should
the consumer side take it as well?

[ ... ]

> @@ -1993,34 +2076,45 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
>  
>  static int ibmveth_poll(struct napi_struct *napi, int budget)
>  {
> -	struct ibmveth_adapter *adapter =
> -			container_of(napi, struct ibmveth_adapter, napi[0]);
> -	struct net_device *netdev = adapter->netdev;
> +	struct net_device *netdev = napi->dev;
> +	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>  	int frames_processed = 0;
>  	unsigned long lpar_rc;
> +	int queue_index, rc;
>  	u16 mss = 0;
>  
> +	queue_index = napi - adapter->napi;
> +
> +	if (WARN_ON(queue_index < 0 || queue_index >= adapter->num_rx_queues))
> +		return 0;
> +

[ ... ]

> @@ -2097,14 +2197,19 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  	/* We think we are done - reenable interrupts,
>  	 * then check once more to make sure we are done.
>  	 */
> -	lpar_rc = ibmveth_enable_irq(adapter, 0);
> -	if (WARN_ON(lpar_rc != H_SUCCESS)) {
> +	lpar_rc = ibmveth_enable_irq(adapter, queue_index);
> +	if (lpar_rc != H_SUCCESS) {
> +		netdev_err(netdev,
> +			   "Failed to enable IRQ for queue %d (rc=0x%lx), scheduling reset\n",
> +			   queue_index, lpar_rc);
>  		schedule_work(&adapter->work);
>  		goto out;
>  	}
>  
> -	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
> -		lpar_rc = ibmveth_disable_irq(adapter, 0);
> +	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
> +	    napi_schedule(napi)) {
> +		lpar_rc = ibmveth_disable_irq(adapter, queue_index);
> +		WARN_ON(lpar_rc != H_SUCCESS);
>  		goto restart_poll;
>  	}

[Severity: Low]

Two diagnostic changes here are not described in the commit message, which
only says callers were updated "so arity stays consistent": the WARN_ON()
around the ibmveth_enable_irq() failure is replaced by an unconditional
netdev_err(), which drops the taint and backtrace that test harnesses key
on, and a new WARN_ON() is added on the ibmveth_disable_irq() result.
Would it help to mention or split out that change?

Also, the new guard added at the top of ibmveth_poll()

	if (WARN_ON(queue_index < 0 || queue_index >= adapter->num_rx_queues))
		return 0;

returns less than budget from a NAPI poll callback without calling
napi_complete_done(), which leaves the instance scheduled with the
hypervisor IRQ still masked.  The guard is unreachable at this commit,
since IBMVETH_MAX_RX_QUEUES is 1 and queue_index is always 0, but the same
early return is still there at the end of the series.  Should it complete
NAPI before returning?

[ ... ]

> @@ -2229,9 +2334,13 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
>  static void ibmveth_poll_controller(struct net_device *dev)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(dev);
> +	int i;
>  
> -	ibmveth_replenish_task(adapter);
> -	ibmveth_schedule_rx_queue(adapter, 0);
> +	for (i = 0; i < adapter->num_rx_queues; i++)
> +		ibmveth_replenish_task(adapter, i);
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++)
> +		ibmveth_schedule_rx_queue(adapter, i);
>  }
>  #endif

[ ... ]

