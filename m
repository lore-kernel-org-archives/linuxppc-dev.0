Return-Path: <linuxppc-dev+bounces-24214-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C147C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 12:53:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzzkp5fZhz2yH5;
	Tue, 14 Jul 2026 22:53:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784033618;
	cv=none; b=jdh4NAcL+6+JDTzL0XIIvjyGHXpuKlWUTcjBZkDhvgf+ZLTMaoYlRXcpFXsi1i0zH2NIpWAT33D7cbjyetryuSpOzV0ebsCs6+mHOM7rIRMtEENC9bwXlD2V8ok8QY7eW3NzWEByFzMKUkPA4//By/MdV8iyrfsMuEmy+KlbsAlbm+8h4ptXWZoOvge9Pv9HpmcGpFUtR3+6L/VhvdDKsu9XM69Q6Onoh/gdeSGrpqyia2PBdsGgysfMquzYj4Nw9pfylEvuhjATOaLsuxccaOtODiVRuNoydTlWVJjzdOB7WtuB+fLqG+mIMtcoos7SpXqs4UDDmeU2/HH2hQKxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784033618; c=relaxed/relaxed;
	bh=EMkk7CFtTQcIlGBgRJv9LJja2Ycb8KtPZthsLBihCqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oo4ShPakMyQXxvNEzDmnNPJ8PrRzQtmcyqrAmi4lQIOePet4ckIVXlO+kAoBrSPcOOrUVsLkGmcyeb9CMcHyt7B/tmq+CnDhpg91TqN9gTMOW9aLSXVhVJ+H5gR0vxK/WGJirNHQwSV859nWbBNonyEYco7hWO8wj6lm6IjM1jsC7uVjGIT0v2xSDQi7RqaU/bwcRYAUP+yacx35+LkPtA+cSB/0M48LGRyLsLtFidp7FgaZuQBZYK2t+gRy325lAUqZ12ScBpU1q/v8CSqVDfeOteFp33pBfdS37+NLytpd7rduoY5o/qWOoeScNL+Kz6qJnIal6/3JfeCYK1bPxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mp1gA8pc; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mp1gA8pc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzzkn3pGSz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 22:53:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 13B9060120;
	Tue, 14 Jul 2026 12:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C61A1F000E9;
	Tue, 14 Jul 2026 12:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784033614;
	bh=EMkk7CFtTQcIlGBgRJv9LJja2Ycb8KtPZthsLBihCqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mp1gA8pcEahDgKIw5Qycwx1OZhwPqMMHSLJDxBv34rD0UuhlBfQtwFpEQoPVo6gku
	 uqt+ZMqIP5XkisRmSdtm6/xzqApyhmIHEpe90NFHOMTXrO1x6b9aIcWsV1A1KF294B
	 VFUHiOwdHS6LuKMmCMB0Ye9GN0MppyxqMN3V3HazkKG2kHkJa110+vIXUBYzcrcXt8
	 1vpz4kbhL2Rgse4UrRmo8/0r0X2feCODsp4CFrq8UyzqB/+zDrG+3fnUwx2QltcpmF
	 pKpwWaAW1Vy08yjxHnlLHsRUiUZsF5eoQxtjpnroOu8ZG9jC/muelTwG6fXtd+uv46
	 2T99lTU53CcrA==
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
Subject: Re: [PATCH net-next v3 09/15] ibmveth: Add queue-aware RX buffer submit helper for MQ
Date: Tue, 14 Jul 2026 13:50:20 +0100
Message-ID: <20260714125019.1833862-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-10-mmc@linux.ibm.com>
References: <20260706193603.8039-10-mmc@linux.ibm.com>
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
ibmveth: Add queue-aware RX buffer submit helper for MQ

This patch updates the ibmveth driver's buffer replenishment path to
be queue-aware for multi-queue receive support. It adds a helper to select
the correct hypervisor call and handles fallback to single-buffer mode if
batch operations are unsupported.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index fa2d4777ffc7b..b3b3886c3eedb 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -597,11 +597,73 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)

