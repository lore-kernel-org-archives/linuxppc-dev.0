Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F84606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blbwHczw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQckd2WjZz3bjc;
	Fri, 13 Nov 2026 10:57:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794527833;
	cv=none; b=L0j7RIFB9Cs1uNbNJmxvwP3TR4Dhhotz/X8VobTGHWUwmEg6MfBN1LcBEliGHpzjur+TYTz/GRo6zriuSshInMOBJdtS6MNVZ5L7YYomvHxH0sA2QkCtv3xF3XRibXlPaJAU7HgWQ3kQcwE3rstC6VQe9hwVuOLcjsxDnTm3qMqvoxJKNLZmZsxp8i54+3CXvj/uP88Iy6r+zJ2cVlr6+cj/kYn5ffevc3A8S2PCYqbe1og4+KaxgwDJdn5q2f9fHNpqgm4LqCGpmit1g3W6LVO72/JXckvuaOVrYCpMBzrCa2D+Yw/IMIXBKgSXTBtfu9mC58TTxhi1ErSXuv7adw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794527833; c=relaxed/relaxed;
	bh=RyjzhzKMJ54LO47b8hj9G6AeITbfXRNhKF+4Refxl1s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j/PvO9JqGBZJTybmnkpwqmTs7bO1IlYUCDDQ6ifFzxt1nZClQDRyCC3S68g6wBkqg3NjQ+OirX/poyQaZjooQAlwqrEV0YXTLNqNb0lOtt75K1kl/XkA6UJ6L5xf1fI4q+Mm/S8KoYmmhwC+VnP7Ez3HRnB+f5uzZMP2PtnZdEKZE9PbFKpAi5PXdAZbWko2B8hElS6extX40NUM2KD6N4LPedEFOtt2eWVcAPALdD0G5CiBmyWX0DAuNcW9bgzTv84PynW8kPXFqOJaWXMr2xYrVtCGEI6mvfFoV++d3BfxPPtvosmZ8b+j8FEEFnpPmO96e6UvXnSKy4Wm3B7Z7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blbwHczw; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blbwHczw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQckc4XKfz3blK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 10:57:12 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 14F254010E;
	Thu, 12 Nov 2026 23:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8191F000C4;
	Thu, 12 Nov 2026 23:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527831;
	bh=RyjzhzKMJ54LO47b8hj9G6AeITbfXRNhKF+4Refxl1s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=blbwHczwvaWRLorErllgB0iHTQIGhPBx1zDgTgurSWxN4XaD5BLcSOFYxP0Ei0gv6
	 lbTIHu7/bgIHQxxxAWsHtHLdBPIt3kXjIl6bKXEtVTdYFGFg92Qe/DyatPJYUNGPdA
	 pW8vwwsjGe2v6R3cCy+t5ZlYzt18+fSCYehQsuSK63klq3CQc3lq58xBMw9QN5U9Iz
	 NTq5ATwosdkXsq0m59L9rzjT5PnFv6k2KOFrG/UiuMl4BfxKtpAswdXoHvaUzCwdIP
	 D7hizDYyp0ubQIZmg6YqVTR65z4UjD9JMdLkSYLBpxx5uQotsDlh1r2b1MaaARLpZN
	 mlUIYMANSM+UA==
Subject:
 Re: [PATCH net-next v8 10/15] ibmveth: Enable multi-queue RX receive path
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Date: Thu, 12 Nov 2026 23:57:09 +0000
Message-ID: <179452782954.2199510.3698776944774316685@kernel.org>
In-Reply-To: <20261109235556.60604-11-mmc@linux.ibm.com>
References: <20261109235556.60604-11-mmc@linux.ibm.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The MQ teardown design is only safe if CMO and MQ firmware
  never run on the same partition, and the code never checks this.

--

ibmveth: Enable multi-queue RX receive path

