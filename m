Return-Path: <linuxppc-dev+bounces-28521-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9E8CA5FA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:33:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvSyc15K8z2yD3;
	Wed, 30 Sep 2026 05:33:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790710408;
	cv=none; b=WsP5PCYlLbOXpY/XWYys0FDy2MQ6xe2EIbHuZEZ9jYGkBZDDdy+FCCIQscKc9JAygFx4AFK5/GQX+yxJJuc+metvheJvLTTZwGxHC5+sfNXcIySezJ+++j/MOw63++CmsCbr1PfBFhCmoTTQG0MvOhKBTf0AiOIdpb4z3rvj69NmABx9FNC2y4zUFFq4PxfvE9KkMz/CH4zV38SF0qArRa1DWJmva9khBFU1Wil3ELTIf5Bv4Ol5/P2i1mki0ZpNutegP0h2Hmxt9qs1IkedCpgbOFMsWgK3Z6iN3OEg4SLoUn1I9tJKx8/tsa8rvm+AbuVr3VBOYJgVXjiwb4S7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790710408; c=relaxed/relaxed;
	bh=coKf8qCmib2tIUQVnyluuWaFyhx9Kl9U3LVajvpzG4E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZjUSR0GoREmkkys2Kc+nVptQfI/Xw5mR7oe5HXMEN9xRSgSeXCn+OI/1ZIqkNGmOMHQr0kaa9uJnBnc93WgACKe6NrJN72G3RqBPnBdiGgMbjAcxEJDT12jaXz1GgESoGKELaqs8Yn/ELSnD4y+q5axZTPW3MAYCokM8BKx5Nn3fQR+1Jk3eoaHG35QHH6T7mSFrHro0Z2D5SBQE6aYs5cSyjsnah3WT8sqmd9Q3Q7LShW/uKvB8Xt82tMfg3kIzYTjpDBMOUmlloLFxGSh3VNaKaTdeajJ39aGqgYoX+AXB711F1VyW12TlDUXHE1qohZvHKMmdqGjrl/oESocd6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PE1thhTe; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PE1thhTe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvSyY0YH4z3bVW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:33:25 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 183926025A;
	Tue, 29 Sep 2026 19:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CD51F00893;
	Tue, 29 Sep 2026 19:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710402;
	bh=coKf8qCmib2tIUQVnyluuWaFyhx9Kl9U3LVajvpzG4E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PE1thhTeaiQGhRXcmB/Af7ELSXtIvhPqUd4bAUiWDPenuL5zdehjvUPEx7lJmxBcq
	 L8ejfzbgBBg6vVgli2ubXBVkwY9mVuSmV2i9mkhqdOcD4dyEXmucAdaEU8kQRlWAGO
	 C19MfL5fF9sGIcf4e6dmK9MkGkTStD1Rj/FpPESIVtq0dmSdG/Vn2SnWAZbcUSgEtf
	 dgZ51y7SMRoSSTqvJIdtPl4saGhGcVYam2dtq3F4HMB2xZTAg9NNB8INGLQNrSRGJp
	 Fgg8sSTQ+nhMy2GlstBLtGvPF148ezLOoEB7DJz9QeW+eyF76mgTZdhnV50mamfMBr
	 X5q/vu1J+RZRw==
Subject:
 Re: [PATCH net-next v7 09/15] ibmveth: Harden RX poll path with helpers
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Tue, 29 Sep 2026 19:33:21 +0000
Message-ID: <179071040151.434549.8640964325817993389@kernel.org>
In-Reply-To:
 <8a7621e33cc595cff0e1712c1415051d8c5679d2.1790319558.git.mmc@linux.ibm.com>
References:
 <8a7621e33cc595cff0e1712c1415051d8c5679d2.1790319558.git.mmc@linux.ibm.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 (2) · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The re-arm guard in ibmveth_poll()
  (drivers/net/ethernet/ibm/ibmveth.c) is a check-then-act race, so it…
- [High] net: ibmveth: kernel crash via OOB array read due to TOCTOU
  double fetch
