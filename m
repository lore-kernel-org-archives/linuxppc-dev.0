Return-Path: <linuxppc-dev+bounces-24582-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BC3C4451C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 08:17:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h49HR6M8Sz2xm3;
	Tue, 21 Jul 2026 18:17:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784621875;
	cv=none; b=HlUqCXc73Y1O9279YQq4Q8RqA60jitd4QEjwLIkgZm5POdBgehO0UT7HA3ZOXikRHvyZPJ3YQusfKOjHD1XIlMaRRdFbKNFXxB7+e+0iGiJnPI+MgzGT5Ht2tj8Rgmp0tDR1SsciccN66ik6qtnOaswU/d5qy4RPeKyMTsEgnSdAM0VnWqNJuwlmcbVzpy9UkwQT329htPlrN/9Fqj100PRVh0l4nm6ZQZiQ68CcWdaKL3f2QTFfnYzMmq1p3XswgpVPCUzVoq26vxGuGUYilE9O6bAvc+5Qt2ExxnHqhrPGnk3p1HOh3SQhmn7vEsuoSsP/Bj/XFGzcCQtRNbGSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784621875; c=relaxed/relaxed;
	bh=T6g9AHg6Msysl37eYnjnLtQmEqUs+OTtZKGs9WFjvSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ivPSH4sQRqYDuGyCD5cPLyZOmvttbDgwjw+wJw5pRZaq6gJgP79JuwG7ZIIOMpeX83zgk32nAY8drvJ7ziGL+FBdVZ6FdDGRp4Iaq7S0bZYACviVaqro0gjleEIPi5QOTYBN34PMD7TV08WT9ojkc1RpszfEduJm+PpXP0jhHEw4hc5qwXpz0C5uWDmAliE6iTi66LXL46dYYJCOD0EewZlua3xUkLGEV7M7Maz4edPMlbUEapVZF9HnoC68n/d23hN85Wsym4HdIj1jS/3kNR7QDW8IxA8XXohpZRmoPFK02Z8o5WxaNNv8rHtsbyGWlgV41/t/4w9KLOTeP8THuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzjjESdF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzjjESdF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h49HR06g1z2xlb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 18:17:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 684E260A9B;
	Tue, 21 Jul 2026 08:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7485D1F000E9;
	Tue, 21 Jul 2026 08:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784621872;
	bh=T6g9AHg6Msysl37eYnjnLtQmEqUs+OTtZKGs9WFjvSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gzjjESdF8CyzkjGgzLW39bNILuphzcta3sLi1URSjyAFzJLipC3UmTrXu3jFFA61P
	 pi0PV5sSxroT5MC4vSB4irmB8zkSTQpTKtCfEXUbyhmwF4wWaIQ7lbNCZq0H7DmKFK
	 8I7OxSO8hwMcqfwnwS7791wWvgudq6KYGJc2fT4Fg1b9+hIgTc7vYx2BwdLm81gs4i
	 wUS79qiWoSovsixtK4st1zKQHQc+AVAWsjP8+JuFDiWzJmzXtUEBmK6h+qeN8XDX1T
	 q37KCU+p9yvcznsgWiTAyqiGmNVH8Q7lJHO4++M0Slhqh7kAciZtfiGRWhaqAlyvHz
	 9t2nZgwHDG8hg==
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
In-Reply-To: <CA+=Fv5Sd5+-K3-MOiEc2N8z_5CoLQPVPUwjiugSj3u8cBWJXXQ@mail.gmail.com>
References: <20260707181957.433213175@kernel.org>
 <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
 <87wluplb6k.ffs@fw13>
 <CA+=Fv5Sd5+-K3-MOiEc2N8z_5CoLQPVPUwjiugSj3u8cBWJXXQ@mail.gmail.com>
Date: Tue, 21 Jul 2026 10:17:49 +0200
Message-ID: <87ecgwlpsi.ffs@fw13>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Magnus!

On Tue, Jul 21 2026 at 00:01, Magnus Lindholm wrote:
> On Mon, Jul 20, 2026 at 9:21=E2=80=AFPM Thomas Gleixner <tglx@kernel.org>=
 wrote:
>> If you want to base your stuff on that for 7.3, I can add a tag which
>> makes it immutable so it can be pulled into the alpha tree.
>
> Yes, please. There is still some ongoing testing/review of my Alpha
> GENERIC_ENTRY series, but assuming it is ready in time for the 7.3 merge
> window, an immutable tag would be very helpful.

Here you go:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-for=
-arch-07-21-26

Thanks,

        tglx

