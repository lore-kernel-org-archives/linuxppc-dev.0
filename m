Return-Path: <linuxppc-dev+bounces-18999-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50433FF4958
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 07:50:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkk1V0532z2xpt;
	Mon, 30 Mar 2026 18:50:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774857005;
	cv=none; b=PvrywDL/sp4EO5FoPsrjHybZWuW7H/yX1WhEKTVJlvAruRnDQCrNDfV+LHvNAk1RrP9gd30wiB6mQmAOkYrffR/Jvsq7TN4VS9mTWdxAy5v21vW03byxOi9IyvbkPdNRY8bU2YthlEIqHuHhcc9nQeCeeHpoO5Fgr4SA5xHAXTU+Aa6zxByvZqJF9pC0ExORXrCRZvCt7q5jUEBKhRk3z3cvHSSN6PAmfKZnZZa3KuxPTJUM1eA7VB1tA2jmOjAFcFbTL3QaLTquFnBg81lzd/EU+vxRyX6j6ioUBcfxac3k7VxwxmmZjNLB9qi8raKJr3i3351Hpd30ndKX8UajEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774857005; c=relaxed/relaxed;
	bh=a1Tv5dyEFVLeCv4Is/9LY0zjm6zQPl9um3jEFkYYu2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAdqoegixvIJNXjtdBRcRDYCWiyfGkb3d9M4SAeEjh416Gp/W2GyjApkNHBBKfsYybA+43Yx0iN5z7b31fYtlunCSNpli9WBWuuTvd5JF8A2kbdKUxrxCA+IxfpaONlnS1XyE5KM4L+OiY5po4yNvDLoH48X0Zz8cZIzUvelVfhS2dn99rb5Vuf9nBE5zPiEmXu30E4PTsGqzKdgxZewGbg4JLLQjccWWRwn81dcMbWu7Fy7IELGo4fg1ENoIxj1ssznJEPp0AUtAOCwzYsozGAYWh7OD422gD27RUsGvc/NVEqpmEtzFEWUQKrS6hpPrJ3BqQhNGiyOWV+CYEjm5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EMLHc9RR; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=guoren@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EMLHc9RR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=guoren@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkk1T1LzPz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 18:50:05 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 18AD64190F
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 07:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AB6C2BCB2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774857003;
	bh=6kNN1RP6hfrxfLPYE0OI9tP3SvLOgSwkQmqyXhzTfyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EMLHc9RRxxgF/q9IZFv1dePuIbnzTXNBuB6kVaoFukkr1ucrR8VtgGKJZxfHAPeda
	 NoOd5dNf4iw60IKhVuiihGzS20d2asneYTQFmIOPC+oibw6j5mB26gshymPA5cOnQU
	 8GwY3XAP/WUOAwUMhNJWulE7D51LKZLfsJ9jYrL2MWSm1AILniv6msGhMHwB2u72wL
	 NV3ZtFjq+6XUwCBsWxZDTcToYuFN8/MCoIOLkqqGR2/HpQGpyQ0uABqlI4zp2AJnVK
	 Rx/alDJqKvr0Bm4U2x6vI4IQVFXpJjTEyE984Dy+/l4J9Tk2CuS6GlGU6iWDdxPTfe
	 2ky4e5ATIv/aQ==
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso289483f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 00:50:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbj/KcJIseZchpH6pakNAI4q4JNQMM/nuSGpuLxD8JuADlHssZJ0jEa2IClkSbcbjRv6LjmI4xmwylCLg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzzfETxLhpmrP/9qDF1x6e6HqT3vK1qw7ii2G3Nm9KwDd/EvuJp
	dyEiCKMbHY1KVUyzcO95EtwGAsp9EDNUFzeVSzniJ2VA9XNYMa+YGNqr5tMsPdHNJY1QO1MDMW4
	hGnetRv4ChX6VCBmepcKpa3gBshh/N+4=
X-Received: by 2002:a05:6000:2409:b0:43b:447a:11b8 with SMTP id
 ffacd0b85a97d-43b9e9d6050mr19116932f8f.6.1774857000398; Mon, 30 Mar 2026
 00:50:00 -0700 (PDT)
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
References: <20260328074013.3589544-1-ruanjinjie@huawei.com>
 <20260328074013.3589544-2-ruanjinjie@huawei.com> <CAJF2gTRN=RpgzQsQ7QDbwjDmyQZP9anQZ+CaK2r-Mrz9dQbohQ@mail.gmail.com>
 <baa90080-9e6e-c1e5-13a1-b17496c690b4@huawei.com>
