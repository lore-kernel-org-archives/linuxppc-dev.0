Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA2606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0ETGGx4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXnnj1yWlz2ySV;
	Mon, 23 Nov 2026 12:06:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795395977;
	cv=none; b=UMexl/Rf4dK7xNPhcNhc6QDwkCzBviqfvLtyV2/xjngU4wiyyPOw0WCpjZU4eRIBbBj5OhKhNoq1mU7PoEvsmv5fAuyz2ceBGXnaQF165umZYfTNfJ8vYN2DL72m7EB0l7nbnaM7Y525DUg+efDm46UybgdYSPkixtax7fnflVJAzy245WMexZnVAQ7mD3tDP5wUlFBUzv/lgibKfqPzcmwzbnA59xBJKWQk+jHLlFx4SaUpumjNWvkSUEzZ1Lj5auiJx251QK8oIgoWVt+/01fbiS7hohuH+E2cIDQz3cF1gSU4j5sJAR9YHH9sMMJlOHnZCkNhQnc2VeS5RbP7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795395977; c=relaxed/relaxed;
	bh=m1kYw4ZrlZ5dWwlbPQBHBTRCJTHoFiCBu7iltfS40Aw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ldFkCpozByigSSGS7Tm834ZYUUdynsFEcwyXHlUZpTytjiqEXAR68iih5BRbPpmxc73wDKR44+9rud2cs/uWTI3CFdc4ke5+GamPW2OsdUv9nqHLex9tVomXXEcfVFxKIXfIvpmLxJW1rPoUI+FPnn3S7dw8RLXhm6fWV+cCgfPoFGvIMcF92oIJ3oEo7TUvDrrBFMs5RBdL5LlgF+nzCtGNmDrelm/2ka1SiqgmKxR6RX3OgY0cZklPBLE6ou3hKV0umjKruIbu5tE/31E0JeT1l/1IY2xO5O0lNGlaVwaPicQhG+TDeByF0q4CH62gOsKesiT75Ev9iPVDKw62fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0ETGGx4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0ETGGx4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXnnh2Xxbz30g6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 12:06:16 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F1A74083E;
	Mon, 23 Nov 2026 01:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C101F000C0;
	Mon, 23 Nov 2026 01:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795395974;
	bh=m1kYw4ZrlZ5dWwlbPQBHBTRCJTHoFiCBu7iltfS40Aw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J0ETGGx4kggl667GPY0Jp3oCOKY8tofipGVE85QP/dYm84HgEVCAaFeLSw0eHS95m
	 nxzxkZtor0D9OQhmOL5lSigPRaz0nFRWud1Arp8EwF5geKV052TWcSjtnrkVx9RhC8
	 KP6SFkfjf59zVDWNNjtKeNuB+1QciOl2pnWFsqvzeAcEn+neHGXQC9jLzJL5BXdY4c
	 lcH8r2rj6QCZHjB1y6+VeAlSNRcxQr1gh+T+Uz2kgMq8HLtgkDsZUxrNwpKzPDQggF
	 XbSL6LtIXrElyv/nAk65UqsNsHzTauw73WR5NC0sw8FjMYtigzfbifRl4VOmc9I69E
	 aNYT1mYyTjExg==
Subject: Re: [PATCH net-next 7/8] ibmveth: Pass the RX queue index through
 replenish and poll
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, horms@kernel.org, davemarq@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Mon, 23 Nov 2026 01:06:12 +0000
Message-ID: <179539597289.3135.13448321447198422850@kernel.org>
In-Reply-To: <20261119000711.18093-8-mmc@linux.ibm.com>
References: <20261119000711.18093-8-mmc@linux.ibm.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch adds the queue_index parameter in inconsistent
  positions across the RX buffer helpers in…

--

ibmveth: Pass the RX queue index through replenish and poll

This patch adds a queue_index parameter to the rxq_* accessors and to the
RX buffer lookup, harvest and replenish helpers, which used to hardcode
queue 0. ibmveth_poll() now gets the queue index from its NAPI instance.
Only queue 0 is used, so the behavior does not change.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index ab8c5f6a265b4..a40d9a6abf51b 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -909,17 +922,20 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
>   * * %-EFAULT - pool and index map to null skb
>   */
>  static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
> -					   u64 correlator, bool reuse)
> +					   u64 correlator, int queue_index,
> +					   bool reuse)

[Severity: Low]
This isn't a bug, but could queue_index go before correlator here, so it
matches the other RX buffer helpers in this patch?

ibmveth_rxq_correlator_valid(), ibmveth_rxq_get_buffer() and
ibmveth_rxq_harvest_buffer() all take (queue_index, correlator).
ibmveth_remove_buffer_from_pool() takes (correlator, queue_index), and its
kernel-doc also lists @correlator before @queue_index.

Because of this, ibmveth_rxq_harvest_buffer() has to swap the arguments
when it passes them on:

    rc = ibmveth_remove_buffer_from_pool(adapter, correlator, queue_index,
                                         reuse);

int and u64 convert to each other without a warning. A future caller that
follows the sibling order would compile cleanly, but it would index
adapter->rx_buff_pool[queue_index][...] with a truncated correlator.

All current callers use the correct order, including the KUnit tests. The
later patch in this series, "ibmveth: Split RX poll into per-slot helpers
for MQ", keeps the same order.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119000711.18093-1-mmc%40linux.ibm.com

