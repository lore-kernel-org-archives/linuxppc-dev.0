Return-Path: <linuxppc-dev+bounces-24216-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40D8C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 13:00:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzztD2CBsz2yY1;
	Tue, 14 Jul 2026 23:00:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784034004;
	cv=none; b=NWdtwAo53tBLpcjd4X+mQ/jmn3ZAbXU4ShN+8H5NItyTzuLhhYC0Pw/wUmdd/TN8JcbaajKLBaPYTs5DOd0Ry/7CtvO7pFWRS4751QQ7w8LeWRk8O5Isfv8P8YgyZyckhgICfFbqXam1AknZcfV46fJqjS/+m/RTdvPZ8cRQhmN72PHbzgoQO4N07CylDjFibd/hdFZO5TgsD059guBoWMl3mABdnBJuloWo+eUeS0FPd+nLuCnMKE8YNgUHovHOgRdr+gbtQA4/VJqcPuTfiJPKJvoiXomec726VGxzG5ug8TvbKD/gkBPcv0epcx6r3+Rnsst6Bu/wMgWbJ5hcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784034004; c=relaxed/relaxed;
	bh=1P/wug/qzmssJOyrjuPPOZYs1q4TmXwKDCPnEXvd4gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6mfeQmEV6SAvLHvnc209PP67dgowY2sP24hjIBnIMxjrFv1l6a3V4q/+jMCtIjNEZgH1ytQ/QVFMDZG46sg2jU2c9VPXOvsBASZMAmaSXuxiD3ivM4odWojBpvp7LILmhjIuX7ZK3dHpYq0DTUyq9rQxdF70XBDQavo8vKI+mK57wDNJbXIddyRAgu1BO4xOEIgR19B364Va69YvE8JPmM2wYgVx3Tq5x+ZWLKUHAQMOVbjOleBuHA4eIYf4m3+0C2ODghf2K97sTyQ4j6Z+C7LuTLcdD9LuUzw7U6HgSZFfK/ePq3XdG/JGRomgEFWb67UZuS0uJBgsENI2ekOtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7UoAST0; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7UoAST0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzztC3TnWz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 23:00:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 76AB760120;
	Tue, 14 Jul 2026 13:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB74A1F000E9;
	Tue, 14 Jul 2026 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784034001;
	bh=1P/wug/qzmssJOyrjuPPOZYs1q4TmXwKDCPnEXvd4gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X7UoAST0BAf5quQi/hWYb9/7KmQ8gg2QSkoTKrfTgtINsPRIFFRwjvZi/aqt9ZLCq
	 a3YcziUtVcr5f0KXxpdnUdCyRAGNjBpyeqqG7pg5f/uqSC/xcSSA8uUGKN12DISA/1
	 iZjio3PiMymS7yYn4ihVW4iYM4TI8ItkWuU9XoSOBUoAmp7CnavZ7n0E4mEcwDjaC9
	 S6rBJHk/5+tFYxP5SSec+hkag3hmQvojB/ArIID9XmeuMwcTMBVxa3ssvsXr8UOd/t
	 tEvjrhduGsfacZl15DVGJ+MNglU9x6dyC9vGsG+uNbvtiq6dIvCDjoHd/5vo6Qj5OZ
	 +idcKl/dTojHg==
From: Simon Horman <horms@kernel.org>
To: mmc@linux.ibm.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v3 11/15] ibmveth: Add per-queue RX and TX statistics collection and reporting
Date: Tue, 14 Jul 2026 13:59:48 +0100
Message-ID: <20260714125948.1841205-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-12-mmc@linux.ibm.com>
References: <20260706193603.8039-12-mmc@linux.ibm.com>
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
Full review at: https://sashiko.dev
---
ibmveth: Add per-queue RX and TX statistics collection and reporting

This commit introduces per-queue statistics tracking for both receive and
transmit paths in the ibmveth driver. The counters are aggregated for legacy
interfaces and exposed individually via ethtool stringsets.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 863e5c68b42c7..4e3f49b6346fd 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
[ ... ]
> @@ -1655,6 +1655,10 @@ static int ibmveth_open(struct net_device *netdev)
>  	if (rc)
>  		goto out_cleanup_rx_interrupts;
>  
> +	rc = ibmveth_alloc_tx_qstats(adapter);
> +	if (rc)
> +		goto out_free_tx_resources;
> +
>  	netif_tx_start_all_queues(netdev);
>  
>  	netdev_dbg(netdev, "open complete\n");
[ ... ]
>  out_cleanup_rx_interrupts:
>  	ibmveth_cleanup_rx_interrupts(adapter);
>  out_free_tx_resources:
>  	ibmveth_free_tx_resources(adapter);

