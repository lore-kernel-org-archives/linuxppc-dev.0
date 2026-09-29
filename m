Return-Path: <linuxppc-dev+bounces-28522-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09974CA5FA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:34:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvSyf5D9qz3bgd;
	Wed, 30 Sep 2026 05:33:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790710410;
	cv=none; b=L+Mvaf1IX3NrfQezardTlxn8/ieOXX4X6zuI+xPtvb5UnyR8DqgT0yzbpiuwnJ2NJLOKSZ6ScX9s3+s/1kPFVPviV0v7ubwLso0HqduEVuONIFmTueSEb7ksk4RH9IQhDcG+cufFdFouErbF11u3wqWg6TRQOVmsGzpD7OG8ekQVDpzBLUPnVMeAIVLA8JjINBcmojHcHVjbJcEsRqsuJqOQzL3cpweCwJ4/nsi99WJbvkClM+wfQMgrPzmI8WABEnRIHfr0mI4prMOtcHtnC+cyif3pj7DI4tS4yI0/eXk0pzh0VV2I4iGnEWBexdLT30SSYdFToHNpMM0qQXPe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790710410; c=relaxed/relaxed;
	bh=W4Bk7MVc9PHGoBz6evrIXfu8kkQOw6auGtUIDGF2C7s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SU7AHNoIObC4UF5zk+SBGUVr8ChcvX6+Y80s1LomD8z1ezfR1rg/tZcEJN+ZYxtuP0K237AWpPbDt10FjI9x1DjkDEwPGx6pJPGK4YxX4xI41qI9t/wU0VDeNKJn0XkdeaYIajjZCIu/NEMtNDiDi9OKYzecFW/IVE/UbTWH1V7bgoTLMY4vOJ4cvIQC/uvUmVQOBbannA6m7+GXJLBY4zKt9OGpVcSQ3g3SZGZBrH7ldJQ6unlpiHYDt5B8+dhkioH01OtOw2MTl3aqitWV9PTWKXBgcDc3AamyWxfF4t1mc8xbRhIANY3jxBif+PnsBRvnyhwFO2FgsZaDYBxyYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DivknI1b; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DivknI1b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvSyZ4BrWz3bbY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:33:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 87A9160239;
	Tue, 29 Sep 2026 19:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAD81F000FF;
	Tue, 29 Sep 2026 19:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710404;
	bh=W4Bk7MVc9PHGoBz6evrIXfu8kkQOw6auGtUIDGF2C7s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DivknI1b9kVFnZ+EcjE/sWCkvInAiXIFbt8MwosGhYA1Raa7Z9umcSNtCtyUm3y5L
	 C+QrLPQUQl4Xf4ibzMSzRgNdYnK0m4z2oyWzeRPo0hMXUWWnWrsZSuyfF0DIheCsdB
	 6AERskRqvTCdoJv0MQlKuPZZqv+q4ZdAnM8WzlH3445HqveFz9RCvHk2S0e0N5Upz1
	 swbUECdFWk/dh2+0voSAX2q7rln7zWzICgk1wHstvjthfKtur4tAiUumOj3TWkrbVi
	 Ed12QpZEs5MoN39O4WSCPHDrgO5s/DRhraKfdd6zCzaMIA3VgWKH3zsRvQ8VNPqpN6
	 jvzpCeQRG9gBw==
Subject:
 Re: [PATCH net-next v7 10/15] ibmveth: Enable multi-queue RX receive path
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Tue, 29 Sep 2026 19:33:22 +0000
Message-ID: <179071040296.434549.8432003596727032409@kernel.org>
In-Reply-To:
 <5b0d412f10728f5708b02adf90ced701d4303222.1790319558.git.mmc@linux.ibm.com>
References:
 <5b0d412f10728f5708b02adf90ced701d4303222.1790319558.git.mmc@linux.ibm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 4 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the ibmveth_remove()
  unregister_netdev()/cancel_work_sync() reorder and the ibmveth_reset()…
- [Medium] With several MQ NAPI instances running at once, the adapter-
  wide RX and replenish counters are still updated with plain read-…
