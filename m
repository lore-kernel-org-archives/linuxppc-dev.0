Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD79167A45
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 09:02:54 +1100 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Date: Tue, 18 Jan 2005 23:02:44 +0100
Message-ID: <BCEFJBPJCGFCNMMMIDBHOECCCKAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20050118200944.GN28724@smtp.west.cox.net>
Cc: "Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH] Handle I-TLB Error and Miss separately on 8xx
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> On Fri, Jan 14, 2005 at 08:51:44PM +0100, Joakim Tjernlund wrote:
> 
> > BTW, there is a simpler fix to the TLB Miss problem.
> > In the TLB Miss handlers, just move the 2: label a few instr. upwards to
> > the same line as the "li	r21, 0x00f0". That way you will force a 
> > TLB error. You can do this for both Data and Instr. Miss handlers.
> > The code after where the 2: label used to be can be deleted. 
> 
> Like this?  Only lightly tested on my rpxlite on 2.6:

Yes, that way you will load a zero pte, except for the bits that always must be ones
into the MMU and TLB error will follow.

You can also move beq 2f instr. 2 lines down and change it to beq- 2f to let branch
prediction do its thing.

Then all that is missing is my dcbX patch and support for 16K pages :)

 Jocke 
> 
> 
> ---
> 
>  linux-2.6-current-trini/arch/ppc/kernel/head_8xx.S |   22 +--------------------
>  1 files changed, 2 insertions(+), 20 deletions(-)
> 
> diff -puN arch/ppc/kernel/head_8xx.S~ppc32-mpc8xx-itlbmiss-fix arch/ppc/kernel/head_8xx.S
> --- linux-2.6-current/arch/ppc/kernel/head_8xx.S~ppc32-mpc8xx-itlbmiss-fix	2005-01-18 11:55:34.000000000 -0700
> +++ linux-2.6-current-trini/arch/ppc/kernel/head_8xx.S	2005-01-18 11:57:11.000000000 -0700
> @@ -343,7 +343,7 @@ InstructionTLBMiss:
>  	 * set.  All other Linux PTE bits control the behavior
>  	 * of the MMU.
>  	 */
> -	li	r11, 0x00f0
> +2:	li	r11, 0x00f0
>  	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
>  	DO_8xx_CPU6(0x2d80, r3)
>  	mtspr	MI_RPN, r10	/* Update TLB entry */
> @@ -357,15 +357,6 @@ InstructionTLBMiss:
>  #endif
>  	rfi
>  
> -2:	mfspr	r10, M_TW	/* Restore registers */
> -	lwz	r11, 0(r0)
> -	mtcr	r11
> -	lwz	r11, 4(r0)
> -#ifdef CONFIG_8xx_CPU6
> -	lwz	r3, 8(r0)
> -#endif
> -	b	InstructionAccess
> -
>  	. = 0x1200
>  DataStoreTLBMiss:
>  #ifdef CONFIG_8xx_CPU6
> @@ -419,7 +410,7 @@ DataStoreTLBMiss:
>  	 * set.  All other Linux PTE bits control the behavior
>  	 * of the MMU.
>  	 */
> -	li	r11, 0x00f0
> +2:	li	r11, 0x00f0
>  	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
>  	DO_8xx_CPU6(0x3d80, r3)
>  	mtspr	MD_RPN, r10	/* Update TLB entry */
> @@ -433,15 +424,6 @@ DataStoreTLBMiss:
>  #endif
>  	rfi
>  
> -2:	mfspr	r10, M_TW	/* Restore registers */
> -	lwz	r11, 0(r0)
> -	mtcr	r11
> -	lwz	r11, 4(r0)
> -#ifdef CONFIG_8xx_CPU6
> -	lwz	r3, 8(r0)
> -#endif
> -	b	DataAccess
> -
>  /* This is an instruction TLB error on the MPC8xx.  This could be due
>   * to many reasons, such as executing guarded memory or illegal instruction
>   * addresses.  There is nothing to do but handle a big time error fault.
> _
> 
> -- 
> Tom Rini
> http://gate.crashing.org/~trini/
