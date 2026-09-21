Return-Path: <linuxppc-dev+bounces-27800-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F85C982DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 03:49:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hp8NZ1XpTz2yDc;
	Mon, 21 Sep 2026 13:49:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::9"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789962542;
	cv=none; b=nupe6cq3fpr4NsTp8i567Cr0qWnl9AEdVYZbX8Nt8Ctk1iyT9bdakJE8B/oMu5Sr6Nt/CTYCbKUoWagi7ElFmVC+CyeCh5T9nq0eWsC1k63XUr4Xgw1ZLdiNhk6R/n3lw6uGCI+1J5i2iXyxmIKXk7Ov+V0PqPHqe/VNi9mJlgMhAp5wqhruDWhOI97Gh8vc3cafgtqZC0FDcSfVjokdO3qN2IuUHYglHFSpMEYBRsOu6bktsiUwOZF+arvGZ3VWNgI/KGvwoIFhHme9ByQ0ogUfzQAgcaKfHeZ4TM8hxBy6+Z5TftAkq1tFnTLkQ4DTEg9aFtt9FWZZF2G7IxKXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789962542; c=relaxed/relaxed;
	bh=1KYgZDmTeWYBCLjsf9i2xkGlcAMywzsXeJh/ZsALZqc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=biPXnSo0vPhgTe8cdK7P86mCwQ2NjdHPLOQPaSfGZdcU6TwqMhsc753EBhAVnGHIb0uhKZ9tKY+GzoI5raf+ioLPo73SX3BEJCS9YwDgS0xRBUbIDYq9np3HCNjjt/zxWROBoVpPtn8ZE883OJTHREsehqM+QRRpL2eBv8TF9qooH2g8JYQRoSX0K5EvsSPDHdNa5FXCqpCTuzWBEyK4UY8GxSF1iMLgPCJugg456ng7Z4xAe7uS05aF8wjacAzg+OwmWoB15M98WoqEr1yEnYmIOhvMnO+L8sqXvcwAIGiaYwXiUmM3EYkM2eWcifKIQ7t15jNwxRV9bS7qhZFXFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wt8jy7jp; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::9; helo=mail-wm2-x09.google.com; envelope-from=memxor@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wt8jy7jp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::9; helo=mail-wm2-x09.google.com; envelope-from=memxor@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x09.google.com (mail-wm2-x09.google.com [IPv6:2a00:1450:4864:31::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hp8NW24tfz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 13:48:58 +1000 (AEST)
Received: by mail-wm2-x09.google.com with SMTP id 5b1f17b1804b1-49e6bd65693so17521445e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2026 20:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789962534; x=1790567334; darn=lists.ozlabs.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1KYgZDmTeWYBCLjsf9i2xkGlcAMywzsXeJh/ZsALZqc=;
        b=Wt8jy7jpJkqpBE0YNTjaZdOQQLXInl9egaR7CNnCsDKU0HXmOJB/M1UarFa9VodqRO
         GP3kNUXEqsmMjq9QQLYwIghAoCwjJX23eLNwMlMCjs2uZ2R6AfLBV68nWC9xWJwatHXH
         //MOM4wif0OJV0WAw/RKZy5tygCQ6cH5GjF5N/1SbE5PDizInwRjkTYj3jJ0nUTIrwtm
         CG6lcj9EcqpjMh/qeE2kZ25ZIzUVJ6EFBpHue6GsEUf2pHOl5MSYOVTjv8+qIVT2SIGj
         QfRoAx4C7EQKW3YHEIEYmT4qot68b1FCQp4yQp8NfmFJ+N9BWyk3CaZAXMu/PVsVsv6z
         QXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789962534; x=1790567334;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1KYgZDmTeWYBCLjsf9i2xkGlcAMywzsXeJh/ZsALZqc=;
        b=ahkfqZpNE/phUkcTxqab8sf3lFm6MmfvwFJegTYpsh9ly3g1s6Xgz7rVuPx0I3e/nI
         c15unDPWkX3begeq71jE1VT1NyeUgHRPxiKAX7okImSlYAXU1Uym4Ml1yxAMugoXmTEx
         maKzIt1mkQZmchtzY+yrqLgTA0P0o/bIkTzFOlk0e4qFPSxG6Kt9N8AAJApFNB2x83us
         4nibSb7kyp0b6jXWcufG3vZakipSiI0yQrZywC/UTfflZLnIiIQneDuBhqWfISJbVMA7
         Fid7SK0I0zy9jdpkq81HU/ZeBz7ra8hngBp2h7q1QBnOO4pL1TOYaa49FkvlAozTedJ0
         Ip/g==
X-Forwarded-Encrypted: i=1; AKwUvBwYBzDMTV6AGX4Hk/Zj4ly2dZw0SeiYo7Q8kDl5RtRQnJsPwG/u7ICuS5L8HdkX6qUPxtiKOvCHmKD1Vfc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lVYK3GIc8sviAqfqV/GrVGAe+7rJI2UfKgipwC/6LZ9ptL/oW+
	H5PyIZC5UdjftadTUWwDjzvnL9XFWH2Us7T7gANQILmaGxX282bvSmaF
X-Gm-Gg: AYBFou1mGwQeonEJ35Tn3cBuJJRx8j9al0zynIVSqxX+rTFrO7VkC7oORt/YovqdlCM
	a47V/hNE1K3pIRh4/Gq6EhCEe3y94JS1ifmL/C9bDzrFG4IrKYl0NBT8VaS/mZTedriXaxaAG/d
	8nTW8vJzFvHW0zodKF5zmX+QOPN0vwoFXz/X6UcEpI1Kl/OjhNGy3xLYp76FHXF9U1jz0zoefYk
	6tnhwDYPPnPPtswTAI0aRr1vJ1hWnCEvb6V66VhsAULhaJNP2RHARQPG3F0YBmufnVB+jUqzRfE
	MHKB0l206IwBlx5AeTKzdtgq4+5Uid9jD3uNOcGq4e/h0V3Z7MnIpZrSra3t8fs9nC+ZSmMYpWi
	zCrel4Ne0fM7Q61sJqYZ9L9hjPWR+8maVGitipzQPtlDzTCFir/2cllbiVePlwJFlK2krZe6IeQ
	g4WhjWvCx5AfakHc+XufXc4QFmxDcIB379p4esXYouLnkQjJk+Ys70SNCJlVkP+C48nyVziKvuC
	zqsx1okq5nxq0bnIEn500X8hpGC7TRCwIr7n7eep2YZgpG5PRLprE6tBERWUy5Wz6PbXWDjReo2
	4Lhs6GrUz0Er4Rc+3ps4wtDk6iWITr97edSbnQ==
X-Received: by 2002:a05:600c:46c5:b0:49c:fc6e:8cb4 with SMTP id 5b1f17b1804b1-49fc5743bb7mr125721885e9.24.1789962533860;
        Sun, 20 Sep 2026 20:48:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0f8563sm222102405e9.6.2026.09.20.20.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 20:48:53 -0700 (PDT)
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 05:48:52 +0200
Message-Id: <DLKORFKGW8D8.XVSVVIH3Q6Q@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Siddharth Chintamaneni" <sidchintamaneni@gmail.com>,
 <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Anton Protopopov"
 <a.s.protopopov@gmail.com>, "Puranjay Mohan" <puranjay@kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <rlmenge@gmail.com>,
 <hargar@linux.microsoft.com>, <apais@microsoft.com>
Subject: Re: [PATCH bpf-next v1 0/7] Fix timed may_goto with private stacks
X-Mailer: aerc 0.21.0
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
In-Reply-To: <20260904195132.141068-1-sidchintamaneni@gmail.com>

On Fri Sep 4, 2026 at 9:51 PM CEST, Siddharth Chintamaneni wrote:
> Jeremy reported a bug[1] while executing a BPF program containing
> timed_may_goto instructions with private stacks.
>
> timed_may_goto[2] is a runtime safety mechanism that allows BPF
> programs to execute longer loops[3]. The BPF verifier replaces each
> may_goto instruction with a loop counter initialized to 0xffff and a
> timestamp check[4] that terminates the loop after 250 ms.
>
> Private stacks[5] allow BPF programs to use per-CPU memory instead of
> consuming more of the native kernel stack when BPF programs are deeply
> nested.
>
> To make timed may_goto work, the BPF program reserves 16 bytes of stack
> space. The first 8 bytes store the loop counter and the next 8 bytes
> store the timestamp.
>
> After the loop counter is exhausted, arch_bpf_timed_may_goto() is
> called. On x86, it adds the counter's stack offset to RBP to obtain a
> pointer to the counter and timestamp[6]. This works when the BPF
> program uses the normal stack because RBP is also the BPF frame pointer.
>
> When a private stack is used, the x86 JIT uses R9 as the BPF frame pointe=
r.
> The verifier-generated loads and stores therefore access the counter and
> timestamp through R9. However, arch_bpf_timed_may_goto() still adds the
> offset to RBP and accesses an unrelated location in the native JIT stack
> frame. This is the mismatch Jeremy reported.
>
> Fix the mismatch by resolving the address in the generated BPF
> instructions:
>
>         BPF_REG_AX =3D BPF_REG_FP
>         BPF_REG_AX +=3D stack_offset
>
> The JIT can then select the correct BPF frame pointer before calling
> arch_bpf_timed_may_goto(). The function receives the resolved pointer
> instead of reconstructing it from RBP.
>
> The LoongArch timed may_goto implementation is currently queued through
> the loongarch-next tree[7], while its selftests were merged separately
> through the bpf-next tree[8]. This series is based on bpf-next and
> therefore does not include the LoongArch trampoline update.
>
> [1] https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.=
cyber.gouv.fr/
> [2] https://lore.kernel.org/all/20250304003239.2390751-1-memxor@gmail.com=
/
> [3] https://elixir.bootlin.com/linux/v7.2.2/source/tools/testing/selftest=
s/bpf/libarena/include/bpf_may_goto.h#L8
> [4] https://elixir.bootlin.com/linux/v7.2.2/source/kernel/bpf/core.c#L340=
7
> [5] https://lore.kernel.org/bpf/20260417034658.2625353-1-yonghong.song@li=
nux.dev/
> [6] https://elixir.bootlin.com/linux/v7.2.2/source/arch/x86/net/bpf_timed=
_may_goto.S#L18
> [7] https://lore.kernel.org/loongarch/20260804153938.16129-3-dongtai.guo@=
linux.dev/
> [8] https://lore.kernel.org/bpf/20260813070906.5164-1-yangtiezhu@loongson=
.cn/
>

I think we can keep this fix local to x86. Would be less churn in the end.

The problem is that x86 switches the BPF frame pointer from RBP to R9 for
private stacks, but the trampoline still uses RBP. arm64 and powerpc64 keep
using X25 and R31 respectively for both stack modes, so their trampolines
already use the right frame pointer.

Instead of changing the generic fixup, can we resolve the pointer in the x8=
6 JIT
when emitting the call to arch_bpf_timed_may_goto()? We already know whethe=
r
priv_frame_ptr is set there. R10 contains the offset passed through BPF_REG=
_AX,
so we can emit:

/* Private stack */
leaq (%r9, %r10), %r10

/* Normal stack */
leaq (%rbp, %r10), %r10

Then remove the LEA from the x86 trampoline, as patch 2 already does.

This gives bpf_check_timed_may_goto() the same address used by the generate=
d
loads and stores: the BPF frame pointer plus the counter=E2=80=99s stack of=
fset. For
normal stacks, we just move the existing calculation into the JIT. For priv=
ate
stacks, we use R9 instead of RBP, which fixes the mismatch.

The existing save/restore of R9 around the call should stay. We also leave =
RBP
alone, since it is still needed for the native frame chain and unwinding.

I haven=E2=80=99t tested this approach, so it still needs checking with bot=
h normal and
private stacks.

pw-bot: cr

> Siddharth Chintamaneni (7):
>   bpf: Fix timed may_goto stack pointer for private stacks
>   bpf, x86: Use resolved pointer for timed may_goto
>   bpf, arm64: Use resolved pointer for timed may_goto
>   bpf, powerpc64: Use resolved pointer for timed may_goto
>   bpf, riscv: Use resolved pointer for timed may_goto
>   bpf, s390: Use resolved pointer for timed may_goto
>   selftests/bpf: Test timed may_goto with private stacks
>
>  arch/arm64/net/bpf_timed_may_goto.S           | 12 ++------
>  arch/powerpc/net/bpf_timed_may_goto.S         |  8 ++---
>  arch/riscv/net/bpf_timed_may_goto.S           | 13 ++++----
>  arch/s390/net/bpf_jit_comp.c                  |  6 ++--
>  arch/s390/net/bpf_timed_may_goto.S            |  8 ++---
>  arch/x86/net/bpf_timed_may_goto.S             |  6 ----
>  kernel/bpf/fixups.c                           | 19 ++++++------
>  .../bpf/progs/verifier_bpf_fastcall.c         | 30 ++++++++++---------
>  .../selftests/bpf/progs/verifier_may_goto_1.c | 17 ++++++-----
>  .../bpf/progs/verifier_private_stack.c        | 19 ++++++++++++
>  10 files changed, 75 insertions(+), 63 deletions(-)
>
>
> base-commit: d761934c9483ecde93fe99d8705282f716dfee50


