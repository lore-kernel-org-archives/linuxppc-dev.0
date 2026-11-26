Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B65606A335
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKjmQFPo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZy7510mcz2xlq;
	Fri, 27 Nov 2026 00:28:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795699729;
	cv=none; b=jpjt8cpwYoAS2GszUgjDpyG6q38DHlFoDP8ABA4XfBOfslGgb1TziI79qEVpqnhFB1P+OfKuDVSSn8Op4f7LxqFeiVK3/CNIdJ0Ev9O4LBycjtSZubYpl/ey5iwz/yKrZfJkFfmGBTTtsfimuVdMzQW2pxnUWEOfm/YnGtLjhS1SKFFr9TXH+/OvEMiWgi2xPtczphXU0HdT+80TZihy/CZX1MiW6aQV1dED2QgXv9tXyCuUuhuSKgkA14ABgEspxLPVsgiLQ/7xEz41oxs6d6y3mkfZgGzoIRWcB1F/6nRCMPRy6oBM+kCmMU5itzjk+2DmzlFA7IqmGTkT1ywNDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795699729; c=relaxed/relaxed;
	bh=cjfeIB7Jh9Ac/AfayNnL1Yf0x7S27z/ryKSokFRvmis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eO+wLNg0axrpIzL4pV+rsFEvCGtc8Ey9qSkOhy7j+v2N788u96C0TGfHEOlvod38BbrLwHBhnvyURR6TAE+xWB7Slo2UuPs/kozZBeTApgM+xPWcpVgdKL+IOPEn0h2t945k5i3dKNL4AxJXyK+fVB7pR8KZA7HAC+nmYj1ARggwcfzWbKkv9qnuwiHDT6kjOAMpBsi+3d7qWEq0AD42tjDFXc8Xc0F0reqew3dBKAfkI9he6OsLI0hyH/AYOP1hNFqT1uFDGPeRI6Zvu4uZ9OR0z0IFBTapZMt5RD5DZHJv4DrkV5hTc7P2571SU5D/gjd5osvp+TggpauUG2sOxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKjmQFPo; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKjmQFPo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZy7414Tgz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 00:28:48 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2AE4063365
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 13:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601EE1F00A3C
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699724;
	bh=cjfeIB7Jh9Ac/AfayNnL1Yf0x7S27z/ryKSokFRvmis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OKjmQFPo1M75NXkW1bHMDWybQdIuae5BfdUB+xGnCd8WnZUl/pDfDcBO7rB3WwRBS
	 /Ob1mY//DhcXEHQ/uv6PMdV+zDPkCmw026DdqzRidvVfO57zNsZ5lx19VY8mEJEfRI
	 NbQBvzhp+gPFFwQBIh98wVGgz0sVb5J2qhuKj3w2sLjZLC+2Jz3xd/iXOMiHZuSFhu
	 VXk/8CCos/vN9KGdGMsSfxA8Ueh0PcXCmFe3AY2A44UJ4PQrSBxPd/ZTi4mfET6X/v
	 ExJt6R9GcDL0CkqyBHW7iQlwm4AKk2/6tvRSIaioKBzEDyuHPX6sX/aLjG/Prito3n
	 cJnEjZgWJdwjA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c08539c827so5529564e87.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 05:28:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGGoWin9j6/rdVQ2POgFR/W8ephYm8HA8ed/suuQ4k6G+JNDN/nONImSceip6HppRUIO7dP8GJTQvOsUrY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9vMHLu6bBW2t2TrDgAywi9gtSJTCb6S6RIJkvD4sj2ahvHF4Dx
	EtYv48Cx4zzMHG+/OXaT3YHak3PG/0PwOl9Q1XpJQQtimEoxsQh3FUF+dZoq9Z+N4Vn2x3aXGn9
	c/xrSyJGXJ5vjnPoKvpU50bW4bqRjgaQ=
X-Received: by 2002:a05:6512:124d:b0:5c1:56f2:fda4 with SMTP id
 2adb3069b0e04-5c1bc89530fmr5518571e87.49.1795699723141; Thu, 26 Nov 2026
 05:28:43 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116124832.662455-1-arnd@kernel.org> <20261116124832.662455-8-arnd@kernel.org>
In-Reply-To: <20261116124832.662455-8-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Nov 2026 14:28:30 +0100
X-Gmail-Original-Message-ID: <CAD++jLmT3dgWNhwXnxBbMWT4FPtM85j7pGqphVhofVDn6bgq4w@mail.gmail.com>
X-Gm-Features: Aa3M54qt87pVcinKxHwHL_cdEyu5uWkoYM1H8TRwnc8234Hd9kxa6PUDkX4jAZc
Message-ID: <CAD++jLmT3dgWNhwXnxBbMWT4FPtM85j7pGqphVhofVDn6bgq4w@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] ARM: defconfig: turn off highmem in favor of CONFIG_VMSPLIT_2G_OPT
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, 
	Andreas Larsson <andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Malin Jonsson <malin.jonsson@est.tech>, 
	Matthew Wilcox <willy@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Nishanth Menon <nm@ti.com>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 1:49=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The multi_v7_defconfig and omap2plus_defconfig attempt to support a
> broad range of hardware. This is at odds with the setting for highmem
> being slowly phased out on the one hand but still enabled by means of
> CONFIG_ARCH_OMAP2PLUS_TYPICAL, leading to a default CONFIG_VMSPLIT_2G_OPT
> split.
>
> None of the upstream OMAP2+ DTS files actually list more than 2GiB
> of RAM, so it seems fine to just turn off highmem by default and use
> CONFIG_VMSPLIT_2G_OPT from the defconfig to still support the same
> hardware but not require highmem.
>
> This also changes multi_v7_defconfig, which currently supports all sorts
> of ARMv7 systems except those that require LPAE.
>
> The best comprimise I can think of again is to use VMSPLIT_2G_OPT in
> place of highmem. Compared to highmem configurations, this should be
> an improvement on most machines with 2GiB of installed memory for the
> lower overhead and complexity, but it does degrade machines that rely
> on highmem to access all memory, as well as reduce the available user
> address space (1.75GiB instead of the traditional 3GiB).
>
> For aspeed_g5_defconfig, the decision is trivial, as there are no
> 4GiB configurations we need to support, but g6 is known to use
> up to 2GiB.
>
> If you run into problems on production machines with the new default,
> with the absence of highmem, or the smaller user area, please complain.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

