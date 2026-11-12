Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A85606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ez1bAsFw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQckj32xGz3blK;
	Fri, 13 Nov 2026 10:57:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794527837;
	cv=none; b=mQ21wm3zfqacanbL0jru4XFtQn4p4IMPB3GeH/HYBhQWmVieWvm3zHr0v0EIgMyTtxDUnQP3VnkW+UhIiklcM3o+BWxGfiajfuYgKOeydhlVyaAwrXOU2T/6ECr1nBUGVzFcqMPZvZ8jhpZ0VlIErni8OsXXtxVL6ihbU97trnxm2C09sV5IheBnsx28HHoMe7xmfoG5GjfO3++1Dag478CO98zvpOplHKNU2OdFSQHRR70LvdZuVMsbfDjOriaDyy3PzXBTT5FrMPyxtUXlylpE4HyfWlF7kwxoVMavBw7+wQROPF31yigXoisiSozvXprRmgLio4+ZezAQ7QxdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794527837; c=relaxed/relaxed;
	bh=jKVVwUqa3LUM+JOkkayvGJFITGMsSnWe1h0V1HJGZaY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=STGyi2AynVaoqgMUv3XNG3XEJXCvjVzf8xwipC4MnK7Nwo92jmQpyO/2fZU28mi7jPZc1lHsYk+VRzNiiyAuo3yf6ndAnntb5Vj2nT3lJN4wFNq6la3ifXpExORJNyQPTYB09Xp3tlWyUL66wc0olnWQUBZZsm9GCRUIS6Wq3D4jUI5yBHv1L94hEzVhTN0x07DsXHUsC20n13TmYrEi6C2ZTSz9oexmTpYdXjJEJR0eTBp0KBfwg+KPiTbFTKu8isSWzmlDQ7znWy0BYm7SLmHd/HjHSd2Hllj2Fdn8Vj4GKWWOajE/wbqsuClATeJBFT1R7f20ZIzIGInldVx1ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ez1bAsFw; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ez1bAsFw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQckh21zJz3bnB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 10:57:16 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B274345A9F;
	Thu, 12 Nov 2026 23:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753411F000C4;
	Thu, 12 Nov 2026 23:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527834;
	bh=jKVVwUqa3LUM+JOkkayvGJFITGMsSnWe1h0V1HJGZaY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ez1bAsFwUIActmQFJHc6zWG7Oapx6c6M95VyCJxvbWgRTJ5e6nrtuUmnPxnByxtqr
	 GGIsGlNTQZ9IYn2J92AKJmtNgzJzd+L9gGYBYtrzzpN8NFkKLAYxyOIBYR2g8BpDUM
	 3XB//5XKehNzh61LuxWSzBeGYOQ6aGELu8iIsMM/+t4xVBGssbPRVRnUIfkF5Icc9g
	 vwgiUJ7EsLQHqXn4b3wW5tSftGGzz2wgU9F8DYIWdZI31yZEc9yJPVczPMhxgivzuo
	 TQ3bDSuYWVhf4jGbZRj5zZXvu67pQu5wmllq4VgimaMDDHfBpNp2zmCaAZzIBSfGUK
	 8ao5gKD3fVdMw==
Subject: Re: [PATCH net-next v8 14/15] ibmveth: Implement incremental MQ RX
 queue resize
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Date: Thu, 12 Nov 2026 23:57:13 +0000
Message-ID: <179452783301.2199510.7559323985625318822@kernel.org>
In-Reply-To: <20261109235556.60604-15-mmc@linux.ibm.com>
References: <20261109235556.60604-15-mmc@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ibmveth_destroy_subordinate_rx_queue() is used for live
  ethtool -L scale-down, the scale-up enable_irq-failure branch and the…
- [Low] When a scale-down hits the destroy-failure keep path,
  ibmveth_scale_down_rx_queues() (drivers/net/ethernet/ibm/ibmveth.c)…
- [Low] The kernel-doc of ibmveth_scale_up_rx_queues() says "A failure
  unwinds only the queues this call added; a queue PHYP refuses to…

--

