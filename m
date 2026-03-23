Return-Path: <linuxppc-dev+bounces-18640-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B88F483D7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 19:15:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffjYK44vtz2yWK;
	Tue, 24 Mar 2026 06:15:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774293317;
	cv=none; b=PleeKuYs0Nyrzmn8NLf8bJ3cgM7Wwy8BTEZB26NwW+M8fa5OLUANO4irQDGKIrjTQ4b6oqQ8LsX6vRcMpOEgsHBLPGf48g+jztB2ulHtyaQAD4MORMj61GhZ3/lLas4GlHQM+rZ7BQb2c2NiVUImK+hfnwqQ2CrnOZ/K7o9aiFstw8XwKELf+2tTkyRmWg5Nx17VrNQ/KcG7OvpOYTXxe+8lY3szkshEvU8bvgD7B4PzYDohXu/HviFne+tAzvlO/Jz7+/7V+0j6X7bYjAF91TOHTq7IyWg3k8ydzZuQAXCQ4Gpl1YD7SYjIfmdhYLaJuwiKMjN1vJixhx5uAvK14w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774293317; c=relaxed/relaxed;
	bh=QWjZU5cOKfszZzg+/blNPtub/ZAyVC21MOjwauifm7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgMngBFEE9bCQjQ5a4G35F3OkGaz3ekmM2Xs641LxJV5g3hb15ak/NyZ/zBqrmfnmYUTcUxV4s5mXBB/i5tGfzCzzaGvXzEiq91qGokmQnIKYNOM3n1TDWUzC9x7CB8qXWVWEuJmtrg9A+u1KLECt4YwMApWCE4v+8wh3Ap/dmtw+H1vauP/00j+r/3e+M4s0ypE8ra2K6Xw8dNfCB0BvTTpJT21ExKbuvu9E0CiwM2lCYz6s04gJvJg53qJpYvFC2e9NWb/REOTxPh46xNKjROW1mtNCyFLWe25rcQswsY5VxJ9k+CFGvoFe2QKIMQ7WNvBcp5td8cskHXbdWn1jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=G+YsQ2+q; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=G+YsQ2+q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffjYJ59dBz2yFb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 06:15:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B1399600C4;
	Mon, 23 Mar 2026 19:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96948C4CEF7;
	Mon, 23 Mar 2026 19:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774293313;
	bh=KW5oMS/dMaLgzmq1TIjs9q0gaJlywaGKGhQIBPyUtvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+YsQ2+q5CUsGWepvrtLqZxCgUIIHzcU0ARVOd9u4cetr9Po565yLMvXMaUpyyszj
	 Pr713zEwDiwEV9P/B4VtahHaclI4AU0ytm/xMCpANQKfiKSfbFqPZGNIwATuomQw7o
	 epwuxxwX434SxWDpWI7066qjRtS4/pXknvr8citwvMzB5z5ZkrtbewdBl5fqGR2wLh
	 OZP+ubB65+pbUkGYXcqWBFezmpaaWamWghIqS4xABnRccb8qXGRwzAURHe26tnl1G2
	 4CAsJmMQX6AXtrAqp/tEo4mltvrtq9N+LTv2Bx0zWlCI8E90w25rzKlMxIc8/pdXl2
	 VAOQ6ubqm3p0Q==
Date: Mon, 23 Mar 2026 19:15:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: Re: [PATCH v2] ASoC: update outdated comments for removed
 snd_soc_new_pcms()
Message-ID: <8c20f43f-be8e-4a03-af80-9c91a4a233c6@sirena.org.uk>
References: <20260321114113.9244-1-kexinsun@smail.nju.edu.cn>
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
	protocol="application/pgp-signature"; boundary="zHmbKEI0dDmFWAsz"
Content-Disposition: inline
In-Reply-To: <20260321114113.9244-1-kexinsun@smail.nju.edu.cn>
X-Cookie: If you suspect a man, don't employ him.


--zHmbKEI0dDmFWAsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 21, 2026 at 07:41:13PM +0800, Kexin Sun wrote:

> - * This function is called when the codec driver calls snd_soc_new_pcms(),
> - * once for each .dai_link in the machine driver's snd_soc_card
> + * This function is called by soc_new_pcm() via the pcm_construct
> + * callback, once for each DAI link in the machine driver's snd_soc_card
>   * structure.

We don't have a pcm_construct() callback...

--zHmbKEI0dDmFWAsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBkTsACgkQJNaLcl1U
h9D6lggAhqjWSWwPqUyQCGYgKhGeY2tNy91ZyUlw2waCRt8pt+QipIbVJCG9yPYJ
eemFpW7rW8rMGf4c2IXhVhOycI+pHqfOuTC0QGlLbWaDR8+9uPZFgcYJbcf0hC2X
z9IBN2pFLQKcvP20uTNZc57mxUj5RNXxQ/SS+8VbpoEO+R69HfH7USK9zssFcPtr
6Ot6PHzGUwCeCohYdiZY0y5qm39SJ1XCU0wZQLoOOYiNVSXnu/C7FveJmsRNQut6
Ls8eyFwcLFVp814O+8zi0AXHNBvK6g0cLsxvwUiWUiMRDcudoy/MLuE821Jc3M+t
TdKdadD3M2K0bCpz+dI9GqGDwEhijQ==
=xHfZ
-----END PGP SIGNATURE-----

--zHmbKEI0dDmFWAsz--

