Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9ACC43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 17:08:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAF921564
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 17:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kit/tBWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAF921564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Lh8m27zhzF389
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 03:08:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kit/tBWW";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kit/tBWW"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Lh5t2dbrzF370
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 03:05:47 +1000 (AEST)
Received: by mail-it1-x143.google.com with SMTP id j81-v6so8821999ite.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 10:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=AwEGUL1NA4kHX5XC94upxrAIeVzdtNSKcRKmm7WoCPU=;
 b=Kit/tBWWHysocmGe8gDCq/AFJeRpuAAq704hIJ0wB7OkluMUZ2AVjyCiavSn7CBup2
 ZBazTKYSgdUIl3SWVnJBWrLi8aBgFOoFLkAcL5Vfff2XsoLIt5f5yeUIy2mVekCTQRDt
 eObLZUJrKucNQyTXIYSiDA4NEelDcTq7PzspI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=AwEGUL1NA4kHX5XC94upxrAIeVzdtNSKcRKmm7WoCPU=;
 b=bNHPs4cfp3OG4AlJPZzBXKHtv5cxq65O8G7+IvyMgOMPKYBl4G0AECsWFQtoR8jDQg
 FyYhzb0RV+98p0F9dW3WysD9mjpgo4MmRjGGxBdISDjX36lF6+epHEOfAws3SQH00RzH
 rDuCW+NZnDr9u7TAcseEvDCEXxwiVGJZIy3DIDd4AnkJu3RArr1AzzSy/Pn4E8MpBphf
 oV0YSobebaYhCTRUgXp0clshcg8NwFMWruYcCueTveU0208osLKCIOZRIkn0PjFK+V3U
 6W5TNg1uCLZMc8E6Y+r6/hy2ZAAEnmGB1uoTVPzuTcaQlShCaZmJsMt+Q7Ot3Vxjv8Cq
 OkgQ==
X-Gm-Message-State: ABuFfoikB5T8WgjaGQlMWBU6V4b2cJbOsrgYgS2tVqNfRu23HcH+g7pJ
 uuU5WVcZ6GurB3QXnr9+vMzTeN7r11MWIq1SQCCr/Q==
X-Google-Smtp-Source: ACcGV62bw71shd+XScqvQU2Q0AOYxuHUynvVNR3VqvYDE6vlS00l2hR2z/l51FvC+ZrqXwAUcb1POXvQzGUxZflDr9E=
X-Received: by 2002:a24:8309:: with SMTP id
 d9-v6mr9738918ite.123.1538067945425; 
 Thu, 27 Sep 2018 10:05:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 10:05:44
 -0700 (PDT)
In-Reply-To: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 27 Sep 2018 19:05:44 +0200
Message-ID:
 <CAKv+Gu-AxtOO04iwPSri12tkb9NRugXV9E2LGrfJT-LJjf4_ow@mail.gmail.com>
Subject: Re: [PATCH 0/8] add generic builtin command line
To: Maksym Kokhan <maksym.kokhan@globallogic.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mips <linux-mips@linux-mips.org>,
 linux-efi <linux-efi@vger.kernel.org>, Ruslan Bilovol <rbilovol@cisco.com>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Daniel Walker <dwalker@fifo99.com>,
 Frank Rowand <frowand.list@gmail.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Daniel Walker <danielwa@cisco.com>,
 Devicetree List <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Bordunov <aborduno@cisco.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Message-ID: <20180927170544.Sb-F-mfENTmbVRuto33s6X4pPaBOO86Ni054YQweZk8@z>

On 27 September 2018 at 18:55, Maksym Kokhan
<maksym.kokhan@globallogic.com> wrote:
> There were series of patches [1] for 4.3.0-rc3, that allowed
> architectures to use a generic builtin command line. I have rebased
> these patches on kernel 4.19.0-rc4.
>

Could you please elaborate on the purpose of this series? Is it simply
to align between architectures? Does it solve an actual problem?

> Things, modified in comparison with original patches:
> * There was some bug for mips, in the case when CONFIG_CMDLINE_PREPEND
> and CONFIG_CMDLINE_APPEND are empty and CMDLINE_OVERRIDE is not set,
> command line from bootloader was ignored, so I fixed it, modifying
> patch "add generic builtin command line".
>
> * Implemented new patch to resolve conflict with new kernel, which
> modify EFI stub code. Unfortunately, I don't have capability to test
> this modification on real arm board with EFI.
>
> * Removed new realisation of mips builtin command line, which was
> created after 4.3.0-rc3.
>
> * Kernel 4.3.0-rc3 with original patches could not be compiled for
> powerpc due to prom_init.c checking by prom_init_check.sh. So I added
> strlcat (which is used by cmdline_add_builtin macro) to
> prom_init_check.sh whitelist.
>
> Patches have been tested in QEMU for x86, arm (little-endian), arm64
> (little-endian), mips (little-endian, 32-bit) and powerpc
> (big-endian, 64-bit), everything works perfectly. Also it was tested
> on linux-next (next-20180924 tag) for all listed above architectures.
>
> [1] : https://lore.kernel.org/patchwork/patch/604992/
>
> Daniel Walker (7):
>   add generic builtin command line
>   drivers: of: ifdef out cmdline section
>   x86: convert to generic builtin command line
>   arm: convert to generic builtin command line
>   arm64: convert to generic builtin command line
>   mips: convert to generic builtin command line
>   powerpc: convert to generic builtin command line
>
> Maksym Kokhan (1):
>   efi: modify EFI stub code for arm/arm64
>
>  arch/arm/Kconfig                        | 38 +-----------------
>  arch/arm/kernel/atags_parse.c           | 14 ++-----
>  arch/arm/kernel/devtree.c               |  2 +
>  arch/arm64/Kconfig                      | 17 +-------
>  arch/arm64/kernel/setup.c               |  3 ++
>  arch/mips/Kconfig                       | 24 +----------
>  arch/mips/Kconfig.debug                 | 47 ----------------------
>  arch/mips/kernel/setup.c                | 41 ++-----------------
>  arch/powerpc/Kconfig                    | 23 +----------
>  arch/powerpc/kernel/prom.c              |  4 ++
>  arch/powerpc/kernel/prom_init.c         |  8 ++--
>  arch/powerpc/kernel/prom_init_check.sh  |  2 +-
>  arch/x86/Kconfig                        | 44 +--------------------
>  arch/x86/kernel/setup.c                 | 19 ++-------
>  drivers/firmware/efi/libstub/arm-stub.c | 10 ++---
>  drivers/of/fdt.c                        |  2 +-
>  include/linux/cmdline.h                 | 70 +++++++++++++++++++++++++++++++++
>  init/Kconfig                            | 68 ++++++++++++++++++++++++++++++++
>  18 files changed, 173 insertions(+), 263 deletions(-)
>  create mode 100644 include/linux/cmdline.h
>
> --
> 2.7.4
>