[Severity: High]
Does the goto out_free_tx_resources on ibmveth_alloc_tx_qstats() failure
bypass the cleanup for RX interrupts?

Since out_free_tx_resources is physically below out_cleanup_rx_interrupts in
ibmveth_open(), failing here leaves the IRQs requested and NAPI enabled. If
an interrupt subsequently fires, could the handler access the freed RX queue
memory and cause a kernel panic?

[ ... ]
> @@ -1699,6 +1699,7 @@ static int ibmveth_close(struct net_device *netdev)
>  		}
>  	}
>  
> +	ibmveth_free_tx_qstats(adapter);
>  	ibmveth_free_tx_resources(adapter);
>  	ibmveth_cleanup_rx_interrupts(adapter);
>  	ibmveth_update_rx_no_buffer(adapter);
[ ... ]
>  	ibmveth_free_rx_qstats(adapter);

[Severity: High]
If ibmveth_close() is called to bring down the interface, does this
unconditionally free adapter->tx_qstats and adapter->rx_qstats without a
grace period?

Since ibmveth_get_stats64() can be called concurrently under RCU, and
ibmveth_start_xmit() can run concurrently if the datapath is not completely
synchronized, could this lead to a use-after-free or NULL pointer dereference
when these functions access the freed arrays?

[ ... ]
> @@ -1967,22 +1967,107 @@ static int ibmveth_set_features(struct net_device *dev,
[ ... ]
> +static void ibmveth_aggregate_rx_qstats(struct ibmveth_adapter *adapter)
> +{
> +	u64 total_invalid = 0;
> +	u64 total_large = 0;
> +	int i;
> +
> +	if (!adapter->rx_qstats)
> +		return;
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		total_invalid += adapter->rx_qstats[i].invalid_buffers;
> +		total_large += adapter->rx_qstats[i].large_packets;
> +	}
> +
> +	adapter->rx_invalid_buffer = total_invalid;
> +	adapter->rx_large_packets = total_large;
> +}

[Severity: High]
Does overwriting adapter->rx_invalid_buffer and other persistent global
counters with the dynamically allocated adapter->rx_qstats values cause a
permanent loss of interface statistics?

When the interface is brought down and back up, ibmveth_close() frees the
queue stats arrays and ibmveth_open() reallocates them as zeroed. Will this
cause all historical statistics to be wiped out on every interface reset,
breaking standard persistence behavior?

[ ... ]
> +static void ibmveth_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> +{
[ ... ]
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		ethtool_sprintf(&p, "rx%d_packets", i);
> +		ethtool_sprintf(&p, "rx%d_bytes", i);

[Severity: Low]
Are these private ethtool stringsets duplicating standard kernel statistics?

According to the subsystem guidelines, per-queue packet and byte statistics
that have a standard UAPI representation (like struct netdev_queue_stats_rx
exported via netlink) should not be duplicated as private ethtool strings.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
> index f7b20fd01acb5..390c660af979e 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.h
> +++ b/drivers/net/ethernet/ibm/ibmveth.h
> @@ -316,9 +316,21 @@ struct ibmveth_rx_queue_stats {
>  	u64 no_buffer_drops;
>  };
>  
> +struct ibmveth_tx_queue_stats {
> +	u64 packets;
> +	u64 bytes;
> +	u64 large_packets;
> +	u64 dropped_packets;
> +	u64 send_failures;
> +	u64 checksum_offload;
> +};

[Severity: Medium]
Will this structure layout prevent cache line false sharing?

The commit message mentions tracking transmit counters per TX queue to avoid
cache line contention, but struct ibmveth_tx_queue_stats appears to be
exactly 48 bytes and lacks cacheline alignment annotations like
____cacheline_aligned. When allocated as a contiguous array, will multiple
CPUs processing different queues end up writing to the same hardware
cacheline?

