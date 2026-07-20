Return-Path: <linuxppc-dev+bounces-24530-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7A0C44520
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 19:21:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3r3H3khyz2xqJ;
	Tue, 21 Jul 2026 05:21:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784575275;
	cv=none; b=EkfJ06FrEAocrZZegsQkgAyopfsJubliL2Eyx5bELCVJxdsqmca4a1BS9yiGMjm9Q+iD/BZmJakUozcr7uVttEPitcU1tIgwgNKUbIY8EdQZCPQSxrJBDsfyzs/eZbpTVJR2M02rq1x9OrFPZ5jLLHBJsnK2iy155twqmmSX55IuVM/icwKIQoWm0a8mEH/aFSkw8sTukYciNwAf4DsKOHdgCj46oI7zX/QpxTlwtlCtQgboN6x3MsDe26UAn6o/k1tJesTU1GdtfmMBMIEEE66IsXtVaVZITAoHTFS6oyTaVPaVuIUgrNd4HfOQn+tAC96WRpQLUOCC0nSwlePjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784575275; c=relaxed/relaxed;
	bh=y4vTZRCmYUoacTgRQeb9iD10u8BLXmQ5njXvIgguyco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZVwSb5/H+U20jy2h5jckaQdfVJ0A2r3DeKtPmj1rQu2dX5ptLI8ckNYzbwiIgzN3ie4tdUzrHuE0f1a1zDCDpNmAlNfQejcKK5LxS/vKcl57j6rRqZfXwGVDBa542qF5/xpIcNeqxTeyUlltZ0Bo9/sGUbbxKFzfyxlPpeSuLhhG+jePnjtWbwhWzBt2My633HBhBKW/ZbOlGAQYkor8PluRvJpfvmxDOuFW/N2XOgNPd+71XgbEDC4ge8agEQP5TEQAEqJy8bIILkq4Tkyu5C3Ms55PNpRDv6G2h9gXhitaSpDTtZjFc313XcmYDsicB4srMqczAmRCdfkOmCVqnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Spav0GWz; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Spav0GWz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3r3G1ZcDz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 05:21:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A5984433B7;
	Mon, 20 Jul 2026 19:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC12B1F000E9;
	Mon, 20 Jul 2026 19:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784575270;
	bh=y4vTZRCmYUoacTgRQeb9iD10u8BLXmQ5njXvIgguyco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Spav0GWz3rWmeiOvTkSHmoLaFmA0dsmghrTMMUGIy7BsnbqtE0r1vEIJpGCtqeWB+
	 BpTJQ6xzB/KOaDAAkoTPfDvyF002TmAYBtSyKK5uExFq/Cj1mLr43Z33qJ2sRMi9Nf
	 nJuZqLg2J7TvcdvdFpFOL3PuoTONb0yf3DbORivGivTO7zCY0H72Bu+OkktKpqh03L
	 Vksh67h0wy7gmPYEI4mwGb9sleMrzw8Jsb1sLuHLmScVy2tv/f+VR08LYTxzvzqe4C
	 b/ZkM/7+AGeKxhezpkSh009TVoxiBEuZvcET+KD3PE+3fxGAVYAS/3R9Y8DzfgWlkp
	 U2Lg+Wsg/dkOQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Shrikanth
 Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
In-Reply-To: <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
References: <20260707181957.433213175@kernel.org>
 <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
Date: Mon, 20 Jul 2026 21:21:07 +0200
Message-ID: <87wluplb6k.ffs@fw13>
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
Content-Type: text/plain

Magnus!

On Sun, Jul 19 2026 at 13:25, Magnus Lindholm wrote:
> One Alpha-specific wrinkle I hit while rebasing the GENERIC_ENTRY patch is
> that Alpha cannot unconditionally pre-seed the normal -ENOSYS return state
> before calling into the generic entry code: syscall_set_return_value() also
> updates r19/a3, which is still syscall argument 4 on the normal entry path.
> Doing that too early broke early userspace mmap() during boot.

Similar to what Peter and me suggested in the related discussion
vs. s390 which has a similar issue, you can just have a dedicated
syscall_return member in your pt_regs struct, which is preset to -ENOSYS
and operate on that. You have an unused padding entry there which means
it won't even change the size.

> Are you planning to send a v2 with the seccomp recheck fix and any other
> review fixups folded in? Is the intention to route this upstream
> during the next merge window?

You were on CC for the V2, no?

The whole pile including Jinjie's seccomp bypass fix is in

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry

and is targeted for the 7.3 merge window.

If you want to base your stuff on that for 7.3, I can add a tag which
makes it immutable so it can be pulled into the alpha tree.

Thanks,

        tglx


