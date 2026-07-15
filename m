Return-Path: <linuxppc-dev+bounces-24297-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D16C44508
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 11:08:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0YMH4LRJz2yY1;
	Wed, 15 Jul 2026 21:08:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784113723;
	cv=none; b=oDigRHmaRGwHBafLmz9j57NHobyqVreA4WFEj1VEcXVe3I6EczOcAONiQpAGkqqstLya3v4RJsrtILxKxGH6k0Wx4XS1clxXWOO9XOdlJgJzQ5sWUi6/tCJZh5ZIa3UlE1ai5Do9qwHLHSiIbEhAk3V1X7efJCl6RteXDYex3Qh6vQjUqQEAfOp6vSU14RhGvR5obdFrDDu/F3XhqDBvrCnfKQJ41Z9wpXYarQR52Fnl/ZBTG0hQXmaJwag3l/DqFimKiGGrqvRSWK4IS1Pwx4Kz1H0vxGQYM0v4/TnW4MZxnTxGJa7JqzTn97T73zFD9gFZAQzIdXTtv34yb4N+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784113723; c=relaxed/relaxed;
	bh=Ptgrn/evLAEwSfzX9qDjHyGQiRkJcXJqaq6HAAvfEGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UErH28+k/RY8Y0yREz3fcUVxqx9zqQz7R4KDDqSK1oCAg6yjoXXrS3uKIZ75eOiQ2ButVlWVYfe2n6nckfehxkGLinbY2UtESXFTfD6FoKfweRfURVQyr0hDoBJtMgNDZz2lgE3YDpulgdmsnfWbExZICnCnVg/0o7HKfFWdbXEjOz/NIk0goHW0MfPi8MIAkbWr5aBSojSWXAq3Hm+EJj2UqYVovivxXk1w9ga8/slzisazYpr8riqBmdpL1a20rL95SKlhbf8BffqnrtzFBEx6ChB04a6VShPTNbvml29Icq4BEcwqNz5inqwpohEGDezMiSv+UGBeqxgsWRy0qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIUCISYX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIUCISYX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0YMG4jqpz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 21:08:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A5875600BB;
	Wed, 15 Jul 2026 11:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4749B1F000E9;
	Wed, 15 Jul 2026 11:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784113719;
	bh=Ptgrn/evLAEwSfzX9qDjHyGQiRkJcXJqaq6HAAvfEGA=;
	h=Date:From:To:Cc:Subject;
	b=UIUCISYXXQx0C4xXq2CYcwmTJm8x9vsEl667KT5Kif9ShoVy6jvTyYNnSGsnfT+1E
	 90vkdrzZ2+W+CVUE4V95Rxg3iFDFOhdrWHULM4ilwudT/rQexS3SA/y4zCKWkBSkTJ
	 ZutvgEwqe5SFCK3xrVugKrW9m0rvzR7vZ8o4m+Qu+OkI/Psp7OFeiGHa2+HwmUwMwQ
	 r6EhSVzgtevcwe7mqrGrDk9Rk214qPaXqRblFuXWtoMOFqxMW74LVV0rJWBBmybZGa
	 ydanzfsTpBogS1B9Jz24LC2mFl2dAKMr55NyXcMemTJFx96GcsLHEO0cCf6HV/dhh6
	 BjDEdqlzPFf6A==
Date: Wed, 15 Jul 2026 12:08:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Fixes tags need work in the powerpc-fixes tree
Message-ID: <aldqM4Rr9xc8-j8O@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="vUCnrw+KxzcmmPWH"
Content-Disposition: inline


--vUCnrw+KxzcmmPWH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In commit

  c1c1ffa490fc3 ("powerpc/vtime: Initialize starttime at boot for native accounting")

Fixes tag

  Fixes: cf9efce0ce31 ("powerpc: Account time using timebase rather  than PURR")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format='Fixes: %h ("%s")'

--vUCnrw+KxzcmmPWH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpXajMACgkQJNaLcl1U
h9DU8Af+LBUvqYZNKl7SFHCXU1Mv2wHQTtzfGyeDG1yyNR3o/0PEb/1pVWLXSmQI
zdWXHnRjynv4j442EA1YsxUwKbo9ajcEIWcC/Y/78/dNRJALCleVDUK7iey8mGVo
/P9fn6qpzmKZdjM022ta3iVnaQNq+RsmQx6AlMRE4Ch1D+ZunjIaKwbS3yamiDEy
TVsz1Mi5aWljQXTro2EV9dw+o3YW/qCAGDOixgASuZjAyZhKonYeTXHXATJeIp5I
6fJSsz4r4ZaicOdEw+IP2P7s2wKtk7ylfks13XCfF+o6UogghyrmfPPY8HFkkX7U
/5Y5l6sypSTHuANWWlibsj+lhodxBg==
=tuUf
-----END PGP SIGNATURE-----

--vUCnrw+KxzcmmPWH--

