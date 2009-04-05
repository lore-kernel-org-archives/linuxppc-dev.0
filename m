Return-Path: <sam@ravnborg.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by ozlabs.org (Postfix) with ESMTP id 4CC6FDDE11
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2009 07:05:55 +1000 (EST)
Date: Sun, 5 Apr 2009 23:07:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/3] powerpc,
	Makefile: Make it possible to safely select CONFIG_FRAME_POINTER
Message-ID: <20090405210756.GG24374@uranus.ravnborg.org>
References: <20090320164404.GA19933@oksana.dev.rtsoft.ru>
	<20090320164429.GA28037@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090320164429.GA28037@oksana.dev.rtsoft.ru>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 20, 2009 at 07:44:29PM +0300, Anton Vorontsov wrote:
> This patch introduces ARCH_HAS_NORMAL_FRAME_POINTERS Kconfig symbol.
> When defined, the top level Makefile won't add -fno-omit-frame-pointer
> cflag (the flag is useless in PowerPC kernels, and also makes gcc
> generate wrong code).
> 
> Also move ARCH_WANT_FRAME_POINTERS's help text.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Hi Anton - sorry for the late feedback.

1) The preferred naming for variables that are supposed to be selcted
   are "HAVE_xxxx".
   So in this case it would be:
   HAVE_NORMAL_FRAME_POINTER

2) I do not really understand the interpretation of normal in this case,
   can it be more specific?

   Looking at your patch then if specified we use "-fomit-frame-pointer"
   in the case where it is set.
   So I read it like:

      If arch has normal framepointer then we omit them - strange?

3) Indent in top-level MAkefile for new stuff is generally 8 spaces.
   Do NOT use tabs as this would confuse make and rener assignmnet non-functional.

4) The individual "HAVE_* members should be sorted alphabetically in the arch
   Kconfig file (which they seldomly are :-( )

	Sam

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
> -- 
> 1.5.6.5
> 
