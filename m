Return-Path: <linuxppc-dev+bounces-24204-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0FAC4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 11:47:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzyG35Bjfz2y7W;
	Tue, 14 Jul 2026 21:47:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784029627;
	cv=none; b=Gz98WH9WNHZjsdso64xmZJvkLgHeMN36F4JzFvWt48ykT+Tni5zeqQWr7UikRh7ylnHUViV5afokhfNWFC8LodgFBH9Im4mYFm/4OAXHS8/A24BZUg/GCzxa/im+5FG4ekhP26p2CSKqO7JzRiyXmRYDx+7QSG7XF/hiGPJI8MCik+tCGEWgy4c8tM74YstO/GoCeTQmgnQdXXxtepiJ+lSSFl1LpQINw20oNxIdyxY1Li2LO9r58YK6GfC4pcBI0NNBYzujUYn/cbgEYUlnruRJgTpMiCZQ8EHUAEDiEsDSeB3oWASK10qFtx5U6/lMQ7IC9GZ4vOJ2ocw/0eDnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784029627; c=relaxed/relaxed;
	bh=ln5WPGLe19x+VbgszBcOfv2DZljhtOY4/AgqGzCy/ug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C4rkc/0S5k+em108mcCMWTd4wJysHor7W+2ZX+eQVEt/Sr0DuYEKBexZueWqZBpW6tvTcT/f9DILd4jWCCdwiSjOsty8HpYeJfzEj63HFu6pKwzI3Isw46cUOrKhhvQ6Mfyg0pDvpkeRw5sGKs30nkuVe8LU9vmU+pcXXydMCbmKf2GOTKTu4DrN31fFbZLsTq6bkIjA9EYtG6a+neAIhhixwPgIIDDp2D2y2ujsSOeypj/f5pDiv2BVO1tJgKMvOKaWYCIYf7Xd03D7BrA+HXI3R01YrABXAtmyH6nARKE3vzRzkTBG3tw0zRwcn0lSuOq4jF+LZC+jjX1nwCtrLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHwyXQWm; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHwyXQWm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzyG302htz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 21:47:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BA077413B2;
	Tue, 14 Jul 2026 11:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BEC1F000E9;
	Tue, 14 Jul 2026 11:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784029623;
	bh=ln5WPGLe19x+VbgszBcOfv2DZljhtOY4/AgqGzCy/ug=;
	h=Date:From:To:Cc:Subject;
	b=aHwyXQWmLc0hD7H5DumvbW5KHtZUBYzhXhsf2A1fzbKkrVEUj/f5tUExJ4QKCobmS
	 BhuM4uT4rFNkKY3JDWKp0rvpqSB0Iz5b63n4vD5LjwcX70bH6N2WhaNlIP2Ttnix/Z
	 uftaYvG9YdRIiXHkrukBPOosV3F8zTJzRKYsTpU5z83DeNBihEJxi4ntjHGcCJTEMk
	 uhhHnrLlVq054f4qGbhOrOZJBgT6AmvY+MqpouHCa6f9Imfv4f58RV9zwYLsFXWyGx
	 CKT6C6Wr0ORWiK0aiYTfHLF7SRfeeU4XJ8jLJCX5Es9nAnXF5QE6MEAuuRxO8RRtLH
	 KMk6Bx93ox1nQ==
Date: Tue, 14 Jul 2026 12:46:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Fixes tags need work in the powerpc-fixes tree
Message-ID: <alYhs4-Le_VfbGcj@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="v+x80NNBOQoEIGSN"
Content-Disposition: inline


--v+x80NNBOQoEIGSN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In commit

  19dbc55d400b8 ("powerpc/vtime: Initialize starttime at boot for native accounting")

Fixes tag

  Fixes: cf9efce0ce31 ("powerpc: Account time using timebase rather  than PURR")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format='Fixes: %h ("%s")'

--v+x80NNBOQoEIGSN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpWIbMACgkQJNaLcl1U
h9CnIQf/WWOUcGUdGt+9biaLiSDpgrYpE06a2eRIbddH85VhG60XHUUD2PUMJawI
7balj/6wkowUUTuqyCSzN920l1FVyGp1dXiFiQGau54VodsJGEvyd1Q+BBpGZbwM
map2b9LmsSYIR5zvKb4XGaNXAgBoDIPXh/hCgVzzWN1u1Ht5TQsnlVt6F7ou7gC+
nojkaJ36pTjxqJSYUMlBiEKvL3so4Y1k6iIRcx11Ur3XrIauwRiDjhJrNk3Tme7B
wJesfUNPWRC/dFtrf8BCyLmpRM2ki6c8p6Opt9sFLBS184DCDESfPp4XQvfkCzQR
pNvwsOHTzl/JU3P4JFz/j5EDKm8nlw==
=G4nd
-----END PGP SIGNATURE-----

--v+x80NNBOQoEIGSN--

