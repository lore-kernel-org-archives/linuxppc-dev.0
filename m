Return-Path: <linuxppc-dev+bounces-25659-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75ADAC5AD4E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 08:10:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJSB24cV2z3048;
	Mon, 10 Aug 2026 18:10:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786349450;
	cv=none; b=XP4IATvUIi2W9NfMSp351we7/WjowR+HSrXnlSKUz5BNpUMFMEkAbd30ixFxHr4DlXZoLlFAhENcoqtdbgMK6Z8/VLUonGK31t2UobSuXFRSFl/0kE3D3W66k9+DM0c0186VrsXFKiGS2Z5S7glSaOH5VUTqIZEoakIXpJanR6ewhT5xno/XAhy2U2dMlyfIZD6NnDNgih1wxQXNMd+yodoSYE1cy8ZcBD2CDUN1PNXsMKBuZ5J0h8bZlSUB463Hdv58k5uulZQTQ6V3ESA8M/ywVdH3om4hJyn9c3l/uOAvFzuXWwL9uQKx92GTPzqND6cnGr8Tg7iM3zy05fJfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786349450; c=relaxed/relaxed;
	bh=D8GAAPcPNkvGTDlj9lP0xZu0c4aQ0+uGJs8xBq+n/kM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=aoe7mWveQmLCw/yUARebCM+jAH+9CiigxN1WQRxKb93bxEn95O1cMJwXl59Mx4WgI7v3czAVtn4ZHGgnM55ihZt3EGjn9q6tKNRWy2JJ+UKhKWqO2S15ghN8rHef4MLeYf+gQF/1b9yj9IxXZS1e4ZXzZ37REkk+H8efGeCvHSCm+EnCjFfMCkLKolN9WAf0UanRp/F1BFghEgClJoTF55mCmJ08xmGIu9bX/CC8y/orxbwv3MHrUjXYUIR1Wn+Sv2ZqOINPAfqXgTkvy3jCSU71oZMvJZaTUm99sGgDbjVJC3x+rMSrsVKe1/DlhTD5bPq86TM3SdBo7RNU2J7f0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ol0m4cZ0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ol0m4cZ0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4hJSB129PBz2ysb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 18:10:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 61303409B6;
	Mon, 10 Aug 2026 08:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BDBF41F000E9;
	Mon, 10 Aug 2026 08:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786349447;
	bh=D8GAAPcPNkvGTDlj9lP0xZu0c4aQ0+uGJs8xBq+n/kM=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=Ol0m4cZ0Ql+pds/46gHDTbjsqiX90sOnocAxtDPny1NKrwNoE52jE/jJOpngRzVsC
	 YSSXcxLgXbE0XDIrqhI4cB2iywfNuJvD0GBzwpZXTG1XSQ8FDg9jony1cfIFCO25n9
	 5tbbwDoiuF5EyiyumRDnSznWZijY3qYvBQKpGHYR+iuLqmjbHdaHUrYLLTRKjgeU0u
	 ratLSBNsbERH7HLY9N9F5LqA6dsZA0aLdF/spscMMk5EM3mhWDCfkZu3U0JasP3vve
	 6jxuaQdP866Q6gSCvFFk7uEwx4X8sI5XJyera4SYOfZf81MJimLLQqfJVjjTeqDPMP
	 9udRKX+sIWR6g==
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
 boundary=44ada78920db0c5cdf4033a7b68fc9cd12279b08ce4d58d6c9e466420964;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 10 Aug 2026 10:10:43 +0200
Message-Id: <DKL4118H7S5U.1FN3E4DBY4GHF@kernel.org>
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
In-Reply-To: <20260731022855.GNamwIZw7Fz4Yhk__S@fat_crate.local>

--44ada78920db0c5cdf4033a7b68fc9cd12279b08ce4d58d6c9e466420964
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Jul 31, 2026 at 4:28 AM CEST, Borislav Petkov wrote:
> On Thu, Jul 30, 2026 at 10:35:20PM +0200, Michael Walle wrote:
>> I don't get what you are trying to say. CONFIG_EDAC_MPC85XX is
>> enabled in the that config already.
>
> You mean, *because* CONFIG_EDAC_MPC85XX is =3Dy, then RAS=3Dy? I guess th=
at is
> true for this particular config.

No. CONFIG_RAS is not set although CONFIG_EDAC_MPC85XX is set.
Because CONFIG_RAS was *automatically* selected before the mentioned
commit.

>> It's just that the mentioned commit broke it because it removed the "sel=
ect
>> RAS", while EDAC depends on it.
>
> No, that commit dropped a select statement which is good in its own right=
.

And while doing that it will break (at least) the corenet32_smp_defconfig,
because it removes the "select RAS" (which was on the EDAC_MM_EDAC symbol).

How would that work without adding CONFIG_RAS=3Dy to the defconfigs
where EDAC (or rather EDAC_MM_EDAC) is enabled?

Here's a quick test:

git checkout e3c4ff6d8c94

# remove "default y" from PCIEAER, because that is also selecting
# RAS. But it was removed in 8c8ff55b4da7 ("PCI/AER: Don't select
# CONFIG_PCIEAER by default").
sed -i "/default y/d" drivers/pci/pcie/aer/Kconfig

ARCH=3Dpowerpc make corenet32_smp_defconfig
grep CONFIG_EDAC .config # no CONFIG_EDAC, nor CONFIG_EDAC_MPC85XX

git revert e3c4ff6d8c94
grep CONFIG_EDAC .config

You see, before that commit, the driver was actually enabled, and
after that commit it is not.

I'm really not sure what I still have to show you that you agree,
that it's a regression.

>> Still, it's already enabled in that config and it somewhat recently
>> got IMX9 support,
>
> Who got IMX9 support?

Disregard that, I was confused, it's in the fsl_ddr_edac.c (which is
shared between EDAC_LAYERSCAPE and EDAC_MPC85XX).

..

> I can pick up well tested patches tho.

Good to hear.

-michael

--44ada78920db0c5cdf4033a7b68fc9cd12279b08ce4d58d6c9e466420964
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCanmHgxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gzcQGAsR41P3plwjqhvP+m1h+za6dU6QPVszbW
GDsyisbCK/xjoSONtEjUStgqsSwvGmwCAX4+j++E6ePSZB2BpGbvqUoa1vUcIUwL
UauC8jzpaOBEDvUoDOtL8YzxVrNA2RNEHtQ=
=Hlr+
-----END PGP SIGNATURE-----

--44ada78920db0c5cdf4033a7b68fc9cd12279b08ce4d58d6c9e466420964--

