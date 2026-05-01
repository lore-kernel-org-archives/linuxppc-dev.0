Return-Path: <linuxppc-dev+bounces-20362-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DC8CCFA13
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 12:28:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6VgS1YTgz309S;
	Fri, 01 May 2026 22:28:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777638484;
	cv=none; b=g1xUCbVHnBmfF3W1kM91IbRC7+dyGf9Y8npRRGneYxPGaOY604UZdRxD/nYJsMPoLrw/vj7vTL0rlnGr5a/vuSGL0vGyVD8PXchNugnjNGSDZgVuL4t3Tx7Edtn3O47csgcjUvz1u+kl5kXvC8TUM7gmhKlYoSAyY5+dnEVZbsYYLgO0pwH+F6zZl23rZrXC14SnQNLqoNMLSKqYIHQGDoQ6icZp/JuOcqOPFm4LdLhYSdN/NgFTcrkK5aeziXP2WxtITdOwNZju09sW6dzDAsTesvxuw8NypCfQQcPR+vrvXGW4LqPYjiEGhp/DRX7cfhOn0++s2D7gos4o7tl4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777638484; c=relaxed/relaxed;
	bh=AbSReR+I1Yt1K1hRuf274vwb+5+jTP41Ywe9J+9tWBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUPS+rlFci5jTLKm+4r7OwSrYR0treiXt5Jhk6LysaCLZBI5KMdZt5ETeekUae/D3tj5sfd6J/JtYn82aTZXGVk1KmSe+7aTa7e3HGKbSL08h9ss6VIoATbyhYjD5S5LURxgnoRmurP8DXfVhXj6ZDImrLcqU9S3EwUW7A6LQTijFWhZYCXj9KqcoFeHJNxKtAAnXW3n+CA/yI1ra73LeJdVlV6vVF7TbF79APkvy+6VplEpLqKZt93t6ApBbZwB/8z7yGEyNYbufYiN3NuBHVDkkQFHJe+rgs79tWsjuOA3047J7rWo2Uhbs761fOfFzX1Bib/aNFyOj1VwGtYccg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S3ywNExU; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S3ywNExU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6VgQ3y2Zz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 22:28:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1523A60126;
	Fri,  1 May 2026 12:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C625C2BCB4;
	Fri,  1 May 2026 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777638479;
	bh=5lT6TRvgI8koPXV5OrJFxLzqZFSDbD429ThALkAUV5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3ywNExUj2rzEoONYig+O5R/gH4E4ylYWyD1Q4XffE93Bn70bImrpG29F2WbHGP9g
	 k1Q0utKUddFKMo71CQGsHyV5fJqSIJvfer2braPRwRiMO96oeVgFcVfnQ/3KiLUDrd
	 toWkkruv1TnGP2NHecRVAl66yd9/VlybHG7lr/gVFaF3dLOFcbonIAGN4YPAiniOVA
	 B+9nw1HdiDlheCg4wCTyv+nl/F2I5DuTOngZNz/EMlqo2ki8W8E76s3io2tZl/zcFM
	 20rW5X56AY+LnJBVf3OGL4DyA3Plz5bQvbWjpfpzMXUwD21+3afkWDef/DEU5rOZNr
	 DuZLj/wvEx9+g==
Date: Fri, 1 May 2026 13:27:56 +0100
From: Simon Horman <horms@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch, chleroy@kernel.org, qiang.zhao@nxp.com
Subject: Re: [PATCH 1/2] net: wan: fsl_ucc_hdlc: fix uhdlc_memclean
Message-ID: <20260501122756.GB15617@horms.kernel.org>
References: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
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
In-Reply-To: <20260429114208.941011-1-holger.brunck@hitachienergy.com>

On Wed, Apr 29, 2026 at 01:42:07PM +0200, Holger Brunck wrote:
> Unmapping of uf_regs is done from ucc_fast_free and doesn't need to be
> done explicitly. If already unmapped ucc_fast_free will crash.
> 
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>

As a fix for code present in net, this warrants a fixes tag
that cites the commit that introduced this bug.
Perhaps this one is appropriate.

Fixes: ca20e191eed0 ("net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove")

Also, as a fix for net it would be best to explicitly target that branch,
like this:

Subject: [PATCH net 1/2] ...

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