- [Medium] Reset escalation for bad correlators now covers only one of
  the three harvest callers in ibmveth_poll().
- [Low] The new comment above the post-completion ibmveth_poll_stopping()
  check gives a rationale the code does not support.
- [Low] When the RX code was moved into ibmveth_poll_deliver_frame(), two
  comments that document PHYP behaviour were dropped.

Pre-existing issues:
- [High] Crafted IPv4 frames with the checksum-offload flag and IHL=0 can
  crash the receiving partition.
- [High] The concern: ibmveth_remove() calls
  cancel_work_sync(&adapter->work) before unregister_netdev().

--

ibmveth: Harden RX poll path with helpers

This splits the per-slot handling in ibmveth_poll() into small helpers
for invalid slots, bad correlators, oversize frames and frame delivery.
It adds stopping checks meant to keep close and napi_disable from
re-arming PHYP. It also bounds the PHYP offset+length against the RX
buffer, and moves bad-correlator reset escalation out of
ibmveth_rxq_get_buffer().

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index ed75dea90a957..7b6c0283e5c32 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> +static bool ibmveth_poll_harvest_slot(struct ibmveth_adapter *adapter,
> +				      int queue_index, bool reuse)
> +{
> +	int rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, reuse);
> +
> +	return !rc || rc == -EINVAL || rc == -EFAULT;
> +}
> +
> +static bool ibmveth_poll_recycle_invalid(struct net_device *netdev,
> +					 struct ibmveth_adapter *adapter,
> +					 int queue_index)
> +{
> +	netdev_dbg(netdev, "recycling invalid buffer\n");
> +	ibmveth_poll_bump_invalid(adapter, queue_index);
> +	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
> +}

[Severity: Medium]
Does the invalid-buffer path lose reset escalation for bad correlators?

In mainline, ibmveth_remove_buffer_from_pool() called
schedule_work(&adapter->work) for an out-of-range correlator (-EINVAL)
or a NULL skb (-EFAULT), for every harvest caller. The previous patch
("ibmveth: Add queue-aware RX buffer submit helper for MQ") removed
that call. This patch then removes schedule_work() from
ibmveth_rxq_get_buffer() too.

The only schedule_work() left in the poll slot handling is in
ibmveth_poll_skip_bad_correlator(). That is reached only from the
valid-slot path in ibmveth_poll_deliver_frame().

Take a slot with the VALID bit clear and a stale or out-of-range
correlator. It goes through:

ibmveth_poll()
  ibmveth_poll_recycle_invalid()
    ibmveth_poll_harvest_slot()   /* -EINVAL/-EFAULT -> true */

The slot is counted, logged only with netdev_dbg(), skipped, and the
loop continues. No reset is scheduled.

The buffer PHYP returned is never given back to free_map, and
pool->available is never decremented for it. That capacity looks lost
until some unrelated reset.

skip_bad_correlator's own comment says a "residual stale slot after
resize" should be recovered by reset. Should recycle_invalid escalate
in the same way?

The commit message says "skip_bad_correlator owns reset escalation" but
doesn't mention that the invalid-slot path loses it. This is still the
case at the end of the series.

> +
> +static bool ibmveth_poll_skip_bad_correlator(struct net_device *netdev,
> +					     struct ibmveth_adapter *adapter,
> +					     int queue_index)
> +{
> +	if (net_ratelimit())
> +		netdev_err(netdev,
> +			   "bad correlator on queue %d, skipping slot\n",
> +			   queue_index);
> +	/* Residual stale slot after resize: recover via reset rather
> +	 * than spinning forever. Always escalate; only the log is
> +	 * rate-limited.
> +	 */
> +	schedule_work(&adapter->work);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch.
At this commit, ibmveth_remove() cancels the work before the netdev is
unregistered:

ibmveth_remove() {
	...
	cancel_work_sync(&adapter->work);

	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
		kobject_put(&adapter->rx_buff_pool[0][i].kobj);

	unregister_netdev(netdev);

	free_netdev(netdev);
	...
}

Can a NAPI poll queue adapter->work from here in that window? If so,
ibmveth_reset() would run after free_netdev().

Mainline poll could already call schedule_work() through
remove_buffer_from_pool() and get_buffer().

This ordering is fixed later in the series by "ibmveth: Enable
multi-queue RX receive path". There, ibmveth_remove() calls
unregister_netdev() before cancel_work_sync().

> +	ibmveth_poll_bump_invalid(adapter, queue_index);
> +	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
> +}

