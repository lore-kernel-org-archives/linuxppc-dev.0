Return-Path: <linuxppc-dev+bounces-20363-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C895CD3424
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 12:36:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6Vrf2RByz2xnZ;
	Fri, 01 May 2026 22:36:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777638962;
	cv=none; b=otPTm4H28l38edC2ZIerhW9stT2CxdxXSkWB4P8OfivOlxgjm8ax+ld7T0U82swaD8vktyXWiIo0sYUvA4NB1VQ3WY27Os+SsrndKZv+Q0upz24f6PR5xMXkZCirnF8w/VSufI6CB4MitG3c01vfIt7RFux6/rqGN1rakw2X3ClXUPz0K7pI4WR6KgwS3nn2LZGtgzuvxH8zcCrlEM7Ac/5r+Liv1DuV3MBDny0n68i2ov/nK5yqSbq0IuUqdhwTzhV/a7QJPrfIhQs6DpvDxid+KjgOdSPPXrJz/rsOGt0A8SBxIJKolkbQTK1VG6TFu3SuP/tc5EDgBbq1+6nf4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777638962; c=relaxed/relaxed;
	bh=+K2jQAl8Hv/LPmM5NOSPiAMmtoZuqIiApcMhc4jYUBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZ7q4kRISEW44LgTSNmIat19QzqoEUcMNf7H86mrlBZ4nCRMDLvRWO8DkZOUQNbJlf537sS3H8hqlbdC8mSnBTHAr6K3rs6dkRn0lVn7ZrvIHmd44bLw5kccKMUdtBCm4ajw9m/lXvmkrEcWL1HQb2TeFasE3EnhjwheT0l+spmUjW5se32DSgR9fWG6JAGp4DIdsaXUK4Szh+EsyfHdQE5HbD2p+8vz9BbWeA/IWq79km4/B5IYv31YAOM10ZAPk1a1DnIp2d6xkAtmbNas64FfFdjHx1zdV15JTpGH915WeYNrNCBqxt8YiNaqHmvL0hgmoOFRl9C+y9NFNH8MLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P24Mo1II; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P24Mo1II;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6Vrd54wWz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 22:36:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B002160126;
	Fri,  1 May 2026 12:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CD0C2BCB4;
	Fri,  1 May 2026 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777638959;
	bh=zs6x/LEwnR68uhk/ijWwQApW1jJL4t87b71Ve+6e4Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P24Mo1IIqSwDbUdn19Cf3/oy2Ut72ojBWwp/ETMZXT91XiN4IRr1onQu6mCobGA0K
	 BszQ1jEhWnGELgzCquvA+Iqg42LzKc4+zgSMY8dzFSPQ8OF7Uh+Q2iNVVQjSzZq4id
	 dwvxelJYGFxlbPce3b3+628jh6eAetX0gOva1fitNc2iuFGmBO0/EGRFEEfGoNrVQr
	 nSvF/rv/vfCH8mrM7wG4PcV76z8HeTkEuwv4U0gRkC6u3YnD2mCPxPO3hOvuOb82h8
	 AbTAoSMOyKEkgvHq1UhelRZmWeosM1EjYDxyAzWGSXN72XJa2uV3O1AS2KxFvVS9rw
	 bRAuL2nDh5jIQ==
Date: Fri, 1 May 2026 13:35:55 +0100
From: Simon Horman <horms@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch, chleroy@kernel.org, qiang.zhao@nxp.com
Subject: Re: [PATCH 2/2] net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove
Message-ID: <20260501123555.GC15617@horms.kernel.org>
References: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
 <20260429114208.941011-2-holger.brunck@hitachienergy.com>
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
In-Reply-To: <20260429114208.941011-2-holger.brunck@hitachienergy.com>

On Wed, Apr 29, 2026 at 01:42:08PM +0200, Holger Brunck wrote:
> If the driver is used in a non tdm mode priv->utdm is a NULL pointer.
> Therefore we need to check this pointer first before checking si_regs.
> 
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>

Hi Holger,

I have the same feedback as for patch 1/2:

As a fix for code present in net, this warrants a fixes tag
that cites the commit that introduced this bug.
Perhaps this one is appropriate.

Fixes: ca20e191eed0 ("net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove")

Also, as a fix for net it would be best to explicitly target that branch,
like this:

Subject: [PATCH net 2/2] ...

I don't think it's necessary to repost to just to address either of the
above.  But for reference more information on the Netdev development
process can be found here:

https://docs.kernel.org/process/maintainer-netdev.html

The above not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, an AI generated review of this patch is available on sashiko.dev.
All the issues flagged there seem to be pre-existing and I do not
believe they should block progress of this patch. But you may want to
look into then in the context of follow-up.

...

