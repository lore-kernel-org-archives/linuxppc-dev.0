Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 6E5AADE472
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 23:36:15 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 21 Apr 2008 15:36:06 +0200
To: Alexander van Heukelum <heukelum@fastmail.fm>
Subject: Re: linux-next: x86-latest/powerpc-next merge conflict
Message-ID: <20080421133606.GA27304@iram.es>
References: <20080421191231.41a34aef.sfr@canb.auug.org.au>
	<20080421095102.GB1666@elte.hu>
	<1208776790.4613.1248992953@webmail.messagingengine.com>
	<18444.34002.74202.564600@cargo.ozlabs.ibm.com>
	<1208783233.25773.1249008469@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1208783233.25773.1249008469@webmail.messagingengine.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@elte.hu>,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 03:07:13PM +0200, Alexander van Heukelum wrote:
> On Mon, 21 Apr 2008 22:13:06 +1000, "Paul Mackerras" <paulus@samba.org>
> said:
> > Alexander van Heukelum writes:
> > > Powerpc would pick up an optimized version via this chain: generic fls64
> > > ->
> > > powerpc __fls --> __ilog2 --> asm (PPC_CNTLZL "%0,%1" : "=r" (lz) : "r"
> > > (x)).
> > 
> > Why wouldn't powerpc continue to use the fls64 that I have in there
> > now?
> 
> In Linus' tree that would be the generic one that uses (the 32-bit)
> fls():
> 
> static inline int fls64(__u64 x)
> {
>         __u32 h = x >> 32;
>         if (h)
>                 return fls(h) + 32;
>         return fls(x);
> }
> 
> > > However, the generic version of fls64 first tests the argument for zero.
> > > From
> > > your code I derive that the count-leading-zeroes instruction for
> > > argument zero
> > > is defined as cntlzl(0) == BITS_PER_LONG.
> > 
> > That is correct.  If the argument is 0 then all of the zero bits are
> > leading zeroes. :)
> 
> So... for 64-bit powerpc it makes sense to have its own implementation
> and ignore the (improved) generic one and for 32-bit powerpc the generic
> implementation of fls64 is fine. The current situation in linux-next
> seems
> optimal to me.


Not so sure, the optimal version of fls64 for 32 bit PPC seems to be:

	cntlzw	ch,h ; ch = fls32(h) where h = x>>32
	cntlzw	cl,l ; cl = fls32(l) where l = (__u32)x
	srwi	t1,ch,5
	neg	t1,t1	; t1 = (h==0) ? -1 : 0
	and	cl,t1,cl ; cl = (h==0) ? cl : 0
	add	result,ch,cl

That's only 6 instructions without any branch, although the dependency 
chain is 5 instructions long. Good luck getting the compiler to 
generate something as compact as this.

Don't worry about the number of cntlzw, it's one clock on all 32 bit 
PPC processors I know, some may even be able to perform 2 or 3 cntlzw 
per clock.

	Regards,
	Gabriel