- [Medium] In MQ open, ibmveth_setup_rx_interrupts() unmasks PHYP on
  every queue (ibmveth_enable_irq) before ibmveth_open() calls…
- [Medium] When MQ interrupt setup fails partway, RX rings can be freed
  while a poll that has already completed NAPI still reads them.
- [Low] At this commit, ibmveth_get_channels() reports max_rx = rx_count
  = netdev->real_num_rx_queues, which is now min(num_online_cpus(), 8)…
- [Low] ibmveth_apply_mq_fallback() calls
  ibmveth_publish_num_rx_queues(adapter, 1) but leaves…
- [Low] The new retry loops in ibmveth_register_logical_lan_queue() re-
  issue H_REG_LOGICAL_LAN_QUEUE, and H_FREE_LOGICAL_LAN_QUEUE on the…

Pre-existing issues:
- [High] At this commit, ibmveth_poll_controller() replenishes and
  schedules every live RX queue without checking adapter->opened.
- [High] This problem wasn't introduced by this patch, but it is a
  remotely triggerable crash on the RX path that this patch extends to…

--

ibmveth: Enable multi-queue RX receive path

This commit turns on the multi-queue RX path when firmware advertises
IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT. It raises IBMVETH_MAX_RX_QUEUES to 16,
defaults to min(num_online_cpus(), 8) queues, registers the subordinate
queues through H_REG_LOGICAL_LAN_QUEUE, and wires up per-queue IRQs and
NAPI. It also adds an mq_fallback latch for H_FUNCTION rejections, reorders
ibmveth_remove(), gates ibmveth_reset() on reg_state, and reworks the pool
kobject lifetime.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 7b6c0283e5c32..3f31793645a31 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -993,15 +1014,21 @@ static int ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>   * because there was not a buffer in the buffer list capable of holding
>   * the frame.
>   */
> -static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
> +static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter,
> +					int queue_index)
>  {
>  	__be64 *p;
> +	u64 drops;
>
> -	if (!adapter->buffer_list_addr[0])
> +	if (queue_index < 0 ||
> +	    queue_index >= ibmveth_get_num_rx_queues(adapter) ||
> +	    !adapter->buffer_list_addr[queue_index])
>  		return;
>
> -	p = adapter->buffer_list_addr[0] + 4096 - 8;
> -	adapter->rx_no_buffer = be64_to_cpup(p);
> +	p = adapter->buffer_list_addr[queue_index] + 4096 - 8;
> +	drops = be64_to_cpup(p);
> +
> +	adapter->rx_no_buffer = drops;
>  }

[Severity: Medium]
With several MQ NAPI instances running at once, adapter->rx_no_buffer is
overwritten by whichever queue ran ibmveth_update_rx_no_buffer() last. Can
it go backwards as a result?

Other adapter-wide counters have the same problem. These are plain
read-modify-writes with no lock, or with only a per-queue replenish_lock,
so concurrent updates can be lost:

  - netdev->stats.rx_packets, rx_bytes and rx_large_packets in
    ibmveth_poll_deliver_frame()
  - rx_invalid_buffer in ibmveth_poll_bump_invalid()
  - the replenish_* counters in ibmveth_replenish_task() and
    ibmveth_replenish_buffer_pool()

The commit message acknowledges the rx_* and rx_no_buffer cases. The next
patch, "ibmveth: Add per-queue RX and TX statistics collection", moves all
of these counters, including replenish_*, into per-queue rx_qstats[]. The
commit message doesn't mention the replenish_* counters, though.

[ ... ]

