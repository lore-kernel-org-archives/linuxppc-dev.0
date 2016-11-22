Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN7J65ClszDvxq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 12:32:38 +1100 (AEDT)
Date: Tue, 22 Nov 2016 09:32:24 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 Eric Biederman <ebiederm@xmission.com>,
 Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v10 04/10] kexec_file: Add support for purgatory built as
 PIE.
Message-ID: <20161122013224.GA8750@dhcp-128-65.nay.redhat.com>
References: <1478748449-3894-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1478748449-3894-5-git-send-email-bauerman@linux.vnet.ibm.com>
 <20161120024546.GA4413@dhcp-128-65.nay.redhat.com>
 <5009580.5GxAkTrMYA@morokweng>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5009580.5GxAkTrMYA@morokweng>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/21/16 at 09:49pm, Thiago Jung Bauermann wrote:
> Hello Dave,
> 
> Thanks for your review.
> 
> Am Sonntag, 20. November 2016, 10:45:46 BRST schrieb Dave Young:
> > On 11/10/16 at 01:27am, Thiago Jung Bauermann wrote:
> > > powerpc's purgatory.ro has 12 relocation types when built as
> > > a relocatable object. To implement support for them requires
> > > arch_kexec_apply_relocations_add to duplicate a lot of code with
> > > module_64.c:apply_relocate_add.
> > > 
> > > When built as a Position Independent Executable there are only 4
> > > relocation types in purgatory.ro, so it becomes practical for the powerpc
> > > implementation of kexec_file to have its own relocation implementation.
> > > 
> > > Also, the purgatory is an executable and not an intermediary output from
> > > the compiler so it makes sense conceptually that it is easier to build
> > > it as a PIE than as a partially linked object.
> > > 
> > > Apart from the greatly reduced number of relocations, there are two
> > > differences between a relocatable object and a PIE:
> > > 
> > > 1. __kexec_load_purgatory needs to use the program headers rather than the
> > > 
> > >    section headers to figure out how to load the binary.
> > > 
> > > 2. Symbol values are absolute addresses instead of relative to the
> > > 
> > >    start of the section.
> > > 
> > > This patch adds the support needed in generic code for the differences
> > > above and allows powerpc to load and relocate a position independent
> > > purgatory.
> > 
> > [snip]
> > 
> > The kexec-tools machine_apply_elf_rel is pretty simple for ppc64, it is
> > not that complex. So could you look into simplify your kexec_file
> > implementation?
> 
> I can try, but there is one fundamental issue here: powerpc position-dependent 
> code relies more on relocations than x86 position-dependent code does, so 
> there's a limit to how simple it can be made without switching to position-
> independent code. And it will always be more involved than it is on x86.
> 
> BTW, building x86's purgatory as PIE results in it not having any relocation 
> at all, so it's an advantage even in that architecture. Unfortunately, the 
> machine locks up during reboot and I didn't have time to try to figure out 
> what's going on.
> 
> > kernel/kexec_file.c kexec_apply_relocations only do limited things
> > and some of the logic is in arch/x86, so move general code out of arch
> > code, then I guess the arch code will be simpler
> 
> I agree that is a good idea. Is the patch below what you had in mind?
> 
> > and then we probably do not need this PIE stuff anymore.
> 
> If you are ok with the patch below I can post a new version of the series 
> based on it and we can see if Michael Ellerman thinks it is enough.
> 

Will review it and do a test. Thanks. I believe this will benefit for
other arches if they want a kexec_file in the future.

> > BTW, __kexec_really_load_purgatory looks worse than
> > ___kexec_load_purgatory ;)
> 
> Really? I find the special handling of bss makes the section-based loader a 
> bit more confusing.

I'm not sure I understand above about "*bss*", personally I like
___kexec_load_purgatory more. But anyway if we move arch code as general
code then it will be not necessary anymore..

