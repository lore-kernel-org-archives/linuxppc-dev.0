Return-Path: <linuxppc-dev+bounces-24212-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2027C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 12:43:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzzWc0gTQz2yH5;
	Tue, 14 Jul 2026 22:43:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784033036;
	cv=none; b=TESmUAfOEk1dWqsIXqk+p6QYviqAp3iJiNzPdZdJvus/NpMZ/23qqK196zo5yiJO4MHrJsrYxI+9aEaVAwS3eAETgeoo2i0ufW0lxDoFFdNef1MNIdj7i+GGwSUC1IbONmuWo8d5OCspoGIsVM2HGeGP7CmFowSKYD84r+4Nem5Oomle9WgKOubevo7Tjw2LkRdKRGwT2mQztoXd04AMtUz1OFRjPAA4xplLsireb+K0t+mjtm69d5mrqHn0VryrS7go59Il+6aj2xYuJ25c1G6fAw8tLyBxvVOu5JCbH/3AtuZkOQFOBOp2Iagz59yQyhvlPaEySWICN5u4A6wSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784033036; c=relaxed/relaxed;
	bh=jtlHSUbiFYNyLLadUNgGYcL9nY8Nv0mWqimOCmfHP3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daHsm7CIY36aOxvwiomGR9O3PIzirxNNLs2hnyGYifRoCgk/jXgcSIIZ8ilrflit9uuMdxvr3zUudONlvQ92FY6azgW12T1065uEtg04lm5T+4Erlcw7BqWWiECFS3Zs2HfOEfUp/bUsw62sCy4Zdhl4LA2ZV5kzQxz6d+bMzutB9tadkZcwBw3ZYrwQwzQENlIRJ3ZSw7mXA4vf5BKFjiGlWSXolt+UsAPCZsHrqPPpmPoj8dEmrYS34s5Fy0vTc33WyXh8xqM4UvUqQj5OUgHjdeqipgiFRZ6HO+96GToVaJaqYvHTKQHZkZoNeHSI2vlBuPaNBoUHpistrvfAog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2DLt847; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2DLt847;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzzWZ41hmz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 22:43:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 574E341244;
	Tue, 14 Jul 2026 12:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0331F000E9;
	Tue, 14 Jul 2026 12:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784033032;
	bh=jtlHSUbiFYNyLLadUNgGYcL9nY8Nv0mWqimOCmfHP3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M2DLt8470B2zE+vab6grYR7GWTyznRDtRlOgOEkTqOw2m54bUZN3aBNl6rBGmt+uQ
	 e85/i5TwIBdDWW7Q8nPS6Zi0h8QdSOWOvdvIejo/3ETWkW/eHPGk0U2cHha9c4GfuN
	 IF0faiXNCZYoApEGxefP8SAXxcAdKrognhjC0E7ulERJwgF950doNYzhuQ1wgpK3rO
	 N366JCe0H5iJQkEa6zCoJIurTb+1be0/tlMwvsGDDEeVa4LNWcDrsmQeOStVLLGHhn
	 DaM4WKPjUdopcs1VSoyPpoMvvA/uHhdKJNq7kq5jJCS0ZmsrFTQEU3duvqixp6ulXY
	 7Ad2MFBvSuryg==
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
Subject: Re: [PATCH net-next v3 07/15] ibmveth: Add RX queue register/deregister helpers for MQ
Date: Tue, 14 Jul 2026 13:43:38 +0100
Message-ID: <20260714124338.1831986-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-8-mmc@linux.ibm.com>
References: <20260706193603.8039-8-mmc@linux.ibm.com>
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
ibmveth: Add RX queue register/deregister helpers for MQ

