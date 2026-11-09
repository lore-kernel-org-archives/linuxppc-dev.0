Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D45606A33B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jz87hB5k
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNZpV5tCVz2xnv;
	Tue, 10 Nov 2026 03:23:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794241410;
	cv=none; b=i8CiAQmRUj4B2Jz519KYbzCCN1ns08vOpI0GkqpElBT34QW13v+/ROPCb0Jc6xpxEzdmb1HSx8rAb9hkXZzdJ9OJIbLHjkAwMSUOIIm4Qc/hhnnHxMJpOTx3XxvRBz6UZkmI+uxYJaS/V+cuyiIHx2qEsyOK+m9t4Apo8uEj2YbQFwxrL5PaJmSzMOxu9/4cgw01aDy5n/4QjZGYxDVaAf6bybzSDYXXN8F3XI76nl+J1pRW5d3+2nqd7WJnmJVKEAZ10bmw91farMMX3aTguWyy3xviAgVnpZUQqcYwnVtyppamQd1cA1s4VYdUE1RXTz0IyE+y6HUytyku0Pu6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794241410; c=relaxed/relaxed;
	bh=tG5yEYutI+mpKyTMneJT8rko5YsS33pVwWvh68hLObg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6czg7r5yH20LgrsI+XUqvWSkgM6x/Vb4XJaUdIHisc/YkGvaV2laf/KkIketBjEAtGE8dTRf8HQ9sR3kvxeP917WZY4DcGheOdekgRGaZFHgIRpnnUoqdgb1Ry6FwEIGKzBWfAwlouca/TRpOVwWGVbMJq9ZMF6hqflYAoaUHzS2rm3umO0Um4Nc21iK+DWJWIWKLFrBE1NlWJMfG931VjqFwBefq6+qvG7Gki1LoPAAe1hOHx+THGcXsQtbct8oCiq8nX2XofRSeswzrkEN06okRJVTyFYwixE4fpIHD5sB6ekGOb2MdvwfumCKt3egwW3uIZoTYMDu7zvG6FH5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jz87hB5k; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jz87hB5k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNZpV1HRJz2xdX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 03:23:30 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 09E0E61CE4;
	Mon,  9 Nov 2026 16:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FFA1F0089F;
	Mon,  9 Nov 2026 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794241406;
	bh=tG5yEYutI+mpKyTMneJT8rko5YsS33pVwWvh68hLObg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jz87hB5k60+uTGtLRku16bW3/e5kRmOxfhlfOyNBjMBL1583P5K2jAVIVtYzdzcZ9
	 7CXXLkC63CRSsT4iPFW/3FpvyVHcaWcPsSNriFvaQTRBRJIo/udtienq9TqMU66e3E
	 jt73m0An7Xx4E+5iZgx5EDhnAURvWwf3WhoMSUf38Xn/Lun9ZynV54GVmpZmMia4BF
	 KO+sa6/Ww+bAAxzvsodLhXI4Rl10eCpp3gvU6SRQDxYEX5V81bLXPd2EN50ivv2kV/
	 mq9i/fBnhWoYauvqBETQLmCGAeqM9T90Cx43JvuxfAVeG5AqeetPj3grWiSabqB3pm
	 JQPDYPw6hBVKw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 361491AC5995; Mon, 09 Nov 2026 16:23:17 +0000 (GMT)
Date: Mon, 9 Nov 2026 16:23:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] ASoC: fsl_sai: Remove redundant error messages
Message-ID: <avHzdeplLMGaL3EM@sirena.co.uk>
References: <20261105104237.38542-1-phucduc.bui@gmail.com>
 <20261105104237.38542-4-phucduc.bui@gmail.com>
 <179397468197.3073895.1522608204443678480.b4-review@b4>
 <CAABR9nE52Rk81oyoM3L5hHRn3n9OCP3PWSxA8nNt+aEPoeRtqA@mail.gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZHui3L9dMLkg4C6t"
Content-Disposition: inline
In-Reply-To: <CAABR9nE52Rk81oyoM3L5hHRn3n9OCP3PWSxA8nNt+aEPoeRtqA@mail.gmail.com>
X-Cookie: Victory or defeat!
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--ZHui3L9dMLkg4C6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2026 at 11:08:05AM +0700, Bui Duc Phuc wrote:

> > >       ret = devm_request_irq(dev, irq, fsl_sai_isr, IRQF_SHARED,
> > >                              np->name, sai);
> > > -     if (ret) {
> > > -             dev_err(dev, "failed to claim irq %u\n", irq);
> > > +     if (ret)
> > >               goto err_pm_get_sync;
> > > -     }

> > This will only print an error for a subset of errors, things like -EBUSY
> > will now silently fail.

> From what I can see in the code, devm_request_irq() ->
> devm_request_threaded_irq() reports every failure via dev_err_probe()
> in devm_request_result(), so -EBUSY should be printed too.

Ah, that's changed since I last looked.

> Or did you mean fsl_sai_read_dlcfg()? It does have some silent
> -EINVAL returns.
> I'll restore that dev_err() together with the fsl_sai_reset_hw()
> change I mentioned earlier.

That too.

--ZHui3L9dMLkg4C6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCavHzdQAKCRAv73Ows9A4
ifrkAP9gnev+hbGO8ePdT7PHgzH3El9OJEtgV6/8NMCbTzrgSAD/RlZa/FDVWGL6
B5UGRb7dndjHNJ0rmqfE9Yhe/h0YhwU=
=fhwP
-----END PGP SIGNATURE-----

--ZHui3L9dMLkg4C6t--

