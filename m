Return-Path: <linuxppc-dev+bounces-24249-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE52C44508
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 15:23:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h033n4dYnz2yH5;
	Wed, 15 Jul 2026 01:23:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.86.107.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784042613;
	cv=none; b=l3WkgI92bDzamLf0TR7jjGH2XYhrwjUEnPvCBYmw8gpE6iVEFgzc2qXnNpdT2TJJA3h8h8T3uQK3KOvIyGZjccNByKlFznpLrQTBdzCeZKJfyOlAc+ZDkyMZIUncMDVozDxPhysX4aIF1wseLSdakF48bkHiQPVy+O2Jfbfzq33r+gIuK8LQ9yT/leH98syrJHcZ/KOLgpkVEKNkT6eMPdFsoKyv5Yvjoz60MgBklvCCPn6i1wDWZdCGCBo0NyOA1r1qRw+JAfS3BA2hLgJd+JdmYEYaamGV4PVWAe/PnEK3NveFOo3HPMHJLzsBgCoDGS+CBHo/N43MmdrqB5mxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784042613; c=relaxed/relaxed;
	bh=WOpcFbjQEhRjPrDCcWIUFFBWvc4u//IvEcN3XAtJ46I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a/f4NW2WoMEUIAJ2J7xYZ4By8KsXagc9kAkoyVW5d6x6KLUtPb+0D9n9gVZy03ub+WF9r0L2Np9a1T3cr5LHED9P3IGVikZ/Y6j7tjiVSxya4PNxs2kwOA/v9Tmx+WP3a8mRRqqclPgks+ZVzLjcgpTE+bT6Q5wvOTsmiS9rP5lmXtsry8XNDbq2rbqmOWMWdcwJRBE4hnxPZ3OD4uAGhEcGuw8PWOGQdzPWmhQAuFSasYzEVC/aYwwJ6xtHQl9a81wEUA0z8/s5QiQ0kHZoh/MJ8pvtRz0Jdz2dv2Xl6QobN6mTi8hjatlebE4F1uNS/idUnzLWuGAI0W1VOurRNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=NV0vXk8z; dkim-atps=neutral; spf=pass (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org) smtp.mailfrom=rendec.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=NV0vXk8z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rendec.net (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org)
Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h033l0pjpz2y7W
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 01:23:29 +1000 (AEST)
Received: from bat.kanata.rendec.net (unknown [24.114.105.230])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 58080C2C75;
	Tue, 14 Jul 2026 18:23:15 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 58080C2C75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1784042604;
	bh=WOpcFbjQEhRjPrDCcWIUFFBWvc4u//IvEcN3XAtJ46I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NV0vXk8zgJRLB4TtiCBgyeC9r0tDdcneBcb9wPunGxkt0IKYL3V3oFKcGY5VDzgyB
	 Qh/m8oD8LhVi1YOubpwGJCzzpJkvbVs+/C7SpT0eBLs6j2D9LC01WQoJevg+YaxeP7
	 Ch7a6ki6Pr+ZxagiEAWxYNM91lMjUP7v7VU8+VBfhBVCnIyf2AfpbY8o00oq1ARHfx
	 ufS87s6adDnBw8zOd3lwsGeZmOenN4AaIMQm9evAXHQOA28DvO+bDbE0lfPGsOErPt
	 xi2vbdX0VrCsKrlSVW9ZFCkHw3ALvgdXIVgUO0XIk014YkUnKwqRZzed8VzIRlFPzw
	 hWwXWveUqEvoA==
Message-ID: <2a8d25c1645cbc570d9da8dfc3043bc9d2f39cd5.camel@rendec.net>
Subject: Re: [patch 1/4] entry: Rework syscall_audit_enter()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Michael Ellerman
	 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt	
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle	
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland	 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Magnus Lindholm	 <linmag7@gmail.com>, "Mukesh Kumar Chaurasiya (IBM)"
 <mkchauras@gmail.com>,  Jonathan Corbet	 <corbet@lwn.net>
Date: Tue, 14 Jul 2026 11:23:09 -0400
In-Reply-To: <20260712141346.576865340@kernel.org>
References: <20260712134433.549076055@kernel.org>
	 <20260712141346.576865340@kernel.org>
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

On Sun, 2026-07-12 at 23:25 +0200, Thomas Gleixner wrote:
> Move it out of line and let it reread the syscall number on it's own. Tha=
t
> makes the low level entry code denser and allows to move the reread to th=
e
> call site of syscall_trace_enter() once the tracer is fixed up.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
> =C2=A0include/linux/entry-common.h=C2=A0 |=C2=A0=C2=A0 14 +++-----------
> =C2=A0kernel/entry/syscall-common.c |=C2=A0=C2=A0 10 ++++++++++
> =C2=A02 files changed, 13 insertions(+), 11 deletions(-)
>=20
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -60,16 +60,7 @@ static __always_inline bool arch_ptrace_
> =C2=A0
> =C2=A0long trace_syscall_enter(struct pt_regs *regs, long syscall);
> =C2=A0void trace_syscall_exit(struct pt_regs *regs, long ret);
> -
> -static inline void syscall_enter_audit(struct pt_regs *regs, long syscal=
l)
> -{
> -	if (unlikely(audit_context())) {
> -		unsigned long args[6];
> -
> -		syscall_get_arguments(current, regs, args);
> -		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
> -	}
> -}
> +void syscall_enter_audit(struct pt_regs *regs);
> =C2=A0
> =C2=A0static __always_inline long syscall_trace_enter(struct pt_regs *reg=
s, unsigned long work,
> =C2=A0						long syscall)
> @@ -111,7 +102,8 @@ static __always_inline long syscall_trac
> =C2=A0	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
> =C2=A0		syscall =3D trace_syscall_enter(regs, syscall);
> =C2=A0
> -	syscall_enter_audit(regs, syscall);
> +	if (unlikely(audit_context()))
> +		syscall_enter_audit(regs);
> =C2=A0
> =C2=A0	return syscall;
> =C2=A0}
> --- a/kernel/entry/syscall-common.c
> +++ b/kernel/entry/syscall-common.c
> @@ -1,5 +1,6 @@
> =C2=A0// SPDX-License-Identifier: GPL-2.0
> =C2=A0
> +#include <linux/audit.h>
> =C2=A0#include <linux/entry-common.h>
> =C2=A0
> =C2=A0#define CREATE_TRACE_POINTS
> @@ -21,3 +22,12 @@ void trace_syscall_exit(struct pt_regs *
> =C2=A0{
> =C2=A0	trace_sys_exit(regs, ret);
> =C2=A0}
> +
> +void syscall_enter_audit(struct pt_regs *regs)
> +{
> +	long syscall =3D syscall_get_nr(current, regs);
> +	unsigned long args[6];
> +
> +	syscall_get_arguments(current, regs, args);
> +	__audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
> +}

Reviewed-by: Radu Rendec <radu@rendec.net>

