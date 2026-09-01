Return-Path: <linuxppc-dev+bounces-26399-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF1AC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 15:10:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ8RV689wz2xns;
	Wed, 02 Sep 2026 01:09:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788275398;
	cv=none; b=aTyNZlvM0UMr14ptx9qDOcu/fjaKMGEGZ1NAtQY0xZ24SaI8mQ1OH3uJph/malqZSfvA2OFDOQzYUUg/RZoS1DTWNmWGPO5iRjUer5x2LYDQTRtklvwAuFTz1FzBUswl+x0/M2X6ZYmopA/BSy6nu39RKV+3BXxMZo9UHjpDTJZg6RH/H8IRvnPMiCr3ywiGjiX+VzO/FfB1qO9Y5XR2s3BNCEwIhFxQaS6oYUcOZyIOgQlxN5nnzbSB2xUUpoP6uOzc4PoATvzponA6ttELvvaJi9YdAoRfyqnEM0qI+psaCQrkoIU/EDwaoxDHfVkphprHONczKNHm+ragpum8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788275398; c=relaxed/relaxed;
	bh=S5y2+wCq0wEsTuG1GWG6BqNCaShtcw/i1pRTa1elg6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xy7X+8P/tzgtOcJXAHwTMBcCjW/gJC7hAlvfFqsr0RYlWHSrDrOBhqxGzDwMw7dQdCLaoIWYs09agE5ScxDL3PiFsv5ek99mVkGE862lWLHKI1/IbhmJHl71TaH4O0cPDD4IEV0AJwzcJN2KaqeU4CJE7q/2u3TIY24oWBW9wGkTIDDMHxwFLZYH/dX3eIJEJ8J4IxMT0fwN5Cq3LaRztGDU3L6v6Gx4PN1J9R1zlJc8NUlT6tgwuWQmbPFA1AQIGePBOM9fU4qth7x9qEKs08H3JbQnpCUjLPdFyvETJBBjRVkZaAwZ2XBg2PHdP9aNRBHXJj7VpyqOpTayld6RUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBFnG++9; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBFnG++9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ8RT1D2tz2xGt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 01:09:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F3D344092B;
	Tue,  1 Sep 2026 15:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBC51F000E9;
	Tue,  1 Sep 2026 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788275391;
	bh=S5y2+wCq0wEsTuG1GWG6BqNCaShtcw/i1pRTa1elg6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UBFnG++94zHjCfFoSrnIXkTRrci3p503x8x7rlcaIEiNh9Pa5e07zU80aTbPpa9Bp
	 SrKEZOcC/Sh99xf1JGgR1tyRjNd25uoS+hB3TdHfpPfd+AOBSpvsepXq22RJAm7QVO
	 NadvhoCWQ5Ent+NnwhuwZIhTLdcxY7QZmTFNCQz9xyb6mLddF1UzhfvD94tFMgVL6+
	 Lvd+ZHPhoqVkE0KkCryHFhCdeggwt1wUXruEw5kDSRD55HA4m+ZRS3ITMpr1UmHCnx
	 Iq/6aDPupP5XwpojpafsEn1scRlNbMWXZq3gnU6f5lDaxMXCV+Ot4jN9fldUxBwomp
	 Zy4YLOOlSfNQQ==
Date: Tue, 1 Sep 2026 08:09:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, richardcochran@gmail.com,
 wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 net-next 0/8] net: dsa: netc: add PTP support for
 NETC switch
Message-ID: <20260901080950.63e28bab@kernel.org>
In-Reply-To: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
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

On Mon, 31 Aug 2026 16:23:27 +0800 wei.fang@oss.nxp.com wrote:
> Subject: [PATCH v3 net-next 0/8] net: dsa: netc: add PTP support for NETC switch

Please be advised that the limit of 15 patches applies across 
the series. You posted 2 large series to net-next at once. 

See "Limit patches outstanding on mailing list" in the docs.
If this happens again we'll be forced to start discarding your patches.