> @@ -1086,6 +1114,27 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>  				     fail.filled, fail.lpar_rc, fail.batch);
>  }
>
> +/**
> + * ibmveth_restart_rx_queue - Post buffers and ensure Q can take RX

[ ... ]

> +static void ibmveth_restart_rx_queue(struct ibmveth_adapter *adapter,
> +				     int qindex)
> +{
> +	ibmveth_replenish_task(adapter, qindex);
> +	if (ibmveth_schedule_rx_queue(adapter, qindex))
> +		return;
> +
> +	ibmveth_enable_irq(adapter, qindex);
> +}

[Severity: Medium]
In MQ mode, ibmveth_setup_rx_interrupts() has already unmasked PHYP on every
queue, with buffers posted, by the time ibmveth_open() calls this function.
Suppose a frame arrives in between:

ibmveth_interrupt()
  ibmveth_schedule_rx_queue()
    napi_schedule_prep() succeeds
    ibmveth_disable_irq()
    __napi_schedule()

ibmveth_restart_rx_queue()
  ibmveth_schedule_rx_queue()
    napi_schedule_prep() fails, NAPI already scheduled
  ibmveth_enable_irq()

Doesn't this leave the queue unmasked while NAPI still owns it?

ibmveth_schedule_rx_queue() only masks when napi_schedule_prep() succeeds:

	if (napi_schedule_prep(napi)) {
		ibmveth_disable_irq(adapter, qindex);
		__napi_schedule(napi);
		return true;
	}
	return false;

Later interrupts during that NAPI run only set NAPIF_STATE_MISSED. MISSED
keeps napi_complete_done() returning false, so under sustained traffic the
queue could take an interrupt per event until a poll completes cleanly.

Could the fallback tell "NAPI already scheduled" apart from "NAPI will never
run" before it unmasks? This code is unchanged at the end of the series.

> @@ -1562,6 +1611,138 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
>  	return rc;
>  }
>
> +/**
> + * ibmveth_register_logical_lan_queue - Register subordinate queue with

[ ... ]

> +	do {
> +		lpar_rc = h_register_logical_lan_queue(ua, bl,
> +						       rxq_desc.desc, &handle,
> +						       &hwirq);
> +	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));

[ ... ]

> +			do {
> +				free_rc = h_free_logical_lan_queue(ua, handle);
> +			} while (H_IS_LONG_BUSY(free_rc) ||
> +				  (free_rc == H_BUSY));

[Severity: Low]
Both loops re-issue the hcall immediately on H_IS_LONG_BUSY(). Should they
honour the requested delay through get_longbusy_msecs() and sleep, or at
least call cond_resched()?

This runs in ndo_open under RTNL, once per subordinate queue. If firmware
keeps returning H_LONG_BUSY_ORDER_*, a CPU would spin with RTNL held. The
same busy-loop shape already exists for h_free_logical_lan() in this
driver.

[ ... ]

> @@ -1642,9 +1828,67 @@ ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)

[ ... ]

> +static void ibmveth_apply_mq_fallback(struct ibmveth_adapter *adapter)
> +{

[ ... ]

> +	netdev_warn(netdev,
> +		    "Falling back to single RX queue (firmware MQ unavailable)\n");
> +	adapter->multi_queue = false;
> +	ibmveth_publish_num_rx_queues(adapter, 1);
> +	/* real_num_rx_queues is set later in open after resources exist. */
> +	if (adapter->rx_buffers_per_hcall > IBMVETH_MAX_RX_REGULAR)
> +		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_REGULAR;
>  }

[Severity: Low]
This publishes 1 and consumes mq_fallback, but netdev->real_num_rx_queues
keeps the old MQ count until ibmveth_open() reaches
netif_set_real_num_rx_queues(). That only happens after these succeed:

  - ibmveth_alloc_filter_list()
  - ibmveth_alloc_rx_queues()
  - ibmveth_alloc_buffer_pools()
  - ibmveth_register_rx_queues()

If one of them fails, the device stays down with real_num_rx_queues at N
while num_rx_queues is 1, and the flag is already cleared. Doesn't that
break the invariant stated in the new comment in ibmveth_probe()?

  Match the advertised default (or SQ 1) before register_netdev so
  down-state readers agree with adapter->num_rx_queues / ethtool -l.

At this commit, ethtool -l would report N queues.

At the end of the series, get_channels() reads num_rx_queues, but the
queues/rx-* sysfs entries and the netdev-genl queue lists would still be
stale. A later down-state ethtool -L rx 1 would not resync them, because
goal_rx equals num_rx_queues.

Would calling netif_set_real_num_rx_queues() here help?

