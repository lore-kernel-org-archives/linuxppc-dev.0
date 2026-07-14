Return-Path: <linuxppc-dev+bounces-24205-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101C5C4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 11:47:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzyGD38p5z2y7W;
	Tue, 14 Jul 2026 21:47:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784029636;
	cv=none; b=UlXUlpOo1M7IpIO929WRXutdFPePWxo7fMv3ZFN/+FYBNk0+ljOKVZZsXljeE6a8v5YNmTThBkuoYVBOQSiKQt+9+anVmEUulwX2XyGq0WJ4FqnNBuvnlnaBHtGp8Obm7k1bfZwktCz/TaWpgW8FmoISsZe1BSM4Xwbmycl1gygr6L/NCLINZuRx3Ey4saMaGroQIgqZAFvSd1zZHFQ9NYX6LHSZFdKgj0w6PSZ0NvQXCAgf/5Zr/T1ZzTzWeG7zI4JfHn06IL30ngEZVN/rjFjPcSu2Scpsqy28qQ2V3lVU7E1kMk60TH0k8Ca6Tt7yvoa9EJWT/GE940mLT2TW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784029636; c=relaxed/relaxed;
	bh=ByEV+HIxTEtSqq52HAcTq1JU/EJC2+REptmFl6VOKbU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FCcPB3WLMns0WDWPBl/Tv9709/7iE6y0F+uXk9VvLcS/rXfip2Wfl9S7J7XSjiElkVwpktMBPGZA6GJCRU89LsuXtRJbT6Zqs/UZqKcT76raj6vSRfi+8+tb70MtqEBaO///6USeC0Sz9f6DEjzEotArzjQwPnQn+ZD4ATQrGAevtSZlr7hmHn8/Wk3o2oVbUgtW5L7rVR66zowwk1wVN1AG03Wd0bKTK6sLusw1h6EuHwbfLSsuEy0hpH9wF6ReGeb+wDDF9YiUiH2dMxP7KU2wgEtA63b/VtMKbih0rcdGdo5JfJSc47vqA6rTfbEVIkN9J+NTZMC9LMfbSC+IOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M6EYWe5y; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M6EYWe5y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzyGC5zZdz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 21:47:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5AA5760120;
	Tue, 14 Jul 2026 11:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FAA1F00A3F;
	Tue, 14 Jul 2026 11:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784029633;
	bh=ByEV+HIxTEtSqq52HAcTq1JU/EJC2+REptmFl6VOKbU=;
	h=Date:From:To:Cc:Subject;
	b=M6EYWe5ySbRMAVurYw7UsndsVxY4TP+fuxTFQMUUSPsS7RzTijCCzfXY7Ri3Nt7JC
	 SXx9Cam2/8dtk5T34OOMAUNBYjso8fMR+9YZ08w5CgbV0GkB8XK23QFNuAkSFL48+S
	 /lNtiGZ20H77s6BLzIFtzqh4JyScjHmn0wiFIcoidZxrudInBCtcyFGakyllGMAGVx
	 1TSEvTKvZ+PJh/AIdovCfJRBcW1JUPZDQEJFNWy3FXn0eKLVMuQ0hdxLgUmnjurAvq
	 oh/yWNpsfgVsacZ3bcEGkoSNJrQHK4Flr95SPLZy1uU2sQEFclpaXeGj7TPcJVo0Jc
	 SctgObvgvDmoQ==
Date: Tue, 14 Jul 2026 12:47:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Fixes tags need work in the powerpc-fixes tree
Message-ID: <alYhvRRKogDZck-B@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="FWaWqzd1XdKSlclC"
Content-Disposition: inline


--FWaWqzd1XdKSlclC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In commit

  1034785975914 ("powerpc/85xx: Add fsl,ifc to common device ids")

Fixes tag

  Fixes: 0bf51cc9e9e5 ("powerpc: dts: mpc85xx: remove simple-bus compatible from ifc node")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format='Fixes: %h ("%s")'

--FWaWqzd1XdKSlclC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpWIbwACgkQJNaLcl1U
h9Bhbgf/ZiWdWeHMXR9cCy08E0L+AwUXSUWRZWMHCmKTkZGto7JS61ffW6mDLdBx
F0S82nbcL/qPoKTakzDeu+OM1Hz7V31Jd4FcTt2QJqOWMh8mHElRvCY7Z7+I04XG
VgJFfnUocDrbi0XGnJ8OILbzKG0DmwgNMrXMpeV2H/LZGO9a7ABQJm7NcbcFcauE
ArWNBium0Ccy4gJPfjjn2ax9cU3SoRRDkhs39g624xIa6KuL2LST5RCNttdnurVO
P2rUSV98u27WvoHQ7D7kE5v9s09EPOi6yq4HXZkyS/NpTqU0A/IpeDkPsNHWZ7Ir
9F4nijDE1EqlvzvQGlF+DUlnzfrb9g==
=aQUO
-----END PGP SIGNATURE-----

--FWaWqzd1XdKSlclC--

