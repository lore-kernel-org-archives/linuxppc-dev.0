Return-Path: <linuxppc-dev+bounces-21466-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36378CD5BC8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 10:14:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPBZQ4KzHz2xbN;
	Mon, 25 May 2026 20:14:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779704078;
	cv=none; b=HreBkpW6rG+XrPitzQHw5Gx3g/qtHaY72doYNXuc3w+s7mEBlG/bmfkL+2wQAEDkn2lBS7TBRikbH9iNSy1I6p7QrDWCVBJW/jB1G1HuN+kRiCG4YAeM1SE3mpD3s4tjg/pLmo/cXHlKdYFp5gNAO/wa7MZ9xn4P/SC4VYb/dL9hST/fz9nUdLPVB9FctchEjXw8rTyLsbRsAt0Xlo8qrGj+usYEujaUbYA5uIJp0My79d3HDmyaRCkarKyy4OSVqYzKdksb5gYYN1B1b64xoYT/9FlkNxcCVsqyOQ3okztJ5AiDnlsoHs0oGHgdzycjwz95/+EhrBeWQa5NhmbQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779704078; c=relaxed/relaxed;
	bh=dUAZrkQxlHQuaRMGZ2OHSU2/UxEYnmUpWIrg2lUbNJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8uAH6vuHW7v1+KbkgJATKTRkA/xAq8thctCOIHn+auXXv+56Hp+Ta3+OLZABD7kRkKtnu/4b4VAG73t/DnHK4Ss8feOY9cU1xEslHxeYk38FY+HYKe8eGCDc4PYPFXD6tDjA5pv0VZS9tW9GDkMvzbwUuwJJkDZc/aulJO4VN6OE0WQ6kx4/Z6uqEvrQh5NUYWVTKRmXD3b86bKpEmHiyLRrnfqL4mOvR+1+iiuUO6N6c7Kb5slS39X24H4e5Lx3eEg5/kVkakHLVuYc/yODoDQjviatv4BMFbkY5dqfeXCL6f+eLe6TXCEJKhHlVdm8uI8NgfLV9ffTFuczQ/xpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHnV7AZC; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chenhuacai@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHnV7AZC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chenhuacai@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPBZP1GFKz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 20:14:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B0C7D401C9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 10:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AB41F00A3D
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 10:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779704073;
	bh=dUAZrkQxlHQuaRMGZ2OHSU2/UxEYnmUpWIrg2lUbNJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LHnV7AZCpFqA7v0O11Qux6vGoP7MUrZ5B8+7OJF3ZtbTtFkoD/WDKbYCi87IbIiVL
	 Hs/fId7nTHciiKCdw86sMGMYLTloY3Jgnc8j4bEHa55Bb9cjJrcDFamGTDK4gfn4ZV
	 bKieHq0rbln1f7qR5TTRuQ6q46RB4aMfDm7u6Mdclyxg3rhpSdZIECA4pfZT22ZXVV
	 kupzSUQyMK+64sf4AmFMfD1sq5Q+RbVZPQol1IvPhjzsnjZADPkWe4cfHGIH/vIXQ1
	 VcZHW0Y2LvPMGVNUk60iMAFFSsjVA/D6rb0vxrhPIv3Vzs7b/fh9auJk0ARZJa4rAG
	 uym5uWJn3pq4A==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6896c54a7easo1727083a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 03:14:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9RLnyWvDvwPVkmtQjTwn04zReTkHwevbxccPrF2TWURaj15BQkbnI4VToWp0teLaRvG+/xTRybtI0Ovec=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwAPieRLu6xbJ1Rsa8stm+JSgQcCmB+XYjBJgQdhaSRT8qY4s5V
	bugPvcTrUc1SK7LqMt8ghUBu9g/DDMXeguJryOf90J0tUmb95mt1We5xcaKOTJVVVFA+qVC8vS5
	vDAI9VHhiV0BR9jEhyfDG28ZaD7APNJw=