> 
> -- 
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 
> 
> Subject: [PATCH] kexec_file: Move generic relocation code from arch/x86 to
>  kernel/kexec_file.c
> 
> The check for undefined symbols stays in arch-specific code because
> powerpc needs to allow TOC symbols to be processed even though they're
> undefined.
> 
> There is no functional change.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 160 +++++++------------------------------
>  include/linux/kexec.h              |   9 ++-
>  kernel/kexec_file.c                | 120 +++++++++++++++++++++++++++-
>  3 files changed, 154 insertions(+), 135 deletions(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 8c1f218926d7..f4860c408ece 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -401,143 +401,45 @@ int arch_kexec_kernel_verify_sig(struct kimage *image, void *kernel,
>  }
>  #endif
>  
> -/*
> - * Apply purgatory relocations.
> - *
> - * ehdr: Pointer to elf headers
> - * sechdrs: Pointer to section headers.
> - * relsec: section index of SHT_RELA section.
> - *
> - * TODO: Some of the code belongs to generic code. Move that in kexec.c.
> - */
> -int arch_kexec_apply_relocations_add(const Elf64_Ehdr *ehdr,
> -				     Elf64_Shdr *sechdrs, unsigned int relsec)
> +int arch_kexec_apply_relocation_add(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> +				    unsigned int reltype, Elf_Sym *sym,
> +				    const char *name, unsigned long *location,
> +				    unsigned long address, unsigned long value)
>  {
> -	unsigned int i;
> -	Elf64_Rela *rel;
> -	Elf64_Sym *sym;
> -	void *location;
> -	Elf64_Shdr *section, *symtabsec;
> -	unsigned long address, sec_base, value;
> -	const char *strtab, *name, *shstrtab;
> -
> -	/*
> -	 * ->sh_offset has been modified to keep the pointer to section
> -	 * contents in memory
> -	 */
> -	rel = (void *)sechdrs[relsec].sh_offset;
> -
> -	/* Section to which relocations apply */
> -	section = &sechdrs[sechdrs[relsec].sh_info];
> -
> -	pr_debug("Applying relocate section %u to %u\n", relsec,
> -		 sechdrs[relsec].sh_info);
> -
> -	/* Associated symbol table */
> -	symtabsec = &sechdrs[sechdrs[relsec].sh_link];
> -
> -	/* String table */
> -	if (symtabsec->sh_link >= ehdr->e_shnum) {
> -		/* Invalid strtab section number */
> -		pr_err("Invalid string table section index %d\n",
> -		       symtabsec->sh_link);
> +	if (sym->st_shndx == SHN_UNDEF) {
> +		pr_err("Undefined symbol: %s\n", name);
>  		return -ENOEXEC;
>  	}
>  
> -	strtab = (char *)sechdrs[symtabsec->sh_link].sh_offset;
> -
> -	/* section header string table */
> -	shstrtab = (char *)sechdrs[ehdr->e_shstrndx].sh_offset;
> -
> -	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
> -
> -		/*
> -		 * rel[i].r_offset contains byte offset from beginning
> -		 * of section to the storage unit affected.
> -		 *
> -		 * This is location to update (->sh_offset). This is temporary
> -		 * buffer where section is currently loaded. This will finally
> -		 * be loaded to a different address later, pointed to by
> -		 * ->sh_addr. kexec takes care of moving it
> -		 *  (kexec_load_segment()).
> -		 */
> -		location = (void *)(section->sh_offset + rel[i].r_offset);
> -
> -		/* Final address of the location */
> -		address = section->sh_addr + rel[i].r_offset;
> -
> -		/*
> -		 * rel[i].r_info contains information about symbol table index
> -		 * w.r.t which relocation must be made and type of relocation
> -		 * to apply. ELF64_R_SYM() and ELF64_R_TYPE() macros get
> -		 * these respectively.
> -		 */
> -		sym = (Elf64_Sym *)symtabsec->sh_offset +
> -				ELF64_R_SYM(rel[i].r_info);
> -
> -		if (sym->st_name)
> -			name = strtab + sym->st_name;
> -		else
> -			name = shstrtab + sechdrs[sym->st_shndx].sh_name;
> -
> -		pr_debug("Symbol: %s info: %02x shndx: %02x value=%llx size: %llx\n",
> -			 name, sym->st_info, sym->st_shndx, sym->st_value,
> -			 sym->st_size);
> -
> -		if (sym->st_shndx == SHN_UNDEF) {
> -			pr_err("Undefined symbol: %s\n", name);
> -			return -ENOEXEC;
> -		}
> -
> -		if (sym->st_shndx == SHN_COMMON) {
> -			pr_err("symbol '%s' in common section\n", name);
> -			return -ENOEXEC;
> -		}
> -
> -		if (sym->st_shndx == SHN_ABS)
> -			sec_base = 0;
> -		else if (sym->st_shndx >= ehdr->e_shnum) {
> -			pr_err("Invalid section %d for symbol %s\n",
> -			       sym->st_shndx, name);
> -			return -ENOEXEC;
> -		} else
> -			sec_base = sechdrs[sym->st_shndx].sh_addr;
> -
> -		value = sym->st_value;
> -		value += sec_base;
> -		value += rel[i].r_addend;
> -
> -		switch (ELF64_R_TYPE(rel[i].r_info)) {
> -		case R_X86_64_NONE:
> -			break;
> -		case R_X86_64_64:
> -			*(u64 *)location = value;
> -			break;
> -		case R_X86_64_32:
> -			*(u32 *)location = value;
> -			if (value != *(u32 *)location)
> -				goto overflow;
> -			break;
> -		case R_X86_64_32S:
> -			*(s32 *)location = value;
> -			if ((s64)value != *(s32 *)location)
> -				goto overflow;
> -			break;
> -		case R_X86_64_PC32:
> -			value -= (u64)address;
> -			*(u32 *)location = value;
> -			break;
> -		default:
> -			pr_err("Unknown rela relocation: %llu\n",
> -			       ELF64_R_TYPE(rel[i].r_info));
> -			return -ENOEXEC;
> -		}
> +	switch (reltype) {
> +	case R_X86_64_NONE:
> +		break;
> +	case R_X86_64_64:
> +		*(u64 *)location = value;
> +		break;
> +	case R_X86_64_32:
> +		*(u32 *)location = value;
> +		if (value != *(u32 *)location)
> +			goto overflow;
> +		break;
> +	case R_X86_64_32S:
> +		*(s32 *)location = value;
> +		if ((s64)value != *(s32 *)location)
> +			goto overflow;
> +		break;
> +	case R_X86_64_PC32:
> +		value -= (u64)address;
> +		*(u32 *)location = value;
> +		break;
> +	default:
> +		pr_err("Unknown rela relocation: %u\n", reltype);
> +		return -ENOEXEC;
>  	}
> +
>  	return 0;
>  
>  overflow:
> -	pr_err("Overflow in relocation type %d value 0x%lx\n",
> -	       (int)ELF64_R_TYPE(rel[i].r_info), value);
> +	pr_err("Overflow in relocation type %u value 0x%lx\n", reltype, value);
>  	return -ENOEXEC;
>  }
>  #endif /* CONFIG_KEXEC_FILE */
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 406c33dcae13..e171a083540d 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -320,8 +320,13 @@ void * __weak arch_kexec_kernel_image_load(struct kimage *image);
>  int __weak arch_kimage_file_post_load_cleanup(struct kimage *image);
>  int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  					unsigned long buf_len);
> -int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
> -					Elf_Shdr *sechdrs, unsigned int relsec);
> +int __weak arch_kexec_apply_relocation_add(const Elf_Ehdr *ehdr,
> +					   Elf_Shdr *sechdrs,
> +					   unsigned int reltype, Elf_Sym *sym,
> +					   const char *name,
> +					   unsigned long *location,
> +					   unsigned long address,
> +					   unsigned long value);
>  int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>  					unsigned int relsec);
>  void arch_kexec_protect_crashkres(void);
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 037c321c5618..1517f977cc25 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -61,8 +61,10 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  
>  /* Apply relocations of type RELA */
>  int __weak
> -arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> -				 unsigned int relsec)
> +arch_kexec_apply_relocation_add(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> +				unsigned int reltype, Elf_Sym *sym,
> +				const char *name, unsigned long *location,
> +				unsigned long address, unsigned long value)
>  {
>  	pr_err("RELA relocation unsupported.\n");
>  	return -ENOEXEC;
> @@ -793,6 +795,117 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
>  	return ret;
>  }
>  
> +/**
> + * kexec_apply_relocations_add - apply purgatory relocations
> + * @ehdr:	Pointer to elf headers
> + * @sechdrs:	Pointer to section headers.
> + * @relsec:	Section index of SHT_RELA section.
> + */
> +static int kexec_apply_relocations_add(const Elf64_Ehdr *ehdr,
> +				       Elf64_Shdr *sechdrs, unsigned int relsec)
> +{
> +	int ret;
> +	unsigned int i;
> +	Elf64_Rela *rel;
> +	Elf64_Sym *sym;
> +	void *location;
> +	Elf64_Shdr *section, *symtabsec;
> +	unsigned long address, sec_base, value;
> +	const char *strtab, *name, *shstrtab;
> +
> +	/*
> +	 * ->sh_offset has been modified to keep the pointer to section
> +	 * contents in memory
> +	 */
> +	rel = (void *)sechdrs[relsec].sh_offset;
> +
> +	/* Section to which relocations apply */
> +	section = &sechdrs[sechdrs[relsec].sh_info];
> +
> +	pr_debug("Applying relocate section %u to %u\n", relsec,
> +		 sechdrs[relsec].sh_info);
> +
> +	/* Associated symbol table */
> +	symtabsec = &sechdrs[sechdrs[relsec].sh_link];
> +
> +	/* String table */
> +	if (symtabsec->sh_link >= ehdr->e_shnum) {
> +		/* Invalid strtab section number */
> +		pr_err("Invalid string table section index %d\n",
> +		       symtabsec->sh_link);
> +		return -ENOEXEC;
> +	}
> +
> +	/* String table for the associated symbol table. */
> +	strtab = (char *)sechdrs[symtabsec->sh_link].sh_offset;
> +
> +	/* section header string table */
> +	shstrtab = (char *)sechdrs[ehdr->e_shstrndx].sh_offset;
> +
> +	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
> +
> +		/*
> +		 * rel[i].r_offset contains byte offset from beginning
> +		 * of section to the storage unit affected.
> +		 *
> +		 * This is location to update (->sh_offset). This is temporary
> +		 * buffer where section is currently loaded. This will finally
> +		 * be loaded to a different address later, pointed to by
> +		 * ->sh_addr. kexec takes care of moving it
> +		 *  (kexec_load_segment()).
> +		 */
> +		location = (void *)(section->sh_offset + rel[i].r_offset);
> +
> +		/* Final address of the location */
> +		address = section->sh_addr + rel[i].r_offset;
> +
> +		/*
> +		 * rel[i].r_info contains information about symbol table index
> +		 * w.r.t which relocation must be made and type of relocation
> +		 * to apply. ELF64_R_SYM() and ELF64_R_TYPE() macros get
> +		 * these respectively.
> +		 */
> +		sym = (Elf64_Sym *)symtabsec->sh_offset +
> +				ELF64_R_SYM(rel[i].r_info);
> +
> +		if (sym->st_name)
> +			name = strtab + sym->st_name;
> +		else
> +			name = shstrtab + sechdrs[sym->st_shndx].sh_name;
> +
> +		pr_debug("Symbol: %s info: %02x shndx: %02x value=%llx size: %llx\n",
> +			 name, sym->st_info, sym->st_shndx, sym->st_value,
> +			 sym->st_size);
> +
> +		if (sym->st_shndx == SHN_COMMON) {
> +			pr_err("symbol '%s' in common section\n", name);
> +			return -ENOEXEC;
> +		}
> +
> +		if (sym->st_shndx == SHN_ABS)
> +			sec_base = 0;
> +		else if (sym->st_shndx >= ehdr->e_shnum) {
> +			pr_err("Invalid section %d for symbol %s\n",
> +			       sym->st_shndx, name);
> +			return -ENOEXEC;
> +		} else
> +			sec_base = sechdrs[sym->st_shndx].sh_addr;
> +
> +		value = sym->st_value;
> +		value += sec_base;
> +		value += rel[i].r_addend;
> +
> +		ret = arch_kexec_apply_relocation_add(ehdr, sechdrs,
> +						      ELF64_R_TYPE(rel[i].r_info),
> +						      sym, name, location,
> +						      address, value);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int kexec_apply_relocations(struct kimage *image)
>  {
>  	int i, ret;
> @@ -836,8 +949,7 @@ static int kexec_apply_relocations(struct kimage *image)
>  		 * relocations of type SHT_RELA/SHT_REL.
>  		 */
>  		if (sechdrs[i].sh_type == SHT_RELA)
> -			ret = arch_kexec_apply_relocations_add(pi->ehdr,
> -							       sechdrs, i);
> +			ret = kexec_apply_relocations_add(pi->ehdr, sechdrs, i);
>  		else if (sechdrs[i].sh_type == SHT_REL)
>  			ret = arch_kexec_apply_relocations(pi->ehdr,
>  							   sechdrs, i);
> -- 
> 2.7.4
> 
> 
