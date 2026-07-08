Return-Path: <linuxppc-dev+bounces-23858-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7013C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:36:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZH33RPDz30C6;
	Thu, 09 Jul 2026 09:36:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.86.107.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783531617;
	cv=none; b=RRcq2UR+frfnOueVfrwfbAo5PddhOTuragRfOpfZtZfBieQ25Fw0MV3GGJ4yCet532DfXgslFCVmy9KoJDGsuQjvE0t1LpDOBV0GIA/jcWFkPI6D69J+f497lF4B0bHKXzX3f3b/pcE2w+FdCq9GTviKdJ1uFGurtYqHKlnuw6NOGLI4PNXICb1nUV3L8/xXkvEoE7d1dVNLrBIgXnDJHodCys8FXDv4FcJJo7cVOZDU6gYq/wH7JZGi9eVdng4Zi0NbJt+6ceVNwEVopVKj0Z4rImu+0TJSl3GTaKhkDG0yyoyWUuOth/NedKqOJHZkZv2QJIFwohSn8c2jiHmLow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783531617; c=relaxed/relaxed;
	bh=1gcsmXz67IjQqMY0eBQ3O8esAmywA90IGOEUSqxZHJQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F3RprLn3oWfp4YrHyjw6F++JQt1ezq1jKvGSQMMYfgNwuZlUDlG+RE/zjOSo19BCuZCP7K4qq7lYReU3ZvtbfMlqIUpLRkMM9dKw549bWHVa4PHSPfMgf2pcHVMOAyJD7oHZjcsZOZLL7YGchaJQQg6y97T29879VnfKTwgAuzdqGTgs2hcah+okuGHyYk59jZlVUxdcNAxPKzEJgOhgzuJY1PIltIVN/ViVHije/yOiT+bAESJc1Cy9DbXDDg3pTLQcrc9SENqaRTb5+PQZ7F6vtQvdWHjyMyTJi25Fl8JyzCAclufJF6jdO4itcgQX0hLpo8VuGpZdr6QyGjHDKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=Z6pyfRb1; dkim-atps=neutral; spf=pass (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org) smtp.mailfrom=rendec.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=Z6pyfRb1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rendec.net (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org)
Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwQ4w3npBz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 03:26:56 +1000 (AEST)
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 1B198C343D;
	Wed,  8 Jul 2026 20:26:25 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 1B198C343D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783531613;
	bh=1gcsmXz67IjQqMY0eBQ3O8esAmywA90IGOEUSqxZHJQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Z6pyfRb1XnNrJb7Iy5l8RXt+U4vqsGvqqzStbhN7435vjpK29RR4S8ie2UFwESgWv
	 CcSG+nZyfqWkQNIiMihfXIe5SU5d9xFxuT/FVpIkY2si8YfqZBiGdxwpOgc4+v6GTu
	 NSt9pFgzwrUImE/LpJy0sei+Lk+GBqVAsmPsiJ8VtpU8nMjFtYkmKduWX13Ouy9uBJ
	 1ENXVXzDYQWjK4BhPh/7z7U3FCNNVQhlgPxqvAWAfKgmRqCj2sxf9iIIgCC2PgpYcH
	 RSMOv3KD/QpK9l25WlQ3grvgf5R2LttSDjfKaawhSgxe9j5XVHCFPDPCqOj6a4P2dQ
	 eMxeS2+WglD9w==
