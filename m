Return-Path: <linuxppc-dev+bounces-26579-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687D9C624D3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 00:52:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcFDS1d17z2ygW;
	Sat, 05 Sep 2026 10:52:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788569560;
	cv=none; b=ojx13xaqDLvbKZZ1QeV9j0rAzSBrUCD18r4N1QdmDdpnjfA/gbmyXr9IRnMjnQqR5+NEYkE05flkFiN0Z7Mj5iUXyFgSzetjL3dXd3DlBelsO0DmMXcbOetoLzf72bQ0esOlBlTzdKLP5Njxkqm1GZo2o/qZFyGtpWvBRCHdvulaNaulFWVPNMfk/nns2uB28xP6YRzBBhNeZl3WoCqZOJJ8DOm3MtvVGpjf8o4cqeNARaK4lcRGAuKTjo6pbgzzi+E49VHkmdKEHqOE8Sxv1hdBsfp0ga5FLV2yEP1dUfxZW+rlcw90dm9/FlTZScKj0Jn9S0lgXS+HwnPMMe4YIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788569560; c=relaxed/relaxed;
	bh=azOTZuSt6WoePHrdQ8r4keF+HbxVxf486hyjpOM5rwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiRc1tlg3ctWEdbZKqTwBnhn13T0XvU8Ecng/Huf1rIEpJhfpk/Ywp3yIC0Ttm7NmeML9TcUD7aNMZ8EPtkzlhBYMmnK1Ej8XYholMnIH5c1ENpT8dcsWoTz5q8ldV2gjPBPnO5IoJ3BeCTe8cFx24d2GlxsXsBaaFKpKfa6tvQ6+zb5NvuxI26bvS9EjOPpVAzV7sCr+ZeZSLCoNLXAaVd4pcqunWB9ovjv9pU+3S1UvTats191mtlgwRJivzgCdSQSAQ7TP9myiZwG9UjRRSTEYVXh3do5qU1cEiSAZ7URwhDjK5Nm9UAAPk/dCUyDhGNjOv4QAjU7No4SZcHUtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlLN7RtY; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlLN7RtY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcFDR1h03z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 10:52:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6731443CA3;
	Sat,  5 Sep 2026 00:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2021F00A3D;
	Sat,  5 Sep 2026 00:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788569556;
	bh=azOTZuSt6WoePHrdQ8r4keF+HbxVxf486hyjpOM5rwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MlLN7RtYiwyCQOX3kQo70IEjQzY6WC8/pAouGkR/sZbHCbcdvTnRmdc0vnXD6x4sK
	 Qtr6WMmVQMa2X2tN8mANiG+YsQGFoVpIUBHFKTEItZvhofVaCjHiaobtNFB+ymhemE
	 w5g1B+MLVAzLUGrkl5CJ5linMMfz2rqEAmSjo/Uh7L+UYgDzKtuYJuPicIcEWuc4Nd
	 nV7I5KHqDYQzhyjnPkrroquNGMsQ/P5BCXZ8av/2UFJjQdaZzJHEyBxbv8gO+3Ybgr
	 YQeSQWghzAYrQUN2iKxlVWMPWdNQbIUZExeA2qzP6NvqjXHvlIDde5Z322iUWhZexr
	 PPiQ12bap/y2Q==
Date: Fri, 4 Sep 2026 17:52:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, richardcochran@gmail.com,
 wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 net-next 8/8] net: dsa: netc: add PTP one-step
 timestamping support
Message-ID: <20260904175235.66dd766b@kernel.org>
In-Reply-To: <20260831082335.1184605-9-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
	<20260831082335.1184605-9-wei.fang@oss.nxp.com>
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

On Mon, 31 Aug 2026 16:23:35 +0800 wei.fang@oss.nxp.com wrote:
> The NETC switch supports one-step TX timestamping for PTP Sync frames.
> When transmitting a Sync frame, the driver reads the current PTP time
> and writes it into the frame's originTimestamp field, and inserts a
> To_Port subtype 1 tag carrying the low 30 bits of that same PTP time.
> As the frame leaves the wire, the MAC captures the SFD transmit time
> and derives the residence time from the timestamp in the tag. It then
> reads the correction field at the offset given by
> PM_SINGLE_STEP[OFFSET], adds the residence time to it, and writes the
> result back.

Please spend more time on this code, especially this patch.
This really looks like clumsy slop, some DSA expert will
have to review it before it gets merged.

