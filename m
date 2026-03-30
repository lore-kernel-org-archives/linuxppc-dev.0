Return-Path: <linuxppc-dev+bounces-18987-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D723FF493A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 03:49:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkchJ55clz2xly;
	Mon, 30 Mar 2026 14:49:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774842592;
	cv=none; b=B6RwMOIg5lMxDrtzT+y2hDbR3PPoI2YWl/I67bPp8OwPDRxF8AWJVoMTkPW+6JdxGlgmCs6oK/gVbbv1hFLO9npgvIgh6UnqeJ7vhFBNqHwJnt7Jpinj7E7jzhT8w9kZSfkRnfuRUnmlNrJC2d6iYp8m8d4OphPKfsiaknpJ2INPZDzr3fFmB7ZC9E2qVAI+a/T+VIzMEqTlCvAepki/1kt7RasNs9pISWXsYGSHeegDQ7t91zjudAL0JZ3OGJ75HfOXB3AVYqVFom015G9VQMS7EhakQakFZr8EsaDZRT4nmu1hZL/2Cy5mTX7HZr+xA9VvbknJ8c1c1KvjGF3XaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774842592; c=relaxed/relaxed;
	bh=W7U7BTXS8iu2ikkIeTXCYXN1EZ8TvQ225S/V4SWCkaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0ULOJ/ltHYVeb0wcMzZy1ovKscaZe5n208zI6eBgExK2l2bwuWVmKjUvewNAw7Vl0qRwj/DaYQaFX3n+rTH573JqVqWBnRpXB6TzU2lBSWoNVrF0ZFIi0PFPj/n11m+GuEcX/+E4d5uExtkE1SYFNxUWRE92rWYiAqoEEndfJ0sLXpm6pKyUH06pqFKuowI1d+CfVRjyHxXSeJ49C9YCi3Dr6F/dI+PYuP7mn6Ub14Imbr6kuTom44s+WVZvzY8WZ1CQVee1LLYm3xRQoXYs1Kd/GGAUkJZSirnc9g1G3/exJ2Cmp3ZSXgSDWspOKBGcKE1q4gAFy8lEAF1vzhrmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eoZ8B/st; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=guoren@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eoZ8B/st;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=guoren@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkchH5kCNz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 14:49:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 681AD44587
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 03:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AECEC2BCF7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 03:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774842589;
	bh=obCDFOyxCbjX0f8M408do6wNaHwmsZQneN83knIeC68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eoZ8B/stmhNenV55/GZwaY1J2F6+Mdl80yqD9NRcEWBOsoYl+9c7bLnMbhuDm8UCy
	 /HdFRjzUQbmAk/UyPSD+aNwyk+7+AXRsactruboxv4TBhmx7ZVUw3PnXCFXHbt/2Tv
	 8gPyg7oqfxDRPwPwOxonENTYb7rY2pfqtB3H6lN+8wTRbtHFo5byuP+ppf4WRnAd5Y
	 XciAnSMYuc3D6bWIB/pXvfsgHa26rnCnF4gtv6axbQIdyVpVlSoEdBsZ3ZtXIwQJfW
	 magEl9/ciAmyJ46LOqRQucXon3Rz5vlKU6TS+JdRCMl0FTU+kXQTbAQM34dEaStji4
	 KbhEz4mM9Fraw==
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so336440f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 20:49:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXtXgFvU8JEmRMUXFmZiN/wsI6nMn/0WCNEZo/4q6s3pxg4OHnKnuLuo4I7bzYHpcAYGTpdTkXFs1ufZY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwtXE5CT7hHgdvpT27iB4DX4sM2y5IR5L9PX/XF2cmkOboPtYcc
	fyKVsCvxkTk510NSW3kBZz8XT3D1pAfbETY5U+Mj5/g7PTBfFME986wnkgXpeBZYWSXc1ASIkPD
	Nfb7EhIFdvBzIBz3ZLWH+laKziQpHNks=
X-Received: by 2002:a05:6000:250f:b0:43c:f4df:923c with SMTP id
 ffacd0b85a97d-43cf4dfaca4mr10913170f8f.49.1774842587366; Sun, 29 Mar 2026
 20:49:47 -0700 (PDT)
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
References: <20260328074013.3589544-1-ruanjinjie@huawei.com> <20260328074013.3589544-2-ruanjinjie@huawei.com>
In-Reply-To: <20260328074013.3589544-2-ruanjinjie@huawei.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 30 Mar 2026 11:49:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRN=RpgzQsQ7QDbwjDmyQZP9anQZ+CaK2r-Mrz9dQbohQ@mail.gmail.com>
X-Gm-Features: AQROBzDiH9EGqvtsmkvuTI8F_a_MxhnUfiDn46oBgBr7JyKcMW8nH_9Y5zS6MkE
Message-ID: <CAJF2gTRN=RpgzQsQ7QDbwjDmyQZP9anQZ+CaK2r-Mrz9dQbohQ@mail.gmail.com>
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

On Sat, Mar 28, 2026 at 3:41=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> As done in commit 944a45abfabc ("arm64: kdump: Reimplement crashkernel=3D=
X")
> and commit 4831be702b95 ("arm64/kexec: Fix missing extra range for
> crashkres_low.") for arm64, while implementing crashkernel=3DX,[high,low]=
,
> riscv should have excluded the "crashk_low_res" reserved ranges from
> the crash kernel memory to prevent them from being exported through
> /proc/vmcore, and the exclusion would need an extra crash_mem range.
>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Fixes: 5882e5acf18d ("riscv: kdump: Implement crashkernel=3DX,[high,low]"=
)
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/riscv/kernel/machine_kexec_file.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/m=
achine_kexec_file.c
> index 54e2d9552e93..3f7766057cac 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -61,7 +61,7 @@ static int prepare_elf_headers(void **addr, unsigned lo=
ng *sz)
>         unsigned int nr_ranges;
>         int ret;
>
> -       nr_ranges =3D 1; /* For exclusion of crashkernel region */
> +       nr_ranges =3D 2; /* For exclusion of crashkernel region */
>         walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback=
);
>
>         cmem =3D kmalloc_flex(*cmem, ranges, nr_ranges);
> @@ -76,8 +76,16 @@ static int prepare_elf_headers(void **addr, unsigned l=
ong *sz)
>
>         /* Exclude crashkernel region */
>         ret =3D crash_exclude_mem_range(cmem, crashk_res.start, crashk_re=
s.end);
> -       if (!ret)
> -               ret =3D crash_prepare_elf64_headers(cmem, true, addr, sz)=
;
> +       if (ret)
> +               goto out;
> +
> +       if (crashk_low_res.end) {
> +               ret =3D crash_exclude_mem_range(cmem, crashk_low_res.star=
t, crashk_low_res.end);
Exclude crashk_low_res is reasonable, but have you tested this?

> +               if (ret)
> +                       goto out;
> +       }
> +
> +       ret =3D crash_prepare_elf64_headers(cmem, true, addr, sz);
>
>  out:
>         kfree(cmem);
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren

