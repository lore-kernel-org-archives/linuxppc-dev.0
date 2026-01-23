Return-Path: <linuxppc-dev+bounces-16230-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F263FD72372
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jan 2026 11:28:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dyFzg2t49z2xHt;
	Fri, 23 Jan 2026 22:28:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769167695;
	cv=none; b=L87Dl8vsuBi41tJ1+Cvvx49x+hos+UGKmPQnhG+jdlRcFNoxEm/9/R1hVF/xEkd3+akZ3XuEWRG/u1MTY/qr6chgoPBBU4kbtGUvrgNolGKugBwn/xjqB8IZhegE/1/Sw0BjN/+C5kCBQfocJVv3G+RqUcOZ5lktMq3Hz/tOK4g4P6wbFzGHq7SRjXey7f1jl4Ahy5EW7LhFXlDQ+7bQk8qeMUtXoa/OfGQSR1si01ymh175YgKbvACE8Hq9Mh5qhYDG76hstd8ln0jfgCi6mbBTOI9k0uuNWzgJ159CoNlLdS0MxIsRZfO8vgkr6LvPu8NmO6Yohky1Eti5y2e9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769167695; c=relaxed/relaxed;
	bh=RxVpmJdCjrivRll4uOmVa64p5tw55xMroactfceMo7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH0aBuPezx/sP3x++51bXL8upjUtAvfb9G2DBAA6WuuJfqA4JcOtHdTeWFG81q24T4V41p6sUQB4cLgM6tpSlItyM+BVMhYubSNPUs78osKi9FnZ5YpqO3O9NEl3aerX9MZaJxUlrvv5n7xKJi9PiUXSaSKvs8ynoQ/JYIU+VOW1R+ZQi2iEf4yduS8s2oyuuxwx2OUnLum6EZob8WRBbnqeYM4mEB0xZPt8Yv7juBUuvPEc1p/35/jH1MgF9SfTQMsPEoAuMA3tdJYsdEFJzXiSvrt488orD0+IjtUBE/5A5tiBctXop9r/XJcdRQyIFBNy4IOjgYpcRV4IiWOBew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sm6g1PbQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sm6g1PbQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dyFzf2y8Sz2x9M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2026 22:28:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 08A4E438E4;
	Fri, 23 Jan 2026 11:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C4BC4CEF1;
	Fri, 23 Jan 2026 11:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769167690;
	bh=RxVpmJdCjrivRll4uOmVa64p5tw55xMroactfceMo7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sm6g1PbQ5DljY0bPMjPN4oRI4K9n8ug8qjP7niI0PDrMY14AxPuQ+PMrAQMRcB4zM
	 R/iUQlC/vsuVE5dordmcnX9I0nVjYH/keNe6rCSULQk4YeajFN4nO9dTzTxMsLowSf
	 rqdIGDxW8NE1QE3lo6Vc9+vs1lrrexUvejFBoW8Th5/0vB9FaRW8HoD+S+v+/pDkmk
	 fSSMhi9fUQQGia/b5H4/eilUTNTQ/pqfhoxOz/ryw9wf2kk63e/X2MKGq1BrPjd3Qz
	 vNCghBXfbreaQqmn2y4c9G5V1lAhBaJ6oM3kt9Ve29dnoYe421P1j/6lwzeX3x8ofg
	 RdYliR7L4TinA==
Date: Fri, 23 Jan 2026 11:28:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [next-20260122] Build failure on IBM Power Server
Message-ID: <13c1bea8-c2e9-4b07-a05a-3553bab0b9de@sirena.org.uk>
References: <43ea0202-891d-4582-980b-5cb557b41114@linux.ibm.com>
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
	protocol="application/pgp-signature"; boundary="l0YcFpOWC0Adhz3o"
Content-Disposition: inline
In-Reply-To: <43ea0202-891d-4582-980b-5cb557b41114@linux.ibm.com>
X-Cookie: HAIR TONICS, please!!


--l0YcFpOWC0Adhz3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 23, 2026 at 09:45:52AM +0530, Venkat Rao Bagalkote wrote:

> # first bad commit: [a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d] Add
> linux-next specific files for 20260122

This bisection is obviously broken, adding the -next files is clearly
going to have no impact on the build.

--l0YcFpOWC0Adhz3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlzW0YACgkQJNaLcl1U
h9AjKAf8CewPI+S5yQZbxZOrhFrkXWBUf45g8vevgCd7lgXOcyYxDbYhctWVPAw/
Rpb972elYzxpbzXiKUoaYAJNyPcLtUb19QK8i0sbyQt9oe16gT7Op1WANCdw+CD8
6XMj0mBIYVPmpmAadvfo8M41YbKznCEgwLJ779v/EVjVdr37YSpRosH9AMEApjAl
vYRaJlSU0B2xegpA6BW5ihdwchhXFiPYtzNvhckvF6TERiRRsqwrjYUc7aTMJrf5
yAItqr8ZI7amnvNS6NAsaSUJTXCy0cEpFK2S6rIHVw10vTKegkvJLUTAbkGRbIVb
X7IrjLusr/plFNngKls7zaRgS2LXTg==
=HRFD
-----END PGP SIGNATURE-----

--l0YcFpOWC0Adhz3o--

