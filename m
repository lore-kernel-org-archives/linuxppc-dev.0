Return-Path: <linuxppc-dev+bounces-23861-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C55C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:38:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZKC1shxz3c0n;
	Thu, 09 Jul 2026 09:38:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.86.107.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783535784;
	cv=none; b=kkQp21uB6ON29cQsEiJexTEcUJYS8Cx9gzTH2SG4kscPZYg1cXKSndMmRCbQg9xX3M33XYusP4EXp/whE/sGWK6Ny2atg1+LKQqoME0fwxNaNhIPq5m47ct3YobfWHAdUxbden36pyQKvoaz4XV/aYlxfq9B/VJDGbXlVpbtOcpr77pk8Z7dI1xVRJZqk13HU8Z//jtLoXLZqetX7VNhP0rSs9HLITdwgpkGSUPw42KJFTliB1HzUeM2dLUVSqMb5LYU3NFF93fZ1pVSQNwBrqscmqgTDaFLhLpYW7C7pu0RB41+rkJqoTtS6/B/L/Gp6IBsTaW7LDlw+q1bjDP93A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783535784; c=relaxed/relaxed;
	bh=HOFoesOyB88RJQpCsNVT6CnljJeq85zHo9ievtK6il8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jnkoegsn1KoUQ0ivo/al29JEpcX3IrAj3WVQ/cmfPYl9F29KMQw+qmQ4asdD/UlojGwRpzG3vW2xEvNBPTckNOVDVtiTHDx8CUezDAqRrWxp3OmEFzKxDx0Lc5W2DD3z5okKBpAxRSXRse2R2UfYVV48LOicXx4V5FzW7bSloJ0e673l+UzT2D5ma7OMFxUOsRLvtpmznO/oP3kC07sw6jD25ZIARDosy/1c/2fJzkkX2ellAap0vJM8wYQI+dSEgXwvwktzPSqaFQ7L8jy0wE/35T2f4LdWIIlfqTvY3Ubi3RpP/QKbQpbqRnqP6Gv8A0ss4Bp9S0nLUMRVb44ayg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=R0pckaM7; dkim-atps=neutral; spf=pass (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org) smtp.mailfrom=rendec.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=R0pckaM7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rendec.net (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org)
Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwRd312rxz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 04:36:22 +1000 (AEST)
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id A4061C3435;
	Wed,  8 Jul 2026 21:35:54 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro A4061C3435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783535777;
	bh=HOFoesOyB88RJQpCsNVT6CnljJeq85zHo9ievtK6il8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=R0pckaM7uzKJhnfLsd+EasA5iL0B7ZA4xUo2QedrlgePDqSCeceDdoKrCaUXSgH75
	 15MPZ33HpRCU30hqcMI0PUJAA4ul+9XUwxAhJeXTpBoywEuKewGCk7m21xK7GBO94b
	 NpDa7pro6OWmXqh5IS/WT+qx6ABBrkCA+Kv5g9jMDrLVH+mh9k+/398rw04b/Uiitl
	 a9blgckrqg3HTXMb7xcAzYPWQFRHvTBk4ekkJmwrZessc3xf9tFXhmpN0qrpZBt8yq
	 5Qao1qyCtvtsSHKBGAM0cGKH+LVrTaTCbKcejqQuUrZPKj01pL+BpzMYflQ9YS3rRx
	 JbQnyYBWoKGdQ==
Message-ID: <a8c5cc7d9296d59bf3d5851a3a2ba5f3a271bb9a.camel@rendec.net>
Subject: Re: [patch 05/18] powerpc/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
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
Date: Wed, 08 Jul 2026 14:35:48 -0400
In-Reply-To: <20260707190253.918861529@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190253.918861529@kernel.org>
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
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> =C2=A0arch/powerpc/kernel/syscall.c |=C2=A0=C2=A0=C2=A0 4 +---
> =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>=20
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -2,7 +2,6 @@
> =C2=A0
> =C2=A0#include <linux/compat.h>
> =C2=A0#include <linux/context_tracking.h>
> -#include <linux/randomize_kstack.h>
> =C2=A0#include <linux/entry-common.h>
> =C2=A0
> =C2=A0#include <asm/interrupt.h>
> @@ -19,8 +18,7 @@ notrace long system_call_exception(struc
> =C2=A0	long ret;
> =C2=A0	syscall_fn f;
> =C2=A0
> -	r0 =3D syscall_enter_from_user_mode(regs, r0);
> -	add_random_kstack_offset();
> +	r0 =3D syscall_enter_from_user_mode_randomize_stack(regs, r0);
> =C2=A0
> =C2=A0	if (unlikely(r0 >=3D NR_syscalls)) {
> =C2=A0		if (unlikely(trap_is_unsupported_scv(regs))) {

Reviewed-by: Radu Rendec <radu@rendec.net>