[ ... ]

> @@ -1676,18 +1922,34 @@ static int ibmveth_open(struct net_device *netdev)

[ ... ]

> +	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
> +		netdev_dbg(netdev, "initial replenish cycle for queue %d\n", i);
> +		ibmveth_replenish_task(adapter, i);
> +	}
> +
>  	rc = ibmveth_setup_rx_interrupts(adapter);
>  	if (rc)
>  		goto out_free_all_queues; /* setup already disposed IRQs */

[Severity: Medium]
Suppose ibmveth_enable_irq() fails for queue k in
ibmveth_setup_rx_interrupts(). Queues 0 to k-1 are already unmasked, so
their NAPI may be polling.

Can a poll that has already passed napi_complete_done() still be reading
rx_queue[q].queue_addr when this path frees it?

ibmveth_poll() on queue q < k:
  napi_complete_done()
  passes ibmveth_poll_stopping()
                            err_disable_napi:
                              napi_disable() returns, SCHED clear
                              synchronize_irq() / free_irq()
                            ibmveth_open():
                              goto out_free_all_queues
                              ibmveth_free_buffer_pools()
                              ibmveth_cleanup_rx_resources()
  ibmveth_enable_irq()
  ibmveth_rxq_pending_buffer()
    reads rx_queue[q].queue_addr[index]

The TX allocation failure branch in ibmveth_open() handles exactly this
window:

out_cleanup_rx_interrupts:
	ibmveth_cleanup_rx_interrupts(adapter);
	/* As in close(): a poll past napi_complete_done() may still run. */
	synchronize_net();

Should the setup_rx_interrupts() failure path also call synchronize_net()
before freeing the rings? This code is unchanged at the end of the series.

[ ... ]

> @@ -2538,6 +2806,7 @@ static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
>  		ibmveth_rx_csum_helper(skb, adapter);
>  	}
>
> +	skb_record_rx_queue(skb, queue_index);
>  	napi_gro_receive(napi, skb);

[Severity: High]
This isn't a bug introduced by this patch, but it sits on the RX path that
this patch now enables for every new queue.

ibmveth_poll_deliver_frame() calls ibmveth_rx_csum_helper() for any frame
carrying IBMVETH_RXQ_CSUM_GOOD, and the sending partition controls that
flag. For ETH_P_IP with iph->check == 0xffff, the helper does:

	iph->check = 0;
	iph->check = ip_fast_csum((unsigned char *)iph,
				  iph->ihl);

It never checks that iph->ihl >= 5. On powerpc, ip_fast_csum_nofold() does:

	for (i = 0; i < ihl - 1; i++, ptr++)
		s += *ptr;

ihl is unsigned, so ihl == 0 makes the limit UINT_MAX.

Can a frame from another partition on the same VLAN, with ihl == 0 and
check == 0xffff, make this read far past the packet in softirq context?
ip_rcv_core() would reject such a header, but only after this helper has
run.

[ ... ]

> @@ -2761,9 +3031,14 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
>  static void ibmveth_poll_controller(struct net_device *dev)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(dev);
> +	unsigned int num = ibmveth_get_num_rx_queues(adapter);
> +	int i;
>
> -	ibmveth_replenish_task(adapter, 0);
> -	ibmveth_schedule_rx_queue(adapter, 0);
> +	for (i = 0; i < num; i++)
> +		ibmveth_replenish_task(adapter, i);
> +
> +	for (i = 0; i < num; i++)
> +		ibmveth_schedule_rx_queue(adapter, i);
>  }

[Severity: High]
This is a pre-existing issue for queue 0, but this change extends it to
every RX queue.

ibmveth_poll_controller() does not check adapter->opened. These callers
invoke ibmveth_close() directly and leave netif_running() true:

  - ibmveth_set_tso()
  - ibmveth_set_csum_offload()
  - ibmveth_change_mtu()
  - veth_pool_store()

That means netconsole's netpoll can run during their teardown:

