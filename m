Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Lh5t2dbrzF370
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 03:05:47 +1000 (AEST)
Received: by mail-it1-x143.google.com with SMTP id j81-v6so8821999ite.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 10:05:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 27 Sep 2018 19:05:44 +0200
Message-ID: <CAKv+Gu-AxtOO04iwPSri12tkb9NRugXV9E2LGrfJT-LJjf4_ow@mail.gmail.com>
Subject: Re: [PATCH 0/8] add generic builtin command line
To: Maksym Kokhan <maksym.kokhan@globallogic.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 James Hogan <jhogan@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Daniel Walker <dwalker@fifo99.com>, Daniel Walker <danielwa@cisco.com>,
 Andrii Bordunov <aborduno@cisco.com>, Ruslan Bilovol <rbilovol@cisco.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Devicetree List <devicetree@vger.kernel.org>,
 linux-efi <linux-efi@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
