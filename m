Return-Path: <linuxppc-dev+bounces-22160-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE08CD8C8E
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Jun 2026 15:32:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYK0t3nNyz2xlV;
	Mon, 08 Jun 2026 01:32:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780846334;
	cv=none; b=IjxWsrB6Pef2fiJ6tS3oDE+ERAquPS+FvFlYrDp/ZRMRUffLT9ZGMcX/DU5cLnb/cq4EpW9ipbCJ9S6aAcq+cCesdbFenhpa+poh+tdbterymaJZBem4r2rm3xxfyKpVp8rfGBcvUsklxCpAFPngEGL8ZW/905hgqoGroKEcM4kgqltZwtTYkYRvOTkZwWMOzmn2rwWf3T9Ih3DHXBcIKhgug8En3F166TE2Ky6GHZdnZjG1Zf6JG5ikG0MEujyvpUKhVIGFW9nS+HeozIVKwm8dORjGOwQKHA75VRM24mzrAM1d99IuCrLxghRTI1XlukKgr3f2Dx5+lOMoQEGYww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780846334; c=relaxed/relaxed;
	bh=9n5oaUj9TttvQUPf+gue7qUfKTd9DGiITCtTFeddBFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyvRi2WitrkaLH6x/65YSG+6o4tU+lho4JH8ff+hHRYptF9DfGSPfD/ULpZgkqcN6x2sRyppbKsJccZftynnUfXaPas/kotxxzk1V3ja+G1b47btzJejpbK1UdTiXjmEfrEwKc5a5v2ubL2Gw7yyHeRooeVI0PceY51pnYimEBpzK16n/R2pbOBP4STnAccl4nBzsKMISR+E8GW/D7xeELqLlGAOEvLoZMGPENUhQoxkiZyvemSLVNxczDWpcbl4z4+RRcxUnC+avkp3xfE219QcmzozCbO1KsvRBrO6jq/7WFpy1LUwXvFBHgdhf8nXMYpw0JcGrwx/nzL3f4sPrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=KP2vm+9s; dkim-atps=neutral; spf=pass (client-ip=212.227.17.22; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=lists.ozlabs.org) smtp.mailfrom=gmx.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=KP2vm+9s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.de (client-ip=212.227.17.22; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=lists.ozlabs.org)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYK0n2nm8z2xl0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 01:32:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780846299; x=1781451099; i=deller@gmx.de;
	bh=9n5oaUj9TttvQUPf+gue7qUfKTd9DGiITCtTFeddBFQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KP2vm+9sBjpcX73PwOBUtLWK1oV4CDB53IsXbiSBKGqj2YcGmDpxMEhw3rJVcvPP
	 F15JygExbSQpWkK8MSnwvb8hBVeuPxaBp8Wgp7MyrRP75WThspEsRYILEzHItlI5R
	 G5iLumUB45hUSHCK6TWNrlOj06h2ppnyy1XfR4v1KJmgit8lpwC7z5AHDbYGBnXDq
	 8H+Y3/tcpXILobPNg97OlKYs6xgKZ9oAMpa7CUN2t09hj1dfDjfWQjzpJ4inKvwQg
	 fjtusX4GA4gJjZoHpeKgJqzjQjpw1nGJfBavZYuZ0oVwwBrNV5+w7HWDWBOIXvQJ0
	 Sp6m7s0vlxtMUPr2mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6qp-1x3QQr3ibj-00ZOg8; Sun, 07
 Jun 2026 17:31:38 +0200
Message-ID: <b1f96555-e222-4efd-8eed-963ff4f94ecf@gmx.de>
Date: Sun, 7 Jun 2026 17:31:35 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] fbdev: Internalize fbcon
To: Thomas Zimmermann <tzimmermann@suse.de>, geert@linux-m68k.org,
 simona@ffwll.ch, airlied@gmail.com, lukas@wunner.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260527151551.258659-1-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260527151551.258659-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kdYW0vmi/C5c3FWbBM5rxOEiduxOc1eBP2SQ9iRtDNKHFnGQl+Y
 Js1o7u9fgzZ8DUuZF0E9VpGcR1wshDG7v8vnvfSAZYgLlBwsym+7oZryyIRnORMLhrodFa0
 ylj1eWvahsdX6Y4EdNZkNg+w+MF5yF5uFLvBLx/A45uyoqvAvwe2XgsSH5K0iNWprSAHkSI
 P27yExXZIBy/vpKMzhRQA==
UI-OutboundReport: notjunk:1;M01:P0:CSgO2upRJZE=;6Mu7EJYG6q4uwMmn3UPhadhkEIp
 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
 FdO23vUvBS77qqcwrZ60nZEQ==

On 5/27/26 17:14, Thomas Zimmermann wrote:
> Turn fbcon into an internal client of fbdev. Manage all interactions
> with graphics drivers within fbdev. Add helpers for these tasks and
> convert drivers.
>=20
> Fbdev's PS3 and SH-Mobile drivers update fbcon as part of user-invoked
> mode changes. Call the new helpers, which also fix inconsistencies
> among the various code paths.
>=20
> Vga-switcheroo remaps the fbcon terminals when switching physical
> outputs. For now, hide this in another helper. The call will later
> move into DRM's fbdev emulation.
>=20
> With all refactoring in place, fbdev manages fbcon interactions by
> itself. Remove the public interfaces.
>=20
> v3:
> - resolve vga-switcheroo dependencies wrt fbcon (Geert)
> v2:
> - use '#if defined' (Helge)
>=20
> Thomas Zimmermann (4):
>    fbdev: Wrap user-invoked calls to fb_set_var() in helper
>    fbdev: Wrap user-invoked calls to fb_blank() in helper
>    fbdev: Wrap fbcon updates from vga-switcheroo in helper
>    fbdev: Do not export fbcon from fbdev
The v2 series is now dropped, and instead the v3 series is applied to fbde=
v git tree.

Thanks!
Helge

