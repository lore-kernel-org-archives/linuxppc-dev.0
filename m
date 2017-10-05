Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7CL62h2YzDr6s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 23:50:38 +1100 (AEDT)
Date: Thu, 5 Oct 2017 14:43:13 +0200
From: Torsten Duwe <duwe@lst.de>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v2] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
Message-ID: <20171005124313.GA25100@lst.de>
References: <20171004152516.25803-1-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171004152516.25803-1-kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 04, 2017 at 11:25:16AM -0400, Kamalesh Babulal wrote:
> 
> Both the failures with REL24 livepatch symbols relocation, can be
> resolved by constructing a new livepatch stub. The newly setup klp_stub
> mimics the functionality of entry_64.S::livepatch_handler introduced by
> commit 85baa095497f ("powerpc/livepatch: Add live patching support on
> ppc64le").

So, do I get his right that this patch is based on your June 13 proposal
"powerpc/modules: Introduce new stub code for SHN_LIVEPATCH symbols" ?
I guess you lost many of us already at that point. What is the new, much
bigger stub code needed for? Stub code should do only the very bare minimum,
all common functionality is handled in the kernel main object.

What exactly is the problem you're trying to solve, what is to be achieved?

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
> +					 ___PPC_RA(11) | 128);
							 ^^^
Also, I was a bit puzzled by this constant, BTW.
Can you #define a meaning to this, perhaps?

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
> +	 * ld    r12, 128(r11)

Is that the same 128 as above? Then it should definitely be a #define to
avoid inconsistencies.

	Torsten
