Return-Path: <SRS0=CBJl=7E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFADC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 13:16:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EEE72070A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 13:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5GKNdFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEE72070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49T6SF4BzKzDr0f
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 23:15:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=f5GKNdFg; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49T6Nc4fG9zDqnl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2020 23:12:47 +1000 (AEST)
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B4C7E206B6;
 Fri, 22 May 2020 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590153165;
 bh=eJKC82/JdUZHlra7wt2AcwBxZx0GOUHbM5qLt27y8DM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f5GKNdFgRnnBIO23cQpX5VzjxVD3vjqLDm5zKWQYH9PGzsWz88uDSXU4smxDdAEXw
 DuNIoPjen0K7HCQd+h/fexnZt0GCdHeqg99S0u9/zoItXB2B9XKxiQ9/4fuSQ5PaaE
 bXVA5rstzRikNPoIOt1rnpDxZXLvYgs5dXdkH0XQ=
Date: Fri, 22 May 2020 14:12:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: imx-pcm-dma: Don't request dma channel in probe
Message-ID: <20200522131242.GI5801@sirena.org.uk>
References: <1589881301-4143-1-git-send-email-shengjiu.wang@nxp.com>
 <0866cd8cdb0c22f0b2a6814c4dafa29202aad5f3.camel@pengutronix.de>
 <CAA+D8APhHvA39wmCayeCsAEKmOJ0n7qOQiT1tZmFHr4+yASgTw@mail.gmail.com>
 <53258cd99caaf1199036737f8fad6cc097939567.camel@pengutronix.de>
 <CAA+D8APAMRwtVneqFsuBgAhozmQo3R0AQi0bVdUCQO4Af4xVfw@mail.gmail.com>
 <20200520123850.GE4823@sirena.org.uk>
 <CAA+D8AOiVVi3B4dzU8r=rCMz=6w9R=wxBkzAQ=0=RAQLKCWy8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Content-Disposition: inline
In-Reply-To: <CAA+D8AOiVVi3B4dzU8r=rCMz=6w9R=wxBkzAQ=0=RAQLKCWy8Q@mail.gmail.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org,
 Linux-ALSA <alsa-devel@alsa-project.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, shawnguo@kernel.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org,
 perex@perex.cz, Nicolin Chen <nicoleotsuka@gmail.com>, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-media@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>, s.hauer@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2020 at 07:30:04PM +0800, Shengjiu Wang wrote:
> On Wed, May 20, 2020 at 8:38 PM Mark Brown <broonie@kernel.org> wrote:

> > Other drivers having problems means those drivers should be fixed, not
> > that we should copy the problems.  In the case of the PXA driver that's
> > very old code which predates deferred probe by I'd guess a decade.

> Thanks.

> For the FE-BE case, do you have any suggestion for how fix it?

> With DMA1->ASRC->DMA2->ESAI case, the DMA1->ASRC->DMA2
> is in FE,  ESAI is in BE.  When ESAI drvier probe,  DMA3 channel is
> created with ESAI's "dma:tx" (DMA3 channel
> is not used in this FE-BE case).    When FE-BE startup, DMA2
> channel is created, it needs the ESAI's "dma:tx", so the warning
> comes out.

Not really TBH, this seems like another one of those csaes where DPCM is
creaking at the seams :/

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Hz8kACgkQJNaLcl1U
h9DJFQf+KOiSW3M/3ZDsfcMnTGh5HgNgjzZUpEU5f1ZyNw/EXh1ViAvYDpkQp2Er
kpo1Tgzodk1pkqsn1sWa5yWP+0c6LboBqkCq+02NHr3Kjyw3dQ6uV4ObJH35s/d1
39jbo9WIGQVqo8IOFdGhjpP4q72Vwxz1ki5asUYV3e1IO8aEowWvvbpnSIRlyuvH
rXKaqX6fYMsrMzXOhUx7afrt0n6HR/eBg/XkyIsnhXvvPpmxEAySIyKPOGGrftBM
rNmOV/XPKbLQXFzjWbK+3ChCcp6ETGTyUyHP25Dm+qXnIyvI6D1ssajhiZHN02RB
EdzpF/hkR+YLYUFNuN3fRvDOjQZT1A==
=fSbG
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--
