Return-Path: <linuxppc-dev+bounces-27639-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DEFC88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 22:34:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm9XW1WQkz2xlZ;
	Fri, 18 Sep 2026 08:34:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789684443;
	cv=none; b=ooNYQpSVJ80x02LRjtZuRsRkMLlB9VfiLKYw6PHYRjHxKHP3HDw/KqPEj1l1SCg/3JjPcjoBeOfx+eXwbEqzpNYOFgi1aO3DBhciu2G1i5HJUkYKFfx1qdJP2/db4yIgze4UPmmJ33N9tIGgfL6j46dR9IvA9j+JeHMM5tdMAfabMMDS1mSAJDo23fB/48TbM3+NaKxABI0XwQEsbi29slwiK1fShMpY8sYN2SJBYd6qS1A0VI6rgoB7wDqJi/XLPWQUvZpJVmmMN7dzm1+aOeGUwTcD6YXWfddQ1TvFHnwxSGO62OOe2nKG2pTeL9BagsMHtHBS2MMtO8TsKwdCow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789684443; c=relaxed/relaxed;
	bh=tXkh16j/Thv+s9cP7UX0gqw0LlvCxf76Arv3zXbeDrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcUkWSASx6eQegoZS6nxlTFCQ+dw70HLxlB35qmvLxaRpKFKutwpHaMjQbMBvTdMNc23H9jrlYqfi4SWF59/YJDxTRLzZOG2oYV5e/rA1el0gC5DFbuJqRG3+aEpHTTceiqVSIAtTJQ6D66OcHabSQuOJ9nyUr6F9fp8BTqHVUtIYJlZ3PL8uQKEd5hW3GXyu6nmOAO5HklRe7xFLrv9Eba+2Yok75uBQDEz1WHlw7TQmyACazEZrZ4S/gtaNXek4PniGZlAxlYl6/yBLP4TwevsLaraHpdXIf9IBUQuDbRunqJ1wnipawfPVX9GwIOWoHKvNQneLtvM0u4AnFA3NQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNdgG5DS; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNdgG5DS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm9XV3Qvbz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 08:34:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3C337601EF;
	Thu, 17 Sep 2026 22:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EE61F000FF;
	Thu, 17 Sep 2026 22:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684440;
	bh=tXkh16j/Thv+s9cP7UX0gqw0LlvCxf76Arv3zXbeDrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WNdgG5DS3KQnHaWNU+TDLlgSaj3d54kvjXav4ma5fjCLAES1Bl113qxoQgiY1TrOj
	 ZlqxNeiNKMsMqahjxk8FGzgsO30737PX2VT2GFlnoRCCvSqj92vT469DaDPG/Om2ah
	 IdB7ICbLYWpxYHUbPz8OEpfkay4B2wVB1caQskAy1McvHiwpmp4ZJiqTMF5fciQ77S
	 1ZG0i55cgy5rJd1ZiC20J0IlOfAewOjliScvCe21NmzCV382tiCh5/Zy+qmcrw02wL
	 ojG+6OmI/81SJ8L19Jkn+tAHoUJtBLvwBipUpKeDSsaFeYt4qrn0CUzP56I6ldCqgG
	 8pvulrTcU4XyA==
Date: Thu, 17 Sep 2026 23:33:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nicoleotsuka@gmail.com,
	perex@perex.cz, shengjiu.wang@gmail.com, tiwai@suse.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Fix ASRC device leak in
 fsl_asoc_card_probe()
Message-ID: <1d80b89f-7b33-4036-a450-bf32c603a238@sirena.org.uk>
References: <20260917165430.2163372-1-vulab@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="P1ZmkZ7HWziaZSjA"
Content-Disposition: inline
In-Reply-To: <20260917165430.2163372-1-vulab@iscas.ac.cn>
X-Cookie: Whip it, whip it good!


--P1ZmkZ7HWziaZSjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2026 at 04:54:30PM +0000, Wentao Liang wrote:
> of_find_device_by_node() returns the ASRC platform device with a
> reference taken, but asrc_pdev is only used during probe to set up the
> DPCM DAI links and is never released. The shared exit path already drops
> the CPU device reference, so release the ASRC one there too, covering
> both the error paths and the successful registration path.

This doesn't apply against current code, please check and resend.

--P1ZmkZ7HWziaZSjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqsatIACgkQJNaLcl1U
h9C0Ygf/RPsRzvwwH4gsQUTDa5a8UQsKSpt0ClJpUzd9B3N82yCZlVAtHxZBcgUj
tHCfZEKD+1B9Glr+QJGAN+8NesYn3HRKfbKiW4Jt5NESTK5QAIAjsMrWxhNrFN3x
KD3sph6e2rbMmYV0ghCw0/S5EZ/uEtePvuWKIZ+c2bgfx5XVFfG1TvUOOlj6kXP8
U8PLUZQeyUmnhexe09hMc5+i0SDW4IiM5p+vB4fHy6Aip6qz+zIX/NocqexZhrhd
j22M3Qgvz3klweIoHpxTZqR/MLYY6lxLcL7Wj9mVCG8qzL/8dZh5HcE83TCzc139
7+M0UMSahUdK1AC4hZiK15UGanLF7g==
=+L6c
-----END PGP SIGNATURE-----

--P1ZmkZ7HWziaZSjA--

