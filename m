Return-Path: <linuxppc-dev+bounces-24250-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C17C44508
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 15:28:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h03B05LNTz2yMn;
	Wed, 15 Jul 2026 01:28:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.86.107.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784042936;
	cv=none; b=VQYA4uPhnMOmENT91YOi+rmz1/bMl5PIAxD3zpmUH2SOXK09zM4OJXfl3EQW5TXgeCKs/krK704hBv9a73dTOn3dwI785fr48uIhpjilyYC+Ab7uT4uvJc9lCdocJ3lPjhOHtowxuu35O8vLxPacPK2AGM9EgSHm/Usqmxr09XNX+WANE2leVF31jge9O1N5MIykNr7iWTHGzfu1kvqIAWqX7FCqCjEe+NBoH6vUbW862YDGyflxoVF2+aV+lo8888Nlw5mk8C3KzCT8JVMMvUWredYu27OrXGcM0KWOip67iWcNb80iFpM2ZRBnEbQn1rhkT3/G1M+70htWo+2XcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784042936; c=relaxed/relaxed;
	bh=oWZluxV84siLpiF5+zUyziImhfWV+NEScMbyx+dvzBs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J5gCRvP0dKWs1EFbuyF8ml+DtXkrVEakL17JaScFbmVjZCL2gNPrUoECHKK5IF8ojKApWitXKKZT2QaCn1tWpJKm5Ul/Xluqe8r0EDnC/slpNxiCGuI6NBKSkX3ZkOJx1ZUw1k8CCcQy161wgVROmM5YR7i7d+2OBDIJPt6yCwSXNrEnBVXvtJONrCc4YrOP26yIpb/sYZm/2ZDTux47ym2V+i9F22/cwYEyEB9uHu86NNGSeBWf5Z1S+deeLtG3ryTk56B2wDIQHl8tn6wwq+gBHUQV6hQD9HFs8dY//V+BvZ2aRmbTFCYnds2XDGCVx9Cclu55Prz+dUX/RG1pfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=Vbg3kCjO; dkim-atps=neutral; spf=pass (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org) smtp.mailfrom=rendec.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=Vbg3kCjO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rendec.net (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org)
Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h03B00FbQz2yH5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 01:28:55 +1000 (AEST)
Received: from bat.kanata.rendec.net (unknown [24.114.105.230])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 68B74C2C75;
	Tue, 14 Jul 2026 18:28:44 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 68B74C2C75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1784042933;
	bh=oWZluxV84siLpiF5+zUyziImhfWV+NEScMbyx+dvzBs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Vbg3kCjOcEIDdoCRUl8bNodo0GCsg6KqZ8Nz67Kr0ZmfOuCejAmX+j5j7Xw45N4Sj
	 0s25sd9fircbQmy6b9Af1co7rARL4M/97kMvNOxfQfyv+jYMfwpAr84/FD55Ah8W+1
	 4U+RtbsU89XGXActBjUAYLqkixwlcLr9tyTW6XI7okTl23G/0pRgU3AJ9T0iiO472p
	 bsUcLyqdUKhEeYdYBK+PYaOYK2X0MF7DG7hzwqvZC3+VGh/aY/Z/oFpw5A4RSGKYqp
	 jpqPJme1o46ygr7QSihAhkv6fxLdRMBZM5EENkoyRg/n/BZI65MV8QeBxnO8GT5CxZ
	 HYC6QlS9f4YEg==
Message-ID: <230256edbe24e417e0e80e31f5a7e7ca120692dc.camel@rendec.net>
Subject: Re: [patch 2/4] entry: Rework trace_syscall_enter()
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
Date: Tue, 14 Jul 2026 11:28:39 -0400
In-Reply-To: <20260712141346.639115923@kernel.org>
References: <20260712134433.549076055@kernel.org>
	 <20260712141346.639115923@kernel.org>
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
> Reread the syscall number from pt_regs and stop returning the eventually
> modified syscall number.
>=20
> That moves the reread to the end of the syscall_trace_enter() and prepare=
s
> for moving it to the call site.
>=20
> No functional change.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
> =C2=A0include/linux/entry-common.h=C2=A0 |=C2=A0=C2=A0 10 ++++------
> =C2=A0kernel/entry/syscall-common.c |=C2=A0=C2=A0=C2=A0 9 ++-------
> =C2=A02 files changed, 6 insertions(+), 13 deletions(-)
>=20
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -58,7 +58,7 @@ static __always_inline bool arch_ptrace_
> =C2=A0}
> =C2=A0#endif
> =C2=A0
> -long trace_syscall_enter(struct pt_regs *regs, long syscall);
> +void trace_syscall_enter(struct pt_regs *regs);
> =C2=A0void trace_syscall_exit(struct pt_regs *regs, long ret);
> =C2=A0void syscall_enter_audit(struct pt_regs *regs);
> =C2=A0
> @@ -96,16 +96,14 @@ static __always_inline long syscall_trac
> =C2=A0			return -1L;
> =C2=A0	}
> =C2=A0
> -	/* Either of the above might have changed the syscall number */
> -	syscall =3D syscall_get_nr(current, regs);
> -
> =C2=A0	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
> -		syscall =3D trace_syscall_enter(regs, syscall);
> +		trace_syscall_enter(regs);
> =C2=A0
> =C2=A0	if (unlikely(audit_context()))
> =C2=A0		syscall_enter_audit(regs);
> =C2=A0
> -	return syscall;
> +	/* Either of the above might have changed the syscall number */

nit: "Either" implies two items. I would rephrase it to "Any" to make
things clearer.

> +	return syscall_get_nr(current, regs);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> --- a/kernel/entry/syscall-common.c
> +++ b/kernel/entry/syscall-common.c
> @@ -8,14 +8,9 @@
> =C2=A0
> =C2=A0/* Out of line to prevent tracepoint code duplication */
> =C2=A0
> -long trace_syscall_enter(struct pt_regs *regs, long syscall)
> +void trace_syscall_enter(struct pt_regs *regs)
> =C2=A0{
> -	trace_sys_enter(regs, syscall);
> -	/*
> -	 * Probes or BPF hooks in the tracepoint may have changed the
> -	 * system call number. Reread it.
> -	 */
> -	return syscall_get_nr(current, regs);
> +	trace_sys_enter(regs, syscall_get_nr(current, regs));
> =C2=A0}
> =C2=A0
> =C2=A0void trace_syscall_exit(struct pt_regs *regs, long ret)

With the above,

Reviewed-by: Radu Rendec <radu@rendec.net>

