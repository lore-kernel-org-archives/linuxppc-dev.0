Return-Path: <linuxppc-dev+bounces-2928-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D69D59F5D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Nov 2024 18:19:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkD4p6GJKz3bg4;
	Thu,  7 Nov 2024 05:19:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730917178;
	cv=none; b=TbkDvqEC/lf+6JquRwbnaIceQGOtt9izKk7H+Ch9UEKUv56STPRgabztjJ2M/FzAmV2+GlhfXTaScsXU8w6iNDVx+qmQn38TZ9DEUBE1I7WfbI/wHuAK9RSuwCa+gub3G/4aaeAgD0ndXCs0qYZtZnOssaXmO15nTkHScy1eioQn0Kn2PPaCiFn3niTo7G33pbuCuo9QlchUfswvhAXZjhqQiAtHepIAHZfSYX79qGPWU3xmuorR3p5fUPDbpepMVGU4ihddvlX7iRo7O1SzEm2oI4p+EhOdb2Tbo/eV0YoFgOGbk+7dZwEXO65DvBIk73qy1VJGsoZ0gmmBFlpFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730917178; c=relaxed/relaxed;
	bh=sn7rRtukOUPi2X7skDpsh/lp6w1uJoAopG9xoA9cpjw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=TgH9ij5TQOCdKIktGKFN0T/SAR1w1RhX4Gr4akqoTOk66voXoyDQPQfe4/Etu5PW50DjjuS/b6dNoEOQKGbXTT3WX3A2+wemY2Rifr2cr9dVJX9KoMcY1NAW4LRwEHIXDySd3f2hPMjBT2yzE/arcgvvlo1mXsI2Q/4ar6zenyF41EJHeNuEdVdjZY+lKrtKCoUe9xcLpCnC7O8BBt1KupkbmQsXqUNUT9zgRLPc4PGJ/yko2cL1ZIqBuYquOOBoW2caCLFSEcnfG9ArrsYLEBzy21Pckg1kP44+xEK2IoMFat2wPtzlICpF+mezRpA96NV0Y7GTolJeAaF7obhdeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=COMLHltx; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=COMLHltx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkD4p05lZz3bg1
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2024 05:19:37 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 933B45C3A71;
	Wed,  6 Nov 2024 18:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643C3C4CEC6;
	Wed,  6 Nov 2024 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730917174;
	bh=sn7rRtukOUPi2X7skDpsh/lp6w1uJoAopG9xoA9cpjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COMLHltxKBSv7HFq68JU1n/OI1WOrP4iijOSeMjN1bNXTIcaD3+61mrthb3NLHksX
	 G/DEnahcYlzwZFfi4bbDgHncZr/aC4FZ8ENpILoc/p3b/Bn5sJJ12YzT5JpdCcv4H8
	 StMi8W+EzKuqMhJ6PUTHk6OekEzz1egCDwPdTfOiRyFdNe/4eReK0Axxc0RhYkdxob
	 0FujBSYVjW70Q05xZvj5aXePyZq9G3e57rgR7in0aeOp1OXJ7WesA97P6cK+OOr2cR
	 WaKiYQT3TvIIL3DtlmUBBcb2eZN9brgSUpfssjw7w0Zr5kqzJiynPXQ5ANyDIu+myc
	 GT6sjwZwer68g==
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Nov 2024 20:19:30 +0200
Message-Id: <D5FAXEKQ71ZJ.1U9AE15UVWRT9@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin"
 <npiggin@gmail.com>, "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] tpm: atmel: Drop PPC64 specific MMIO setup
X-Mailer: aerc 0.18.2
References: <20240702161052.3563599-1-robh@kernel.org>
 <D2RSWMPFF8KK.X5HZZMHANQMO@iki.fi> <D2RT0J8KXY1H.3MEV7KGQXTWHW@iki.fi>
 <CAL_JsqJDX+uOSoPh6pTNEP0vBLwcP3bKmAW1wCr_0cVr5fsPcg@mail.gmail.com>
 <D2SSH5HSDHQS.2YJSB22W3MHQK@iki.fi>
 <CAL_JsqLF+gs9e1TL1yi-xAZJRx4Kz7fOk=2wcF8kCqU3vyMWZA@mail.gmail.com>
 <D5FAVRTM32ZJ.1HFCHF3L9I68C@kernel.org>
In-Reply-To: <D5FAVRTM32ZJ.1HFCHF3L9I68C@kernel.org>

On Wed Nov 6, 2024 at 8:17 PM EET, Jarkko Sakkinen wrote:
> > Whatever happened to this? Can you please apply my patch if you don't
> > have the time for further rework.
>
> Sorry unintentional.
>
> I applied with
>
> -static void __iomem * atmel_get_base_addr(unsigned long *base, int *regi=
on_size)
> +static void __iomem *atmel_get_base_addr(unsigned long *base, int *regio=
n_size)
> =20
> as this gives checkpatch error.

See:=20
https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/comm=
it/?id=3Db18ffd5e0faaa02bffda61e19a013573451008d4

If that looks good to you, I can mirror it to -next.

BR, Jarkko