In-Reply-To: <baa90080-9e6e-c1e5-13a1-b17496c690b4@huawei.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 30 Mar 2026 15:49:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQE58ooXwyPSztDHbrxMRWCWhJNMKcRJZJsmKznBD12wA@mail.gmail.com>
X-Gm-Features: AQROBzBd-gKOewl3PX_5GW7wfDT6ZMEcMbV186WYHO9lbJECvy1QYs-DBc7P3MM
Message-ID: <CAJF2gTQE58ooXwyPSztDHbrxMRWCWhJNMKcRJZJsmKznBD12wA@mail.gmail.com>
Subject: Re: [PATCH v11 01/11] riscv: kexec_file: Fix crashk_low_res not
 exclude bug
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org, 
	saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org, 
	peterz@infradead.org, feng.tang@linux.alibaba.com, 
	pawan.kumar.gupta@linux.intel.com, dapeng1.mi@linux.intel.com, 
	kees@kernel.org, elver@google.com, paulmck@kernel.org, lirongqing@baidu.com, 
	rppt@kernel.org, leitao@debian.org, ardb@kernel.org, cfsworks@gmail.com, 
	osandov@fb.com, jbohac@suse.cz, tangyouling@kylinos.cn, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, eajames@linux.ibm.com, 
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com, vishal.moola@gmail.com, 
	junhui.liu@pigmoral.tech, coxu@redhat.com, fuqiang.wang@easystack.cn, 
	liaoyuanhong@vivo.com, chenjiahao16@huawei.com, hbathini@linux.ibm.com, 
	takahiro.akashi@linaro.org, james.morse@arm.com, lizhengyu3@huawei.com, 
	x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:11=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
>
>
> On 2026/3/30 11:49, Guo Ren wrote:
> > On Sat, Mar 28, 2026 at 3:41=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.=
com> wrote:
> >>
> >> As done in commit 944a45abfabc ("arm64: kdump: Reimplement crashkernel=
=3DX")
> >> and commit 4831be702b95 ("arm64/kexec: Fix missing extra range for
> >> crashkres_low.") for arm64, while implementing crashkernel=3DX,[high,l=
ow],
> >> riscv should have excluded the "crashk_low_res" reserved ranges from
> >> the crash kernel memory to prevent them from being exported through
> >> /proc/vmcore, and the exclusion would need an extra crash_mem range.
> >>
> >> Cc: Guo Ren <guoren@kernel.org>
> >> Cc: Baoquan He <bhe@redhat.com>
> >> Fixes: 5882e5acf18d ("riscv: kdump: Implement crashkernel=3DX,[high,lo=
w]")
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> >> ---
> >>  arch/riscv/kernel/machine_kexec_file.c | 14 +++++++++++---
> >>  1 file changed, 11 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kerne=
l/machine_kexec_file.c
> >> index 54e2d9552e93..3f7766057cac 100644
> >> --- a/arch/riscv/kernel/machine_kexec_file.c
> >> +++ b/arch/riscv/kernel/machine_kexec_file.c
> >> @@ -61,7 +61,7 @@ static int prepare_elf_headers(void **addr, unsigned=
 long *sz)
> >>         unsigned int nr_ranges;
> >>         int ret;
> >>
> >> -       nr_ranges =3D 1; /* For exclusion of crashkernel region */
> >> +       nr_ranges =3D 2; /* For exclusion of crashkernel region */
> >>         walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callb=
ack);
> >>
> >>         cmem =3D kmalloc_flex(*cmem, ranges, nr_ranges);
> >> @@ -76,8 +76,16 @@ static int prepare_elf_headers(void **addr, unsigne=
d long *sz)
> >>
> >>         /* Exclude crashkernel region */
> >>         ret =3D crash_exclude_mem_range(cmem, crashk_res.start, crashk=
_res.end);
> >> -       if (!ret)
> >> -               ret =3D crash_prepare_elf64_headers(cmem, true, addr, =
sz);
> >> +       if (ret)
> >> +               goto out;
> >> +
> >> +       if (crashk_low_res.end) {
> >> +               ret =3D crash_exclude_mem_range(cmem, crashk_low_res.s=
tart, crashk_low_res.end);
> > Exclude crashk_low_res is reasonable, but have you tested this?
>
> Just simply tested on qemu with crashkernel=3D4G with following kexec
> mentioned in
> https://lore.kernel.org/all/20230726175000.2536220-1-chenjiahao16@huawei.=
com/.
> And the second kernel can be started normally.
>
> https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2
>
> # dmesg | grep crash
> [    0.000000] crashkernel low memory reserved: 0xf8000000 - 0x100000000
> (128 MB)
> [    0.000000] crashkernel reserved: 0x000000017fe00000 -
> 0x000000027fe00000 (4096 MB)
Adding a test log to the commit log makes the patch more trustworthy.

Reviewed-by: Guo Ren <guoren@kernel.org>

>
>
>
> >
> >> +               if (ret)
> >> +                       goto out;
> >> +       }
> >> +
> >> +       ret =3D crash_prepare_elf64_headers(cmem, true, addr, sz);
> >>
> >>  out:
> >>         kfree(cmem);
> >> --
> >> 2.34.1
> >>
> >
> >



--=20
Best Regards
 Guo Ren

