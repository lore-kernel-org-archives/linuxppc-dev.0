Return-Path: <linuxppc-dev+bounces-27393-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0767CC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:44:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhYW1XDDz3cBP;
	Tue, 15 Sep 2026 22:44:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789473617;
	cv=none; b=WD4BM6qOUdqrkaluA2MAxNJ2QVJwKpTXkPp6GENiTgrb6D7FXWZQ8tnwX/IzeDDWVZJxmVtVoGLfqZDHneSO6L3aT8bQCVUTnT9lBweY01LRecyYftNLmuu1LhpdAXylvpQ9qIpSQ27bcnj+Dy7w/Qjh5HBRnkuKuhskE9hQ7HxsHo4sdb4aMDglvgV6AlNW07u3nXy8m2tf72pIoiLQmcams1pJ+wR5cdQiEZfLrCSC+CyI88l6b9cCidPgwR1xrVaLnMe3QV5CYFxMWFSpPKCF87RaLMgO5TPQWaUgaVmzxRdlmNt/xTwi/kzEQg0fFPKiyKGRA1PylSEOXQFwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789473617; c=relaxed/relaxed;
	bh=lkRrGN3tHH0vPXJQpfXyuI1f/hj84726OJ+wXiSAjkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gj8t9UMaTAk/7946K17KV37EXQgOzvYSYpP6HmdUN4MWEB+7HVJLcJBtPvM7jVjIPRmx+u7+jZqiXOgHmyqb7CuHA6qbgDY02jBZs3tvY7V9RXrhz/uUoKUgnOU1nb2MvDtCjjKCHxS+SD1GPvtG8CD3AqAPY7E4NedT3wnhkWKYn9ybdxVSvpyBXTZM2KdG/bfA5BeKvzfaR8wm3pcbeMxaqQzOVBe22f7fM7/WfZxtrjXRTMKOxm8BMkAJC0IXE8kIPMdjK1PKGwhffXyKd1PfVSe38FaTkxnQa+tPRqgujcwSE+7I4ctF4symobTuC3M9kzcbqEuZc/qsIw4vHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bdJ8EfCA; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bdJ8EfCA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgZ80mWRz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:00:16 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C51DE41B2F;
	Tue, 15 Sep 2026 12:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59F81F000FF;
	Tue, 15 Sep 2026 12:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473613;
	bh=lkRrGN3tHH0vPXJQpfXyuI1f/hj84726OJ+wXiSAjkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bdJ8EfCAcKRLCnZZLr9KUFRKwzOp9HwWHqD8dKOgs2QECDixoCiY7OitpfSWybTgc
	 GrKy8T3cB5cVyun9gMM4tiazPAmkuvnRoSJn20gDY30Pi6NZ2BlWie/yV3J02KVzmP
	 +FdO4hMG7v/dI5BZjC8kuRbGxnY1BMC++7JlKDVKVVz2TBx0SWNpwMbRNY+KWbqJrn
	 ewEE2svDPg32d5ej4oQppZf8rSJTrU4fXT0CFb4RwzIPHo6I6kwXfOXCr0tMaXJRUv
	 nQKJqvUmQYSXF6bRUemMO3EjVCVESrcELW0g+JEeeCOWgYbp17E7wf+3S6taJJ6xjy
	 asi0ByODbGixg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 18/50] xtensa: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-openrisc@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-hyperv@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, virtualization@lists.linux.dev, "Oleg
 Nesterov" <oleg@redhat.com>, linux-alpha@vger.kernel.org, kexec@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, dri-devel@lists.freedesktop.org, linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "Jan
 Kara" <jack@suse.cz>, linux-um@lists.infradead.org, "Eugenio Perez" <eperezma@redhat.com>, "Jann
 Horn" <jannh@google.com>, bpf@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-snps-arc@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org, sparclinux@vger.kernel.org, linux-mips@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-18-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-18-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:00:11 +0000
Message-Id: <20260915120011.D59F81F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] xtensa: inconsistent mid-syscall ptrace exit tracing due to stal=
e flags
--

commit f64c69fbd6ff1a2ee8dd26645f9d56d2d371647e
Author: Christian Brauner <brauner@kernel.org>

xtensa: commit fds on syscall exit

Add TIF_FD_SLOTS and test it once the system call has stored its
return value. A task that reserved descriptors uses the traced path.

[ ... ]

> diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
> index 272fff587907f..4b95f48736e6b 100644
> --- a/arch/xtensa/kernel/entry.S
> +++ b/arch/xtensa/kernel/entry.S
> @@ -1976,6 +1976,11 @@ ENTRY(system_call)
>  1:	/* regs->areg[2] =3D return_value */
> =20
>  	s32i	abi_rv, abi_saved0, PT_AREG2
> +
> +	/* descriptors reserved by the syscall are committed in do_syscall_trac=
e_leave */
> +	GET_THREAD_INFO(a4, a1)
> +	l32i	a4, a4, TI_FLAGS
> +	bbsi.l	a4, TIF_FD_SLOTS, 1f
>  	bnez	abi_saved1, 1f

[Severity: Medium]
Does this introduce a regression leading to inconsistent ptrace
observability?

The exit path in system_call() dynamically checks TIF_FD_SLOTS from fresh
thread flags (loaded into a4), but falls back to abi_saved1 for trace work.

Earlier in system_call(), abi_saved1 is cached before executing the syscall:

    GET_THREAD_INFO(a4, a1)
    l32i    abi_saved1, a4, TI_FLAGS
    movi    a4, _TIF_WORK_MASK
    and     abi_saved1, abi_saved1, a4

If a tracer attaches mid-syscall (e.g. using PTRACE_ATTACH on an Xtensa
process currently blocked inside a system call), wouldn't the exit trace
events be missed for most syscalls because abi_saved1 lacks the new flags,
yet mysteriously be caught if the syscall happens to allocate a file
descriptor (because TIF_FD_SLOTS is checked against the fresh TI_FLAGS)?

Could we reload the fresh _TIF_WORK_MASK from thread_info here instead of
relying on the stale abi_saved1 cache?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D18

