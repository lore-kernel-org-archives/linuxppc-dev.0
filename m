Return-Path: <srs0=96zu=j2=gmail.com=mathieu.malaterre@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PvhZ3KcLzDrcC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 17:58:22 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41PvhZ2nfvz8t4B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 17:58:22 +1000 (AEST)
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41PvhY4pbZz9s00
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2018 17:58:20 +1000 (AEST)
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so40898156oib.9
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2018 00:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180709142426.26999-1-mpe@ellerman.id.au>
In-Reply-To: <20180709142426.26999-1-mpe@ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 10 Jul 2018 09:58:06 +0200
Message-ID: <CA+7wUsz3hADry_O7MCO8pJRmWb84dbQYu8zOyEYQ01P=R8WoDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: Add ppc32_allmodconfig defconfig target
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 9, 2018 at 4:24 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Because the allmodconfig logic just sets every symbol to M or Y, it
> has the effect of always generating a 64-bit config, because
> CONFIG_PPC64 becomes Y.
>
> So to make it easier for folks to test 32-bit code, provide a phony
> defconfig target that generates a 32-bit allmodconfig.
>
> The 32-bit port has several mutually exclusive CPU types, we choose
> the Book3S variants as that's what the help text in Kconfig says is
> most common.

Ok then.

> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/Makefile                 | 5 +++++
>  arch/powerpc/configs/book3s_32.config | 2 ++
>  2 files changed, 7 insertions(+)
>  create mode 100644 arch/powerpc/configs/book3s_32.config
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 2ea575cb3401..2556c2182789 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -354,6 +354,11 @@ mpc86xx_smp_defconfig:
>         $(call merge_into_defconfig,mpc86xx_basic_defconfig,\
>                 86xx-smp 86xx-hw fsl-emb-nonhw)
>
> +PHONY += ppc32_allmodconfig
> +ppc32_allmodconfig:
> +       $(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/book3s_32.config \
> +               -f $(srctree)/Makefile allmodconfig
> +

I this a good time to update line 34 at the same time:

KBUILD_DEFCONFIG := $(shell uname -m)_defconfig

?

>  define archhelp
>    @echo '* zImage          - Build default images selected by kernel config'
>    @echo '  zImage.*        - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
> diff --git a/arch/powerpc/configs/book3s_32.config b/arch/powerpc/configs/book3s_32.config
> new file mode 100644
> index 000000000000..8721eb7b1294
> --- /dev/null
> +++ b/arch/powerpc/configs/book3s_32.config
> @@ -0,0 +1,2 @@
> +CONFIG_PPC64=n
> +CONFIG_PPC_BOOK3S_32=y
> --
> 2.14.1
>
