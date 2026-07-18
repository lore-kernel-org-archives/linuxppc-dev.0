Return-Path: <linuxppc-dev+bounces-24404-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD36C4451C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Jul 2026 11:30:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2Pj41krGz2xRs;
	Sat, 18 Jul 2026 21:30:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784374232;
	cv=none; b=MQkoesfpAbuYLeyvKtHhBi0kxliHav7cXY47fWagGUqaboTB62uTCEOeo8cyd882vmSWwoSz7jHn4//mOT2rTWk0/oPrhPJMLAyZKTiZxUcoL+bXCBd9cH/JyyBI0AJwLSSb/Ii+SOY/7NfQLcBGYGvsqz+S5kf17lN4XBvIRv2QLhg0QqHpAfSZV0x0GLtPfEVPfPsLL1sUgRZx5UNvKpaaDtPfKN38FpgdW6BSPaqjggNiB489JpdlbWMJeWUbBAHKpe84CcP7NNAdVfTCPcFqbfA+QjJtCbiRI87tFs6dM7j7NnVIBZxcwpmyxIMQqQNOdkE3LQZTUcvGFM4NOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784374232; c=relaxed/relaxed;
	bh=impHDjenMIJErEGwDatH0w1SiMFR8u879Cjzsuf2iok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bFvoWOod6S+vNylSiiD05OfRCNquQpxzEX9RIXE7J1ZjdKhGc/jMTYk0LZVWVPELx3TuXsZQGJVnm3kSq17OYMd/yowXt32U5h0KZ2lDITFdSf3q/805XU940bi08Gj2qZCM9wrAIXCszm4dYv+GwjuEojT93VwZJhYGZeHiK69ivDh/b+OrT+CKrqBp6ktkBQWF3eLNw9yK5/C4qTx78GsI5RvcOPsOCvv9eZ7mT568efZDvNTDrBhh+983+8FQUCAPMj9OwIypKA2sKDKDK5glXYl7v5AHmMSIPC3cnGrIVianEbWAPtAtDFpZcocFazjR5JSxcDgxaXQ/y4TpGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=V5YQC7Ue; dkim-atps=neutral; spf=pass (client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org; envelope-from=manuelebner@mailbox.org; receiver=lists.ozlabs.org) smtp.mailfrom=mailbox.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=V5YQC7Ue;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org; envelope-from=manuelebner@mailbox.org; receiver=lists.ozlabs.org)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050:0:465::103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h2Pj16wQvz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 21:30:27 +1000 (AEST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4h2Phm5HFbzKnR5;
	Sat, 18 Jul 2026 13:30:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784374216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=impHDjenMIJErEGwDatH0w1SiMFR8u879Cjzsuf2iok=;
	b=V5YQC7UeDTEjbe402VoyHW+O4eByuzyQMKs562aNH1f1PTDQgWRyRhLG7k+62kPRjDGM4b
	HhtZReOzxd2itJtWIzsgc0sQoYwII8y83BsFEa0yQwL2dILam3EikOXSc6HU/5RHFcBZqe
	WcGgYa99X4UMr2OQqqLAccP3BS6Ajl3NHG70Nnm9IT/HazIaCA5AKhl7Q/rhBMJ9Q04yxE
	85kU88G6Svq95H+ISh4b/KSgjTLCR4ObGddNhGGJDOL99f08U+XtEQQ3hcddoMQfpyljbO
	5L/8bUmlTUdqGUYRPUyjH3pmg3CaWpquyzsYU16qvcrkigaa0PTs+iWMeFIesw==
Message-ID: <49ad090f48d0ad38a46642c2ddd019ae3cfebc82.camel@mailbox.org>
Subject: Re: [PATCH] USB: phy: fsl-usb: fix missing static keywords
From: Manuel Ebner <manuelebner@mailbox.org>
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: linux-next@vger.kernel.org, linux-usb@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Mark Brown <broonie@kernel.org>
Date: Sat, 18 Jul 2026 13:30:11 +0200
In-Reply-To: <20260717154957.1853976-1-johan@kernel.org>
References: <20260717154957.1853976-1-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-MBO-RS-ID: defd08d209d5d9186f3
X-MBO-RS-META: qb4kafrytksnh784kfinnqhmnj564f6y

On Fri, 2026-07-17 at 17:49 +0200, Johan Hovold wrote:
> A recent change enabling compile testing of a Freescale dual-role
> controller indirectly enabled a USB PHY driver to be built. That driver
> in turn is missing a bunch of static keywords which results in warnings
> like:
>=20
> drivers/usb/phy/phy-fsl-usb.c:105:5: error: no previous prototype for 'wr=
ite_ulpi' [-
> Werror=3Dmissing-prototypes]
> =C2=A0 105 | int write_ulpi(u8 addr, u8 data)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~=
~~~~~~
>=20
> which consequently breaks -Werror builds.
>=20
> Add the missing static keywords.
>=20
> Fixes: 0807c500a1a6 ("USB: add Freescale USB OTG Transceiver driver")
> Cc: stable@vger.kernel.org	# 3.0

Add linux-next@vger.kernel.org

> Reported-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/r/4f9f5ff9-8eaa-4bd5-9331-37119f78e13f@sire=
na.org.uk
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>

Thanks
 Manuel

> ---
> =C2=A0drivers/usb/phy/phy-fsl-usb.c | 52 +++++++++++++++++---------------=
---
> =C2=A0drivers/usb/phy/phy-fsl-usb.h |=C2=A0 6 ++--
> =C2=A02 files changed, 29 insertions(+), 29 deletions(-)
>=20
> [...]

