Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCE4D1A1A24
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 22:48:34 +1100 (AEDT)
Message-ID: <1450439308.22320.6.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Enable UBSAN support
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, andrew.donnellan@au1.ibm.com, Andrey
 Ryabinin <aryabinin@virtuozzo.com>, Daniel Axtens <dja@axtens.net>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Fri, 18 Dec 2015 22:48:28 +1100
In-Reply-To: <1450151187-24041-1-git-send-email-dja@axtens.net>
References: <1450151187-24041-1-git-send-email-dja@axtens.net>
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

On Tue, 2015-12-15 at 14:46 +1100, Daniel Axtens wrote:

> This hooks up UBSAN support for PowerPC.
> 
> So far it's found some interesting cases where we don't properly sanitise
> input to shifts, including one in our futex handling. It's also found an
> out of bounds read in an array. Nothing critical, but worth fixing.
> 
> Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> CC: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
> 
> RFC -> v1:
>  - Update patch to use fixed spelling of SANITIZE.
>  - Include tested by tag from Andrew - Thanks!
> 
> This applies on top of next with Andrey's patches:
>  1) https://patchwork.kernel.org/patch/7761341/
>  2) https://patchwork.kernel.org/patch/7761351/
>  3) https://patchwork.kernel.org/patch/7761361/
>  4) https://patchwork.kernel.org/patch/7785791/
>  5) https://patchwork.kernel.org/patch/7819661/
> 
> -mm and therefore -next have these patches, and the RFC of this
> patch.

Thanks Daniel, looks good, if there's other files that need excluding we can
add them later.

akpm please take this version into mm.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers


> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 25283796a02e..171d4e4b015d 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -156,6 +156,7 @@ config PPC
>  	select EDAC_ATOMIC_SCRUB
>  	select ARCH_HAS_DMA_SET_COHERENT_MASK
>  	select HAVE_ARCH_SECCOMP_FILTER
> +	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  
>  config GENERIC_CSUM
>  	def_bool CPU_LITTLE_ENDIAN
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index ba336930d448..794f22adf99d 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -136,12 +136,18 @@ endif
>  obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
>  obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
>  
> -# Disable GCOV in odd or sensitive code
> +# Disable GCOV & sanitizers in odd or sensitive code
>  GCOV_PROFILE_prom_init.o := n
> +UBSAN_SANITIZE_prom_init.o := n
>  GCOV_PROFILE_ftrace.o := n
> +UBSAN_SANITIZE_ftrace.o := n
>  GCOV_PROFILE_machine_kexec_64.o := n
> +UBSAN_SANITIZE_machine_kexec_64.o := n
>  GCOV_PROFILE_machine_kexec_32.o := n
> +UBSAN_SANITIZE_machine_kexec_32.o := n
>  GCOV_PROFILE_kprobes.o := n
> +UBSAN_SANITIZE_kprobes.o := n
> +UBSAN_SANITIZE_vdso.o := n
>  
>  extra-$(CONFIG_PPC_FPU)		+= fpu.o
>  extra-$(CONFIG_ALTIVEC)		+= vector.o
> diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
> index 6abffb7a8cd9..cbabd143acae 100644
> --- a/arch/powerpc/kernel/vdso32/Makefile
> +++ b/arch/powerpc/kernel/vdso32/Makefile
> @@ -15,6 +15,7 @@ targets := $(obj-vdso32) vdso32.so vdso32.so.dbg
>  obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
>  
>  GCOV_PROFILE := n
> +UBSAN_SANITIZE := n
>  
>  ccflags-y := -shared -fno-common -fno-builtin
>  ccflags-y += -nostdlib -Wl,-soname=linux-vdso32.so.1 \
> diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
> index 8c8f2ae43935..c710802b8fb6 100644
> --- a/arch/powerpc/kernel/vdso64/Makefile
> +++ b/arch/powerpc/kernel/vdso64/Makefile
> @@ -8,6 +8,7 @@ targets := $(obj-vdso64) vdso64.so vdso64.so.dbg
>  obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
>  
>  GCOV_PROFILE := n
> +UBSAN_SANITIZE := n
>  
>  ccflags-y := -shared -fno-common -fno-builtin
>  ccflags-y += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
> diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
> index 1278788d96e3..436062dbb6e2 100644
> --- a/arch/powerpc/xmon/Makefile
> +++ b/arch/powerpc/xmon/Makefile
> @@ -3,6 +3,7 @@
>  subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
>  
>  GCOV_PROFILE := n
> +UBSAN_SANITIZE := n
>  
>  ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
>  