[ ... ]

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
> +		unsigned long buffersznum = (buff_size << 32) | filled;
> +		unsigned long ioba[IBMVETH_MAX_RX_PER_HCALL / 2] = {0};
> +		int i;
> +
> +		/* Pack descriptor addresses into ioba pairs.
> +		 * Each ioba holds two 32-bit addresses packed into 64 bits:
> +		 * - Even descriptors (0,2,4...) go in high 32 bits
> +		 * - Odd descriptors (1,3,5...) go in low 32 bits
> +		 */
> +		for (i = 0; i < filled && i < IBMVETH_MAX_RX_PER_HCALL; i++) {
> +			int pair_idx = i / 2;           /* Which pair: 0-5 */
> +			int is_high = (i % 2 == 0);     /* High or low 32 bits */
> +
> +			if (is_high)
> +				ioba[pair_idx] = (unsigned long)descs[i].fields.address << 32;
> +			else
> +				ioba[pair_idx] |= descs[i].fields.address;
> +		}
> +
> +		rc = h_add_logical_lan_buffers_queue(vdev->unit_address,
> +						     adapter->queue_handle[queue_index],
> +						     buffersznum,
> +						     ioba[0], ioba[1], ioba[2],
> +						     ioba[3], ioba[4], ioba[5]);
> +		adapter->hcall_stats.add_bufs_queue++;

[Severity: Medium]
Will this counter increment lose updates when multiple NAPI poll routines run
concurrently on different CPUs?

Since multi-queue enables concurrent execution, it seems global statistic
counters like hcall_stats.add_bufs_queue and replenish_add_buff_success might 
need atomic or per-CPU operations to avoid read-modify-write data races.

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
> +
> +	return rc;
> +}

[ ... ]

> @@ -745,24 +798,19 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>  		}
>  		adapter->replenish_add_buff_failure += filled;
>  
> -		/*
> -		 * If multi rx buffers hcall is no longer supported by FW
> -		 * e.g. in the case of Live Partition Migration
> -		 */
> -		if (batch > 1 && lpar_rc == H_FUNCTION) {
> -			/*

[ ... ]

> +		if (lpar_rc == H_FUNCTION) {
> +			if (adapter->multi_queue) {
> +				netdev_err(adapter->netdev,
> +					   "Unexpected H_FUNCTION from multi-queue buffer add (queue=%d, batch=%d)\n",
> +					   queue_index, batch);
> +				break;
> +			} else if (batch > 1) {
> +				netdev_warn(adapter->netdev,
> +					    "H_FUNCTION from legacy batch buffer add (batch=%d), falling back to single buffer mode\n",
> +					    batch);
> +				adapter->rx_buffers_per_hcall = 1;
> +				continue;

[Severity: High]
Does this continue statement cause an infinite loop?

Looking at ibmveth_replenish_buffer_pool(), the local batch variable is set
before the while loop:

	batch = adapter->rx_buffers_per_hcall;
	while (remaining > 0) {
		...

If the fallback updates adapter->rx_buffers_per_hcall to 1 and issues a continue,
the loop will restart but the local batch variable will retain its original
value.

Would this lead to the loop repeatedly attempting the unsupported batch size
and failing with H_FUNCTION forever?

> +			}
>  		}
>  		break;
>  	}
> @@ -784,18 +832,24 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>  }
>  
>  /* replenish routine */
> -static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
> +static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
> +				   int queue_index)
>  {
>  	int i;
>  
> +	if (queue_index >= adapter->num_rx_queues)
> +		return;
> +
>  	adapter->replenish_task_cycles++;

[Severity: Medium]
Similar to the hcall_stats counters above, could this increment suffer from data
races when multiple queues are processed concurrently across different CPUs?