[ ... ]

> +	if (lrg_pkt) {
> +		__be64 *rxmss = (__be64 *)(skb->data + 8);
> +
> +		mss = (u16)be64_to_cpu(*rxmss);
> +	}

[ ... ]

> +	skb_put(skb, length);
> +	skb->protocol = eth_type_trans(skb, netdev);
> +
> +	if (skb->protocol == cpu_to_be16(ETH_P_IP))
> +		iph_check = ((struct iphdr *)skb->data)->check;

[Severity: Low]
This isn't a bug, but two comments about PHYP behaviour were dropped
when this code moved into ibmveth_poll_deliver_frame():

	/* if the large packet bit is set in the rx queue
	 * descriptor, the mss will be written by PHYP eight
	 * bytes from the start of the rx buffer, which is
	 * skb->data at this stage
	 */

	/* PHYP without PLSO support places a -1 in the ip
	 * checksum for large send frames.
	 */

Without them, the skb->data + 8 read and the 0xffff test have no
explanation. Could the comments be kept?

> +
> +	if ((length > netdev->mtu + ETH_HLEN) || lrg_pkt ||
> +	    iph_check == 0xffff) {
> +		ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
> +		adapter->rx_large_packets++;
> +	}
> +
> +	if (csum_good) {
> +		skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		ibmveth_rx_csum_helper(skb, adapter);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but can a crafted IPv4 frame
from another partition crash the receiver here? When csum_good is set,
ibmveth_rx_csum_helper() does:

	if (iph->check == 0xffff) {
		iph->check = 0;
		iph->check = ip_fast_csum((unsigned char *)iph,
					  iph->ihl);
	}

iph->ihl is not validated first. On powerpc64, ip_fast_csum_nofold()
has this loop, where ihl is unsigned:

	for (i = 0; i < ihl - 1; i++, ptr++)
		s += *ptr;

With IHL=0 that is about 4 billion 32-bit reads (about 16 GiB) past the
skb, in softirq context.

The RX IBMVETH_RXQ_CSUM_GOOD bit (0x01000000) mirrors the sender's TX
IBMVETH_BUF_CSUM_GOOD bit (0x01000000). So a peer on the same virtual
LAN controls both csum_good and the IP header.

The new offset+length bound in ibmveth_poll_deliver_frame() doesn't
cover this. Should iph->ihl be validated before ip_fast_csum() is
called?

[ ... ]

>  	if (!napi_complete_done(napi, frames_processed))
>  		goto out;
>  
> -	/* We think we are done - reenable interrupts,
> -	 * then check once more to make sure we are done.
> +	/*
> +	 * napi_disable() sets DISABLE then waits for this poll. Without a
> +	 * second stopping check here, enable_irq() can re-arm PHYP after
> +	 * resize already masked the queue; late IRQs then hit the handler
> +	 * after num_rx_queues was published lower (lab WARN at interrupt).
>  	 */

[Severity: Low]
Is this comment accurate for this commit? It refers to a resize that
publishes num_rx_queues lower, and to a "lab WARN at interrupt".

At this commit, num_rx_queues is only assigned in probe. Also,
ibmveth_interrupt() explicitly avoids a WARN:

	/*
	 * Quiet on out-of-range: teardown can leave a residual IRQ after the
	 * live count drops. Do not WARN-storm; return IRQ_NONE until free_irq.
	 */
	if (qindex < 0 || qindex >= adapter->num_rx_queues)
		return IRQ_NONE;

Resize arrives later in the series. However, the WARN-at-interrupt text
and "napi_disable() sets DISABLE then waits for this poll" are still
wrong in the final tree (see the next comment).

> +	if (ibmveth_poll_stopping(netdev, napi))
> +		goto out;
> +
>  	rc = ibmveth_enable_irq(adapter, queue_index);

[Severity: High]
Does this check close the re-arm race the commit message describes? The
message says:

    ibmveth_poll_stopping() ensures close/napi_disable
    does not re-arm PHYP.

By this point, napi_complete_done() has already cleared
NAPI_STATE_SCHED. napi_disable_locked() only waits while SCHED or NPSVC
is set, and it clears NAPI_STATE_DISABLE again before returning.

So a napi_disable() that starts after napi_complete_done() does not
wait for this poll, and napi_disable_pending() is only true briefly.
Documentation/networking/napi.rst also says napi_disable() waits only
for ownership to be released, not for the poll method to exit.

pool_store and change_mtu call ibmveth_close() directly, so
netif_running() stays true on those paths. That allows:

CPU0 (ibmveth_poll)
  napi_complete_done()
  ibmveth_poll_stopping()   /* false: DISABLE not set yet */
  <delayed, e.g. vCPU preempted>

CPU1 (ibmveth_close() from pool_store or change_mtu)
  ibmveth_cleanup_rx_interrupts()
    ibmveth_disable_irq(); synchronize_irq();
    napi_disable();          /* SCHED clear, returns at once */
    ibmveth_disable_irq(); synchronize_irq();
    free_irq();
  synchronize_net();

CPU0
  ibmveth_enable_irq()      /* unmasks PHYP after the last mask */

The later reschedule attempt in the poll fails because the disabled
NAPI now owns SCHED, so nothing masks the queue again.

ibmveth_close() only calls synchronize_net() after
ibmveth_cleanup_rx_interrupts() and does not remask:

	ibmveth_cleanup_rx_interrupts(adapter);
	/* Wait for softirq/poll that already passed shutdown checks. */
	synchronize_net();

dev_close() callers look safe, because __dev_close_many() clears
__LINK_STATE_START and synchronizes before ndo_stop.

With the later "ibmveth: Implement incremental MQ RX queue resize"
patch, the same window seems to let a retiring queue stay unmasked
until H_FREE_LOGICAL_LAN_QUEUE.

Would this need real synchronization, for example a remask after
synchronize_net(), rather than another lockless flag test?

[ ... ]

> @@ -2390,130 +2388,239 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
>  	}
>  }
>  
> +static void ibmveth_poll_bump_invalid(struct ibmveth_adapter *adapter,
> +				      int queue_index)
> +{
> +	adapter->rx_invalid_buffer++;
> +}
> +
> +static bool ibmveth_poll_stopping(struct net_device *netdev,
> +				  struct napi_struct *napi)
> +{
> +	return !netif_running(netdev) || napi_disable_pending(napi);
> +}
> +
> +static bool ibmveth_poll_harvest_slot(struct ibmveth_adapter *adapter,
> +				      int queue_index, bool reuse)
> +{
> +	int rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, reuse);
> +
> +	return !rc || rc == -EINVAL || rc == -EFAULT;
> +}
> +
> +static bool ibmveth_poll_recycle_invalid(struct net_device *netdev,
> +					 struct ibmveth_adapter *adapter,
> +					 int queue_index)
> +{
> +	netdev_dbg(netdev, "recycling invalid buffer\n");
> +	ibmveth_poll_bump_invalid(adapter, queue_index);
> +	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
> +}
> +
> +static bool ibmveth_poll_skip_bad_correlator(struct net_device *netdev,
> +					     struct ibmveth_adapter *adapter,
> +					     int queue_index)
> +{
> +	if (net_ratelimit())
> +		netdev_err(netdev,
> +			   "bad correlator on queue %d, skipping slot\n",
> +			   queue_index);
> +	/* Residual stale slot after resize: recover via reset rather
> +	 * than spinning forever. Always escalate; only the log is
> +	 * rate-limited.
> +	 */
> +	schedule_work(&adapter->work);
> +	ibmveth_poll_bump_invalid(adapter, queue_index);
> +	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
> +}
> +
> +static bool ibmveth_poll_drop_oversize(struct net_device *netdev,
> +				       struct ibmveth_adapter *adapter,
> +				     int queue_index, unsigned int off,
> +				     unsigned int len, unsigned int room)
> +{
> +	if (net_ratelimit())
> +		netdev_err(netdev,
> +			   "RX frame %u+%u exceeds buffer %u on queue %d, dropping\n",
> +			   off, len, room, queue_index);
> +	ibmveth_poll_bump_invalid(adapter, queue_index);
> +	return ibmveth_poll_harvest_slot(adapter, queue_index, true);
> +}
> +
> +/**
> + * ibmveth_poll_deliver_frame - Build SKB from one valid RX slot and GRO it
> + * @napi: NAPI context for this RX queue
> + * @adapter: ibmveth adapter
> + * @netdev: net_device for @adapter
> + * @queue_index: RX queue index
> + *
> + * Return: 1 frame delivered, 0 if the slot was skipped cleanly, -1 on error.
> + */
> +static int ibmveth_poll_deliver_frame(struct napi_struct *napi,
> +				      struct ibmveth_adapter *adapter,
> +				      struct net_device *netdev,
> +				      int queue_index)
> +{
> +	struct sk_buff *skb, *new_skb;
> +	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
> +	unsigned int room, off, len, pool;
> +	int length, offset, csum_good, lrg_pkt;
> +	__sum16 iph_check = 0;
> +	u16 mss = 0;
> +	int rc;
> +
> +	length = ibmveth_rxq_frame_length(adapter, queue_index);
> +	offset = ibmveth_rxq_frame_offset(adapter, queue_index);
> +	csum_good = ibmveth_rxq_csum_good(adapter, queue_index);
> +	lrg_pkt = ibmveth_rxq_large_packet(adapter, queue_index);
> +
> +	skb = ibmveth_rxq_get_buffer(adapter, queue_index);
> +	if (unlikely(!skb)) {
> +		if (!ibmveth_poll_skip_bad_correlator(netdev, adapter,
> +						      queue_index))
> +			return -1;
> +		return 0;
> +	}
> +
> +	pool = rxq->queue_addr[rxq->index].correlator >> 32;
> +	room = min_t(unsigned int, skb_tailroom(skb),
> +		     adapter->rx_buff_pool[queue_index][pool].buff_size);
> +	off = offset;
> +	len = length;
> +	if (unlikely(off >= room || len > room - off)) {
> +		if (!ibmveth_poll_drop_oversize(netdev, adapter, queue_index,
> +						off, len, room))
> +			return -1;
> +		return 0;
> +	}
> +
> +	if (lrg_pkt) {
> +		__be64 *rxmss = (__be64 *)(skb->data + 8);
> +
> +		mss = (u16)be64_to_cpu(*rxmss);
> +	}
> +
> +	new_skb = NULL;
> +	if (length < rx_copybreak)
> +		new_skb = netdev_alloc_skb(netdev, length);
> +
> +	if (new_skb) {
> +		skb_copy_to_linear_data(new_skb, skb->data + offset, length);
> +		if (rx_flush)
> +			ibmveth_flush_buffer(skb->data, length + offset);
> +		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
> +		if (unlikely(rc)) {
> +			kfree_skb(new_skb);
> +			return -1;
> +		}
> +		skb = new_skb;
> +	} else {
> +		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, false);
> +		if (unlikely(rc))
> +			return -1;
> +		skb_reserve(skb, offset);
> +	}
> +
> +	skb_put(skb, length);
> +	skb->protocol = eth_type_trans(skb, netdev);
> +
> +	if (skb->protocol == cpu_to_be16(ETH_P_IP))
> +		iph_check = ((struct iphdr *)skb->data)->check;
> +
> +	if ((length > netdev->mtu + ETH_HLEN) || lrg_pkt ||
> +	    iph_check == 0xffff) {
> +		ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
> +		adapter->rx_large_packets++;
> +	}
> +
> +	if (csum_good) {
> +		skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		ibmveth_rx_csum_helper(skb, adapter);
> +	}
> +
> +	napi_gro_receive(napi, skb);
> +
> +	netdev->stats.rx_packets++;
> +	netdev->stats.rx_bytes += length;
> +
> +	return 1;
> +}
> +
>  static int ibmveth_poll(struct napi_struct *napi, int budget)
>  {
>  	struct net_device *netdev = napi->dev;
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>  	int frames_processed = 0;
>  	int queue_index, rc;
> -	u16 mss = 0;
>  
>  	queue_index = napi - adapter->napi;
>  
> +	if (WARN_ON(queue_index < 0 ||
> +		    queue_index >= adapter->num_rx_queues)) {
> +		if (budget)
> +			napi_complete_done(napi, 0);
> +		return 0;
> +	}
> +
> +	if (ibmveth_poll_stopping(netdev, napi)) {
> +		if (budget)
> +			napi_complete_done(napi, 0);
> +		return 0;
> +	}
> +
>  restart_poll:
>  	while (frames_processed < budget) {
> +		if (ibmveth_poll_stopping(netdev, napi))
> +			break;
> +
>  		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
>  			break;
>  
>  		smp_rmb();
>  		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
>  			wmb(); /* suggested by larson1 */
> -			adapter->rx_invalid_buffer++;
> -			netdev_dbg(netdev, "recycling invalid buffer\n");
> -			rc = ibmveth_rxq_harvest_buffer(adapter,
> -							queue_index, true);
> -			if (unlikely(rc))
> +			if (!ibmveth_poll_recycle_invalid(netdev, adapter,
> +							  queue_index))
>  				break;
>  		} else {
> -			struct sk_buff *skb, *new_skb;
> -			int length = ibmveth_rxq_frame_length(adapter,
> -							      queue_index);
> -			int offset = ibmveth_rxq_frame_offset(adapter,
> -							      queue_index);
> -			int csum_good = ibmveth_rxq_csum_good(adapter,
> -							      queue_index);
> -			int lrg_pkt = ibmveth_rxq_large_packet(adapter,
> -							       queue_index);
> -			__sum16 iph_check = 0;
> -
> -			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
> -			if (unlikely(!skb)) {
> -				struct ibmveth_rx_q *rxq =
> -					&adapter->rx_queue[queue_index];
> -
> -				ibmveth_rxq_advance(rxq);
> +			rc = ibmveth_poll_deliver_frame(napi, adapter, netdev,
> +							queue_index);
> +			if (rc < 0)
>  				break;
> -			}
> -
> -			/* if the large packet bit is set in the rx queue
> -			 * descriptor, the mss will be written by PHYP eight
> -			 * bytes from the start of the rx buffer, which is
> -			 * skb->data at this stage
> -			 */
> -			if (lrg_pkt) {
> -				__be64 *rxmss = (__be64 *)(skb->data + 8);
> -
> -				mss = (u16)be64_to_cpu(*rxmss);
> -			}
> -
> -			new_skb = NULL;
> -			if (length < rx_copybreak)
> -				new_skb = netdev_alloc_skb(netdev, length);
> -
> -			if (new_skb) {
> -				skb_copy_to_linear_data(new_skb,
> -							skb->data + offset,
> -							length);
> -				if (rx_flush)
> -					ibmveth_flush_buffer(skb->data,
> -							     length + offset);
> -				rc = ibmveth_rxq_harvest_buffer(adapter,
> -								queue_index,
> -								true);
> -				if (unlikely(rc))
> -					break;
> -				skb = new_skb;
> -			} else {
> -				rc = ibmveth_rxq_harvest_buffer(adapter,
> -								queue_index,
> -								false);
> -				if (unlikely(rc))
> -					break;
> -				skb_reserve(skb, offset);
> -			}
> -
> -			skb_put(skb, length);
> -			skb->protocol = eth_type_trans(skb, netdev);
> -
> -			/* PHYP without PLSO support places a -1 in the ip
> -			 * checksum for large send frames.
> -			 */
> -			if (skb->protocol == cpu_to_be16(ETH_P_IP)) {
> -				struct iphdr *iph = (struct iphdr *)skb->data;
> -
> -				iph_check = iph->check;
> -			}
> -
> -			if ((length > netdev->mtu + ETH_HLEN) ||
> -			    lrg_pkt || iph_check == 0xffff) {
> -				ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
> -				adapter->rx_large_packets++;
> -			}
> -
> -			if (csum_good) {
> -				skb->ip_summed = CHECKSUM_UNNECESSARY;
> -				ibmveth_rx_csum_helper(skb, adapter);
> -			}
> -
> -			napi_gro_receive(napi, skb);	/* send it up */
> -
> -			netdev->stats.rx_packets++;
> -			netdev->stats.rx_bytes += length;
> -			frames_processed++;
> +			if (rc > 0)
> +				frames_processed++;
>  		}
>  	}
>  
>  	ibmveth_replenish_task(adapter, queue_index);
>  
> +	if (ibmveth_poll_stopping(netdev, napi)) {
> +		/* budget 0 is netpoll, which must not complete NAPI.
> +		 * Otherwise returning budget after completing would ask
> +		 * NAPI to reschedule, so cap the return at budget - 1.
> +		 */
> +		if (budget) {
> +			napi_complete_done(napi, frames_processed);
> +			return min(frames_processed, budget - 1);
> +		}
> +		return 0;
> +	}
> +
>  	if (frames_processed == budget)
>  		goto out;
>  
>  	if (!napi_complete_done(napi, frames_processed))
>  		goto out;
>  
> -	/* We think we are done - reenable interrupts,
> -	 * then check once more to make sure we are done.
> +	/*
> +	 * napi_disable() sets DISABLE then waits for this poll. Without a
> +	 * second stopping check here, enable_irq() can re-arm PHYP after
> +	 * resize already masked the queue; late IRQs then hit the handler
> +	 * after num_rx_queues was published lower (lab WARN at interrupt).
>  	 */
> +	if (ibmveth_poll_stopping(netdev, napi))
> +		goto out;
> +
>  	rc = ibmveth_enable_irq(adapter, queue_index);
>  	if (rc) {
>  		netdev_err(netdev,

[Severity: High]
Can the pool index computed here go out of bounds?

ibmveth_rxq_get_buffer() loads the correlator from the RX ring once,
checks it with ibmveth_rxq_correlator_valid() and returns the skb.
This hunk then recomputes pool from a fresh load of
rxq->queue_addr[rxq->index].correlator. That field lives in DMA
memory that PHYP writes. The new value is never checked against
IBMVETH_NUM_BUFF_POOLS before it indexes
adapter->rx_buff_pool[queue_index][pool].

pool is an unsigned int taken from the top 32 bits. If the ring entry
no longer matches what get_buffer() validated, the buff_size read can
land far past the end of struct ibmveth_adapter and fault in NAPI
softirq context. None of these loads use READ_ONCE(), so the compiler
is also free to refetch.

ibmveth_rxq_harvest_buffer() then reads the correlator a third time
and hands it to ibmveth_remove_buffer_from_pool(). That read predates
this patch. If it disagrees with get_buffer(), the driver removes a
different pool entry from the one whose skb it gives to
napi_gro_receive(). With reuse false, the delivered skb would stay in
pool->skbuff[] and stay DMA-mapped. A later recycle or
ibmveth_free_buffer_pool() could then touch an skb the stack already
owns.

PHYP is not expected to rewrite a slot it has handed back. But the
commit message presents the new offset+length bound as hardening
against PHYP-supplied values, and this adds an unchecked index right
next to it.

Would it be better to read the correlator once per slot and pass the
validated value (or pool and index) through get_buffer, the room
calculation and the harvest, instead of going back to the ring each
time?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790319558.git.mmc%40linux.ibm.com

