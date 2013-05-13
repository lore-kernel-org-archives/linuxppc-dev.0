Return-Path: <paubert@iram.es>
Received: from marchena.puc.rediris.es (marchena.puc.rediris.es
 [IPv6:2001:720:418:ca00::4])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 718F12C00A9
 for <linuxppc-dev@ozlabs.org>; Mon, 13 May 2013 18:13:50 +1000 (EST)
Date: Mon, 13 May 2013 09:33:19 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: provide __bswapdi2
Message-ID: <20130513073319.GA5886@visitor2.iram.es>
References: <1368220707.3378.57.camel@shinybook.infradead.org>
 <9813.1368428999@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9813.1368428999@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
 viro@zeniv.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 13, 2013 at 05:09:59PM +1000, Michael Neuling wrote:
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > From: David Woodhouse <David.Woodhouse@intel.com>
> > 
> > Some versions of GCC apparently expect this to be provided by libgcc.
> > 
> > Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> > ---
> > Untested.
> > 
> > diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
> > index 19e096b..f077dc2 100644
> > --- a/arch/powerpc/kernel/misc_32.S
> > +++ b/arch/powerpc/kernel/misc_32.S
> > @@ -657,6 +657,17 @@ _GLOBAL(__ucmpdi2)
> >  	li	r3,2
> >  	blr
> >  
> > +_GLOBAL(__bswapdi2)
> > +	rlwinm	10,4,8,0xffffffff
> > +	rlwinm	11,3,8,0xffffffff
> > +	rlwimi	10,4,24,0,7
> > +	rlwimi	11,3,24,0,7
> > +	rlwimi	10,4,24,16,23
> > +	rlwimi	11,3,24,16,23
> > +	mr	4,11
> > +	mr	3,10
> > +	blr
> > +
> 
> This doesn't work for me but the below does:
> 
> _GLOBAL(__bswapdi2)
> 	rotlwi  r9,r4,8
> 	rotlwi  r10,r3,8
> 	rlwimi  r9,r4,24,0,7
> 	rlwimi  r10,r3,24,0,7
> 	rlwimi  r9,r4,24,16,23
> 	rlwimi  r10,r3,24,16,23
> 	mr      r4,r10
> 	mr      r3,r9
> 	blr
> 

Actually, I'd swap the two mr instructions to never
have an instruction that uses the result from the
previous one. 


> stolen from GCC -02 output of:
>   unsigned long long __bswapdi2(unsigned long long x)
>   {
> 	 return ((x & 0x00000000000000ffULL) << 56) |
> 		((x & 0x000000000000ff00ULL) << 40) |
> 		((x & 0x0000000000ff0000ULL) << 24) |
> 		((x & 0x00000000ff000000ULL) <<  8) |
> 		((x & 0x000000ff00000000ULL) >>  8) |
> 		((x & 0x0000ff0000000000ULL) >> 24) |
> 		((x & 0x00ff000000000000ULL) >> 40) |
> 		((x & 0xff00000000000000ULL) >> 56);
>   }
> 
> >  _GLOBAL(abs)
> >  	srawi	r4,r3,31
> >  	xor	r3,r3,r4
> > diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> > index 5cfa800..3b2e6e8 100644
> > --- a/arch/powerpc/kernel/misc_64.S
> > +++ b/arch/powerpc/kernel/misc_64.S
> > @@ -234,6 +234,18 @@ _GLOBAL(__flush_dcache_icache)
> >  	isync
> >  	blr
> >  
> > +_GLOBAL(__bswapdi2)
> > +	srdi	8,3,32
> > +	rlwinm	7,3,8,0xffffffff
> > +	rlwimi	7,3,24,0,7
> > +	rlwinm	9,8,8,0xffffffff
> > +	rlwimi	7,3,24,16,23
> > +	rlwimi	9,8,24,0,7
> > +	rlwimi	9,8,24,16,23
> > +	sldi	7,7,32
> > +	or	7,7,9
> > +	mr	3,7
> > +	blr
> 
> This works but we should add "r" to the register names.
> 

And merge the last two instructions as a single "or r3,r7,r9".


	Gabriel
