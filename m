Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC86F606A323
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmuJxYRP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jT6qp1R4Fz2xtC;
	Tue, 17 Nov 2026 12:40:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794879622;
	cv=none; b=FqohL6tZZDjbgwPuyrrlBbl/DrZvSaRu7QuwillJfknKxP7XpPsKrr8LHx9gdfZ4ALoWkmydXVCaNmC9ppldB8KLBZJV7zuXJgZf4GpR6me19fH5m7Av4vo/PNZKbCa+5Nc9HwJfjyY2yUwyaQsN0wuMuU25p87tWwoE3df71e7giKRTWj3CKPw0Ew+R4RTJupmlw8JfWVbGiwE45LwL97+q4h5LnE9Lv9R/gAteRw+rESgE0hkg9nNALokCdKNDpNruDpUSRX3DlNiBNu+phK2l8I+Dce4SI/z9+eb6u+cGcokgGu5aVdKmsPQWxCJX4eqizIA/HnYtmMTTUv3sag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794879622; c=relaxed/relaxed;
	bh=qws+Fz4Ekk6Ecm3aw/aRo4AQeOV511tnJt/HAz178OY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGS4Lo+Dv4snpm+tyOA6+noocsJQLuQJCQjtymAmdnttB7ru0YctSGFcOJJPa6JjDQ+njeTn3Gy1RAZocIGmSaYfxvzoqrzjXvQpTRX0OIQiBeJQLLwUZH+fuBBfcSXHZFX4gOj58GLU7y2lGBJP/JxJ1qSdwsKSTfMDu/+fa8LUoaXWgg9+iDYAKwoa8PYvzr5oQ/1K+lWELlpNv2tkqB8sd+AMVoWz5qn1W1hD6dNOSFyKakrqUaLyTJ6IjgFPjy0J7L6UaiX/15wHJLp2LkLihzJntBvecOcLqSJTR81WOb+aTcbAoTll2NmzM6GQO0x9sUBynfbXmD8atSJEoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmuJxYRP; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmuJxYRP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jT6qn42Jmz2xqL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 12:40:21 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ADEFD40AC3;
	Tue, 17 Nov 2026 01:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7C31F000C5;
	Tue, 17 Nov 2026 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794879619;
	bh=qws+Fz4Ekk6Ecm3aw/aRo4AQeOV511tnJt/HAz178OY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DmuJxYRPhYSHm3ULmL9zTKQL3tx32zAmXRE0eO/0wmGJd+DiD99B0Fv+FA3fpmZVA
	 WeRD+mnEd3lmnHKF/TQrJEBIygl065mKAf/ECAB3sM/c/IBfzMzSgoiDQaDMG1B+e8
	 CUqVcHlUYCnn6cIhymrdh+j2eVAnBMtRr78JpFRRB4QcV2VKjb36vecLKkDyWLLoCl
	 Pru1LvDJim4y6QTRALjf8vguET4iQk2W4rgFHkXqZkIz08w7RVtFYNwa/7alonPIzL
	 H+LxpoG08mxWWf8SQfx2gssd2mU+DlvGIac8AhF9g96ULKqjF4+5VoroM/to0Elsup
	 DzQPzgNyE8dQQ==
Date: Mon, 16 Nov 2026 17:40:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, horms@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, chleroy@kernel.org,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Subject: Re: [PATCH net-next v8 09/15] ibmveth: Split RX poll into per-slot
 helpers for MQ
Message-ID: <20261116174018.6cd71ba5@kernel.org>
In-Reply-To: <20261109235556.60604-10-mmc@linux.ibm.com>
References: <20261109235556.60604-1-mmc@linux.ibm.com>
	<20261109235556.60604-10-mmc@linux.ibm.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon,  9 Nov 2026 15:55:50 -0800 Mingming Cao wrote:
> +	if (WARN_ON(queue_index < 0 ||
> +		    queue_index >= adapter->num_rx_queues)) {

You add such checks all over the place, why?
The kernel coding style explicitly recommends against defensive
programming.

> +		if (budget)
> +			napi_complete_done(napi, 0);
> +		return 0;
> +	}
> +
> +	if (ibmveth_poll_stopping(netdev, napi)) {

Why are you checking if the NAPI is stopping?
Maybe I missed it in the avalanche of words in the commit message,
you mention live resize, which I assume is patch 14. I don't get why
you need to explicitly check this, core already does.

> +		if (budget)
> +			napi_complete_done(napi, 0);
> +		return 0;
> +	}
> +
>  	while (frames_processed < budget) {
> +		if (ibmveth_poll_stopping(netdev, napi))
> +			break;
> +
>  		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
>  			break;
>  
>  		smp_rmb();
> -		correlator = ibmveth_rxq_read_correlator(adapter, queue_index);
>  		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
>  			wmb(); /* suggested by larson1 */
> -			adapter->rx_invalid_buffer++;
> -			netdev_dbg(netdev, "recycling invalid buffer\n");
> -			rc = ibmveth_rxq_harvest_buffer(adapter, queue_index,
> -							correlator, true);
> -			if (unlikely(rc)) {
> -				netdev->stats.rx_dropped++;
> +			if (ibmveth_poll_recycle_invalid(netdev, adapter,
> +							 queue_index))
>  				frames_processed++;
> -				continue;
> -			}
>  		} else {
> -			struct sk_buff *skb, *new_skb;
> -			int length = ibmveth_rxq_frame_length(adapter,
> -							      queue_index);
> -			int offset = ibmveth_rxq_frame_offset(adapter,
> -							      queue_index);
> -			int csum_good = ibmveth_rxq_csum_good(adapter,
> -							      queue_index);
> -			int lrg_pkt = ibmveth_rxq_large_packet(adapter,

You should really factor out the pure code movement to a separate patch.

