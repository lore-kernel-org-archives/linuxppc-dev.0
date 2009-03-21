Return-Path: <srostedt@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id CA2F5DDE11
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 14:49:54 +1100 (EST)
Subject: Re: [PATCH 1/3] powerpc, Makefile: Make it possible to safely
	select CONFIG_FRAME_POINTER
From: Steven Rostedt <srostedt@redhat.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090320164429.GA28037@oksana.dev.rtsoft.ru>
References: <20090320164404.GA19933@oksana.dev.rtsoft.ru>
	<20090320164429.GA28037@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Fri, 20 Mar 2009 23:49:29 -0400
Message-Id: <1237607369.17367.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Ben,

Can you ACK this patch? Or even take it in your tree?

Thanks,

-- Steve

On Fri, 2009-03-20 at 19:44 +0300, Anton Vorontsov wrote:
> This patch introduces ARCH_HAS_NORMAL_FRAME_POINTERS Kconfig symbol.
> When defined, the top level Makefile won't add -fno-omit-frame-pointer
> cflag (the flag is useless in PowerPC kernels, and also makes gcc
> generate wrong code).
> 
> Also move ARCH_WANT_FRAME_POINTERS's help text.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  Makefile             |    7 +++++--
>  arch/powerpc/Kconfig |    1 +
>  lib/Kconfig.debug    |   16 ++++++++++------
>  3 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 46c04c5..bf41b05 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -538,9 +538,12 @@ KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
>  endif
>  
>  ifdef CONFIG_FRAME_POINTER
> -KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
> +  KBUILD_CFLAGS	+= -fno-optimize-sibling-calls
> +  ifndef ARCH_HAS_NORMAL_FRAME_POINTERS
> +    KBUILD_CFLAGS	+= -fno-omit-frame-pointer
> +  endif
>  else
> -KBUILD_CFLAGS	+= -fomit-frame-pointer
> +  KBUILD_CFLAGS	+= -fomit-frame-pointer
>  endif
>  
>  ifdef CONFIG_DEBUG_INFO
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 97f9a64..4587e66 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -113,6 +113,7 @@ config PPC
>  	select HAVE_FUNCTION_TRACER
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	select ARCH_HAS_NORMAL_FRAME_POINTERS
>  	select HAVE_IDE
>  	select HAVE_IOREMAP_PROT
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 4b63b6b..fc8cd1f 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -661,20 +661,24 @@ config DEBUG_NOTIFIERS
>  	  This is a relatively cheap check but if you care about maximum
>  	  performance, say N.
>  
> -#
> -# Select this config option from the architecture Kconfig, if it
> -# it is preferred to always offer frame pointers as a config
> -# option on the architecture (regardless of KERNEL_DEBUG):
> -#
>  config ARCH_WANT_FRAME_POINTERS
>  	bool
>  	help
> +	  Select this config option from the architecture Kconfig, if it
> +	  it is preferred to always offer frame pointers as a config
> +	  option on the architecture (regardless of KERNEL_DEBUG).
> +
> +config ARCH_HAS_NORMAL_FRAME_POINTERS
> +	bool
> +	help
> +	  Architectures should select this symbol if their ABI implies
> +	  having a frame pointer.
>  
>  config FRAME_POINTER
>  	bool "Compile the kernel with frame pointers"
>  	depends on DEBUG_KERNEL && \
>  		(CRIS || M68K || M68KNOMMU || FRV || UML || S390 || \
> -		 AVR32 || SUPERH || BLACKFIN || MN10300) || \
> +		 AVR32 || SUPERH || BLACKFIN || MN10300 || PPC) || \
>  		ARCH_WANT_FRAME_POINTERS
>  	default y if (DEBUG_INFO && UML) || ARCH_WANT_FRAME_POINTERS
>  	help
