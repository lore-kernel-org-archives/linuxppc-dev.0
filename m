Return-Path: <linuxppc-dev+bounces-16778-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AF6EA811B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:40:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9PPb1YcDz2xN5;
	Wed, 11 Feb 2026 01:40:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770734451;
	cv=none; b=LFmPc1SNol3xYw26Xqt4cOYFQJcrU1gaXSwc5W2U4/uJg1LCzD7J2qCLszh1WPiEsw7uECmpmJKe4NPVfPWcQ93JJGxriR5G+MgkrwqV/0N0c8Bs+AJgRdvoIk0AqdoVNTQC8yZLPYrLC/EbFlfPgqDKUpZh+qDimYo4CsArCvyviblxMe9dhSzn/+2lSIq00v3ZIql/OtS04iInUGr4e25IIQZr2pqCxOORiBjgt4oGuHwPt+KvR/uiNWGoKBY8q/wEOSCJt2sQxunrwIqtkUe+8XFTyLhSrQdbR6uOwzSPziiFIxejkHjxF112jO2Gbl1G7ai6IO5ma2VdKJhdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770734451; c=relaxed/relaxed;
	bh=jTCU+bOGKWZs/m0zlw0GMf4W0aa1RKds0gWzBn7yWI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZg8ibeABGJ1khmycqdlwjop66klnPNRNAtHom3kSXJAl73erS2ZDtJT6gYgZrCcmtfv7/zlqR+puerbrQkH2ciW1BogPhut3mF2Bv+4XFEvRd3YWbgGTabT7OStu0FZEz1RsGuPCY/hu7lcoLxqhlt1K9XNDPYyWtdxAti7yjWl0B8LsPC52IOYoFCCBqr/tgDrI+Dgk7NClah7HrqgVxPT05abQYAIEJaPPJox5aD+DX5sOfMWFfX2hTOoHn23Cda5hRKl0Hq4FbiiW2/xN0IENswPDxQSzqrw+EgkjwnYOPEYj0F91xBqxY6M+DcTvTkL4oTj4wEAgT8c4uyKdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JESPI7yt; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JESPI7yt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9PPZ4Z4Lz2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2026 01:40:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8F4F540729;
	Tue, 10 Feb 2026 14:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1850CC116C6;
	Tue, 10 Feb 2026 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770734447;
	bh=jTCU+bOGKWZs/m0zlw0GMf4W0aa1RKds0gWzBn7yWI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JESPI7ytWwfUvL7WCXgZ7O7OxvIMAs6O052e1hep6h9XLwCOYVh/3UAumqJQ4EfJi
	 TU3FhrwfiaCc+1lV5RwOh+zjBdlnNYHtcM0IDYusd40M8QTbVg3oqqncX1yDP81hOW
	 ELg5KYNzDuM3egZHsCId3J23nauG76RXiaXQwIKtUdVpZ5boUSZZxTR2KZ2vsgN/++
	 RvvL9XyQHBKkkrIsh6v2Q6WpNjtM8TR2mKAh0IyrGX37U/ynuerZg+E5vTqBzrMIQd
	 lnR1mYxk1c/EjKUM+9YySVCt9okLcJrrheAedXwLRiDZ6SrHDPeVanebSkosnQCogJ
	 3dct+0bpuHwIw==
Date: Tue, 10 Feb 2026 14:40:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ASoC: fsl_xcvr: fix missing lock in
 fsl_xcvr_mode_put()"
Message-ID: <937c2123-e384-4046-a1a8-390714b905e5@sirena.org.uk>
References: <20260210143809.297565-1-n7l8m4@u.northwestern.edu>
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
	protocol="application/pgp-signature"; boundary="QaCcNFHudlm6l9fn"
Content-Disposition: inline
In-Reply-To: <20260210143809.297565-1-n7l8m4@u.northwestern.edu>
X-Cookie: Spelling is a lossed art.


--QaCcNFHudlm6l9fn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 10, 2026 at 02:38:09PM +0000, Ziyi Guo wrote:

> This reverts commit f514248727606b9087bc38a284ff686e0093abf1.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.


--QaCcNFHudlm6l9fn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmLQ2kACgkQJNaLcl1U
h9C+qwgAgmU9wHudJYALXuwSpuwnLKK7LNQAx9GkbTJfzcGCq2OjpqHi+bu3eBsJ
EwEUEbBKYo6LbgtGYzwMVu1qBfTLhWYMUxHdyNXXxcc90hCBBuG3hIW7v8wohCf9
yElLgtGmTLt/DyoPZR+H7BQc77n/zt+/3jnCjpfKca/JYmlWhdFPyToJya19q5jD
1nGz3SrgAUanMaAiQQQJ2Jc0tlZyKKEgWVXnzJd+pnWDMdTV0AegS4E9/a4JJnFY
EkGrUM1MINtpoXkL6xF1ICHsoHSvWmdJmWfbG2P/ZfIS5M8enqdP2ilPHHUtQu4M
gFWP5l9KseHF19wgckGu8rHmDMENRw==
=l/Ry
-----END PGP SIGNATURE-----

--QaCcNFHudlm6l9fn--