X-Received: by 2002:a17:907:3f13:b0:bc5:1329:a1c8 with SMTP id
 a640c23a62f3a-bdd25ce8c6bmr701925566b.31.1779704071168; Mon, 25 May 2026
 03:14:31 -0700 (PDT)
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
References: <20260525084932.934910-1-ruanjinjie@huawei.com>
In-Reply-To: <20260525084932.934910-1-ruanjinjie@huawei.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 25 May 2026 18:14:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4NA7vgyxKnK+N_3C6pWBnwXc2URUyLh_h1m-MO=MnsGQ@mail.gmail.com>
X-Gm-Features: AVHnY4JdnTdCqWcFn0MbwORLZN7izpJL9xjUY_iGyTtHymhcSRhMVmbA2oKRU5I
Message-ID: <CAAhV-H4NA7vgyxKnK+N_3C6pWBnwXc2URUyLh_h1m-MO=MnsGQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/17] arm64/riscv: Add support for crashkernel CMA reservation
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
	will@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org, 
	saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	ruirui.yang@linux.dev, rdunlap@infradead.org, pmladek@suse.com, 
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com, kees@kernel.org, 
	elver@google.com, kuba@kernel.org, lirongqing@baidu.com, ebiggers@kernel.org, 
	paulmck@kernel.org, thuth@redhat.com, ardb@kernel.org, masahiroy@kernel.org, 
	mark.rutland@arm.com, maz@kernel.org, james.morse@arm.com, leitao@debian.org, 
	sourabhjain@linux.ibm.com, yeoreum.yun@arm.com, coxu@redhat.com, 
	jbohac@suse.cz, ryan.roberts@arm.com, cfsworks@gmail.com, 
	tangyouling@kylinos.cn, ritesh.list@gmail.com, songshuaishuai@tinylab.org, 
	junhui.liu@pigmoral.tech, vishal.moola@gmail.com, kas@kernel.org, 
	debug@rivosinc.com, namcao@linutronix.de, liaoyuanhong@vivo.com, 
	fuqiang.wang@easystack.cn, seanjc@google.com, guoren@kernel.org, 
	chenjiahao16@huawei.com, hbathini@linux.ibm.com, bgwin@google.com, 
	takahiro.akashi@linaro.org, lizhengyu3@huawei.com, x86@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jinjie,

On Mon, May 25, 2026 at 4:50=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> The crash memory allocation, and the exclude of crashk_res, crashk_low_re=
s
> and crashk_cma memory are almost identical across different architectures=
,
> This patch set handle them in crash core in a general way, which eliminat=
e
> a lot of duplication code.
>
> And add support for crashkernel CMA reservation for arm64 and riscv.
>
> Also add support for arm64 crash hotplug.
>
> This patch set is rebased on v7.1-rc1.
>
> Basic second kernel boot test were performed on QEMU platforms for x86,
> ARM64 and RISC-V architectures with the following parameters:
>
>         "cma=3D256M crashkernel=3D4G crashkernel=3D64M,cma"
>
> For first kernel, there will be such log:
>
>         # dmesg | grep crash
>         [    0.000000] crashkernel low memory reserved: 0xe8000000 - 0xf0=
000000 (128 MB)
>         [    0.000000] crashkernel reserved: 0x000000023e600000 - 0x00000=
0033e600000 (4096 MB)
>         [    0.000000] crashkernel CMA reserved: 64 MB in 1 ranges
>
>         # dmesg | grep cma
>         [    0.000000] cma: Reserved 256 MiB at 0x00000000f0000000
>         [    0.000000] cma: Reserved 64 MiB at 0x0000000100000000
>
> For second kernel, there will be such log:
>
>         [    0.000000] OF: fdt: Looking for usable-memory-range property.=
..
>         [    0.000000] OF: fdt: cap_mem_regions[0]: base=3D0x000000023e60=
0000, size=3D0x0000000100000000
>         [    0.000000] OF: fdt: cap_mem_regions[1]: base=3D0x00000000e800=
0000, size=3D0x0000000008000000
>         [    0.000000] OF: fdt: cap_mem_regions[2]: base=3D0x000000010000=
0000, size=3D0x0000000004000000
>
> Changes in v14:
> - Fix image->elf_headers memory leak during retry loop for arm64 as Sashi=
ko
>   AI code review pointed out.
> - Solve the hotplug notifier arch_crash_handle_hotplug_event() AA
>   self-deadlock problem as Sashiko AI code review pointed out.
> - Fix the TOCTOU issue in prepare_elf_headers() by get_online_mems().
> - -ENOMEM -> -EAGAIN as Breno suggested.
> - Add support for arm64 crash hotplug.
> - Link to v13: https://lore.kernel.org/all/20260511030454.1730881-1-ruanj=
injie@huawei.com/
>
> Changes in v13:
> - Rebased on v7.1-rc1.
> - Update the commit message.
> - Add Reviewed-by.
> - Link to v12: https://lore.kernel.org/all/20260402072701.628293-1-ruanji=
njie@huawei.com/
>
> Changes in v12:
> - Remove the unused "nr_mem_ranges" for x86.
> - Add "Fix crashk_low_res not exclude bug" test log.
> - Provide a separate patch for each architecture for using
>   crash_prepare_headers(), which will make the review more convenient.
> - Add Reviewed-by and Tested-by.
> - Link to v11: https://lore.kernel.org/all/20260328074013.3589544-1-ruanj=
injie@huawei.com/
>
> Changes in v11:
> - Avoid silently drop crash memory if the crash kernel is built without
>   CONFIG_CMA.
> - Remove unnecessary "cmem->nr_ranges =3D 0" for arch_crash_populate_cmem=
()
>   as we use kvzalloc().
> - Provide a separate patch for each architecture to fix the existing
>   buffer overflow issue.
> - Add Acked-bys for arm64.
>
> Changes in v10:
> - Fix crashk_low_res not excluded bug in the existing
>   RISC-V code.
> - Fix an existing memory leak issue in the existing PowerPC code.
> - Fix the ordering issue of adding CMA ranges to
>   "linux,usable-memory-range".
> - Fix an existing concurrency issue. A Concurrent memory hotplug may occu=
r
>   between reading memblock and attempting to fill cmem during kexec_load(=
)
>   for almost all existing architectures.
> - Link to v9: https://lore.kernel.org/all/20260323072745.2481719-1-ruanji=
njie@huawei.com/
>
> Changes in v9:
> - Collect Reviewed-by and Acked-by, and prepare for Sashiko AI review.
> - Link to v8: https://lore.kernel.org/all/20260302035315.3892241-1-ruanji=
njie@huawei.com/
>
> Changes in v8:
> - Fix the build issues reported by kernel test robot and Sourabh.
> - Link to v7: https://lore.kernel.org/all/20260226130437.1867658-1-ruanji=
njie@huawei.com/
>
> Changes in v7:
> - Correct the inclusion of CMA-reserved ranges for kdump kernel in of/kex=
ec
>   for arm64 and riscv.
> - Add Acked-by.
> - Link to v6: https://lore.kernel.org/all/20260224085342.387996-1-ruanjin=
jie@huawei.com/
>
> Changes in v6:
> - Update the crash core exclude code as Mike suggested.
> - Rebased on v7.0-rc1.
> - Add acked-by.
> - Link to v5: https://lore.kernel.org/all/20260212101001.343158-1-ruanjin=
jie@huawei.com/
>
> Jinjie Ruan (16):
>   riscv: kexec_file: Fix crashk_low_res not exclude bug
>   powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
>   arm64: kexec: Fix image->elf_headers memory leak during retry loop
>   x86/kexec: Fix potential buffer overflow in prepare_elf_headers()
>   arm64: kexec_file: Fix potential buffer overflow in
>     prepare_elf_headers()
>   riscv: kexec_file: Fix potential buffer overflow in
>     prepare_elf_headers()
>   LoongArch: kexec: Fix potential buffer overflow in
>     prepare_elf_headers()
>   crash: Add crash_prepare_headers() to exclude crash kernel memory
>   arm64: kexec_file: Use crash_prepare_headers() helper to simplify code
>   x86/kexec: Use crash_prepare_headers() helper to simplify code
>   riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
>   LoongArch: kexec: Use crash_prepare_headers() helper to simplify code
>   crash: Use crash_exclude_core_ranges() on powerpc
>   arm64: kexec: Add support for crashkernel CMA reservation
>   riscv: kexec: Add support for crashkernel CMA reservation
>   arm64/crash: Add crash hotplug support
I have some bikesheedings about the subjects. Can we unify the prefix forma=
ts?
x86/kexec, arm64: kexec_file, riscv: kexec_file, LoongArch: kexec .....

