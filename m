Return-Path: <James.Yang@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F24B12C0096
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 04:03:17 +1100 (EST)
Date: Mon, 10 Feb 2014 11:03:07 -0600
From: James Yang <James.Yang@freescale.com>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
In-Reply-To: <20140210110342.GA15806@visitor2.iram.es>
Message-ID: <alpine.LRH.2.00.1402101056410.10318@ra8135-ec1.am.freescale.net>
References: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
 <20140206082635.GA7048@visitor2.iram.es>
 <OFA4C1AF9F.B23E83EC-ONCA257C78.00044235-CA257C78.00080D50@csc.com>
 <20140207101036.GA823@visitor2.iram.es>
 <alpine.LRH.2.00.1402071348380.10318@ra8135-ec1.am.freescale.net>
 <20140210110342.GA15806@visitor2.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: James Yang <James.Yang@freescale.com>, Chris Proctor <cproctor@csc.com.au>,
 Stephen N Chivers <schivers@csc.com.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 10 Feb 2014, Gabriel Paubert wrote:

> On Fri, Feb 07, 2014 at 02:49:40PM -0600, James Yang wrote:
> > On Fri, 7 Feb 2014, Gabriel Paubert wrote:
> > 
> > > 	Hi Stephen,
> > > 
> > > On Fri, Feb 07, 2014 at 11:27:57AM +1000, Stephen N Chivers wrote:
> > > > Gabriel Paubert <paubert@iram.es> wrote on 02/06/2014 07:26:37 PM:
> > > > 
> > > > > From: Gabriel Paubert <paubert@iram.es>
> > > > > To: Stephen N Chivers <schivers@csc.com.au>
> > > > > Cc: linuxppc-dev@lists.ozlabs.org, Chris Proctor <cproctor@csc.com.au>
> > > > > Date: 02/06/2014 07:26 PM
> > > > > Subject: Re: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
> > > > > 
> > > > > On Thu, Feb 06, 2014 at 12:09:00PM +1000, Stephen N Chivers wrote:


> > 
> > > > > > 
> > > > > >                 mask = 0;
> > > > > >                 if (FM & (1 << 0))
> > > > > >                         mask |= 0x0000000f;
> > > > > >                 if (FM & (1 << 1))
> > > > > >                         mask |= 0x000000f0;
> > > > > >                 if (FM & (1 << 2))
> > > > > >                         mask |= 0x00000f00;
> > > > > >                 if (FM & (1 << 3))
> > > > > >                         mask |= 0x0000f000;
> > > > > >                 if (FM & (1 << 4))
> > > > > >                         mask |= 0x000f0000;
> > > > > >                 if (FM & (1 << 5))
> > > > > >                         mask |= 0x00f00000;
> > > > > >                 if (FM & (1 << 6))
> > > > > >                         mask |= 0x0f000000;
> > > > > >                 if (FM & (1 << 7))
> > > > > >                         mask |= 0x90000000;
> > > > > > 
> > > > > > With the above mask computation I get consistent results for 
> > > > > > both the MPC8548 and MPC7410 boards.

> Ok, if you have measured that method1 is faster than method2, let us go for it.
> I believe method2 would be faster if you had a large out-of-order execution
> window, because more parallelism can be extracted from it, but this is probably
> only true for high end cores, which do not need FPU emulation in the first place.

