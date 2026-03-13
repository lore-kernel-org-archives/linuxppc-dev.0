Return-Path: <linuxppc-dev+bounces-18164-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7658C106FD9A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 08:36:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXHsM6kFbz3cJr;
	Fri, 13 Mar 2026 19:36:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773391015;
	cv=none; b=VKnjWjxO1jsCYiLYxGLypH8Y5Rf3daPldvPenwu34iMDeZW69SIGze+kEzp+Zs4ckeLvVDWAqOmvxeN15QGsCttGGPqPma0jbqhYMC5yUwh9KroDvqDQKhLEupqWsIvBHvLYIMK5i/hDdZDnHLNFgbXqpl6MnnWq7AiJQETiJ2JeR6zJbR0DRlmS5e/a0WaUj35aicEq3acXZOn1JGkG7GhLmGPN1R3pzIiV/owPLDtRccAp6TNZg7ev2470o7YfmxTHo3MfeamNwtqXwV4TEgLxRK0FwI2we6L9e7Ew4S7ymAv2Ddpenvi/9PzoIhxywrqY6gwiuipRQjXoqzxMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773391015; c=relaxed/relaxed;
	bh=2nRDxZu+d9TWrj4WVetOFAoz7B787w6aylEKVWKeURU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZ8Q1D48uTtXa+yVR1JR/1TmbCohVZeLQWsZLj7EEznAJhgiyT3uaaoI2d0ayBDsida/P/lyiSji/pbnhXpDY8r/5YT5PZD65n/UjUtdZC3OYOtRrMmk6V4zlFuG/w9zFxhHoRAz253TQvwHEDPaSAhd0ao++s0JkiwGYXynDTjAq7KyE5VrtOCHFTl2KTXlDdvc0Br4jC5JVlMRuKFRaFkQkBktxGa1jdLhAJ6bM0jjbEciSXslhGdm8uEdndlvftVUVY8CiUI4SKbcG1cZB78Eijo0jQqudyatbNTrCrkU8pyLd29kKE6LSpdrOIKbeqxyJ+eA0KT+6vsVKLabBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pEVHVxmx; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pEVHVxmx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXHsM10fDz3cJk
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 19:36:55 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9F5226013A
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 08:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720B4C2BCB8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 08:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773391012;
	bh=2nRDxZu+d9TWrj4WVetOFAoz7B787w6aylEKVWKeURU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=pEVHVxmxlyR1AQS1tR8C2csZ0Qi99RNivHqgeYILFINvq+UgxBXoaqmb2GYX/Ld4+
	 Ggrfr8od449FzPXaxUdGgWt9/wtQ+twSFhI5ShnQhf+y7mcdjLtdJ57IX6OVMgv3Jt
	 xOfteiTDFayLyYkGt8Nn+e+3/sQZlOyOpu4k3d0cYbILyJZ19z4aLF5ss3oSCP/ncp
	 zA7ewy+LaQATTSk1EFJSIoXRBQdGPWQp+wlgdKu9Q4NxiAihO/U3kiiejZdFS5vghm
	 /+oIxRgcMibWkmCXvDtAKs8WeeBa7Hj0DtuJLWDonFuHitIlNZDOZIIG4fL0NK1iRe
	 KnIZQzvHZyJJg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38a2f92fab4so17352541fa.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 01:36:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVk3aPZ1UyTxA+KawXArrXxIGywwvpmmuFugzVnB7VRGB0Rbtx7ureHJol2qdEh01NjnBKXBP2V/wb062A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy54VODFetXjQMPuUs/joqTar/3vhgbP4y9TbpKG3zwEB3RUrSb
	K1AWFOMZwc0RL1hNPCzM6LLr1Xm0TkUQI2qRgHhAmU1E3x4xJd1JAzcdmjJqI2Rb3oJ/ULzOnOG
	5PsqXwYPWHiW89CDIng9xs+t/+pJD0E/v9FZQMP/VCw==
X-Received: by 2002:a05:651c:515:b0:383:20cd:52fe with SMTP id
 38308e7fff4ca-38a896b6407mr7399191fa.17.1773391010614; Fri, 13 Mar 2026
 01:36:50 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Mar 2026 01:36:49 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Mar 2026 01:36:49 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <2026031231-whiff-speculate-805a@gregkh>
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
References: <20260223-soc-of-root-v2-0-b45da45903c8@oss.qualcomm.com>
 <20260224183832.GB3239922-robh@kernel.org> <CAMRc=Mft5vc-C8miKVdw6C-qRdYsqfgm-UgLZJOctFwagMF0iA@mail.gmail.com>
 <2026031231-whiff-speculate-805a@gregkh>
Date: Fri, 13 Mar 2026 01:36:49 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdhhEMJn5JTB3wn_ScmV=a0o6fTnaUDSDjOLN5WH5rOFQ@mail.gmail.com>
X-Gm-Features: AaiRm50bkC2plkyLpch8sSUugz619L6Cf_EZYcxggWcjYtxkwiUVoHYnqPIvC6o
Message-ID: <CAMRc=MdhhEMJn5JTB3wn_ScmV=a0o6fTnaUDSDjOLN5WH5rOFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] soc: remove direct accesses to of_root from drivers/soc/
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Saravana Kannan <saravanak@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Frank Li <Frank.Li@nxp.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, driver-core@lists.linux.dev, 
	Peng Fan <peng.fan@nxp.com>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Mar 2026 16:18:38 +0100, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> said:
> On Thu, Feb 26, 2026 at 10:28:26AM +0100, Bartosz Golaszewski wrote:
>> On Tue, Feb 24, 2026 at 7:38=E2=80=AFPM Rob Herring <robh@kernel.org> wr=
ote:
>> >
>> > On Mon, Feb 23, 2026 at 02:37:15PM +0100, Bartosz Golaszewski wrote:
>> > > linux/of.h declares a set of variables providing addresses of certai=
n
>> > > key OF nodes. The pointers being variables can't profit from stubs
>> > > provided for when CONFIG_OF is disabled which means that drivers
>> > > accessing these variables can't profit from CONFIG_COMPILE_TEST=3Dy
>> > > coverage.
>> > >
>> > > There are drivers under drivers/soc/ that access the of_root node. T=
his
>> > > series introduces new OF helpers for reading the machine compatible =
and
>> > > model strings, exports an existing SoC helper that reads the machine
>> > > string from the root node and finally replaces all direct accesses t=
o
>> > > of_root with new or already existing helper functions.
>> > >
>> > > Merging strategy: first two patches should be either acked by Rob or
>> > > picked up into an immutable branch based on v7.0-rc1, the rest can g=
o
>> > > through the SoC tree.
>> >
>> > SoC tree is good.
>> >
>> > For all but patch 8,
>> >
>> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> >
>>
>> FYI Rob also reviewed patch 8 now. Who would pick the patches up? Greg
>> KH? There does not seem to be a centralized SoC maintainer in
>> MAINTAINERS?
>
> Sure, let me take them now, thanks.
>
> greg k-h
>

In the meantime Geert sent an alternative to patch 8/9 so this single one c=
an
be dropped from the series.

Thanks,
Bartosz