This patch introduces new helpers to handle RX queue registration and
deregistration for MQ support. It replaces the single adapter-level
register/free paradigm with per-queue register calls to the hypervisor,
fetching queue handles and IRQs. These new paths are only fully exercised
when multi-queue mode is enabled.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 63b0184c622a4..7fc11a4e1f61d 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
[ ... ]
> @@ -401,6 +401,28 @@ ibmveth_dispose_subordinate_irq_mappings(struct ibmveth_adapter *adapter)
[ ... ]
> +static int __maybe_unused
> +ibmveth_setup_rx_interrupts(struct ibmveth_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	int i, rc;
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		if (!adapter->queue_irq[i]) {
> +			netdev_err(netdev, "queue %d has invalid IRQ (0)\n", i);
> +			rc = -EINVAL;
> +			goto err_free_irqs;
> +		}
> +
> +		rc = request_irq(adapter->queue_irq[i], ibmveth_interrupt,
> +				 0, netdev->name, &adapter->napi[i]);
> +		if (rc) {
> +			netdev_err(netdev,
> +				   "request_irq() failed for irq 0x%x queue %d: %d\n",
> +				   adapter->queue_irq[i], i, rc);
> +			goto err_free_irqs;
> +		}
> +	}
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++)
> +		napi_enable(&adapter->napi[i]);

[Severity: Medium]
Could this sequence race with packet reception during interface bring-up?
By calling request_irq() before napi_enable(), the hardware interrupt is
unmasked while the NAPI state is still NAPI_STATE_DISABLE. If an interrupt
fires in this window, could ibmveth_interrupt() fail to schedule the NAPI
poll, potentially leading to dropped events or an interrupt storm?

[ ... ]
> @@ -1136,6 +1176,293 @@ static void __maybe_unused ibmveth_free_rx_qstats(struct ibmveth_adapter *adapte
[ ... ]
> +static int
> +ibmveth_register_logical_lan_queue(struct ibmveth_adapter *adapter,
> +				   union ibmveth_buf_desc rxq_desc,
> +				   int queue_index)
> +{
[ ... ]
> +	if (lpar_rc == H_FUNCTION) {
> +		if (adapter->multi_queue) {
> +			netdev_info(adapter->netdev,
> +				    "Multi queue mode not supported by firmware, falling back to single queue\n");
> +			adapter->multi_queue = 0;
> +		} else {
> +			netdev_err(adapter->netdev,
> +				   "Unexpected H_FUNCTION for queue %d registration (MQ mode already disabled)\n",
> +				   queue_index);
> +		}
> +		return lpar_rc;

[Severity: Medium]
Does returning lpar_rc here cause a regression for the single queue fallback?
Since this error propagates up to ibmveth_register_rx_queues(), it seems it
will unconditionally jump to err_unregister and fail the interface open
rather than allowing it to continue with a single queue.

> +	}
> +
> +	if (try_again) {
> +		try_again = 0;
> +		goto retry;

[Severity: Low]
Does this retry loop provide any benefit? Unlike the primary queue which
calls h_free_logical_lan() before retrying to clear stale state, this
jumps back to retry the exact same hypercall with the exact same arguments,
which seems like it will immediately fail again.

> +	}
[ ... ]
> +static int
> +ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
> +{
[ ... ]
> +	for (i = 1; i < adapter->num_rx_queues; i++) {
> +		rc = ibmveth_register_single_rx_queue(adapter, i, mac_address);
> +		if (rc) {
> +			if (!adapter->queue_handle[i] || !adapter->queue_irq[i]) {
> +				netdev_err(netdev,
> +					   "Invalid hypervisor return for queue %d: handle=0x%llx irq=%u\n",
> +					   i, adapter->queue_handle[i],
> +					   adapter->queue_irq[i]);
> +			}

[Severity: Low]
Is this validation check placed correctly? Because it sits inside the
if (rc) error block, it will log "Invalid hypervisor return" whenever
registration fails normally (e.g., due to resource constraints). It appears
the hypervisor is not expected to populate the handle and irq on failure.

> +			goto err_unregister;
> +		}
> +	}

