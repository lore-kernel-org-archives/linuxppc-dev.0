Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4F481A05FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 12:11:41 +1100 (AEDT)
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43F56140B9A
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 12:11:41 +1100 (AEDT)
Received: by mail-pa0-x232.google.com with SMTP id ho8so22855989pac.2
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 17:11:41 -0800 (PST)
Subject: Re: [PATCH 10/12] powerpc/ftrace: FTRACE_WITH_REGS configuration
 variables
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-10-git-send-email-mpe@ellerman.id.au>
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56CE54C5.1060204@gmail.com>
Date: Thu, 25 Feb 2016 12:11:33 +1100
MIME-Version: 1.0
In-Reply-To: <1456324115-21144-10-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 25/02/16 01:28, Michael Ellerman wrote:
> From: Torsten Duwe <duwe@lst.de>
>
> * arch/powerpc/Makefile:
>     - globally use -mprofile-kernel in case it's configured,
>       available and bug-free.
>   * arch/powerpc/gcc-mprofile-kernel-notrace.sh:
>     - make sure -mprofile-kernel works and has none of the
>       known bugs.
>   * arch/powerpc/kernel/ftrace.c:
>     - error out on compile with HAVE_DYNAMIC_FTRACE_WITH_REGS
>       and a buggy compiler.
>   * arch/powerpc/Kconfig / kernel/trace/Kconfig:
>     - declare that ppc64le HAVE_MPROFILE_KERNEL and
>       HAVE_DYNAMIC_FTRACE_WITH_REGS, and use it.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/Kconfig                        |  2 ++
>  arch/powerpc/Makefile                       | 17 +++++++++++++++
>  arch/powerpc/gcc-mprofile-kernel-notrace.sh | 33 +++++++++++++++++++++++++++++
>  arch/powerpc/kernel/ftrace.c                |  5 +++++
>  kernel/trace/Kconfig                        |  5 +++++
>  5 files changed, 62 insertions(+)
>  create mode 100755 arch/powerpc/gcc-mprofile-kernel-notrace.sh
>
> FIXME, needs more work. We can't break the build for someone with an
> unsupported toolchain.
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index e4824fd04bb7..e5f288ca7e12 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -94,8 +94,10 @@ config PPC
>  	select OF_RESERVED_MEM
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_DYNAMIC_FTRACE
> +	select HAVE_DYNAMIC_FTRACE_WITH_REGS if PPC64 && CPU_LITTLE_ENDIAN
>  	select HAVE_FUNCTION_TRACER
>  	select HAVE_FUNCTION_GRAPH_TRACER
> +	select HAVE_MPROFILE_KERNEL if PPC64 && CPU_LITTLE_ENDIAN
>  	select SYSCTL_EXCEPTION_TRACE
>  	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	select VIRT_TO_BUS if !PPC64
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 96efd8213c1c..08a39523e17a 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -133,6 +133,23 @@ else
>  CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
>  endif
>  
> +ifeq ($(CONFIG_PPC64),y)
> +ifdef CONFIG_HAVE_MPROFILE_KERNEL
> +
> +ifdef CONFIG_DYNAMIC_FTRACE
> +ifeq ($(shell $(CONFIG_SHELL) $(srctree)/arch/powerpc/gcc-mprofile-kernel-notrace.sh $(CC) -I$(srctree)/include -D__KERNEL__), y)
> +CC_USING_MPROFILE_KERNEL := -mprofile-kernel
> +endif
> +endif
> +
> +ifdef CC_USING_MPROFILE_KERNEL
> +CC_FLAGS_FTRACE	:= -pg $(CC_USING_MPROFILE_KERNEL)
> +KBUILD_CPPFLAGS	+= -DCC_USING_MPROFILE_KERNEL
> +endif
> +
> +endif
> +endif
> +
>  CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
>  CFLAGS-$(CONFIG_POWER4_CPU) += $(call cc-option,-mcpu=power4)
>  CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
> diff --git a/arch/powerpc/gcc-mprofile-kernel-notrace.sh b/arch/powerpc/gcc-mprofile-kernel-notrace.sh
> new file mode 100755
> index 000000000000..68d6482d56ab
> --- /dev/null
> +++ b/arch/powerpc/gcc-mprofile-kernel-notrace.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +# Test whether the compile option -mprofile-kernel
> +# generates profiling code ( = a call to mcount), and
> +# whether a function without any global references sets
> +# the TOC pointer properly at the beginning, and
> +# whether the "notrace" function attribute successfully
> +# suppresses the _mcount call.
> +
> +echo "int func() { return 0; }" | \
> +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> +    grep -q "mcount"
> +
> +trace_result=$?
> +
> +echo "int func() { return 0; }" | \
> +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> +    sed -n -e '/func:/,/bl _mcount/p' | grep -q TOC
> +
> +leaf_toc_result=$?
> +
We should remove this bit, we don't need a TOC for leaf procedures anymore
> +/bin/echo -e "#include <linux/compiler.h>\nnotrace int func() { return 0; }" | \
> +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> +    grep -q "mcount"
> +
> +notrace_result=$?
> +
> +if [ "$trace_result" -eq "0" -a \
> +	"$leaf_toc_result" -eq "0" -a \
> +	"$notrace_result" -eq "1" ]; then
> +	echo y
> +else
> +	echo n
> +fi
> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> index 56e5bd53c323..f190528e3781 100644
> --- a/arch/powerpc/kernel/ftrace.c
> +++ b/arch/powerpc/kernel/ftrace.c
> @@ -28,6 +28,11 @@
>  
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
> +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS) && defined(CONFIG_PPC64) && \
> +  !defined(CC_USING_MPROFILE_KERNEL)
> +#error "DYNAMIC_FTRACE_WITH_REGS requires working -mprofile-kernel"
> +#endif
> +
>  static unsigned int
>  ftrace_call_replace(unsigned long ip, unsigned long addr, int link)
>  {
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index e45db6b0d878..a138f6d866ae 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -52,6 +52,11 @@ config HAVE_FENTRY
>  	help
>  	  Arch supports the gcc options -pg with -mfentry
>  
> +config HAVE_MPROFILE_KERNEL
> +	bool
> +	help
> +	  Arch supports the gcc options -pg with -mprofile-kernel
> +
>  config HAVE_C_RECORDMCOUNT
>  	bool
>  	help
