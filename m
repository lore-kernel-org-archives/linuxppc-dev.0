Return-Path: <linuxppc-dev+bounces-21467-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8E6CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 10:33:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPBzk4QSSz2xbN;
	Mon, 25 May 2026 20:33:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779705186;
	cv=none; b=RWIDyEFd/ggA5uSHpfYtP+5XSW3wngHIBAQf98LYXtjbm9J3AOY9B0bjnXN3E2NfbD+fuqx7QyxZoxb/eV5taLfxgFZEqprdjifspYWU6Dt1WoM5r44d28dOezOXZ08qOYDSzSbwx/6/S1B0budUktyl+PvE1ITn9DLHOk+erZYighjpcDoNRnJp379rU8Zf94I1qF59qxty2Ph8YDbAfnAwGbbT+yqhreh+7vQDE0LttND6g58cN8XPPHTsc56/ZVlfdwplTT0gsGO5CbgNp3rL2qpjv5MsL+uc9M9s76DjfVYwMOQVQBp6/wYQaGD8zt6GnJtUP7yK6eMjHJApcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779705186; c=relaxed/relaxed;
	bh=KAZDuzP9gijbdivs8EV0WW9vXZa0QHchZnHc3UcVfKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku8zqDpHZ+9rg4oBtiCZITxydxsqS57s7/H7eOes+3C31XRY7ULr7rN0SyjqxyHr5MfTdiUiA/7H6MdGpF/xK24Ekq2zwrvthxtSUKldGIfrTZVBGUMab7FdQJZPkuUnA+6ynaHA3aU24JaXyAYwZ1Bf9iG3Q/+YAGkgzGfPa9rrXv1QIxQpL0aKbWRqQtnar/XkgdOkLgNRKTNG1Fe+XBE01BKu4hY6rcaKm1Z39OcGlsfk7Z1c6DNpTEupZzojGZQMtczUHFgFyoEsJ9NRJJVGIRwZQE68dXAakeVeDQuBSR/Z1fzPRmJA/xini54Yw9kFFM0OmZ+THKweMPbdyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVkX4JLx; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVkX4JLx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPBzj5QCrz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 20:33:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E267242ACC;
	Mon, 25 May 2026 10:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EB81F000E9;
	Mon, 25 May 2026 10:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779705183;
	bh=KAZDuzP9gijbdivs8EV0WW9vXZa0QHchZnHc3UcVfKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CVkX4JLxb7HaWjUtQlrnAVuwlF8utsaH7hoDGGQVTbahetlxUakzK3OdbPCKp6I6E
	 py6FY8lHYeOhdUW5HEweEaWdfm/LK8Wyt9VOBs/2/njR0FjFhHScrv9c/C4ZiboKmN
	 bWG+SBKd8WA3bLDdt+QnxA28klqmRLuT3/9AbsnAEXjED+RKQ/RORg1PyJCb3B1d7O
	 khEnTRvtMCT3H/V++iHj4BUizlljIGFY9t+j6csDKKfATUvi5ar4LuhgHRj6fsl9u8
	 t1t33znDbhcYeOAtWK/npIDpyHwXh59zgfq/wkwsneDtDL+CdpqqzERmR7kivDAgKF
	 s8QBMbsK1vY9w==
Date: Mon, 25 May 2026 11:32:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: eeprom: at24: Make VCC supply description
 requirement optional
Message-ID: <e71a9a6e-b6b5-42b6-b7a3-a689aed77faf@sirena.org.uk>
References: <20260524080533.8749-2-pmenzel@molgen.mpg.de>
 <ahN2m3kCbyTUNXzZ@sirena.org.uk>
 <84448a84-1c96-45a9-9ba8-1e058d0bf8a5@molgen.mpg.de>
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
	protocol="application/pgp-signature"; boundary="jB4dCdALwZLV8nsW"
Content-Disposition: inline
In-Reply-To: <84448a84-1c96-45a9-9ba8-1e058d0bf8a5@molgen.mpg.de>
X-Cookie: Prevent forest fires.


--jB4dCdALwZLV8nsW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 25, 2026 at 09:07:42AM +0200, Paul Menzel wrote:
> Am 25.05.26 um 00:07 schrieb Mark Brown:

> > This is not appropriate unless the device can actually operate without
> > power, any driver could be used in a system where the firmware does not
> > describe the regultors and it'd obviously be pointless and error prone
> > to scatter bodges like this on every single call to a regulator API
> > function.

> How should the warning on the POWER server be addressed then?

They should fix their DT, or you should arrange some way of identifying
that for some reason their DT is like this and dummy regulators are the
expected case.

--jB4dCdALwZLV8nsW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoUJVYACgkQJNaLcl1U
h9AREAf/f/v7mAzKhtOmRxOlT4TGjQJtePIPPOm6XiISP/8a1lNhvpCtL2KgDxcr
Iv7aZOZF8Ob9aM+VcpXShG33QQR8UENGmNQzQTZQGUj+pmaL3J5sgXCTQ4dLAajp
8v6MqtFBpLqTRXsDM7OWtACOPcfeAxzryWOvmus7dnEIMkzhEyHQ6aTai2hw7PyY
UjPm1ynrtZW/YuShzDmoFdfsiY3uzI2NBrTv3GoHe5LIOxHxQtTOitwy62xSkFUn
lh0zFO3elO0qbj3h9yMznmrlp7NLybaH37p1hrJEXZTyUqv2DFyq41WmHuJFK+5y
r0lUT3Oeeqzp5CYrkcIoShE7zdUx2g==
=sanc
-----END PGP SIGNATURE-----

--jB4dCdALwZLV8nsW--

