Return-Path: <linuxppc-dev+bounces-27392-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57460C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:44:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhYP5cPpz30VT;
	Tue, 15 Sep 2026 22:44:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789473599;
	cv=none; b=clrafoVnAsdWU2hdEAl6g/5TyJRqJ7Q0KzjcB8bWYokwZ3bDuNP8Wb9gSR5aJBuS/ovDn/4UOGHx7UbACsejCW6nM7rSDyc5JaZ/KzrBhM+oU77TUrh6jMpb/Xjq8zuT7iT5uaKpdidL3sPparyZp0zpBWDjh1vkBnF6BTuDnqUDpMeS8dJJgEkazKRMGAn/AYhru+/wqZZRdAkDRB3tykI13FT9Tz2UiW8RqX+hW6s7Rs0YCkY6gejChS9UJKV8lMYvwxDelxm3irvJI1N7GDaeGNjTEZMbw5/5P2BxbwoaBzGMhslGeTrX9moor93KgeZSryd5CNL0NAhtSulQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789473599; c=relaxed/relaxed;
	bh=XROzleDAWNHKip4xHBVteIb0cCuN7FAQoMQU9zewp/g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SAM5Klwp8OdBB2TQJVUMm30te1i7uovqkKOKdMDjCBl30T2PPPauAlNiK6qAaKoc5/62F6gbXbnULqv8sBkyTXH+Qk3maXrMA3CpxiDf08IT3Gu91CmfAbKjrwQrWnrZ/viAw60XTv403x9gqosqwHBHfOZrZ0QKXuAC7WdfWs2AQGmGd8ezA7cq1nuasFcEHXkmqjLtOaOjrfT6GBieAkCU3wm1w0cWqEtWWERhjVRAyglOy8BmkIvvBVFh1pYwlAEcZcnJIhRXh2kjzWOACGWP/xJKwprvfbLaaPEah//wszPgJYHPZx2z7+yvBlTsZyGY8Ohphhqnwr8fvpF17Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuDfDBIp; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuDfDBIp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgYp3xNkz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:59:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9A98B602BE;
	Tue, 15 Sep 2026 11:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B93C1F00893;
	Tue, 15 Sep 2026 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473596;
	bh=XROzleDAWNHKip4xHBVteIb0cCuN7FAQoMQU9zewp/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LuDfDBIpgc+rUudqugD7YWLMIYTyPSh1djqeFTSZvIqwl+MCFr2F9Jod5sQ3BdeBH
	 Fs4P2kaC4Rq/e2WctPCUaANEEugIP/+ZEAefkQjg3r930Bx3+wPmgnd43osNu5U8C9
	 EyuNiUbu78gNfTdrTeVFFD2nhC1r5SHLm94AIfGff4/9p19OhtUCSOkAUYL8ijEd9H
	 l9DN/Fa9wQdaggqiklG21wysLrbu7J9tNRHYcAgnuhIFYUQdGWbvPhv23a8BBnteix
	 dj3Dz8036WkGhtwkv8ziLkCVxCa1RZBk5Y1nQhcVea1ZYeF0cF/u11/S008mj3HeiR
	 /EId/I6+w1CIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 05/50] ARM: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-um@lists.infradead.org, linux-openrisc@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, bpf@vger.kernel.org, linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-gpio@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Jan Kara" <jack@suse.cz>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-hyperv@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-alpha@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org, io-uring@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, kvm@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, "David
 Airlie" <airlied@redhat.com>, linuxppc-dev@lists.ozlabs.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jann Horn" <jannh@google.com>, linux-sh@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org, linux-mips@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, kexec@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-5-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-5-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:59:54 +0000
Message-Id: <20260915115954.7B93C1F00893@smtp.kernel.org>
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
- [Low] arm: redundant TIF_FD_SLOTS check due to bit-shift overlap
--

commit bdf52635177f575c1b58cdb7e902386551a36647
Author: Christian Brauner <brauner@kernel.org>

ARM: commit fds on syscall exit

Add TIF_FD_SLOTS and test it where the syscall return path decides
between the syscall work and the plain work pending slow path. A task
that reserved descriptors goes through __sys_trace_return_nosave
where syscall_trace_exit() commits them before audit and the ptrace
exit stop.

> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-commo=
n.S
> index 88336a1292bb7..59a70d90b0b61 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S

[ ... ]

> @@ -83,6 +83,8 @@ ENDPROC(ret_fast_syscall)
> =20
>  	tst	r1, #_TIF_SYSCALL_WORK
>  	bne	__sys_trace_return_nosave
> +	tst	r1, #(_TIF_FD_SLOTS << 16)	@ r1 holds TI_FLAGS << 16
> +	bne	__sys_trace_return_nosave

[Severity: Low]
Is this newly added check reachable?

The preceding tst r1, #_TIF_SYSCALL_WORK instruction appears to intercept
the branch because it inadvertently catches this condition.

In ret_fast_syscall, r1 is loaded with TI_FLAGS << 16. TIF_FD_SLOTS is
bit 5, so shifting it by 16 places it at bit 21 in r1.

_TIF_SYSCALL_WORK naturally includes bit 21 (_TIF_SYSCALL_AUDIT). Because of
this bit-shift overlap, the first test against _TIF_SYSCALL_WORK will
evaluate to non-zero whenever TIF_FD_SLOTS is set. This means the branch to
__sys_trace_return_nosave is taken early, making the new tst instruction
unreachable dead code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D5

