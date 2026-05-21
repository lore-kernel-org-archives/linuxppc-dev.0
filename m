Return-Path: <linuxppc-dev+bounces-21263-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAFFCD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 00:45:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLV7y1Y4bz2xlh;
	Thu, 21 May 2026 10:45:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779324350;
	cv=none; b=IdVUva19VKh+uz2TqwJFHNssInyZYFIEl98NwDw527h0pSh62RVJOx842CJEqUOZW+hXopYzPvDcLDJygiQx/QRMo+bmetPGaXKnk397vjMpNtV3h7gDLy//Bpjy9Ctlm999TGI9bsrsQyKMzwBjOYc4GsFXvk/zLuaiyPjk0OiH2REw3pwwioLD2c0vF5Lice+lNYvFosd2jqeSNyg1SefprWAAt/MM3HFPRMfFm1Et2YmShc6TsmY+9V7y3E+/sYpmaYDX9AGs5Q6nLd0zbZ0xVdljH1ISl7t+L3oK9hcL/rJTp6g/g9TgOYSsyb8d3PXb/ZdrqKhC09o5uv9AZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779324350; c=relaxed/relaxed;
	bh=d/GjZWbX9fuiG28r9u5wb4+qykcdkLHar6zri5fQxHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KaDEHgwLCNn28fz/+eoQtBpBZrigNIyI9RIxSwBJs/gV5WMN4N70NDLDCCVmyV9BEW9cBfBUi4kGd/cE5zus3XPxs+wfeOcu1nnGKRjv8jd5UuWScgOJ6M21J6lp1Gl5xD5dm07MxO5MQ26YvI4KFxQzA+LDUrSOTC6gFuQM6JVgUDugorHqKAKjBMK/eNloLw9qmnXlOYKC7cyhHI1qTO9J6BXzuVdpsE19iR7akf3vSaP7XT3SSeBv0C33ifm8p7Tuq5jLyX/kXDRivQyj8vF/LITsXwmiLEbzpgLqZzDXpIt7odt6fip3r3kmgZ7vW+EvoeQmaVlhpzMu9hhc6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLpc4G+R; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLpc4G+R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLV7x0N8Bz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 10:45:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A565A42B91;
	Thu, 21 May 2026 00:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBA51F000E9;
	Thu, 21 May 2026 00:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779324346;
	bh=d/GjZWbX9fuiG28r9u5wb4+qykcdkLHar6zri5fQxHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RLpc4G+RqTO3RNeHjmqFeFE4bAmLfOaNRO/Qau/Y9ZFbMqKQVkXVg5k4L1YGNHqwB
	 qmcqUl/cjm5QcA8RUa92cKkvZfTLk9XY0wrblhcjKyi1BbKfCfuqhSb42WbOyUuJcO
	 oWL3h2EHZTvHSqOMjXlRWjkXM/rwk6abKxcpabpD+YBuw78dDnxFW2zcHAZO+FDiNr
	 aecYjPKIgXSfa6gOkcGEJBDvISX2M05D+1IJKJRDJZzuq5izRhRLHaTHOt3Aot+CMZ
	 9hQbKWO14EqyrG7CnBuKvVFbdLkorew+LxX/4vsQfdWh5kn9L5QXCpxXHMoTCXBL9v
	 x2LyOwzxnQ8CQ==
Date: Wed, 20 May 2026 17:45:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "open list:FREESCALE QUICC ENGINE UCC ETHERNET
 DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack
 handoff
Message-ID: <20260520174545.69766438@kernel.org>
In-Reply-To: <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com>
References: <20260517192856.3925-1-rosenp@gmail.com>
	<20260520165746.7ed10c7b@kernel.org>
	<CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 17:39:41 -0700 Rosen Penev wrote:
> > On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:  
> > > Collect received skbs on a local list during RX polling and pass the
> > > completed batch to netif_receive_skb_list(). This lets the networking
> > > stack process packets from a poll cycle in bulk instead of handing each
> > > skb up individually.  
> >
> > GRO should be even better.  
> GRO will result in slower routing performance because there is no
> hardware checksum.

Mention this in the commit message too.
Network adapters without checksum offload are pretty rare these days.
Speaking of being old, do you know if this driver is used in practice?
Maybe we can delete it.

