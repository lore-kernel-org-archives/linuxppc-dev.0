Return-Path: <linuxppc-dev+bounces-25675-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F30BC5AD55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 14:03:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJc0s6Q5Kz2yxG;
	Tue, 11 Aug 2026 00:03:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786370605;
	cv=none; b=IScLTqNzCr3eARbC9iu6A97DVXrfISR3qkbcuoKsuuufIrVOhX1yQ8i32fsj+KBhjRdXxCNOns7gIfDa9/ZyFYqFDfzflNhYdgnAWXU6AwjeA1+qMKxYl48lze/51JpIRLgaZVUt9AylYez70VgCrIH7BtvWEeRIVceVfXlwXM0PU3CSVCHnvNbaki3swT+ZMDGD3Jf0X5Cqm6uQpcJoYon9nZhRSPrTvTAkFwIL0EiTG8TZY4lhKfY7W9JH9PBg8T2dCXJer8Tx3mBoaVasuTXc752siZ0kSgE7BTHwfjyxK9l5Qn1GHoiBL5ZIf8XCnjodxjHH0eF7LFpM7B9b5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786370605; c=relaxed/relaxed;
	bh=PLTFNlxmfZnluw3lrmK2dvWW7y/hPCNzql0E1f/F1NE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=RBbW7pxfoszfE0SQmJpyT78Um7NV5xi2x0ZR4CUT1evhwCj17duMop5tpToiF5bIn9do+v5+6Hb6UmurqfRMa65hw4DmNq9jJwYMssXZI9JNMv1MJlqASWh/nIw/brCXq7tPpuvFrlwFpDgLBVKcsVCc9By1RAzhJDnaY6gJjq3d1pm6pVchULCjnpegNxSfTENJmEmGiX64XZ9DvPZ6uoYWuxjUKANX5Vj85/h59mV1qo2sZPYYyfmzOhDVKI1dPYbgYcJ18DcENvkWEnhkVTwxlSgquv9cc94j3E7RV+Kgt1GCSQ9ec/JyJV+kD45DRQDcxc7d8XbeUTJ4rPXIGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9+I7wnn; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9+I7wnn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4hJc0s1rwPz2ysb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 00:03:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id AFDFB60052;
	Mon, 10 Aug 2026 14:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D52AB1F000E9;
	Mon, 10 Aug 2026 14:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786370601;
	bh=PLTFNlxmfZnluw3lrmK2dvWW7y/hPCNzql0E1f/F1NE=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=M9+I7wnnd4k8hb2GZAJuUbY7tptqoXDHY35E1ZgHFN4SkhLunaUg4OsVfH3O6xMfH
	 Do8YoR78L3XvXFAzgUINNKE1+dVJsSBb37wskK7jAI+wC0FjI3RIUnVIHx2Sq33CiR
	 eG2PztbDcVoVZOFOEPgt97zBNDWVM44SdOdMPqFXOppNvErRLTKgY6tABMlRQyCass
	 KlaVBZi+nRCVKlUiE/HqEeM+JP7Jn/uHktzG2OD8q3AB9TXNmEc6lYqXQfnFybctz9
	 JjjYTjBwm2sdmHdxC1n4NUCVp8KgaWUAgimbDeicCtM5HglesO0aXPQ8iWxqL9CXe1
	 erkliNcthRl0A==
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
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=286f580f11416b2d2a5c68b49ff507d9abfc06251ea1c6c09a03767a470c;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 10 Aug 2026 16:03:17 +0200
Message-Id: <DKLBIZ7ZBP1K.20VHSP02I6BW2@kernel.org>
Subject: Re: [PATCH RESEND] powerpc/configs: enable CONFIG_RAS to fix EDAC
 support
Cc: "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman"
 <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>, "Christophe
 Leroy" <chleroy@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Janusz
 Krzysztofik" <jmkrzyszt@gmail.com>, "Takashi Iwai" <tiwai@suse.de>, "David
 Heidelberg" <david@ixit.cz>, <linux-edac@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Borislav Petkov" <bp@alien8.de>
X-Mailer: aerc 0.20.0
References: <20260730105546.3658570-1-mwalle@kernel.org>
 <20260730185620.GDamueVIGV-8iIzozX@fat_crate.local>
 <DKC6Z5YGBF2O.TAJAN566BN0L@kernel.org>
 <20260731022855.GNamwIZw7Fz4Yhk__S@fat_crate.local>
 <DKL4118H7S5U.1FN3E4DBY4GHF@kernel.org>
 <20260810135020.GBannXHLXtUlqJjzqS@fat_crate.local>
In-Reply-To: <20260810135020.GBannXHLXtUlqJjzqS@fat_crate.local>

--286f580f11416b2d2a5c68b49ff507d9abfc06251ea1c6c09a03767a470c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Aug 10, 2026 at 3:50 PM CEST, Borislav Petkov wrote:
>> And while doing that it will break (at least) the corenet32_smp_defconfi=
g,
>> because it removes the "select RAS" (which was on the EDAC_MM_EDAC symbo=
l).
>
> And things like that are fixed by adjusting the config. Basically your pa=
tch.
>
> So whoever picks it up, can add:
>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Thanks! Christophe already pointed out [1] that it should go via the
same tree as the commit it fixed, i.e. the EDAC tree.

-michael

[1] https://lore.kernel.org/all/1500e19d-9bd3-4050-8568-31b546f0b22e@kernel=
.org/

--286f580f11416b2d2a5c68b49ff507d9abfc06251ea1c6c09a03767a470c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCannaJRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gNlwGAhtavgVGyN1VN9r110B1+4Uyn1aZkJ4AF
EdDhMHp6PzUVyOqLmecwEN47l1jbetgHAYDHONeXALMdJkWx0TV7ubizRmS/jmmA
aK/pJO6JnC5xYRuR4BOHVyilzBNBx+CKuQ0=
=G7pb
-----END PGP SIGNATURE-----

--286f580f11416b2d2a5c68b49ff507d9abfc06251ea1c6c09a03767a470c--