This commit turns on multi-queue RX when firmware advertises
IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT in H_ILLAN_ATTRIBUTES. Each
subordinate queue 1..N gets its own IRQ, NAPI instance and buffer pools.
It also changes teardown: in multi-queue mode, a hard H_FREE_LOGICAL_LAN
failure now leaves the LAN memory mapped, and open() and remove() retry
the free later.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index b12bfa1e485eb..a0c3c06d2b9d9 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1630,17 +1864,25 @@ static long ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,

[ ... ]

> + * Retries only H_BUSY and H_IS_LONG_BUSY. Other failures are logged.
> + * In multi-queue mode a failure other than H_PARAMETER (already free)
> + * is fail-before-start: PHYP may still DMA into the LAN memory, so
> + * return -EIO with the slots still registered. The caller skips the
> + * unmap, and the next open() or remove() retries. Single-queue mode
> + * keeps what close() always did, log and let the caller unmap; one
> + * reason it cannot simply keep the memory mapped is that on a CMO
> + * partition vio_cmo_bus_remove() BUG()s on an outstanding entitlement.

[ ... ]

> @@ -1654,29 +1896,45 @@ static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
>  	if (lpar_rc != H_SUCCESS) {
>  		netdev_err(adapter->netdev,
>  			   "h_free_logical_lan failed: %ld\n", lpar_rc);
> +		if (lpar_rc != H_PARAMETER && adapter->multi_queue)
> +			return -EIO;
>  	}

[ ... ]

> @@ -3131,16 +3527,30 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  		netdev->features |= NETIF_F_FRAGLIST;
>  	}
>  
> -	/* Initialize queue count - always 1 for now */
> -	adapter->multi_queue = 0;
> -	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
> +	if (ret == H_SUCCESS &&
> +	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT)) {
> +		adapter->multi_queue = true;

[Severity: Medium]

The new -EIO path in ibmveth_free_all_queues() is only safe if CMO and
multi-queue are never active on the same partition. The kernel-doc above
uses the CMO BUG() to explain why single-queue must still unmap, and the
commit message says:

  CMO (Power9 and earlier) and MQ firmware (Power11+) do not coexist

Does anything in the driver enforce that? Here multi_queue is set from
the IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT bit alone. Yet ibmveth_probe()
checks FW_FEATURE_CMO a few lines further down to pick pool_count_cmo:

	if (firmware_has_feature(FW_FEATURE_CMO))
		memcpy(pool_count, pool_count_cmo, sizeof(pool_count));

Suppose firmware does report the MQ bit on a CMO partition and
H_FREE_LOGICAL_LAN hard-fails. ibmveth_remove() then returns with the
DMA mappings still live:

	if (ibmveth_lan_resources_live(adapter)) {
		if (ibmveth_free_all_queues(adapter))
			dev_err(&dev->dev,
				"h_free_logical_lan still failing at remove; leaking LAN buffers\n");
		...
	}

Would the bus remove path then hit this BUG()?

arch/powerpc/platforms/pseries/vio.c:vio_cmo_bus_remove() {
    ...
	if (viodev->cmo.allocated) {
		dev_err(&viodev->dev, "%s: device had %lu bytes of IO "
		        "allocated after remove operation.\n",
		        __func__, viodev->cmo.allocated);
		BUG();
	}
    ...
}

The entitlement is also mismatched. vio_cmo_bus_probe() computes the
CMO desired entitlement before the driver probes, so it covers one
queue. Probe does not refresh it, but MQ maps up to 8 times the RX
buffers.

Could multi_queue be gated on !firmware_has_feature(FW_FEATURE_CMO)
here, so the driver checks this instead of assuming it? At the end of
the series, probe still enables MQ the same way, and remove() still has
the "leaking LAN buffers" path.

> +		ibmveth_publish_num_rx_queues(adapter,
> +					      min(num_online_cpus(),
> +						  IBMVETH_DEFAULT_QUEUES));

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235556.60604-1-mmc%40linux.ibm.com