netpoll
  ibmveth_poll_controller()
    ibmveth_replenish_task()
      reads pool->free_map, skbuff, dma_addr
                              ibmveth_close()
                                ibmveth_free_buffer_pools()
                                  ibmveth_free_buffer_pool()
                                    kfree(pool->free_map)

ibmveth_free_buffer_pool() frees these arrays without taking
replenish_lock. Can this be a use-after-free?

Later in the series, "ibmveth: Complete set_channels down-path and
mq_fallback max_rx cap" adds an early return on !adapter->opened in
ibmveth_poll_controller(), which seems to close this. Would it be better to
add that gate in this patch, where the loop over every queue is introduced?

[ ... ]

> @@ -2965,16 +3293,30 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  		netdev->features |= NETIF_F_FRAGLIST;
>  	}
>
> -	/* Initialize queue count - always 1 for now */
> -	adapter->multi_queue = 0;
> -	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
> +	if (ret == H_SUCCESS &&
> +	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT)) {
> +		adapter->multi_queue = true;
> +		ibmveth_publish_num_rx_queues(adapter,
> +					      min(num_online_cpus(),
> +						  IBMVETH_DEFAULT_QUEUES));

[Severity: Low]
On MQ firmware, real_num_rx_queues now becomes min(num_online_cpus(), 8),
and ibmveth_get_channels() reports it as both max_rx and rx_count. The
ethtool core will therefore accept a smaller rx_count. However,
ibmveth_set_channels() only reads channels->tx_count:

	unsigned int old = netdev->real_num_tx_queues,
		     goal = channels->tx_count;

At this commit, does ethtool -L rx 2 return success without changing
anything?

The commit message notes that set_channels does not handle rx_count yet.
The next patch, "ibmveth: Report MQ-aware RX counts in ethtool
get_channels", returns -EOPNOTSUPP when rx_count changes. "ibmveth:
Implement incremental MQ RX queue resize" and "ibmveth: Complete
set_channels down-path and mq_fallback max_rx cap" then implement the
resize.

[ ... ]

> @@ -3037,14 +3416,17 @@ static void ibmveth_remove(struct vio_dev *dev)
>  {
>  	struct net_device *netdev = dev_get_drvdata(&dev->dev);
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
> -	int i;
>
> -	cancel_work_sync(&adapter->work);
> -
> -	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
> -		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
> +	ibmveth_put_pool_kobjs(adapter, IBMVETH_NUM_BUFF_POOLS);
>
> +	/*
> +	 * Unregister first so NAPI/xmit cannot re-arm reset work after we
> +	 * cancel it. cancel_work_sync() before unregister left a window
> +	 * where poll could schedule_work() and the worker ran after
> +	 * free_netdev().
> +	 */
>  	unregister_netdev(netdev);
> +	cancel_work_sync(&adapter->work);

[Severity: Medium]
The commit message says:

  This commit adds schedule_work() producers on buffer-add H_FUNCTION,
  so the remove-path unregister / cancel_work_sync reorder and reset
  reg_state gate land here to prevent a queued reset from racing
  device teardown.

Is this attribution accurate?

Before this series, ibmveth_remove() already called cancel_work_sync()
before unregister_netdev(). In that gap, adapter->work could already be
queued from NAPI or replenish context by:

  - the invalid free_map path in ibmveth_replenish_task()
  - the WARN paths in ibmveth_remove_buffer_from_pool() and
    ibmveth_rxq_get_buffer()
  - the h_vio_signal() failure in ibmveth_poll()

The MQ schedule_work() on buffer-add H_FUNCTION came from the earlier
patch "ibmveth: Add queue-aware RX buffer submit helper for MQ". This
commit only makes it reachable and sets mq_fallback.

So the reset worker running after free_netdev() looks like a use-after-free
that predates this series. Two other lifetime bugs that predate it are also
fixed here:

  - ktype_veth_pool had .release = NULL; it now has
    ibmveth_pool_kobj_release() plus a completion wait before
    free_netdev()
  - the pool kobjects leaked on probe failure, which the commit message
    already calls pre-existing

Could these three fixes be split into their own patches with Fixes: tags,
so they can reach stable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790319558.git.mmc%40linux.ibm.com