ibmveth: Implement incremental MQ RX queue resize

This commit lets ethtool -L change the RX queue count on a live ibmveth
adapter one queue at a time. It adds ibmveth_scale_up_rx_queues() and
ibmveth_scale_down_rx_queues(), with unwind paths for hypervisor
failures. It also factors ibmveth_desired_dma_for_rxqs() out of
ibmveth_get_desired_dma(), and frees queues stranded above the live
count after a successful H_FREE_LOGICAL_LAN.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index e805e7b1d2fe2..510d9d80e2df5 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -2028,6 +2315,644 @@ static void ibmveth_release_lan_resources(struct ibmveth_adapter *adapter)
>  	ibmveth_free_filter_list(adapter);
>  }
>  

[ ... ]

> +/**
> + * ibmveth_destroy_subordinate_rx_queue - Tear down one subordinate RX queue
> + * @adapter: ibmveth adapter structure
> + * @queue_idx: Queue index to destroy (1..N)
> + *
> + * Deregister with PHYP before unmapping buffer pools so hypervisor buffer
> + * ownership is released while queue metadata is still valid. After a
> + * successful H_FREE, fold the last no_buffer sample into retired while
> + * the page is still mapped. If the hcall fails, leave the queue mapped,
> + * keep the handle, and skip retire.
> + *
> + * Return: 0 on success, -EIO if deregister failed
> + */
> +static int
> +ibmveth_destroy_subordinate_rx_queue(struct ibmveth_adapter *adapter,
> +				     int queue_idx)
> +{
> +	int rc;
> +
> +	rc = ibmveth_deregister_single_rx_queue(adapter, queue_idx);
> +	if (rc)
> +		return rc;
> +	ibmveth_retire_rx_no_buffer(adapter, queue_idx);
> +	ibmveth_cleanup_single_rx_interrupt(adapter, queue_idx);
> +	ibmveth_free_single_rx_queue(adapter, queue_idx);
> +	return 0;
> +}

[Severity: Medium]
Is the order of H_FREE_LOGICAL_LAN_QUEUE and the IRQ teardown safe here?

ibmveth_deregister_single_rx_queue() issues H_FREE_LOGICAL_LAN_QUEUE
first. Only after that does ibmveth_cleanup_single_rx_interrupt() run
free_irq() and irq_dispose_mapping() on the queue's virq. That virq was
created by irq_create_mapping(NULL, hwirq), using the hwirq returned by
H_REG_LOGICAL_LAN_QUEUE. So the interrupt source belongs to the queue
being freed.

On pseries XIVE, free_irq() reaches xive_irq_shutdown(), which does an
ESB access and an H_INT_SET_SOURCE_CONFIG hcall against that source:

arch/powerpc/sysdev/xive/common.c:xive_irq_shutdown() {
    ...
	xive_do_source_set_mask(xd, true);
	xive_ops->configure_irq(hw_irq,
				get_hard_smp_processor_id(xd->target),
				0xff, XIVE_BAD_IRQ);
    ...
}

irq_dispose_mapping() then tears down the per-source XIVE data and its
ESB mapping.

If H_FREE_LOGICAL_LAN_QUEUE releases the LISN, these operations would
run against a source the partition no longer owns. Could that produce
failed hcalls, stale irq_desc state, or an ESB access to a page the
hypervisor no longer backs?

The rest of this driver tears the IRQ down first:

  - ibmveth_close() runs ibmveth_cleanup_rx_interrupts() before
    ibmveth_free_all_queues().
  - The open() error path disposes the mappings before
    H_FREE_LOGICAL_LAN.
  - The scale-up request_irq failure branch disposes before it
    deregisters.

ibmvnic's release_sub_crqs() also calls free_irq() and
irq_dispose_mapping() before release_sub_crq_queue() issues
H_FREE_SUB_CRQ.

The commit message explains why deregister has to come before the DMA
unmap, but not why it has to come before the IRQ teardown. Would it
work to keep PHYP masked, call free_irq() (and dispose the mapping),
then issue H_FREE_LOGICAL_LAN_QUEUE, and re-request the IRQ in the rare
case the hcall fails?