Yeah, 8548 can issue 2 SFX instructions per cycle which is what the 
compiler generated.   

 
> The other place where we can optimize is the generation of FEX. Here is 
> my current patch:
> 
> 
> diff --git a/arch/powerpc/math-emu/mtfsf.c b/arch/powerpc/math-emu/mtfsf.c
> index dbce92e..b57b3fa8 100644
> --- a/arch/powerpc/math-emu/mtfsf.c
> +++ b/arch/powerpc/math-emu/mtfsf.c
> @@ -11,48 +11,35 @@ mtfsf(unsigned int FM, u32 *frB)
>  	u32 mask;
>  	u32 fpscr;
>  
> -	if (FM == 0)
> +	if (likely(FM == 0xff))
> +		mask = 0xffffffff;
> +	else if (unlikely(FM == 0))
>  		return 0;
> -
> -	if (FM == 0xff)
> -		mask = 0x9fffffff;
>  	else {
> -		mask = 0;
> -		if (FM & (1 << 0))
> -			mask |= 0x90000000;
> -		if (FM & (1 << 1))
> -			mask |= 0x0f000000;
> -		if (FM & (1 << 2))
> -			mask |= 0x00f00000;
> -		if (FM & (1 << 3))
> -			mask |= 0x000f0000;
> -		if (FM & (1 << 4))
> -			mask |= 0x0000f000;
> -		if (FM & (1 << 5))
> -			mask |= 0x00000f00;
> -		if (FM & (1 << 6))
> -			mask |= 0x000000f0;
> -		if (FM & (1 << 7))
> -			mask |= 0x0000000f;
> +		mask = (FM & 1);
> +		mask |= (FM << 3) & 0x10;
> +		mask |= (FM << 6) & 0x100;
> +		mask |= (FM << 9) & 0x1000;
> +		mask |= (FM << 12) & 0x10000;
> +		mask |= (FM << 15) & 0x100000;
> +		mask |= (FM << 18) & 0x1000000;
> +		mask |= (FM << 21) & 0x10000000;
> +		mask *= 15;


Needs to also mask out bits 1 and 2, they aren't to be set from frB.

		mask &= 0x9FFFFFFF;




>  	}
>  
> -	__FPU_FPSCR &= ~(mask);
> -	__FPU_FPSCR |= (frB[1] & mask);
> +	fpscr = ((__FPU_FPSCR & ~mask) | (frB[1] & mask)) &
> +		~(FPSCR_VX | FPSCR_FEX);
>  
> -	__FPU_FPSCR &= ~(FPSCR_VX);
> -	if (__FPU_FPSCR & (FPSCR_VXSNAN | FPSCR_VXISI | FPSCR_VXIDI |
> +	if (fpscr & (FPSCR_VXSNAN | FPSCR_VXISI | FPSCR_VXIDI |
>  		     FPSCR_VXZDZ | FPSCR_VXIMZ | FPSCR_VXVC |
>  		     FPSCR_VXSOFT | FPSCR_VXSQRT | FPSCR_VXCVI))
> -		__FPU_FPSCR |= FPSCR_VX;
> -
> -	fpscr = __FPU_FPSCR;
> -	fpscr &= ~(FPSCR_FEX);
> -	if (((fpscr & FPSCR_VX) && (fpscr & FPSCR_VE)) ||
> -	    ((fpscr & FPSCR_OX) && (fpscr & FPSCR_OE)) ||
> -	    ((fpscr & FPSCR_UX) && (fpscr & FPSCR_UE)) ||
> -	    ((fpscr & FPSCR_ZX) && (fpscr & FPSCR_ZE)) ||
> -	    ((fpscr & FPSCR_XX) && (fpscr & FPSCR_XE)))
> -		fpscr |= FPSCR_FEX;
> +		fpscr |= FPSCR_VX;
> +
> +	/* The bit order of exception enables and exception status
> +	 * is the same. Simply shift and mask to check for enabled
> +	 * exceptions.
> +	 */
> +	if (fpscr & (fpscr >> 22) &  0xf8) fpscr |= FPSCR_FEX;
>  	__FPU_FPSCR = fpscr;
>  
>  #ifdef DEBUG
>  mtfsf.c |   57 ++++++++++++++++++++++-----------------------------------
>  1 file changed, 22 insertions(+), 35 deletions(-)
> 
> 
> Notes: 
> 
> 1) I'm really unsure on whether 0xff is frequent or not. So the likely()
> statement at the beginning may be wrong. Actually, if it is not very likely,
> it might be better to remove the special casef for FM==0xff. A look at 
> GCC sources shows that it never generates a mask of 0xff. From glibc
> sources, there vast majority of cases uses 0x1, only isnan() uses 0xff.

Can't handle all cases here.  
 
> 2) it may be better to remove the check for FM==0, after all, the instruction
> efectively becomes a nop, and generating the instruction in the first place
> would be too stupid for words.

Hmm a heavy no-op.  I wonder if it is heavier than a sync.
 
> 3) if might be better to #define the magic constants (22 and 0xf8) used 
> in the last if statement.
> 
> 	Gabriel
