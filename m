Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D71EC1A0688
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2015 03:20:12 +1100 (AEDT)
Date: Thu, 3 Dec 2015 17:20:08 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v4 4/9] ppc64 ftrace_with_regs configuration variables
Message-ID: <20151203162008.GF8047@pathway.suse.cz>
References: <20151125172608.9588569260@newverein.lst.de>
 <20151125172916.9D50269260@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151125172916.9D50269260@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 2015-11-25 17:37:33, Torsten Duwe wrote:
>   * Makefile:
>     - globally use -mprofile-kernel in case it's configured.
>   * arch/powerpc/Kconfig / kernel/trace/Kconfig:
>     - declare that ppc64le HAVE_MPROFILE_KERNEL and
>       HAVE_DYNAMIC_FTRACE_WITH_REGS, and use it.
> 
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -133,6 +133,13 @@ else
>  CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
>  endif
>  
> +ifeq ($(CONFIG_PPC64),y)
> +ifdef CONFIG_HAVE_MPROFILE_KERNEL
> +CC_FLAGS_FTRACE	:= -pg $(call cc-option,-mprofile-kernel)

Do we want to define -pg even when -mprofile-kernel is not supported
by the used gcc, please?

> +KBUILD_CPPFLAGS	+= -DCC_USING_MPROFILE_KERNEL

IMHO, we should not define CC_USING_MPROFILE_KERNEL if it is not
supported by the compiler.

I took inspiration from the CC_USING_FENTRY handling in
linux/Makefile. The following code worked for me:

CC_USING_MPROFILE_KERNEL := $(call cc-option, -pg -mprofile-kernel -DCC_USING_MPROFILE_KERNEL)
CC_FLAGS_FTRACE := $(CC_USING_MPROFILE_KERNEL)
KBUILD_CPPFLAGS += $(CC_USING_MPROFILE_KERNEL)

I just do not understand why we need to add the flags also
to KBUILD_CPPFLAGS. It seems that they are duplicated
when compiling kernel/livepatch/core.o. But livepatching
did not work without it. I wonder if you found the culprit.

Best Regards,
Petr

> +endif
> +endif
> +
>  CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
>  CFLAGS-$(CONFIG_POWER4_CPU) += $(call cc-option,-mcpu=power4)
>  CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