Message-ID: <8b21dbb1e167b4a50b72613f09fdbb800a420fb8.camel@rendec.net>
Subject: Re: [patch 03/18] entry: Provide
 [syscall_]enter_from_user_mode_randomize_stack()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>,  Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen	
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>, 
	linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland
 <mark.rutland@arm.com>,  Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas	 <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven	 <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,  Helge Deller	 <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, 	linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, 	linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, 	linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, 	linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta	 <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>,  Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,  Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, Michal =?ISO-8859-1?Q?Such=E1nek?=	
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org
Date: Wed, 08 Jul 2026 13:26:19 -0400
In-Reply-To: <20260707190253.816918647@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190253.816918647@kernel.org>
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
> Randomizing the syscall stack can only happen after state is established
> via enter_from_user_mode() or syscall_enter_from_user_mode(). The earlier
> it happens the better.
>=20
> Provide two new macros to consolidate that:
>=20
> =C2=A0 - enter_from_user_mode_randomize_stack()
> 	enter_from_user_mode();
> 	add_random_kstack_offset_irqsoff();
>=20
> =C2=A0 - syscall_enter_from_user_mode_randomize_stack()
> 	enter_from_user_mode_randomize_stack();
> 	syscall_enter_from_user_mode_work();
> =C2=A0=C2=A0=C2=A0=20
> to reduce boiler plate code.
>=20
> Those are macros and not inline functions as the latter would limit the
> stack randomization scope to the inline function itself.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
> =C2=A0include/linux/entry-common.h |=C2=A0=C2=A0 56 +++++++++++++++++++++=
++++++++++++++++++++++
> =C2=A01 file changed, 56 insertions(+)
>=20
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -6,6 +6,7 @@
> =C2=A0#include <linux/irq-entry-common.h>
> =C2=A0#include <linux/livepatch.h>
> =C2=A0#include <linux/ptrace.h>
> +#include <linux/randomize_kstack.h>
> =C2=A0#include <linux/resume_user_mode.h>
> =C2=A0#include <linux/seccomp.h>
> =C2=A0#include <linux/sched.h>
> @@ -150,6 +151,61 @@ static __always_inline long syscall_ente
> =C2=A0}
> =C2=A0
> =C2=A0/**
> + * enter_from_user_mode_randomize_stack - Establish state and add stack =
randomization
> + *					=C2=A0 before invoking syscall_enter_from_user_mode_work()
> + * @regs:	Pointer to currents pt_regs
                           ^^^^^^^^

Nit: current

> + *
> + * Invoked from architecture specific syscall entry code with interrupts
> + * disabled. The calling code has to be non-instrumentable. When the fun=
ction
> + * returns all state is correct, interrupts are still disabled and the
> + * subsequent functions can be instrumented.
> + *
> + * Implemented as a macro so that the stack randomization is effective
> + * throughout the function in which it is invoked. An inline would only =
make it
> + * effective in the scope of the inline function.
> + */
> +#define enter_from_user_mode_randomize_stack(regs)			\
> +do {									\
> +	enter_from_user_mode(regs);					\
> +	instrumentation_begin();					\
> +	add_random_kstack_offset_irqsoff();				\
> +	instrumentation_end();						\
> +} while (0)
> +
> +/**
> + * syscall_enter_from_user_mode_randomize_stack - Establish state and ch=
eck and handle work
> + *						=C2=A0 before invoking a syscall
> + * @regs:	Pointer to currents pt_regs
                           ^^^^^^^^

Same here.

> + * @syscall:	The syscall number
> + *
> + * Invoked from architecture specific syscall entry code with interrupts
> + * disabled. The calling code has to be non-instrumentable. When the
> + * function returns all state is correct, interrupts are enabled and the
> + * subsequent functions can be instrumented.
> + *
> + * This is the combination of enter_from_user_mode_randomize_stack() and
> + * syscall_enter_from_user_mode_work() to be used when there is no
> + * architecture specific work to be done between the two.
> + *
> + * Returns: The original or a modified syscall number. See
> + * syscall_enter_from_user_mode_work() for further explanation.
> + *
> + * Implemented as a macro to make stack randomization effective in the c=
alling
> + * scope.
> + */
> +#define syscall_enter_from_user_mode_randomize_stack(regs, syscall)	\
> +({									\
> +	enter_from_user_mode_randomize_stack(regs);			\
> +									\
> +	instrumentation_begin();					\
> +	local_irq_enable();						\
> +	long _ret =3D syscall_enter_from_user_mode_work(regs, syscall);	\
> +	instrumentation_end();						\
> +									\
> +	_ret;								\
> +})
> +
> +/**
> =C2=A0 * syscall_enter_from_user_mode - Establish state and check and han=
dle work
> =C2=A0 *				=C2=A0 before invoking a syscall
> =C2=A0 * @regs:	Pointer to currents pt_regs

With the above nits,

Reviewed-by: Radu Rendec <radu@rendec.net>