Huacai

>
> Sourabh Jain (1):
>   powerpc/crash: sort crash memory ranges before preparing elfcorehdr
>
>  .../admin-guide/kernel-parameters.txt         |  16 +--
>  arch/arm64/Kconfig                            |   3 +
>  arch/arm64/include/asm/kexec.h                |  14 +-
>  arch/arm64/kernel/Makefile                    |   1 +
>  arch/arm64/kernel/crash.c                     | 125 ++++++++++++++++++
>  arch/arm64/kernel/kexec_image.c               |  22 ++-
>  arch/arm64/kernel/machine_kexec_file.c        |  78 ++++++-----
>  arch/arm64/mm/init.c                          |   5 +-
>  arch/loongarch/kernel/machine_kexec_file.c    |  43 +++---
>  arch/powerpc/include/asm/kexec_ranges.h       |   1 -
>  arch/powerpc/kexec/crash.c                    |   7 +-
>  arch/powerpc/kexec/ranges.c                   | 101 +-------------
>  arch/riscv/kernel/machine_kexec_file.c        |  42 +++---
>  arch/riscv/mm/init.c                          |   5 +-
>  arch/x86/kernel/crash.c                       |  92 ++-----------
>  drivers/of/fdt.c                              |   9 +-
>  drivers/of/kexec.c                            |   9 ++
>  include/linux/crash_core.h                    |  11 ++
>  include/linux/crash_reserve.h                 |   4 +-
>  kernel/crash_core.c                           | 102 +++++++++++++-
>  20 files changed, 392 insertions(+), 298 deletions(-)
>  create mode 100644 arch/arm64/kernel/crash.c
>
> --
> 2.34.1
>

