Return-Path: <linuxppc-dev+bounces-25190-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BC0C55171
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 23:11:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBhdS1Dqmz2yY1;
	Sat, 01 Aug 2026 09:11:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785523647;
	cv=none; b=iqL6u5sd9dtwTr/xy2Swe973uRUTq3/8agHIQS06RsDstLW6/L8RvfAT1DTnVGWyQbLsCeknKeaisBVc4cGrW7rni8b51wS4P2Zf6gDuDaq8womT0N6NcmIA4NTfOYdPSVhrjQKhN8JPAa9YOtk+BWQRKRfsGLxHR/YwfkZHTBhgQKvXH3SVG4hD3vPo5PcK1ynQ094dBWiNrDieoXrQ6hl6+KZx1Z03vIAwtX2bKgRfZoD4BGtTxD4WPe9xEPAxC8G1CF6uy6r7av+XrUo2OK0r/ASdCdBw2HDCS9g8vNgZVFWARW4kaNSZ4EmGJZVZ2HrxyvDG3T97wAvF35JIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785523647; c=relaxed/relaxed;
	bh=WHxIQdmnQsQ/IADeLdnlbcR01iDCUUK4XH5hZVT382k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqJy6J4ALw4C8QCzyZrNwYtXT1fCVFCyvbMDJtQdBWsGXFIYNxuCxfLhfVzibGf11xCQIzSyAcgs3SBNe0GATLKmh0JMUuqKjkuCuqIXe0fO68Z/sA3S9Pcgs1dYnUolAHZiCZ5OBl6ykcH4w9yUQONDxQhKUb62YGP4j/NoEX/KlCrxB0MyTsebGMX1Ll12cGXvrnBTP6e8AF2n5m56GzR6Q+0tNkehL7RTrmHAhwCoC26/0FzdavURStyavy/TzQbKJ7QiAkmVGgpyY3aH0WOXQEnrKoKkYVRQq/5mhVhAEgc0XrCyZjqcCErzKyf4dn1zO6TJhCWLOPqbg0j6lA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Ym4loQjv; dkim-atps=neutral; spf=pass (client-ip=212.27.42.1; helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Ym4loQjv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=212.27.42.1; helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBZn91vL2z2yjn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 04:47:24 +1000 (AEST)
Received: from L30177.local (unknown [81.201.198.134])
	(Authenticated sender: vjardin@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 62D8FB00539;
	Fri, 31 Jul 2026 20:47:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1785523638;
	bh=MVmUN6cvQNR9Vik+aqrg7gfIKX4sgnXQNCiuhrBNk/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ym4loQjvoeC3iUm0F6Dyn4Kb7pOQtbk0EFQFprKVCIXqQ3Ia37tPkyitxmf04+V0R
	 bzAPvOFxZ7od2Lp6qNhVBmreC5hcWAi78Sey0he5KtGHVQINS82wKVLoyKQkl9LgbZ
	 65YA+Sdy2QhbnTd9PW2GjO3yUEkjXYz0uP/039ZVWOnaKYsIucaGJ84vxpiTcWfEJ8
	 zymFLyawG7FsC//P+WJhwMewo4w3brQd8Er0ebPbMiBsW+2AvDv/Z+goPuLkNypGnu
	 TU3KzrWEN52uIGES5oafinoKCeulnbJGac6EzUPjg/l1GLQPtyYm3Fko4kKNkt5+Fq
	 o5jTCHlwUAXbw==
Date: Fri, 31 Jul 2026 20:47:09 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bogdan Purcareata <bogdan.purcareata@nxp.com>,
	Stuart Yoder <stuyoder@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc: set dma_mask for the root DPRC device
Message-ID: <amztrR-CAHlMN49T@L30177.local>
References: <20260724-for-upstream-fsl-mc-dprc-dma-mask-v1-1-6f08af883195@free.fr>
 <smvzffc65xr23fyozcahv4ifj643hxd6rj6uu6pi6ikc2tfvqx@ik4vkhhjytxh>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <smvzffc65xr23fyozcahv4ifj643hxd6rj6uu6pi6ikc2tfvqx@ik4vkhhjytxh>

Hi Ioana,

> > Fixes: a259ed1618d2 ("bus/fsl-mc: support dma configure for devices on fsl-mc bus")
> 
> Is this fixing an actual bug introduced by the blamed commit or are we
> talking only about the warning message?

It is just a warning message.

I did more test today. I reverted it on my LX2160A with the SMMU-less config and rebooted.
Then, I get this notification:
  dprc.1: DMA mask not set

Still the DPRC binds, all DPAA2 children (dpni/dpio/dpbp) probe.

In practice, it is more a cleanup warning/notification. I do not remember why I did state
this commit log that is few month old.

I'll rework the v2 per your suggested common block, I'll drop Cc: stable and update
my commit log accordingly.

Best regards,
  Vincent

> Commit 4d8bde883bfb ("OF: Don't set default coherent DMA mask") is the
> one that added the dev_warn.

