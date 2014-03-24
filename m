Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0BDA72C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 14:42:41 +1100 (EST)
Message-ID: <1395632548.3460.135.camel@pasglop>
Subject: Re: [PATCH 18/18] powerpc/boot: add PPC64_BOOT_WRAPPER config option
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Date: Mon, 24 Mar 2014 14:42:28 +1100
In-Reply-To: <1395328213-19206-19-git-send-email-clg@fr.ibm.com>
References: <1395328213-19206-1-git-send-email-clg@fr.ibm.com>
 <1395328213-19206-19-git-send-email-clg@fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-03-20 at 16:10 +0100, Cédric Le Goater wrote:
> The previous patch broke compatibility for 64bit big endian kernel.
> 
> This patch adds a config option to compile the boot wrapper in 64bit
> only when CPU_LITTLE_ENDIAN is selected. It restores 32bit compilation
> and linking for the big endian kernel.

So I originally applied all 3 last patches of the series as one
(collapsed them in git) in order to not break bisection.

However, I had to take the series out in the end due to it
causing this error on some of my test configs:

powerpc64-linux-ld: cannot find arch/powerpc/boot/pseries-head.o: No such file or directory

I haven't had a chance to investigate yet, but sadly it looks like
this series might have to wait for the next round.

Ben.


> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
> ---
>  arch/powerpc/boot/Makefile             |    2 +-
>  arch/powerpc/boot/wrapper              |    2 +-
>  arch/powerpc/boot/zImage.lds.S         |    8 ++++----
>  arch/powerpc/platforms/Kconfig.cputype |    5 +++++
>  4 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index b7e640028711..35189540b699 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -23,7 +23,7 @@ BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
>  		 -fno-strict-aliasing -Os -msoft-float -pipe \
>  		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
>  		 -isystem $(shell $(CROSS32CC) -print-file-name=include)
> -ifdef CONFIG_PPC64
> +ifdef CONFIG_PPC64_BOOT_WRAPPER
>  BOOTCFLAGS	+= -m64
>  endif
>  ifdef CONFIG_CPU_BIG_ENDIAN
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 3270e2a5c901..1948cf8b8a40 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -140,7 +140,7 @@ fi
>  elfformat="`${CROSS}objdump -p "$kernel" | grep 'file format' | awk '{print $4}'`"
>  case "$elfformat" in
>      elf64-powerpcle)	format=elf64lppc	;;
> -    elf64-powerpc)	format=elf64ppc	;;
> +    elf64-powerpc)	format=elf32ppc	;;
>      elf32-powerpc)	format=elf32ppc	;;
>  esac
>  
> diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
> index afecab0aff5c..861e72109df2 100644
> --- a/arch/powerpc/boot/zImage.lds.S
> +++ b/arch/powerpc/boot/zImage.lds.S
> @@ -1,6 +1,6 @@
>  #include <asm-generic/vmlinux.lds.h>
>  
> -#ifdef CONFIG_PPC64
> +#ifdef CONFIG_PPC64_BOOT_WRAPPER
>  OUTPUT_ARCH(powerpc:common64)
>  #else
>  OUTPUT_ARCH(powerpc:common)
> @@ -22,7 +22,7 @@ SECTIONS
>      *(.rodata*)
>      *(.data*)
>      *(.sdata*)
> -#ifdef CONFIG_PPC32
> +#ifndef CONFIG_PPC64_BOOT_WRAPPER
>      *(.got2)
>  #endif
>    }
> @@ -37,7 +37,7 @@ SECTIONS
>    .interp : { *(.interp) }
>    .rela.dyn :
>    {
> -#ifdef CONFIG_PPC64
> +#ifdef CONFIG_PPC64_BOOT_WRAPPER
>      __rela_dyn_start = .;
>  #endif
>      *(.rela*)
> @@ -67,7 +67,7 @@ SECTIONS
>      _initrd_end =  .;
>    }
>  
> -#ifdef CONFIG_PPC64
> +#ifdef CONFIG_PPC64_BOOT_WRAPPER
>    .got :
>    {
>      __toc_start = .;
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 434fda39bf8b..a4aadb091a1e 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -421,6 +421,7 @@ config CPU_BIG_ENDIAN
>  
>  config CPU_LITTLE_ENDIAN
>  	bool "Build little endian kernel"
> +	select PPC64_BOOT_WRAPPER
>  	help
>  	  Build a little endian kernel.
>  
> @@ -429,3 +430,7 @@ config CPU_LITTLE_ENDIAN
>  	  little endian powerpc.
>  
>  endchoice
> +
> +config PPC64_BOOT_WRAPPER
> +	def_bool n
> +	depends on CPU_LITTLE_ENDIAN
