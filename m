Return-Path: <linuxppc-dev+bounces-21992-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D755BCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 05:34:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWCtN5p5xz2xrC;
	Thu, 04 Jun 2026 15:34:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780551260;
	cv=none; b=R+HNAt/GG6cr0BRJ4D3EuP4vV3Q/p7z6jlvvS7qpoXq5I1A70BwYZPO8k56dXmWEAwi79DIxcGAmofL4ww2e/qIv13E+tTkSTsETaS8D7fUFRaZZRv9MBV/ebWtoGI/c4+j6u3P+9S1HgKNvWOViZ42+N4ad/Op+iBUQ+Tbe1IpXql0y0cQoamXIu+xKTgFEkV/SojpaVOa1YeslzoB7zXijZpGO0IbPZv+bcsVt8EyFfWD8ReI/dtBiK7cusbS3wv1Si+zNz4nvMOkI/1riim0hZcxfukx/edI67F9GoCrcz5QX4HAcwToEcjmcVXxlaMbl1sDHuiCI7elvnbeSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780551260; c=relaxed/relaxed;
	bh=j314sgZEJ2BPq8oCCjils0V0pfkJmoyrEoH+1wcS5k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJT0Nm6HJg/CLW00x+hzPfssmhv+7o8jOdF5cM8ADdq+lpprU3IkzPa9fPZdI1xbLikL6qkh/vbGJk1fwYJFcwRZ8PpruvaBERXeEg1/AiP4IewYsbcLCvqZts8bL5zteUOu8c5myCPOAhnMxGsCd7lBfGVyk9ok3/Bz/5SIkfyXJSRxUR6mo/auR7XLDAzkjuzYnllG2+hRLSnGjPFjrrNA5Ypp5Y4IZOHqSyJUm6ECcFf9eXYjJJ7/WDiWn8TpM+jD1ssXfU7cAERfXlYTWuK4roSvzHhHr+Dzc+H3FDLW4jRhTEy/Am9FkY2+I9jT5aykZfhA1yziACu2YQXwYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KCRKarqR; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KCRKarqR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWCtM41Vlz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 15:34:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 312F3601DD;
	Thu,  4 Jun 2026 05:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F841F00893;
	Thu,  4 Jun 2026 05:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780551255;
	bh=j314sgZEJ2BPq8oCCjils0V0pfkJmoyrEoH+1wcS5k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KCRKarqRgscWmvkIuazYhE6YgPoRl81f/jSgLnxgHA3jrF5in45VV3I6+00lckijU
	 HZgGkLXbrrcjjmyYGamSXhA8Sh2/s2W1k2XWWNvsDoypK+rxS0d/dHPU1N/4ajHchI
	 FtwstIDZapl/FhrDCWCanJ8qNtw3lGyXIPzDldla2AWkHm/JTx5o5ZqB9vmTTOdZDj
	 6aQViy2MifdZ7pNOJQSRMvoTXFTr9mk4gxu35mAC1jBFdSnVqCwSchxd2elr0ZNBwM
	 jbkiWPK9NnfPMw4COfej82NQjiQp2fePVWvkeKna5SXF3mIDHkKCSgJStb+HwqasCy
	 ptExAnxNIx6kQ==
Date: Thu, 4 Jun 2026 07:34:12 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@infradead.org>, 
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, sumit.semwal@linaro.org, 
	lkp@intel.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mm@kvack.org, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-s390@vger.kernel.org, Dan Williams <djbw@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
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
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="jqptshhieja74xp6"
Content-Disposition: inline
In-Reply-To: <20260527160716.GN2487554@ziepe.ca>


--jqptshhieja74xp6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
MIME-Version: 1.0

On Wed, May 27, 2026 at 01:07:16PM -0300, Jason Gunthorpe wrote:
> On Sun, May 24, 2026 at 11:21:33PM -0700, Christoph Hellwig wrote:
> > On Fri, May 22, 2026 at 03:58:53PM -0700, T.J. Mercier wrote:
> > > After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap int=
o a
> > > module") the system dma-buf heaps can be built as a module. The
> > > system_cc_shared heap uses set_memory_encrypted and set_memory_decryp=
ted
> > > but those functions are not exported on powerpc. This can result in a
> > > build error like:
> >=20
> > I'd much rather revert the above commit.  Yes, x86 has exported these
> > since 2017, but that's a really bad idea, and we should fix it instead
> > of spreading the export.
> >=20
> > Setting memory decrypted is a dangerous operations and should only
> > be available to core code.  We should have various allocators for
> > decrypted code, but not export the functionality to random code.
>=20
> At the very least an EXPORT_SYMBOL_NS.
>=20
> Looks like there are about 3 modules using it already..

So, I'm not really sure how to fix this now. Should we revert the patch
making the system heap a module, or should we export the symbols for all
archs?

Maxime

--jqptshhieja74xp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiEOSwAKCRAnX84Zoj2+
dsIpAX9h+K6tpCAvZItDUjp18GfV1Lws4Co6p+mCPIcMvXSb9nHyxnRm60dsf2DY
5WaP+wMBf3/f3uHeLbsQL6So6AEsb7aKUbpaAgJo6FK/gDrwlAX+ebBpuWxfClty
yJnTzPlrTw==
=ZFmF
-----END PGP SIGNATURE-----

--jqptshhieja74xp6--

