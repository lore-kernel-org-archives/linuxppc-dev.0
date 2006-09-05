Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4A58167B6D
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 09:19:47 +1000 (EST)
Date: Wed, 6 Sep 2006 09:19:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [POWERPC] merge iSeries i/o operations with the rest
Message-Id: <20060906091939.89da6e4b.sfr@canb.auug.org.au>
In-Reply-To: <20060905164146.GA7139@austin.ibm.com>
References: <20060905120817.e52857ee.sfr@canb.auug.org.au>
	<20060905164146.GA7139@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linas,

On Tue, 5 Sep 2006 11:41:46 -0500 linas@austin.ibm.com (Linas Vepstas) wrote:
>
> On Tue, Sep 05, 2006 at 12:08:17PM +1000, Stephen Rothwell wrote:
> > @@ -273,25 +234,30 @@ #define iobarrier_w()  eieio()
> > + *
> > + * For some of these, we force the target/source register to be
> > + * r0 to ease decoding on iSeries.
> 
> ???
> Why?

Because we were considering runtime patching of the i/o instruction on
iSeries and it seemed it would be simpler.  I have a new patch (coming
soon) the removes the forcing of r0.

> > -	int ret;
> > +	register unsigned int ret __asm__("r0");
> 
> Such as here .. why is this being forced ??

See above.

> > -	__asm__ __volatile__("lbz%U1%X1 %0,%1; twi 0,%0,0; isync"
> > -			     : "=r" (ret) : "m" (*addr));
> > +	__asm__ __volatile__("lbzx %0,0,%1; twi 0,%0,0; isync"
> > +			     : "=r" (ret) : "r" (addr));
> 
> Why make this change? The old code allows the compiler to optimize
> better than the new code.  One might argue that, in the grand scheme of
> things, i/o is very slow, so a few cycles here doesn't matter much.
> But still, I don't understand why this change is needed.

Because the original could produce any of 4 (?) different instructions
that we would have to emulate.   Interestingly the change actually made
my pSeries kernel slightly smaller (though I don't know if it was more or
less efficient).  But I will think a bit more about this.

> > +static inline void memset_io(volatile void __iomem *addr, int c,
> > +                                 unsigned long n)
> > +{
> > +	if (firmware_has_feature(FW_FEATURE_ISERIES))
> > +		iSeries_memset_io(addr, c, n);
> > +	else
> > +		eeh_memset_io(addr, c, n);
> > +}
> 
> !! I think it would be much better to have this be a compile-time
> check rather than a run-time check. No only does it save cycles, 
> but it makes the iSeries kernel smaller (by not needing eeh code 
> in it) and the p-series code smaller (by not compiling iseries
> code into it.

On a kernel built for only iSeries, firmware_has_feature(FW_FEATURE_ISERIES)
evaluates to a compile time 1 so the eeh code is not required as the
compiler elides the call.  Similarly, on a kernel that does not include
iSeries support at all, firmware_has_feature(FW_FEATURE_ISERIES)
evaluates to a compiler time 0, so the iSeries code is not required. The
only time this is a run time check is if you compile a MULTIPLATFORM
kernel incluing iSeries support (which is currently impossible but is
what we are aiming for as a possibility).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
