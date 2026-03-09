Return-Path: <linuxppc-dev+bounces-17936-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DA1FCA19C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 22:43:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVBqz36Vhz3c8W;
	Tue, 10 Mar 2026 09:43:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773096207;
	cv=none; b=VxXdCxeVbthNSi50Z550SApt4N9iOKyac/1TtT8lornvK2Pt110pyeKeS77AozVxvBUzt3h9InHDFzcWato4mVnMkdWTIpZL2bJrNmmOaNKoYH5HM/dyLBoO90PJMIN7AUdFZciOSjPnIiRLna6IMjwI7VMGfNFaaWp7BrFy67hWmbKgmsupKinGj1gnqHB+5ACZiXVxY7ot1OS2ZAQ1Fv5Z9XbANVTH2nB+YZ8FgwMHxUwHr/7D7RScFkup9VQ3NvXL1IsFM26UsdtaatV8BLkR6rMbMMu+pS3z6vWQocQLv8mGYr6jEYcAkLu3+2RANQPYDG/dQP9RkOab/LGf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773096207; c=relaxed/relaxed;
	bh=ZEYhz7xg3sczBOBu+pB/xffLoulI7gmHnmvTYKan0H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjouREYBa8iX8EW21DmQb1cetQG++suo69+BwCIDj8lb5YZkQWHsaw+iSmxWI+5NJEL5OMtHK+lq0VGvS/IRGTghTuGprnIN35fUs5lLqdYr+cpz29DLH3AWPVjuhQ58ekf2rTeQyikyUbMmmoJKuc44eRAvua115LJX34el8ul+X5X35w7/lsbQ4VvqvKroQiGRqLlYV17TSJKX1ms6fepp2tpOrKwmYIWZaHZT+LQ7Ot8VvGXzwoK2bTrP/KAs9MQOsaE//mtvgE1GYXp5BfRMkifXvQThPiTgtMjn9Mo6G6JraBE+UKu9GSBXD/hxwwk3yiUqYGwCNBSMDTu9Ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o0ChRkx4; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o0ChRkx4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVBqy6DRzz30hP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 09:43:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 315E760054;
	Mon,  9 Mar 2026 22:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B761CC4CEF7;
	Mon,  9 Mar 2026 22:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773096204;
	bh=ZEYhz7xg3sczBOBu+pB/xffLoulI7gmHnmvTYKan0H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0ChRkx4adkI30uwkOeH8CBE7kaj0h8OwVe2s768+/VoisV3Q4KA4KiVW/UetyhCt
	 w98Rn6inG8wjPuNP6fwTCc6YGUQ7hUNxzNiKrCOxm8jhPwpmj3PZNFDS8oWBvI79sz
	 M6mtc73kj7tWgP3mmXZCq/l1taIBAxvKd9u/aQEoRBlMTk5xpBbi51hFpQcqPgiw2y
	 qCSN+G/aK9KeBKu14dvXVJA7bn8ZsAXn+kVf2u5R0fPbqUG/qV4s0sMf0kz8qxA8eZ
	 PvZ4ohLyolQqya0eWfLQWMdGPJ2rCyFvA4JA7785bW7YXrqUJZMJYhAlswApR6Xgxz
	 pWYG+Mv/WCfUg==
Date: Mon, 9 Mar 2026 22:43:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] ASoC: fsl_xcvr: add bitcount and timestamp
 controls
Message-ID: <6033818a-4a33-47ca-996d-343dd738da9a@sirena.org.uk>
References: <20260309083530.2977163-1-shengjiu.wang@nxp.com>
 <20260309083530.2977163-4-shengjiu.wang@nxp.com>
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
	protocol="application/pgp-signature"; boundary="Bx38oB90IhNv6QVK"
Content-Disposition: inline
In-Reply-To: <20260309083530.2977163-4-shengjiu.wang@nxp.com>
X-Cookie: Nobody knows the trouble I've been.


--Bx38oB90IhNv6QVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2026 at 04:35:30PM +0800, Shengjiu Wang wrote:
> The transmitter and receiver implement separate timestamp counters and
> bit counters. The bit counter increments at the end of each bit in a
> frame whenever the transmitter or receiver is enabled. The bit counter

The issues with the resets will apply here too.

--Bx38oB90IhNv6QVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmvTQcACgkQJNaLcl1U
h9Aa+gf+LS4vLmYbpcLR4JyVW23Bv5pW8NuxC9NGus3SH9+7Lbg0PqsUvPiKx0ug
ncbBwa2Q+4vOJQbYCTMei+kbbIJp0zxVzc6lwQlmoxeGOpeJxOcSCLt++jZ0xXqg
1CKU25jxQVE9AONmBM94RyIPnL2Q8pIV1OFVYP4pJW3Ldd1YoKZZFKC0KcqZdCBr
uvksmp5Wkh8CUwb1csHuLQuaCv9ISC0f1BYQUa5zPYRWHKqESeKgKUWwvH7GamhD
x6Y/pphhOOJGdsKJYs6trNaI4xpSyqZIGVX9TgL3zKrx4NhnVT05AQUJlNHXMtq6
2bmGIkrlbuBGJ5Hr0r8w+IN/5B8s3w==
=xpOe
-----END PGP SIGNATURE-----

--Bx38oB90IhNv6QVK--

