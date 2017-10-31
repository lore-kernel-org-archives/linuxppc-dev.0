Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRD5g2HDbzDr1w
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 01:20:23 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9VEJvCT093783
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 10:20:20 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dxrqh156a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 10:20:19 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 31 Oct 2017 14:20:06 -0000
Date: Tue, 31 Oct 2017 19:49:59 +0530
From: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 Torsten Duwe <duwe@lst.de>, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v3] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
References: <1508217523-18885-1-git-send-email-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508217523-18885-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Message-Id: <20171031141959.7pqnlncg2236yqqg@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kamalesh,
Sorry for the late review. Overall, the patch looks good to me. So:
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

However, I have a few minor comments which can be addressed in a 
subsequent patch.

On 2017/10/17 05:18AM, Kamalesh Babulal wrote:
> Livepatch re-uses module loader function apply_relocate_add() to write
> relocations, instead of managing them by arch-dependent
> klp_write_module_reloc() function.
> 
> apply_relocate_add() doesn't understand livepatch symbols (marked with
> SHN_LIVEPATCH symbol section index) and assumes them to be local symbols
> by default for R_PPC64_REL24 relocation type. It fails with an error,
> when trying to calculate offset with local_entry_offset():
> 
> module_64: kpatch_meminfo: REL24 -1152921504897399800 out of range!
> 
> Whereas livepatch symbols are essentially SHN_UNDEF, should be
> called via stub used for global calls. This issue can be fixed by
> teaching apply_relocate_add() to handle both SHN_UNDEF/SHN_LIVEPATCH
> symbols via the same stub. It isn't a complete fix, as it will fail for
> local calls becoming global.
> 
> Consider a livepatch sequence[1] below, where function A calls B, B is
> livepatched function and any calls to function B is redirected to
> patched version P. Now, livepatched function P calls function C in M2,
> whereas C was local to function B and global to function P.
> 
>   +--------+            +--------+    +--------+      +--------+
>   |        |   +--------+--------+--->|        |  +-->|        |
>   |  A     |   |        |  B     |    |  F     |  |   |  P     |
>   |        |   |        |        |    |        +--+   |        |
>   |        +---+        |        |    |        |<-+   |        |
>   |        |<--+   +----+   C    |    |        |  |   |        |
>   |        |   |   | +->|        |    |        |  |   |        |<---+
>   | K / M1 |   |   | |  | K / M2 |  +-+ Kernel |  +---+ Mod3   +--+ |
>   +--------+   |   | |  +--------+  | +--------+      +--------+  | |
>                |   | |              |                             | |
>                +---+-+--------------+                             | |
>                    | |                                            | |
>                    | +--------------------------------------------+ |
>                    +------------------------------------------------+
> 
> Handling such call with existing stub, triggers another error:
> 
> module_64: kpatch_meminfo: Expect noop after relocate, got 3d220000
> 
> Reason being, ppc64le ABI v2 expects a nop instruction after every
> branch to a global call. That gets overwritten by an instruction to
> restore TOC with r2 value of callee. Given function C was local to
> function B, it does not store/restore TOC as they are not expected to be
> clobbered for functions called via local entry point.
> 
> The current stub can be extended to re-store TOC and have a single stub
> for both SHN_UNDEF/SHN_LIVEPATCH symbols. Constructing a single stub proves
> to be an overhead for non-livepatch calls, with additional instructions
> to restore TOC.
> 
> A new stub to call livepatch symbols with an intermediate stack to
> store/restore, TOC/LR between livepatched function and global function
> will work for most of the cases but will fail when arguments are passed
> via stack between functions.
> 
> This issue has been already solved by introduction of livepatch_handler,
> which runs in _mcount context by introducing livepatch stack growing
> upwards from the base of the regular stack, eliminating the need for an
> intermediate stack.
> 
> Current approach is to setup klp_stub mimicking the functionality of
> entry_64.S::livepatch_handler to store/restore TOC/LR values, other than
> the stub setup and branch. This patch also introduces new
> ppc64le_klp_stub_entry[], along with the helpers to find/allocate
> livepatch stub.
> 
> [1] ASCII diagram adopted from:
> http://mpe.github.io/posts/2016/05/23/kernel-live-patching-for-ppc64le/
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Cc: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> Cc: Torsten Duwe <duwe@lst.de>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: live-patching@vger.kernel.org
> ---
> v3:
>  - Defined FUNC_DESC_OFFSET to calculate func_desc offset from
>    struct ppc64le_klp_stub_entry.
>  - Replaced BUG_ON() with WARN_ON() in klp_stub_for_addr().
>  - Major commit message re-write.
> 
> v2:
>  - Changed klp_stub construction to re-use livepatch_handler and
>    additional patch code required for klp_stub, instead of duplicating it.
>  - Minor comments and commit body edit.
> 
>  arch/powerpc/include/asm/module.h              |   4 +
>  arch/powerpc/kernel/module_64.c                | 139 ++++++++++++++++++++++++-
>  arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  31 ++++++
>  3 files changed, 171 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
> index 6c0132c..de22c4c 100644
> --- a/arch/powerpc/include/asm/module.h
> +++ b/arch/powerpc/include/asm/module.h
> @@ -44,6 +44,10 @@ struct mod_arch_specific {
>  	unsigned long toc;
>  	unsigned long tramp;
>  #endif
> +#ifdef CONFIG_LIVEPATCH
> +	/* Count of kernel livepatch relocations */
> +	unsigned long klp_relocs;
> +#endif
> 
>  #else /* powerpc64 */
>  	/* Indices of PLT sections within module. */
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> index 0b0f896..005aaea 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -140,6 +140,24 @@ static u32 ppc64_stub_insns[] = {
>  	0x4e800420			/* bctr */
>  };
> 
> +#ifdef CONFIG_LIVEPATCH
> +extern u32 klp_stub_insn[], klp_stub_insn_end[];
> +extern u32 livepatch_handler[], livepatch_handler_end[];
> +
> +struct ppc64le_klp_stub_entry {
> +	/*
> +	 * Other than setting up the stub and livepatch stub also needs to
> +	 * allocate extra instructions to allocate livepatch stack,
> +	 * storing/restoring TOC/LR values on/from the livepatch stack.
> +	 */
> +	u32 jump[31];
> +	/* Used by ftrace to identify stubs */
> +	u32 magic;
> +	/* Data for the above code */
> +	func_desc_t funcdata;
> +};
> +#endif
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  int module_trampoline_target(struct module *mod, unsigned long addr,
>  			     unsigned long *target)
> @@ -239,10 +257,19 @@ static void relaswap(void *_x, void *_y, int size)
> 
>  /* Get size of potential trampolines required. */
>  static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
> -				    const Elf64_Shdr *sechdrs)
> +				    const Elf64_Shdr *sechdrs,
> +				    struct module *me)
>  {
>  	/* One extra reloc so it's always 0-funcaddr terminated */
>  	unsigned long relocs = 1;

You might want to get rid of 'relocs' above and simply use the below 
two.

> +	/*
> +	 * size of livepatch stub is 28 instructions, whereas the
> +	 * non-livepatch stub requires 7 instructions. Account for
> +	 * different stub sizes and track the livepatch relocation
> +	 * count in me->arch.klp_relocs.
> +	 */
> +	unsigned long sec_relocs = 0;
> +	unsigned long klp_relocs = 0;

You should also initialize this to 1 (similar to relocs above) for use 
in the iterators below. Or, update the iterators to use 
me->arch.klp_relocs (1)

>  	unsigned i;
> 
>  	/* Every relocated section... */
> @@ -262,9 +289,14 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
>  			     sechdrs[i].sh_size / sizeof(Elf64_Rela),
>  			     sizeof(Elf64_Rela), relacmp, relaswap);
> 
> -			relocs += count_relocs((void *)sechdrs[i].sh_addr,
> +			sec_relocs = count_relocs((void *)sechdrs[i].sh_addr,
>  					       sechdrs[i].sh_size
>  					       / sizeof(Elf64_Rela));

How about also capturing 'sec_relocs' in 'struct mod_arch_specific'? (2)  
That will help simplify a lot of the calculations here and elsewhere.  
Note that there are many other places where the number of stubs is 
derived looking at 'sh_size', which is incorrect since we now have klp 
stubs as well (create_ftrace_stub() for instance).

> +			relocs += sec_relocs;
> +#ifdef CONFIG_LIVEPATCH
> +			if (sechdrs[i].sh_flags & SHF_RELA_LIVEPATCH)
> +				klp_relocs += sec_relocs;
> +#endif

If a module has SHF_RELA_LIVEPATCH, but the kernel is compiled without 
CONFIG_LIVEPATCH, should we refuse to load the kernel module?

You might want to consider removing the above #ifdef and processing some 
of these flags regardless of CONFIG_LIVEPATCH.

>  		}
>  	}
> 
> @@ -273,6 +305,15 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
>  	relocs++;
>  #endif
> 
> +	relocs -= klp_relocs;
> +#ifdef CONFIG_LIVEPATCH
> +	me->arch.klp_relocs = klp_relocs;
> +
> +	pr_debug("Looks like a total of %lu stubs, (%lu) livepatch stubs, max\n",
						   ^^^^^
						   (%lu livepatch stubs)

Just wondering why the brackets are the way they are...

> +				relocs, klp_relocs);
> +	return (relocs * sizeof(struct ppc64_stub_entry) +
> +		klp_relocs * sizeof(struct ppc64le_klp_stub_entry));
> +#endif
>  	pr_debug("Looks like a total of %lu stubs, max\n", relocs);
>  	return relocs * sizeof(struct ppc64_stub_entry);
>  }
> @@ -369,7 +410,7 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
>  		me->arch.toc_section = me->arch.stubs_section;
> 
>  	/* Override the stubs size */
> -	sechdrs[me->arch.stubs_section].sh_size = get_stubs_size(hdr, sechdrs);
> +	sechdrs[me->arch.stubs_section].sh_size = get_stubs_size(hdr, sechdrs, me);
>  	return 0;
>  }
> 
> @@ -415,6 +456,59 @@ static inline int create_stub(const Elf64_Shdr *sechdrs,
>  	return 1;
>  }
> 
> +#ifdef CONFIG_LIVEPATCH
> +
> +#define FUNC_DESC_OFFSET offsetof(struct ppc64le_klp_stub_entry, funcdata)
> +
> +/* Patch livepatch stub to reference function and correct r2 value. */
> +static inline int create_klp_stub(const Elf64_Shdr *sechdrs,
> +				  struct ppc64le_klp_stub_entry *entry,
> +				  unsigned long addr,
> +				  struct module *me)
> +{
> +	long reladdr;
> +	unsigned long klp_stub_idx, klp_stub_idx_end;
> +
> +	klp_stub_idx = (klp_stub_insn - livepatch_handler);
> +	klp_stub_idx_end = (livepatch_handler_end - klp_stub_insn_end);
> +
> +	/* Copy first half of livepatch_handler till klp_stub_insn */
> +	memcpy(entry->jump, livepatch_handler, sizeof(u32) * klp_stub_idx);
> +
> +	/* Stub uses address relative to r2. */
> +	reladdr = (unsigned long)entry - my_r2(sechdrs, me);
> +	if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
> +		pr_err("%s: Address %p of stub out of range of %p.\n",
> +				me->name, (void *)reladdr, (void *)my_r2);
> +		return 0;
> +	}
> +	pr_debug("Stub %p get data from reladdr %li\n", entry, reladdr);
> +
> +	/*
> +	 * Patch the code required to load the trampoline address into r11,
> +	 * function global entry point into r12, ctr.
> +	 */
> +	entry->jump[klp_stub_idx++] = (PPC_INST_ADDIS | ___PPC_RT(11) |
> +					___PPC_RA(2) | PPC_HA(reladdr));
> +
> +	entry->jump[klp_stub_idx++] = (PPC_INST_ADDI | ___PPC_RT(11) |
> +					 ___PPC_RA(11) | PPC_LO(reladdr));
> +
> +	entry->jump[klp_stub_idx++] = (PPC_INST_LD | ___PPC_RT(12) |
> +					 ___PPC_RA(11) | FUNC_DESC_OFFSET);
> +
> +	entry->jump[klp_stub_idx++] = PPC_INST_MTCTR | ___PPC_RT(12);
> +
> +	/* Copy second half of livepatch_handler starting klp_stub_insn_end */
> +	memcpy(entry->jump + klp_stub_idx, klp_stub_insn_end,
> +				sizeof(u32) * klp_stub_idx_end);
> +
> +	entry->funcdata = func_desc(addr);
> +	entry->magic = STUB_MAGIC;
> +	return 1;
> +}
> +#endif
> +
>  /* Create stub to jump to function described in this OPD/ptr: we need the
>     stub to set up the TOC ptr (r2) for the function. */
>  static unsigned long stub_for_addr(const Elf64_Shdr *sechdrs,
> @@ -441,6 +535,39 @@ static unsigned long stub_for_addr(const Elf64_Shdr *sechdrs,
>  	return (unsigned long)&stubs[i];
>  }
> 
> +#ifdef CONFIG_LIVEPATCH
> +static unsigned long klp_stub_for_addr(const Elf64_Shdr *sechdrs,
> +				       unsigned long addr,
> +				       struct module *me)
> +{
> +	struct ppc64le_klp_stub_entry *klp_stubs;
> +	unsigned int num_klp_stubs = me->arch.klp_relocs;
> +	unsigned int i, num_stubs;
> +
> +	num_stubs = (sechdrs[me->arch.stubs_section].sh_size -
> +		    (num_klp_stubs * sizeof(*klp_stubs))) /
> +				sizeof(struct ppc64_stub_entry);

(2) This can be simplified if we have me->arch.sec_relocs.

> +
> +	/*
> +	 * Create livepatch stubs after the regular stubs.
> +	 */
> +	klp_stubs = (void *)sechdrs[me->arch.stubs_section].sh_addr +
> +		    (num_stubs * sizeof(struct ppc64_stub_entry));
> +	for (i = 0; stub_func_addr(klp_stubs[i].funcdata); i++) {
		    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		    (1) This needs us to allocate one additional stub.


- Naveen


> +		if (WARN_ON(i >= num_klp_stubs))
> +			return 0;
> +
> +		if (stub_func_addr(klp_stubs[i].funcdata) == func_addr(addr))
> +			return (unsigned long)&klp_stubs[i];
> +	}
> +
> +	if (!create_klp_stub(sechdrs, &klp_stubs[i], addr, me))
> +		return 0;
> +
> +	return (unsigned long)&klp_stubs[i];
> +}
> +#endif
> +
>  #ifdef CC_USING_MPROFILE_KERNEL
>  static bool is_early_mcount_callsite(u32 *instruction)
>  {
> @@ -622,6 +749,12 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>  					return -ENOEXEC;
> 
>  				squash_toc_save_inst(strtab + sym->st_name, value);
> +#ifdef CONFIG_LIVEPATCH
> +			} else if (sym->st_shndx == SHN_LIVEPATCH) {
> +				value = klp_stub_for_addr(sechdrs, value, me);
> +				if (!value)
> +					return -ENOENT;
> +#endif
>  			} else
>  				value += local_entry_offset(sym);
> 
> diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> index b4e2b71..4ef9329 100644
> --- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> +++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> @@ -183,7 +183,10 @@ _GLOBAL(ftrace_stub)
>  	 *  - CTR holds the new NIP in C
>  	 *  - r0, r11 & r12 are free
>  	 */
> +
> +	.global livepatch_handler
>  livepatch_handler:
> +
>  	CURRENT_THREAD_INFO(r12, r1)
> 
>  	/* Allocate 3 x 8 bytes */
> @@ -201,8 +204,33 @@ livepatch_handler:
>  	ori     r12, r12, STACK_END_MAGIC@l
>  	std	r12, -8(r11)
> 
> +	/*
> +	 * klp_stub_insn/klp_stub_insn_end marks the beginning/end of the
> +	 * additional instructions, which gets patched by create_klp_stub()
> +	 * for livepatch symbol relocation stub. The instructions are:
> +	 *
> +	 * Load TOC relative address into r11. module_64.c::klp_stub_for_addr()
> +	 * identifies the available free stub slot and loads the address into
> +	 * r11 with two instructions.
> +	 *
> +	 * addis r11, r2, stub_address@ha
> +	 * addi  r11, r11, stub_address@l
> +	 *
> +	 * Load global entry into r12 from entry->funcdata offset
> +	 * ld    r12, FUNC_DESC_OFFSET(r11)
> +	 *
> +	 * Put r12 into ctr and branch there
> +	 * mtctr r12
> +	 */
> +
> +	.global klp_stub_insn
> +klp_stub_insn:
> +
>  	/* Put ctr in r12 for global entry and branch there */
>  	mfctr	r12
> +
> +	.global klp_stub_insn_end
> +klp_stub_insn_end:
>  	bctrl
> 
>  	/*
> @@ -234,6 +262,9 @@ livepatch_handler:
> 
>  	/* Return to original caller of live patched function */
>  	blr
> +
> +	.global livepatch_handler_end
> +livepatch_handler_end:
>  #endif /* CONFIG_LIVEPATCH */
> 
>  #endif /* CONFIG_DYNAMIC_FTRACE */
> -- 
> 2.7.4
> 
