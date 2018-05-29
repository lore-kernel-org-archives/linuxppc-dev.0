Return-Path: <yamada.masahiro@socionext.com>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wFTc2K3hzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 23:49:55 +1000 (AEST)
Received: from mail-ua0-f172.google.com (mail-ua0-f172.google.com
 [209.85.217.172]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id w4TDncXq018440
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 22:49:38 +0900
Received: by mail-ua0-f172.google.com with SMTP id j5-v6so10005855uak.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 06:49:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516141458.18996-5-npiggin@gmail.com>
References: <20180516141458.18996-1-npiggin@gmail.com>
 <20180516141458.18996-5-npiggin@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 29 May 2018 22:48:57 +0900
Message-ID: <CAK7LNASczrs9KVmeXuXjckPzrWjK=hsWMkk0iJKxw63kWuqoeQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] powerpc/kbuild: move -mprofile-kernel check to
 Kconfig
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2018-05-16 23:14 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> This eliminates the workaround that requires disabling
> -mprofile-kernel by default in Kconfig.
>
> [ Note: this depends on https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kconfig-shell-v3 ]
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Since v3:
> - Moved a stray hunk back to patch 3 where it belongs.
>
>  arch/powerpc/Kconfig  | 16 +---------------
>  arch/powerpc/Makefile | 14 ++------------
>  2 files changed, 3 insertions(+), 27 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 512fcc177c87..af527f894f9b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -460,23 +460,9 @@ config LD_HEAD_STUB_CATCH
>
>           If unsure, say "N".
>
> -config DISABLE_MPROFILE_KERNEL
> -       bool "Disable use of mprofile-kernel for kernel tracing"
> -       depends on PPC64 && CPU_LITTLE_ENDIAN
> -       default y
> -       help
> -         Selecting this options disables use of the mprofile-kernel ABI for
> -         kernel tracing. That will cause options such as live patching
> -         (CONFIG_LIVEPATCH) which depend on CONFIG_DYNAMIC_FTRACE_WITH_REGS to
> -         be disabled also.
> -
> -         If you have a toolchain which supports mprofile-kernel, then you can
> -         disable this. Otherwise leave it enabled. If you're not sure, say
> -         "Y".
> -
>  config MPROFILE_KERNEL
>         depends on PPC64 && CPU_LITTLE_ENDIAN
> -       def_bool !DISABLE_MPROFILE_KERNEL
> +       def_bool $(success $(srctree)/arch/powerpc/tools/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__)


Your fix-up patch is good,
but could you check my comments below please?



>  config IOMMU_HELPER
>         def_bool PPC64
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 6faf1d6ad9dd..8f7a64fe7370 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -161,18 +161,8 @@ CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
>  endif
>
>  ifdef CONFIG_MPROFILE_KERNEL
> -    ifeq ($(shell $(srctree)/arch/powerpc/tools/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__),OK)


You do not need to compare the returned string with "OK" any more.


Please remove the
echo "OK"
line from the shell script.



> -        CC_FLAGS_FTRACE := -pg -mprofile-kernel
> -        KBUILD_CPPFLAGS += -DCC_USING_MPROFILE_KERNEL
> -    else
> -        # If the user asked for mprofile-kernel but the toolchain doesn't
> -        # support it, emit a warning and deliberately break the build later
> -        # with mprofile-kernel-not-supported. We would prefer to make this an
> -        # error right here, but then the user would never be able to run
> -        # oldconfig to change their configuration.
> -        $(warning Compiler does not support mprofile-kernel, set CONFIG_DISABLE_MPROFILE_KERNEL)
> -        CC_FLAGS_FTRACE := -mprofile-kernel-not-supported
> -    endif
> +       CC_FLAGS_FTRACE := -pg -mprofile-kernel
> +       KBUILD_CPPFLAGS += -DCC_USING_MPROFILE_KERNEL


Now, CONFIG_MPROFILE_KERNEL is equivalent to CC_USING_MPROFILE_KERNEL.


If you replace #ifdef CC_USING_MPROFILE_KERNEL
with #ifdef CONFIG_MPROFILE_KERNEL,
you can remove CC_USING_MRPROFILE_KERNEL entirely, right?





>  endif
>
>  CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
