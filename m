Return-Path: <dgibson@ozlabs.org>
Date: Mon, 24 Sep 2007 13:14:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 6/15] bootwrapper: help for 64 bit cpus
Message-ID: <20070924031451.GG8058@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <boot-8-06.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <boot-8-06.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Rob Landley <rob@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2007 at 06:04:37PM -0500, Milton Miller wrote:
> Add code to check if the processor is in 64 or 32 bit mode using
> only instructions from the 32 bit subset.  If the processor is in
> 64 bit mode, switch to 32 bit mode by clearing MSR[SF].
> 
> Also add a 64 bit procedure descriptor to use as a elf64 entry
> point.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> --- 
> vs 12173
> correct comment (equal vs not-equal)
> 
> Index: kernel/arch/powerpc/boot/crt0.S
> ===================================================================
> --- kernel.orig/arch/powerpc/boot/crt0.S	2007-07-10 03:33:36.000000000 -0500
> +++ kernel/arch/powerpc/boot/crt0.S	2007-07-10 03:39:08.000000000 -0500
> @@ -17,11 +17,47 @@
>  _zimage_start_opd:
>  	.long	_zimage_start, 0, 0, 0
>  
> +	/* a procedure descriptor used when pretending to be elf64_powerpc */
> +	.balign	8
> +	.globl	_zimage_start_64
> +_zimage_start_64:

Hrm, I'd prefer _zimage_start_opd64 in analogy with the COFF opd entry
above.

> +	.long	0, _zimage_start	/* big endian, supported reloc ppc32 */
> +	.long	0, 0, 0, 0, 0, 0
> +
> +
>  	.weak	_zimage_start
>  	.globl	_zimage_start
>  _zimage_start:
>  	.globl	_zimage_start_lib
>  _zimage_start_lib:
> +	/* Check if the processor is running in 32 bit mode, using
> +	 * only 32 bit instructions which should be safe on 32 and
> +	 * 64 bit processors.
> +	 *
> +	 * Subtract bottom 32 bits of MSR from full value recording
> +	 * the result.  Since MSR[SF] is in the high word, we will
> +	 * be equal iff in 32 bit mode (either the processor is
> +	 * a 32 bit processor or MSR[SF] = 0).
> +	 */
> +	mfmsr	r0		/* grab whole msr		*/
> +	rlwinm	r8,r0,0,0,31	/* extract bottom word		*/
> +	subf.	r8,r8,r0	/* subtract, same?		*/
> +	beq	0f		/* yes: we are 32 bit mode	*/
> +
> +	/* We are in 64-bit mode.  This program must run in 32 bit
> +	 * mode.  Assume we are actually running somewhere in the
> +	 * low 32 bits of the address space, so we can just turn
> +	 * off MSR[SF] which is bit 0.
> +	 */
> +	.machine push
> +	.machine "ppc64"
> +	rldicl	r0,r0,0,1
> +	sync
> +	mtmsrd	r0
> +	isync
> +	.machine pop
> +0:	/* We are now in 32-bit mode */
> +
>  	/* Work out the offset between the address we were linked at
>  	   and the address where we're running. */
>  	bl	1f
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
