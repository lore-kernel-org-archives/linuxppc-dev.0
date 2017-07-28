Return-Path: <srs0=hmoq=67=gmail.com=cyrilbur@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJfGh2KlDzDrMm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 16:35:08 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xJfGh1MC1z8vlJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 16:35:08 +1000 (AEST)
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xJfGg4XFqz9s4q
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2017 16:35:07 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id v127so15010425itd.2
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2017 23:35:07 -0700 (PDT)
Message-ID: <1501223699.3324.9.camel@gmail.com>
Subject: Re: [PATCH] powerpc/boot: Fix 64-bit boot wrapper build with
 non-biarch compiler
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Date: Fri, 28 Jul 2017 16:34:59 +1000
In-Reply-To: <1501075144-20582-1-git-send-email-mpe@ellerman.id.au>
References: <1501075144-20582-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-26 at 23:19 +1000, Michael Ellerman wrote:
> Historically the boot wrapper was always built 32-bit big endian, even
> for 64-bit kernels. That was because old firmwares didn't necessarily
> support booting a 64-bit image. Because of that arch/powerpc/boot/Makefile
> uses CROSS32CC for compilation.
> 
> However when we added 64-bit little endian support, we also added
> support for building the boot wrapper 64-bit. However we kept using
> CROSS32CC, because in most cases it is just CC and everything works.
> 
> However if the user doesn't specify CROSS32_COMPILE (which no one ever
> does AFAIK), and CC is *not* biarch (32/64-bit capable), then CROSS32CC
> becomes just "gcc". On native systems that is probably OK, but if we're
> cross building it definitely isn't, leading to eg:
> 
>   gcc ... -m64 -mlittle-endian -mabi=elfv2 ... arch/powerpc/boot/cpm-serial.c
>   gcc: error: unrecognized argument in option ‘-mabi=elfv2’
>   gcc: error: unrecognized command line option ‘-mlittle-endian’
>   make: *** [zImage] Error 2
> 
> To fix it, stop using CROSS32CC, because we may or may not be building
> 32-bit. Instead setup a BOOTCC, which defaults to CC, and only use
> CROSS32_COMPILE if it's set and we're building for 32-bit.
> 
> Fixes: 147c05168fc8 ("powerpc/boot: Add support for 64bit little endian wrapper")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Without this patch applied and using a 64bit LE only toolchain my
powernv_defconfig build fails:

gcc: error: unrecognized argument in option ‘-mabi=elfv2’
gcc: note: valid arguments to ‘-mabi=’ are: ms sysv
  BOOTAS  arch/powerpc/boot/crt0.o
  BOOTCC  arch/powerpc/boot/cuboot.o
gcc: error: unrecognized argument in option ‘-mabi=elfv2’
gcc: note: valid arguments to ‘-mabi=’ are: ms sysv
  COPY    arch/powerpc/boot/zlib.h
gcc: error: unrecognized command line option ‘-mlittle-endian’; did you
mean ‘-fconvert=little-endian’?
gcc: error: unrecognized argument in option ‘-mabi=elfv2’
gcc: error: unrecognized command line option ‘-mlittle-endian’; did you
mean ‘-fconvert=little-endian’?
gcc: note: valid arguments to ‘-mabi=’ are: ms sysv
  COPY    arch/powerpc/boot/zutil.h
  COPY    arch/powerpc/boot/inffast.h
  COPY    arch/powerpc/boot/zconf.h
make[1]: *** [arch/powerpc/boot/Makefile:201: arch/powerpc/boot/crt0.o]
Error 1
make[1]: *** Waiting for unfinished jobs....
  MODPOST 244 modules
gcc: error: unrecognized command line option ‘-mlittle-endian’; did you
mean ‘-fconvert=little-endian’?
make[1]: *** [arch/powerpc/boot/Makefile:198: arch/powerpc/boot/cpm-
serial.o] Error 1
make[1]: *** [arch/powerpc/boot/Makefile:198:
arch/powerpc/boot/cuboot.o] Error 1
  COPY    arch/powerpc/boot/inffixed.h
make: *** [arch/powerpc/Makefile:289: zImage] Error 2
make: *** Waiting for unfinished jobs....

With this patch applied builds fine. Please merge!

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

> ---
>  arch/powerpc/boot/Makefile | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index a7814a7b1523..6f952fe1f084 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -25,12 +25,20 @@ compress-$(CONFIG_KERNEL_XZ)   := CONFIG_KERNEL_XZ
>  BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
>  		 -fno-strict-aliasing -Os -msoft-float -pipe \
>  		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
> -		 -isystem $(shell $(CROSS32CC) -print-file-name=include) \
>  		 -D$(compress-y)
>  
> +BOOTCC := $(CC)
>  ifdef CONFIG_PPC64_BOOT_WRAPPER
>  BOOTCFLAGS	+= -m64
> +else
> +BOOTCFLAGS	+= -m32
> +ifdef CROSS32_COMPILE
> +    BOOTCC := $(CROSS32_COMPILE)gcc
> +endif
>  endif
> +
> +BOOTCFLAGS	+= -isystem $(shell $(BOOTCC) -print-file-name=include)
> +
>  ifdef CONFIG_CPU_BIG_ENDIAN
>  BOOTCFLAGS	+= -mbig-endian
>  else
> @@ -183,10 +191,10 @@ clean-files := $(zlib-) $(zlibheader-) $(zliblinuxheader-) \
>  		empty.c zImage.coff.lds zImage.ps3.lds zImage.lds
>  
>  quiet_cmd_bootcc = BOOTCC  $@
> -      cmd_bootcc = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
> +      cmd_bootcc = $(BOOTCC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
>  
>  quiet_cmd_bootas = BOOTAS  $@
> -      cmd_bootas = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
> +      cmd_bootas = $(BOOTCC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
>  
>  quiet_cmd_bootar = BOOTAR  $@
>        cmd_bootar = $(CROSS32AR) -cr$(KBUILD_ARFLAGS) $@.$$$$ $(filter-out FORCE,$^); mv $@.$$$$ $@
