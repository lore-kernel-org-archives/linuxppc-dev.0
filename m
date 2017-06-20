Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsGHd09MszDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:14:52 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5K5Egrt075720
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 01:14:50 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b6qen4s5g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 01:14:50 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 15:14:47 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5K5Ea1n131364
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:14:44 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5K5ECUW027010
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:14:12 +1000
Subject: Re: [PATCH] powerpc/modules: Introduce new stub code for
 SHN_LIVEPATCH symbols
To: linuxppc-dev@lists.ozlabs.org
References: <1497336619-17954-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
 live-patching@vger.kernel.org
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Tue, 20 Jun 2017 10:43:54 +0530
MIME-Version: 1.0
In-Reply-To: <1497336619-17954-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <800806c4-5224-95fd-d5ff-c0e75950ff0b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Any thoughts/suggestions on the approach ?


On Tuesday 13 June 2017 12:20 PM, Kamalesh Babulal wrote:
> R_PPC64_REL24 relocation type is used for a function call, where the
> function symbol address is resolved and stub code (a.k.a trampoline)
> is constructed to jump into the global entry of the function. The
> caller is responsible for setting up the TOC of the called function
> before branching and NOP is expected after every branch, which gets
> replaced with an instruction to restore the callers TOC from the
> stack on return.
>
> SHN_LIVEPATCH symbols with R_PPC64_REL24 relocation type might not
> adhere to nop instruction after a branch. The reason being called
> function was local to the callee and the instruction sequence
> generated does not stores and restores the TOC value onto the stack
> of the calling function, which is right instead uses the localentry
> (function entry + 0x8) to jump into the function and returns without
> the need for store/restoring the TOC, as both of the functions were
> in the same compilation unit.
>
> When such functions become global because they are livepatched and
> every call to the function, re-directs the callee to the patched
> version in the module. Every branch from the livepatch module, to
> previously local function turns out to jump into the kernel code
> but with the code, sequence remains that of the localentry. This
> leads to error while trying to access the function with assumption.
>
> insmod: ERROR: could not insert module ./kpatch-meminfo-string.ko: Invalid module format
>
> Jun 13 02:10:47 ubuntu kernel: [   37.774292] module_64: kpatch_meminfo_string: REL24 -1152921504749690968 out of range!
>
> SHN_LIVEPATCH symbols + R_PPC64_REL24 type relocation should be handled
> by introducing a new stub code sequence, instead of regular stub code.
> Where stub takes care of storing and restoring the Link Register/TOC
> onto the stack of the livepatched function and restores them upon
> return from the called function.
>
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: live-patching@vger.kernel.org
> ---
>  arch/powerpc/kernel/module_64.c | 55 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 44 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> index 0b0f896..52ded0f 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -102,10 +102,16 @@ static unsigned int local_entry_offset(const Elf64_Sym *sym)
>     jump, actually, to reset r2 (TOC+0x8000). */
>  struct ppc64_stub_entry
>  {
> -	/* 28 byte jump instruction sequence (7 instructions). We only
> -	 * need 6 instructions on ABIv2 but we always allocate 7 so
> -	 * so we don't have to modify the trampoline load instruction. */
> -	u32 jump[7];
> +	/* 28 byte jump instruction sequence (7 instructions) and only
> +	 * 6 instructions are needed on ABIv2 to create trampoline.
> +	 * Trampoline for livepatch symbol needs extra 7 instructions
> +	 * to save and restore LR, TOC values.
> +	 *
> +	 * To accommodate extra instructions required for livepatch
> +	 * entry, we allocate 15 instructions so we don't have to
> +	 * modify the trampoline load instruction.
> +	 */
> +	u32 jump[15];
>  	/* Used by ftrace to identify stubs */
>  	u32 magic;
>  	/* Data for the above code */
> @@ -131,7 +137,7 @@ static u32 ppc64_stub_insns[] = {
>  	0x396b0000,			/* addi    r11,r11, <low> */
>  	/* Save current r2 value in magic place on the stack. */
>  	0xf8410000|R2_STACK_OFFSET,	/* std     r2,R2_STACK_OFFSET(r1) */
> -	0xe98b0020,			/* ld      r12,32(r11) */
> +	0xe98b0040,			/* ld      r12,64(r11) */
>  #ifdef PPC64_ELF_ABI_v1
>  	/* Set up new r2 from function descriptor */
>  	0xe84b0028,			/* ld      r2,40(r11) */
> @@ -140,6 +146,24 @@ static u32 ppc64_stub_insns[] = {
>  	0x4e800420			/* bctr */
>  };
>
> +static u32 ppc64_klp_stub_insns[] = {
> +	0x3d620000,                     /* addis   r11,r2, <high>	*/
> +	0x396b0000,                     /* addi    r11,r11, <low>	*/
> +	0x7c0802a6,                     /* mflr    r0			*/
> +	0xf8010010,                     /* std     r0,16(r1)		*/
> +	/* Save current r2 value in magic place on the stack. */
> +	0xf8410000|R2_STACK_OFFSET,     /* std     r2,R2_STACK_OFFSET(r1) */
> +	0xe98b0040,			/* ld	   r12,64(r11)		*/
> +	0xf821ffe1,                     /* stdu    r1,-32(r1)		*/
> +	0x7d8903a6,                     /* mtctr   r12			*/
> +	0x4e800421,                     /* bctrl			*/
> +	0x38210020,                     /* addi    r1,r1,32		*/
> +	0xe8010010,                     /* ld      r0,16(r1)		*/
> +	0xe8410000|R2_STACK_OFFSET,     /* ld      r2,R2_STACK_OFFSET(r1) */
> +	0x7c0803a6,                     /* mtlr    r0			*/
> +	0x4e800020                      /* blr				*/
> +};
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  int module_trampoline_target(struct module *mod, unsigned long addr,
>  			     unsigned long *target)
> @@ -392,11 +416,16 @@ static inline unsigned long my_r2(const Elf64_Shdr *sechdrs, struct module *me)
>  static inline int create_stub(const Elf64_Shdr *sechdrs,
>  			      struct ppc64_stub_entry *entry,
>  			      unsigned long addr,
> -			      struct module *me)
> +			      struct module *me, int klp_symbol)
>  {
>  	long reladdr;
>
> -	memcpy(entry->jump, ppc64_stub_insns, sizeof(ppc64_stub_insns));
> +	memset(entry, 0, sizeof(*entry));
> +	if (klp_symbol)
> +		memcpy(entry->jump, ppc64_klp_stub_insns,
> +				sizeof(ppc64_klp_stub_insns));
> +	else
> +		memcpy(entry->jump, ppc64_stub_insns, sizeof(ppc64_stub_insns));
>
>  	/* Stub uses address relative to r2. */
>  	reladdr = (unsigned long)entry - my_r2(sechdrs, me);
> @@ -419,7 +448,7 @@ static inline int create_stub(const Elf64_Shdr *sechdrs,
>     stub to set up the TOC ptr (r2) for the function. */
>  static unsigned long stub_for_addr(const Elf64_Shdr *sechdrs,
>  				   unsigned long addr,
> -				   struct module *me)
> +				   struct module *me, int klp_symbol)
>  {
>  	struct ppc64_stub_entry *stubs;
>  	unsigned int i, num_stubs;
> @@ -435,7 +464,7 @@ static unsigned long stub_for_addr(const Elf64_Shdr *sechdrs,
>  			return (unsigned long)&stubs[i];
>  	}
>
> -	if (!create_stub(sechdrs, &stubs[i], addr, me))
> +	if (!create_stub(sechdrs, &stubs[i], addr, me, klp_symbol))
>  		return 0;
>
>  	return (unsigned long)&stubs[i];
> @@ -615,13 +644,17 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>  			/* FIXME: Handle weak symbols here --RR */
>  			if (sym->st_shndx == SHN_UNDEF) {
>  				/* External: go via stub */
> -				value = stub_for_addr(sechdrs, value, me);
> +				value = stub_for_addr(sechdrs, value, me, 0);
>  				if (!value)
>  					return -ENOENT;
>  				if (!restore_r2((u32 *)location + 1, me))
>  					return -ENOEXEC;
>
>  				squash_toc_save_inst(strtab + sym->st_name, value);
> +			} else if (sym->st_shndx == SHN_LIVEPATCH) {
> +				value = stub_for_addr(sechdrs, value, me, 1);
> +				if (!value)
> +					return -ENOENT;
>  			} else
>  				value += local_entry_offset(sym);
>
> @@ -775,7 +808,7 @@ static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs, struct module
>  #else
>  static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs, struct module *me)
>  {
> -	return stub_for_addr(sechdrs, (unsigned long)ftrace_caller, me);
> +	return stub_for_addr(sechdrs, (unsigned long)ftrace_caller, me, 0);
>  }
>  #endif
>


-- 
cheers,
Kamalesh.