This path runs on every successful live RX shrink and on the scale-up
unwinds. The ordering is unchanged at the end of the series.

[ ... ]

> +/**
> + * ibmveth_scale_up_rx_queues - Add RX queues to a live adapter
> + * @adapter: ibmveth adapter structure
> + * @old_count: Current number of RX queues
> + * @new_count: Target number of RX queues, above @old_count
> + * @rxq_entries: Number of entries per RX queue
> + *
> + * Raises CMO entitlement and widens real_num_rx_queues before any new
> + * queue is unmasked, then brings each queue up in turn. A failure
> + * unwinds only the queues this call added; a queue PHYP refuses to
> + * release stays in the live set instead.

[ ... ]

> +		rc = ibmveth_register_single_rx_queue(adapter, i);
> +		if (rc) {
> +			netdev_err(netdev, "Failed to register queue %d: %d\n",
> +				   i, rc);
> +			if (rc == -EOPNOTSUPP)
> +				WRITE_ONCE(adapter->mq_fallback, true);
> +			if (!ibmveth_deregister_single_rx_queue(adapter,
> +								i))
> +				ibmveth_free_single_rx_queue(adapter,
> +							     i);
> +			else
> +				schedule_work(&adapter->work);
> +			goto cleanup_new_queues;
> +		}

[Severity: Low]
This isn't a bug, but the kernel-doc above says "a queue PHYP refuses
to release stays in the live set instead". Does that hold for this
branch?

Take the case where H_REG succeeds, irq_create_mapping() fails, and the
H_FREE inside ibmveth_register_logical_lan_queue() also fails.
queue_registered[i] then stays set. If the retry in
ibmveth_deregister_single_rx_queue() fails as well, this branch
schedules a reset and jumps to cleanup_new_queues. That label publishes
old_count (or a lower keep) and passes it to
netif_set_real_num_rx_queues().

Queue i is then left registered and mapped above the live count. The
request_irq failure branch below ends up in the same state.

Only the enable_irq failure branch with a failed destroy actually keeps
the queue in the live set. ibmveth_free_stranded_rx_queues() and the
-EBUSY check at the top of this loop exist for the stranded state, and
the ibmveth_free_stranded_rx_queues() kernel-doc describes that queue as
"out of the live set".

Could the kernel-doc here be updated to match? It is unchanged at the
end of the series.

[ ... ]

> +	for (i = old_count - 1; i >= new_count; i--) {
> +		int keep;
> +
> +		rc = ibmveth_destroy_subordinate_rx_queue(adapter, i);
> +		if (!rc)
> +			continue;
> +
> +		/*
> +		 * High-to-low so a failed free leaves 0..i live.
> +		 * Queues i+1..old_count-1 are already gone.
> +		 */
> +		keep = i + 1;
> +		ibmveth_publish_num_rx_queues(adapter, keep);

[ ... ]

> +			ibmveth_restart_rx_queue(adapter, i);
> +		}
> +		return rc;
> +	}
> +
> +	return 0;
> +}

[Severity: Low]
Is an ibmveth_refresh_cmo_desired() call missing before this return?

When ibmveth_destroy_subordinate_rx_queue() fails, this path publishes
keep, restores queues new_count..keep-1 and returns rc. The dispatcher
refreshes CMO only on success:

ibmveth_resize_rx_queues_incremental() {
    ...
	if (rc)
		return rc;
    ...
	ibmveth_refresh_cmo_desired(adapter);
    ...
}

So the desired entitlement stays sized for old_count, even though
queues keep..old_count-1 have already been freed.

Every failure exit of ibmveth_scale_up_rx_queues() refreshes CMO, and
the commit message says "Refresh CMO entitlement across the resize".
The patch also notes that CMO and MQ firmware do not coexist, so this
may not be reachable in practice, but it leaves the two directions
inconsistent.

This is still the case at the end of the series. The later
"ibmveth: Complete set_channels down-path" commit does not change
ibmveth_scale_down_rx_queues().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235556.60604-1-mmc%40linux.ibm.com

