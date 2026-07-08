Return-Path: <linuxppc-dev+bounces-23863-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD654C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:40:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZMd2tYBz3c1Q;
	Thu, 09 Jul 2026 09:40:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.86.107.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783544252;
	cv=none; b=T6BqVmz233x6PgbXOePY6EQDtscgtjaf4G5fQouvUTKNNHTCaU0XgwXpAyUs4irHp9x+OhjdVOAvZXdx+riMRj/+VCPxesL5yrIQyioYUjtvbQarn/w4HJKKTc1xqitzdoI6dgfhJGN9u/VCDeArKUWUXhQupMKOLRsMylXbBDji/sHstZHW76Y2fJIp9UAGqAM8usqRh5Eh1TrX+L1GIOh68k1nBtch/eLKAOIbPMNFvsJlLCQ3sDAqX62d6hp+M8kMJqZl+CwekScd/3AFKSni0ZQmM/ZdMxoFS3BLnnGRUBTDJfYA71adydHDO2K05bkfBBk5w8gneEMeMjTdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783544252; c=relaxed/relaxed;
	bh=up349XAcstBbuMmtgpGoCSrvvL3bQC70drCvWmoD2ds=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e6Y2KIOUMh1YzQfqErI2kzWAcBLYhWIQQi46Ef2fD7Aotm3TWQm5j8Tknu+/POX/Y+C97ziPBiExS1C+4d9CYiXEaMr6ZVfoagZlUrjw5colirYOLl9FG1aWA1YMvBekeb//aIfnVsJv4RE5vtkTSGVLLjFeovuwvqFkj/Qr0Es7zK8SspTGE0EUJKnFNJ1NM39o6L9X7Gjnb4VaIS9OdMXypCL5c2QDoWpE0nO6pkc3W/Nde5g8ZrAWSTHwx3jb4TzB+MHuCTgLCFF59dQ6KUi/xFCbBWHBOOffEgH9GlRwsLY5TDaAGKluDASlJF60pnkZo3uwb5aTxty2S4w6Rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=ynS36ddU; dkim-atps=neutral; spf=pass (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org) smtp.mailfrom=rendec.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=ynS36ddU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rendec.net (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org)
Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwVlv2ZYYz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 06:57:30 +1000 (AEST)
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 276CAC3437;
	Wed,  8 Jul 2026 23:57:05 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 276CAC3437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783544246;
	bh=up349XAcstBbuMmtgpGoCSrvvL3bQC70drCvWmoD2ds=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ynS36ddUdp8eq69SvUl6OgUXVC9QL2tj6JdfNjNoPXNVKwC/3CN8EubMigM7yTWhw
	 wN2l7xiScOadwqXH8k1Mr6pkHvNMtNLdr91wDtAcHVTHHdPCMoFrB5PPDCaDQEpQ/7
	 nrAG0UN1qXnV/0+w7ire/3DQ71IknBguOljyr+0fQFSjwNiLglUjXiqoASKEjWfiP9
	 hdpfN4vBD8SgIx0jZq/vsbn+u9RcOw90ghJIPsraTy3Kmn5rysmmntnF1EMEJ6MLYT
	 FeMAfAFofJ6Q5u7zyyWHuX3D2olPOI2XjVzaGihUsp+73EBHAshY/LugN1FUs+Ocpp
	 c1dTfe4hj1cHA==
Message-ID: <a8aea664b6dbe92a3ae0c2f084f5c9b1ce591792.camel@rendec.net>
Subject: Re: [patch 06/18] riscv/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Michael Ellerman <mpe@ellerman.id.au>,  Shrikanth Hegde
 <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>, Huacai Chen	 <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Sven Schnelle	 <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland	
 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski	 <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson	 <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>,  Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,  Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,  Richard Weinberger	
 <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann	
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>,  Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, 	linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, 	sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?ISO-8859-1?Q?Such=E1nek?=	
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org
Date: Wed, 08 Jul 2026 16:57:00 -0400
In-Reply-To: <20260707190253.974626922@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190253.974626922@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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

On Tue, 2026-07-07 at 21:06 +0200, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
>=20
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var=
()
> as that code is invoked with interrupts disabled.
>=20
> No functional change.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-riscv@lists.infradead.org
> ---
> =C2=A0arch/riscv/kernel/traps.c |=C2=A0=C2=A0=C2=A0 5 +----
> =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
>=20
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -7,7 +7,6 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/irqflags.h>
> -#include <linux/randomize_kstack.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/sched/debug.h>
> =C2=A0#include <linux/sched/signal.h>
> @@ -333,9 +332,7 @@ void do_trap_ecall_u(struct pt_regs *reg
> =C2=A0
> =C2=A0		riscv_v_vstate_discard(regs);
> =C2=A0
> -		syscall =3D syscall_enter_from_user_mode(regs, syscall);
> -
> -		add_random_kstack_offset();
> +		syscall =3D syscall_enter_from_user_mode_randomize_stack(regs, syscall=
);
> =C2=A0
> =C2=A0		if (syscall >=3D 0 && syscall < NR_syscalls) {
> =C2=A0			syscall =3D array_index_nospec(syscall, NR_syscalls);

Reviewed-by: Radu Rendec <radu@rendec.net>

