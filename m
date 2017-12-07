Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysvpf02NPzDsNJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2017 23:26:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, amodra@gmail.com
Cc: desnesn@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 ard.biesheuvel@linaro.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] [powerpc-next] Fix powerpc64 alignment of .toc section in
 kernel modules
In-Reply-To: <20171206191228.30830-1-desnesn@linux.vnet.ibm.com>
References: <20171206191228.30830-1-desnesn@linux.vnet.ibm.com>
Date: Thu, 07 Dec 2017 23:25:57 +1100
Message-ID: <877etylo6i.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Desnes,

Am I right that Alan largely wrote this patch?

If so it should probably be From: him, so that he is the author in the
git log.


Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 1381693..c472f5b 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -63,6 +63,7 @@ UTS_MACHINE := $(subst $(space),,$(machine-y))
>  ifdef CONFIG_PPC32
>  KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
>  else
> +KBUILD_LDFLAGS_MODULE += -T arch/powerpc/kernel/module.lds

This needs to be:

KBUILD_LDFLAGS_MODULE += -T $(srctree)/arch/powerpc/kernel/module.lds

Otherwise building with O=../build fails with:

  ld: cannot open linker script file arch/powerpc/kernel/module.lds: No such file or directory

I'll fix it up.

> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> index 759104b..9b2c5c1 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -374,11 +377,13 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
>  }
>  
>  /* r2 is the TOC pointer: it actually points 0x8000 into the TOC (this
> -   gives the value maximum span in an instruction which uses a signed
> -   offset) */
> + * gives the value maximum span in an instruction which uses a signed
> + * offset).  Round down to a 256 byte boundary for the odd case where
> + * we are setting up r2 without a .toc section.
> + */
>  static inline unsigned long my_r2(const Elf64_Shdr *sechdrs, struct module *me)
>  {
> -	return sechdrs[me->arch.toc_section].sh_addr + 0x8000;
> +	return (sechdrs[me->arch.toc_section].sh_addr & -256) + 0x8000;

I think it's more typical in the kernel to write -256 as ~0xff.

Again I can fix it up.

cheers
