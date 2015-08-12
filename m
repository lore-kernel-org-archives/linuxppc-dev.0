Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A0F71A0034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 15:12:54 +1000 (AEST)
In-Reply-To: <1438153805-31828-5-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [5/8] powerpc/slb: Add documentation to runtime patching of SLB
 encoding
Message-Id: <20150812051253.7DEB91401DA@ozlabs.org>
Date: Wed, 12 Aug 2015 15:12:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-29-07 at 07:10:02 UTC, Anshuman Khandual wrote:
> This patch adds some documentation to 'patch_slb_encoding' function
> explaining about how it clears the existing immediate value in the
> given instruction and inserts a new one there.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/slb.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index c87d5de..1962357 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -279,7 +279,18 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>  static inline void patch_slb_encoding(unsigned int *insn_addr,
>  				      unsigned int immed)
>  {
> -	int insn = (*insn_addr & 0xffff0000) | immed;
> +
> +	/*
> +	 * This function patches either an li or a cmpldi instruction with
> +	 * a new immediate value. This relies on the fact that both li
> +	 * (which is actually addi) and cmpldi both take a 16-bit immediate
> +	 * value, and it is situated in the same location in the instruction,
> +	 * ie. bits 16-31 (Big endian bit order) or the lower 16 bits.
> +	 * To patch the value we read the existing instruction, clear the
> +	 * immediate value, and or in our new value, then write the instruction
> +	 * back.
> +	 */
> +	unsigned int insn = (*insn_addr & 0xffff0000) | immed;
>  	patch_instruction(insn_addr, insn);
>  }

As Segher pointed out the signedness of the immediate value differs between the
instructions, I added:

+	 * The signedness of the immediate operand differs between the two
+	 * instructions however this code is only ever patching a small value,
+	 * much less than 1 << 15, so we can get away with it.

cheers
