Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 53B1167BEC
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 03:02:50 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 22 Nov 2006 16:44:06 +0100
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Firefox/PPC64 support
Message-ID: <20061122154406.GB30451@iram.es>
References: <1164182413.19448.108.camel@pmac.infradead.org>
	<1164193398.19448.113.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1164193398.19448.113.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 22, 2006 at 11:03:18AM +0000, David Woodhouse wrote:
> On Wed, 2006-11-22 at 08:00 +0000, David Woodhouse wrote:
> > My understanding of the PPC64 C++ ABI is largely empirical. Could
> > someone else glance over the attached patch which adds ppc64 support to
> > firefox?
> 
> Bug #1: I wasn't ensuring that the stack pointer remained aligned to 16
> bytes in XPTC_InvokeByIndex(). Fixed (and use of r28 eliminated since I
> didn't use it in the end as I intended to) thus:
> 
> (full updated patch at http://david.woodhou.se/firefox-1.5-ppc64.patch)
> 
> --- mozilla/xpcom/reflect/xptcall/src/md/unix/xptcinvoke_asm_ppc64_linux.s~	2006-11-21 18:11:30.000000000 +0000
> +++ mozilla/xpcom/reflect/xptcall/src/md/unix/xptcinvoke_asm_ppc64_linux.s	2006-11-22 10:43:26.000000000 +0000
> @@ -18,6 +18,7 @@
>  // Rights Reserved.
>  //
>  // Contributor(s):
> +//   dwmw2@infradead.org (David Woodhouse)
>  //   Franz.Sirl-kernel@lauterbach.com (Franz Sirl)
>  //   beard@netscape.com (Patrick Beard)
>  //   waterson@netscape.com (Chris Waterson)
> @@ -58,7 +59,6 @@ XPTC_InvokeByIndex:
>          mflr	0
>  	std	0,16(r1)
>  	
> -        std	r28,-32(r1)
>          std	r29,-24(r1)
>  	std	r30,-16(r1)
>          std	r31,-8(r1)
> @@ -67,17 +67,19 @@ XPTC_InvokeByIndex:
>  	mr	r30,r4			// Save 'methodIndex' in r30
>  	mr	r31,r1			// Save old frame
>  
> -	// Allocate stack frame with space for params
> -	
> -	sldi	r28,r5,3		// Max. 8 bytes per parameter
> -	addi	r28,r28,128+(24*8)	// Standard frame, 15 dwords for GP/FP, 4 for r28-r31
> -	neg	r28,r28
> -	stdux	r1,r1,r28
> +	// Allocate stack frame with space for params. Since at least the
> +	// first 7 parameters (not including 'that') will be in registers,
> +	// we don't actually need stack space for those. Start by rounding
> +	// down to make sure the stack remains 16-byte aligned.
> +
> +	rldicr	r7,r5,r5,59		// r7 = (r3 << 3) & ~15

I don't see how the instruction can match the comment:
- the third parameter of rldicr is the shift count, 
  so r5 is a typo (the assembler will take it as 5).
- the comment uses r3, the instruction r5.

I believe that the correct instruction is: rldicr r7,r5,3,59.

> +	addi	r7,r7,128+(18*8)	// Standard frame, 7 dwords for GPR,
> +					// 13 dwords for FPR, 3 for r29-r31,
> +					// less 5 of the extra unused params

I'm not yet sure that the code is correct even after the previous
correction, it looks fragile, you should rather compute the size 
by first adding a constant from r5 to r7 (+1 for the round-up) and 
then shift left and truncate. Something like:

	addi r7,r5,34		// adjust value I'm not sure
	rldicr r7,r7,3,59 	// multiply by 8 and truncate to multiple of 16

I'm not sure at all of the immediate value for the add, since
it also depends on the interpretation or r5: does it include 
the 'this' pointer in the count or not?

	Regards,
	Gabriel
