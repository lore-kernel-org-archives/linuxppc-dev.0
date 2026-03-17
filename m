Return-Path: <linuxppc-dev+bounces-18301-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92341FD875C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 12:20:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZrcy5lq3z2yfP;
	Tue, 17 Mar 2026 23:20:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773750002;
	cv=none; b=oiZvm4qyAuYBU6BfRNkcXSwgVHtpYdJH7t0oEzbzytOw+dNTv1pv7Hpd64nwE/MQShlY8ao2rdIFuR5ju95x29fn4IpTKLSrUzv/iGLcKc4Jq0L9baMc3CVFw8eOpYG1w0HWKZB9l1FPUFRwES+ew0q8yZnQTgGethbeJh4mQleQ7+u0qTHlbeKVxbOx+pGfWWWVKpioY4YB9G0RVOqqKk/Wy+NnqLbU4CxACCwU87+6qlnPdzOkFjyg0i4oq/xrDqaiAOjOBjYVosUjwtsZt1UFEdHMu7dLuGsuPDCp2MxTGNfBAGxsePK7Z7U0tKl7GgXxLrR2+yOXYf+hF+x5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773750002; c=relaxed/relaxed;
	bh=AStXLKYhjJ7asRmVKNPQmyQ+2hK0H624+uL9+3uQZso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixSdPzNakyE49d/6kvMg145WIVuW1JwQtwc4xUhq2N5fP9xKJ223Rx00bHfdGpyRRurDAs75wgn7rSdbiJBRpp82OZHAIMjkwd4kDOZsjA+mF/LVLxQAU3CA4zXSJ1A2WMkrgikNRJoIHk4WgY9L9/sBUKDTVkG9wqrZun5pt0QzNQjIKRpI8rqVGVD+vMGU6pb3kKGr+lbn682oghDxW6JEJH/k1j1k5G+7W2giNjWBMfNwVn08xEeiNDTvTvMew+Ilj55KomRiUcfzVF6l1sMT4yrMOUgn517RQi1jjMhIQiSEahkPaCYRWfCRLggJa9Bhdr3eMHEGwm4pUZpNiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VbxaE3Hx; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VbxaE3Hx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZrcx69M2z2ySq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 23:20:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7590F435A8;
	Tue, 17 Mar 2026 12:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2BAC4CEF7;
	Tue, 17 Mar 2026 12:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773749999;
	bh=LkVtMzQ8iwPMCCFFu6AX2GHaJLGRANe1jKQRznyYI6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbxaE3HxAtENyW3Yfmxs7SV4PM6sQ/iodDqLj139Us8RUXa0fBtRxmZo1ZEHopsaE
	 AFOU3h6DU9uen8+KhpS5Sqd8jOlLISSwemqyXDXYsmMQ4fSFXQtMXoup9CAiJkR1IC
	 SdHfu/6f+d6skDH1pdUVME2iocvL8/XZ9KcJ/s8YiV6kjIyji3eEQVfSDoSNozkRrQ
	 W2bP1X0pHSW2XRzOI/eLIGYAPcl0vELCBIzrWyH3BA0qI+lxHMblMF2pECbxcjnqlB
	 iLPtRL8zJSXXzou6LLb6OVO2Y0N0yKRia/tKBqacOOuAR5sZO3TkPflaxUc1gAoNZF
	 xkXYmFasbVXYg==
Date: Tue, 17 Mar 2026 12:19:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [External] : [PATCH] ASoC: fsl_easrc: fix comment typo
Message-ID: <a05120a1-650f-481a-a1dd-4dced984f2f1@sirena.org.uk>
References: <20260316180545.144032-1-joseph.salisbury@oracle.com>
 <a61b8ef0-32c1-4d1a-9ab4-ceb6d5f004bd@oracle.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xkNM2tTQgD+DOtei"
Content-Disposition: inline
In-Reply-To: <a61b8ef0-32c1-4d1a-9ab4-ceb6d5f004bd@oracle.com>
X-Cookie: Must be over 18.


--xkNM2tTQgD+DOtei
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 07:50:57PM -0400, Joseph Salisbury wrote:
> On 3/16/26 2:05 PM, Joseph Salisbury wrote:

> > Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> > Cc: stable@vger.kernel.org

> I inadvertently added Fixes: and Cc: stable tags.=A0 If possible, please
> remove them as they are not appropriate for fixes to misspellings in code
> comments.=A0 If it's not possible to remove them, I can send a v2.

Oops, yes.  Sorry, but I already applied this and there's a merge on top
of it.  It'll not do too much harm, worst case the patch gets
backported and does no harm.

--xkNM2tTQgD+DOtei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm5RuUACgkQJNaLcl1U
h9AfQgf/VAaRj6I5VjU+iAt5wOu/imM4dGay/S99ALt8Ewn35FjMynEZj9SKWZNs
kIcAw34uZtovKJv7ZavcyDhDKrqAgfVc3qxlN9oy7avAoXg7scYIJfH9AQ8B2VF3
aoPQSnYh1uM6+nfFqETH1ZdnGk+RTbGT0J3F8yLpEVt1asVUR4JYYr+T5GT67aOV
C4EYB6HQC76pQMoNzLl2OaMcE69pSfbxar1w7KbUac1F3q2eoHk7F/X/bWgoxgMx
fHesfDmZd+FjpVBmmsosuuoliT3Q9UgE6jDNGDByALRY3iL4WKEg15fG5xo8Hbzg
SWxCEa9Zj+6jHLYpsqh2hAU0Q9hz0w==
=GG/p
-----END PGP SIGNATURE-----

--xkNM2tTQgD+DOtei--

