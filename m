Return-Path: <linuxppc-dev+bounces-25918-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07774C5B572
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 01:47:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPCHv0F9Kz2xpv;
	Tue, 18 Aug 2026 11:47:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787017642;
	cv=none; b=dO4YhpCJsDOScfCtfa2U7DxrqcdmMRpVfmqoNARtPWEMjK1dCJPoFooCVTT1LE3XmK/K4LeBe2t9RRgXLWHocsZdTsa4gmH3KVXUZF6DIh+ca4/a2g4lVAzrcipgwCmGsRqWimKJFEd2Yuia9BZVOYa77GuPuw4/j8xzs7WAmfeEZMfsGJoO9OAyAC35aKOYfAhTctbktgRf+l7D1fGb9WV+VQk7wMqrQZ5ZF2WVVzCnIRG6GaFfoAZKYszPF3M09mfedJrisOfNPI2QompAKfksIcoBudKLH4T5LQV4KDxZaaFyYz7wvJzi0wBvuumgnVYzR1FI+MTDF36RW8t8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787017642; c=relaxed/relaxed;
	bh=HmplJZQjfBhgX90BI6gxVRCJzgCHyHxoC55haeiIcnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3dTkJqXbB1Na8Y+uu/mzdP74JIO3M9MIATKPEaB6afTuDynBgNwV1/EJS7HkRpHksiNAZiSgUG/km3yCNvYy41rG+u7lW+/5D1aPJMhB/Bd0zRBoNbw441R2lFso+/NP/m0bW8pfAp/Ddi98KvyGgxvpTiSj4Yf/zk/k+2wz+KGGpwUqF9Iht2WMFl14VhTJIiXragDcGgKwpGnvLWwyGARPta/SeB+OOg/ko2M2MA2cI84BJZaXs3Uigmi7OjPUGzejRgCIIAB2n/StWE2t8RWWiB+w+NlPNH4tF+uQLYFnoj77sabLkcgeGqcld08JbumBKapUjFQsgWFXW3TdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1P/frJv; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1P/frJv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPCHs6v43z2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:47:21 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D24CE403CA;
	Tue, 18 Aug 2026 01:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8351F000E9;
	Tue, 18 Aug 2026 01:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017637;
	bh=HmplJZQjfBhgX90BI6gxVRCJzgCHyHxoC55haeiIcnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F1P/frJvEfNFR/mtmSnQqLUhDO7YJr1J+D+co7hZKp/d1V0CUrwAF38BoEMF46q/3
	 V82klElwrQcZ9DBytSxR6rN6WCgccXgiRIL4mf06GoNBgKXVDvlb4Dvv274RDwkGrA
	 PEVxdCDlyAd/PrWf2P8mMZkqnzUGngsAncBfB0jiftB5tFgz4eKY4elHRdo2BWTrbj
	 Cg3Dleej/7A/EG44eaam3FoON67akZ/pDQ37stTxK70dicV7mLaimIY/x2WGhqTx6m
	 5bH6BNur+IVRvn28nFITAJJ01FCoJrWh2NltVE7khIpsw3IxkiRldpI4w2qzejVbb9
	 9BBNwe8smmzIw==
From: Jakub Kicinski <kuba@kernel.org>
To: mmc@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	nnac123@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	davemarq@linux.ibm.com,
	bjking1@linux.ibm.com,
	shaik.abdulla1@ibm.com
Subject: Re: [PATCH net-next v5 01/15] ibmveth: Add MQ RX hypercall wrappers and call definitions
Date: Mon, 17 Aug 2026 18:47:10 -0700
Message-ID: <20260818014710.3853684-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-2-mmc@linux.ibm.com>
References: <20260814073642.24630-2-mmc@linux.ibm.com>
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
ibmveth: Add MQ RX hypercall wrappers and call definitions

This adds the PHYP call IDs for H_REG_LOGICAL_LAN_QUEUE,
H_ADD_LOGICAL_LAN_BUFFERS_QUEUE and H_FREE_LOGICAL_LAN_QUEUE, raising
MAX_HCALL_OPCODE accordingly, and adds matching static inline wrappers in
ibmveth.h.  It is plumbing only, with no runtime behaviour change until a
later commit enables multi_queue.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
> index d87713668ed30..c0ef03cad9b9a 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.h
> +++ b/drivers/net/ethernet/ibm/ibmveth.h
> @@ -66,6 +66,142 @@ static inline long h_add_logical_lan_buffers(unsigned long unit_address,

[ ... ]

> +/**
> + * h_add_logical_lan_buffers_queue - Add buffers to subordinate queue
> + * @unit_address: Device unit address
> + * @queue_handle: Queue handle from h_register_logical_lan_queue()

[Severity: Low]
This isn't a bug, but do these two kernel-doc blocks in the same header
contradict each other about which handles are valid here?

h_add_logical_lan_buffers_queue() is documented as "Add buffers to
subordinate queue" with "@queue_handle: Queue handle from
h_register_logical_lan_queue()", while h_register_logical_lan_with_handle()
below says its queue 0 handle:

 * Registers the primary receive queue (queue 0) with the hypervisor and
 * returns the queue handle. This is needed in multi-queue mode to use
 * h_add_logical_lan_buffers_queue() for all queues including queue 0.

By the end of the series the second wording is the one that matches the
code: ibmveth_add_logical_lan_buffers() in
drivers/net/ethernet/ibm/ibmveth.c passes
adapter->queue_handle[queue_index] for every index, queue_index == 0
included, and that handle comes from h_register_logical_lan_with_handle().

Would it be clearer to widen the add-buffers kdoc to say the handle may
come from either h_register_logical_lan_queue() or
h_register_logical_lan_with_handle(), so a future caller doesn't conclude
queue 0 must use the legacy buffer hcalls?

> + * @buffersznum: Buffer size (upper 32 bits) | count (lower 32 bits)
> + * @ioba12: Buffer addresses 1 and 2 packed ((addr1 << 32) | addr2)
> + * @ioba34: Buffer addresses 3 and 4 packed
> + * @ioba56: Buffer addresses 5 and 6 packed
> + * @ioba78: Buffer addresses 7 and 8 packed
> + * @ioba910: Buffer addresses 9 and 10 packed
> + * @ioba1112: Buffer addresses 11 and 12 packed
> + *
> + * Return:
> + *   H_SUCCESS - All buffers added successfully
> + *   H_PARAMETER - Invalid parameters
> + *   H_HARDWARE - Hardware error
> + */
> +static inline long h_add_logical_lan_buffers_queue(unsigned long unit_address,
> +						   unsigned long queue_handle,

[ ... ]

> +/**
> + * h_register_logical_lan_with_handle - Register primary queue and get handle
> + * @unit_address: Device unit address
> + * @buffer_list: DMA address of buffer list
> + * @rec_queue: Buffer descriptor of receive queue
> + * @filter_list: DMA address of filter list
> + * @mac_address: MAC address
> + * @queue_handle: Output parameter for queue handle (may be NULL)
> + *
> + * Registers the primary receive queue (queue 0) with the hypervisor and
> + * returns the queue handle. This is needed in multi-queue mode to use
> + * h_add_logical_lan_buffers_queue() for all queues including queue 0.
> + *
> + * Return: H_SUCCESS (0) on success, error code otherwise
> + */

[ ... ]

Cross-instance finding from sashiko-gemini (34d1289184ae332db8c101e251d3dec96e9969f2e8dee8d98c3efff05039c9d0):
[Severity: High]
Calling plpar_hcall9() with missing arguments causes an out-of-bounds stack read, leaking uninitialized kernel stack memory to the hypervisor.
-- 
pw-bot: cr

