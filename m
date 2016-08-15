Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCSHW3SHfzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 17:46:47 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y134so3343098pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 00:46:47 -0700 (PDT)
Date: Mon, 15 Aug 2016 17:46:34 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 04/13] powerpc: Factor out relocation code from
 module_64.c to elf_util_64.c.
Message-ID: <20160815074634.GC21080@balbir.ozlabs.ibm.com>
Reply-To: bsingharora@gmail.com
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956898-5991-5-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470956898-5991-5-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2016 at 08:08:09PM -0300, Thiago Jung Bauermann wrote:
> The kexec_file_load system call needs to relocate the purgatory, so
> factor out the module relocation code so that it can be shared.
> 
> This patch's purpose is to move the ELF relocation logic from
> apply_relocate_add to elf_util_64.c with as few changes as
> possible. The following changes were needed:
> 
> To avoid having module-specific code in a general purpose utility
> function, struct elf_info was created to contain the information
> needed for ELF binaries manipulation.
> 
> my_r2, stub_for_addr and create_stub were changed to use it instead of
> having to receive a struct module, since they are called from
> elf64_apply_relocate_add.
> 
> local_entry_offset and squash_toc_save_inst were only used by
> apply_rellocate_add, so they were moved to elf_util_64.c as well.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/elf_util.h |  70 ++++++++
>  arch/powerpc/include/asm/module.h   |  14 +-
>  arch/powerpc/kernel/Makefile        |   4 +
>  arch/powerpc/kernel/elf_util_64.c   | 269 +++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/module_64.c     | 312 ++++--------------------------------
>  5 files changed, 386 insertions(+), 283 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/elf_util.h b/arch/powerpc/include/asm/elf_util.h
> new file mode 100644
> index 000000000000..37372559fe62
> --- /dev/null
> +++ b/arch/powerpc/include/asm/elf_util.h
> @@ -0,0 +1,70 @@
> +/*
> + * Utility functions to work with ELF files.
> + *
> + * Copyright (C) 2016, IBM Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _ASM_POWERPC_ELF_UTIL_H
> +#define _ASM_POWERPC_ELF_UTIL_H
> +
> +#include <linux/elf.h>
> +
> +struct elf_info {
> +	struct elf_shdr *sechdrs;
> +
> +	/* Index of stubs section. */
> +	unsigned int stubs_section;
> +	/* Index of TOC section. */
> +	unsigned int toc_section;
> +};
> +
> +#ifdef __powerpc64__
> +#ifdef PPC64_ELF_ABI_v2
> +
> +/* An address is simply the address of the function. */
> +typedef unsigned long func_desc_t;
> +#else
> +
> +/* An address is address of the OPD entry, which contains address of fn. */
> +typedef struct ppc64_opd_entry func_desc_t;
> +#endif /* PPC64_ELF_ABI_v2 */
> +
> +/* Like PPC32, we need little trampolines to do > 24-bit jumps (into
> +   the kernel itself).  But on PPC64, these need to be used for every
> +   jump, actually, to reset r2 (TOC+0x8000). */
> +struct ppc64_stub_entry
> +{
> +	/* 28 byte jump instruction sequence (7 instructions). We only
> +	 * need 6 instructions on ABIv2 but we always allocate 7 so
> +	 * so we don't have to modify the trampoline load instruction. */
> +	u32 jump[7];
> +	/* Used by ftrace to identify stubs */
> +	u32 magic;
> +	/* Data for the above code */
> +	func_desc_t funcdata;
> +};
> +#endif
> +
> +/* r2 is the TOC pointer: it actually points 0x8000 into the TOC (this
> +   gives the value maximum span in an instruction which uses a signed
> +   offset) */
> +static inline unsigned long my_r2(const struct elf_info *elf_info)
> +{
> +	return elf_info->sechdrs[elf_info->toc_section].sh_addr + 0x8000;
> +}
> +
> +int elf64_apply_relocate_add(const struct elf_info *elf_info,
> +			     const char *strtab, unsigned int symindex,
> +			     unsigned int relsec, const char *obj_name);
> +
> +#endif /* _ASM_POWERPC_ELF_UTIL_H */
> diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
> index cd4ffd86765f..f2073115d518 100644
> --- a/arch/powerpc/include/asm/module.h
> +++ b/arch/powerpc/include/asm/module.h
> @@ -12,7 +12,14 @@
>  #include <linux/list.h>
>  #include <asm/bug.h>
>  #include <asm-generic/module.h>
> +#include <asm/elf_util.h>
>  
> +/* Both low and high 16 bits are added as SIGNED additions, so if low
> +   16 bits has high bit set, high 16 bits must be adjusted.  These
> +   macros do that (stolen from binutils). */
> +#define PPC_LO(v) ((v) & 0xffff)
> +#define PPC_HI(v) (((v) >> 16) & 0xffff)
> +#define PPC_HA(v) PPC_HI ((v) + 0x8000)
>  
>  #ifndef __powerpc64__
>  /*
> @@ -33,8 +40,7 @@ struct ppc_plt_entry {
>  
>  struct mod_arch_specific {
>  #ifdef __powerpc64__
> -	unsigned int stubs_section;	/* Index of stubs section in module */
> -	unsigned int toc_section;	/* What section is the TOC? */
> +	struct elf_info elf_info;
>  	bool toc_fixed;			/* Have we fixed up .TOC.? */
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  	unsigned long toc;
> @@ -90,6 +96,10 @@ static inline int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sec
>  }
>  #endif
>  
> +unsigned long stub_for_addr(const struct elf_info *elf_info, unsigned long addr,
> +			    const char *obj_name);
> +int restore_r2(u32 *instruction, const char *obj_name);
> +
>  struct exception_table_entry;
>  void sort_ex_table(struct exception_table_entry *start,
>  		   struct exception_table_entry *finish);
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index b2027a5cf508..e38aace0a6e7 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -123,6 +123,10 @@ ifneq ($(CONFIG_PPC_INDIRECT_PIO),y)
>  obj-y				+= iomap.o
>  endif
>  
> +ifeq ($(CONFIG_MODULES)$(CONFIG_WORD_SIZE),y64)
> +obj-y				+= elf_util_64.o
> +endif
> +
>  obj64-$(CONFIG_PPC_TRANSACTIONAL_MEM)	+= tm.o
>  
>  obj-$(CONFIG_PPC64)		+= $(obj64-y)
> diff --git a/arch/powerpc/kernel/elf_util_64.c b/arch/powerpc/kernel/elf_util_64.c
> new file mode 100644
> index 000000000000..decad2c34f38
> --- /dev/null
> +++ b/arch/powerpc/kernel/elf_util_64.c
> @@ -0,0 +1,269 @@
> +/*
> + * Utility functions to work with ELF files.
> + *
> + * Copyright (C) 2016, IBM Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <asm/ppc-opcode.h>
> +#include <asm/elf_util.h>
> +
> +/*
> + * We just need to use the functions defined in <asm/module.h>, so just declare
> + * struct module here and avoid having to import <linux/module.h>.
> + */
> +struct module;
> +#include <asm/module.h>
> +
> +#ifdef PPC64_ELF_ABI_v2
> +/* PowerPC64 specific values for the Elf64_Sym st_other field.  */
> +#define STO_PPC64_LOCAL_BIT	5
> +#define STO_PPC64_LOCAL_MASK	(7 << STO_PPC64_LOCAL_BIT)
> +#define PPC64_LOCAL_ENTRY_OFFSET(other)					\
> + (((1 << (((other) & STO_PPC64_LOCAL_MASK) >> STO_PPC64_LOCAL_BIT)) >> 2) << 2)
> +
> +static unsigned int local_entry_offset(const Elf64_Sym *sym)
> +{
> +	/* sym->st_other indicates offset to local entry point
> +	 * (otherwise it will assume r12 is the address of the start
> +	 * of function and try to derive r2 from it). */
> +	return PPC64_LOCAL_ENTRY_OFFSET(sym->st_other);
> +}
> +#else
> +static unsigned int local_entry_offset(const Elf64_Sym *sym)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#ifdef CC_USING_MPROFILE_KERNEL
> +/*
> + * In case of _mcount calls, do not save the current callee's TOC (in r2) into
> + * the original caller's stack frame. If we did we would clobber the saved TOC
> + * value of the original caller.
> + */
> +static void squash_toc_save_inst(const char *name, unsigned long addr)
> +{
> +	struct ppc64_stub_entry *stub = (struct ppc64_stub_entry *)addr;
> +
> +	/* Only for calls to _mcount */
> +	if (strcmp("_mcount", name) != 0)
> +		return;
> +
> +	stub->jump[2] = PPC_INST_NOP;
> +}
> +#else
> +static void squash_toc_save_inst(const char *name, unsigned long addr) { }
> +#endif
> +
> +/**
> + * elf64_apply_relocate_add - apply 64 bit RELA relocations
> + * @elf_info:		Support information for the ELF binary being relocated.
> + * @strtab:		String table for the associated symbol table.
> + * @symindex:		Section header index for the associated symbol table.
> + * @relsec:		Section header index for the relocations to apply.
> + * @obj_name:		The name of the ELF binary, for information messages.
> + */
> +int elf64_apply_relocate_add(const struct elf_info *elf_info,
> +			     const char *strtab, unsigned int symindex,
> +			     unsigned int relsec, const char *obj_name)
> +{
> +	unsigned int i;
> +	Elf64_Shdr *sechdrs = elf_info->sechdrs;
> +	Elf64_Rela *rela = (void *)sechdrs[relsec].sh_addr;
> +	Elf64_Sym *sym;
> +	unsigned long *location;
> +	unsigned long value;
> +


For the relocatable kernel we expect only

R_PPC64_RELATIVE
R_PPC64_NONE
R_PPC64_ADDR64

In the future we can use this to check/assert the usage of this
for the core kernel (vmlinux) when loaded.

Did we check elf64_apply_relocate_add with zImage and vmlinux?

Balbir Singh
