Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2E8E67B23
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 03:24:15 +1000 (EST)
Date: Thu, 7 Apr 2005 09:00:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Message-ID: <20050407120013.GF14822@logos.cnet>
References: <20050406121649.GC11066@logos.cnet>
	<BCEFJBPJCGFCNMMMIDBHKEGBCLAA.Joakim.Tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHKEGBCLAA.Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8xx v2.6 TLB problems and suggested workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Apr 06, 2005 at 11:24:46PM +0200, Joakim Tjernlund wrote:
> > On Tue, Apr 05, 2005 at 11:51:42PM +0200, Joakim Tjernlund wrote:
> > > Hi Marcelo
> > > 
> > > Reading your report it doesn't sound likely but I will ask anyway:
> > > Is it possible that the problem you are seeing isn't caused by the
> > > "famous" CPU bug mentioned here: 
> > > http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016351.html
> > > 
> > > The DTLB error handler needs DAR to be set correctly and since the
> > > dcbX instructions doesn't set DAR in either DTLB Miss nor DTLB Error you
> > > may end up trying to fix the wrong address.
> > 
> > Hi Joakim,
> > 
> > First of all, thanks your care!
> 
> NP, I want to be able to run 8xx on 2.6 in the future.
>  
> > 
> > Well, I dont think the above issue is exactly what we're hitting because
> > DAR is correctly updated on our case with "dcbst".
> 
> Are you sure? Cant remeber all details but this looks a bit strange to me
> SPR  826 : 0x00001f00         7936
> is not 0x00001 supposed to be the physical page? 

SPR 826 contains the page attributes, not Physical Page Number (which is held 
by SPR 825).

> Also DSISR: C2000000 looks strange and "impossible". Are you sure this value
> is correct?  

As defined by the PEM, bit 1 indicates "data-store error exception", bit 2 
indicates:

"Set if the translation of an attempted access is not found in the primary hash 
table entry group (HTEG), or in the rehashed secondary HTEG, or in the range of a 
DBAT register (page fault condition); otherwise cleared." 

And bit 6 indicates a store operation (shouldnt be set). 

> Don't understand why the "tlbie()" call  works around the problem. Can you
> explain that a bit more?

It must be because the TLB entry is now removed from the cache, which avoids 
dcbst from faulting as a store.

There must be some relation to the invalid present TLB entry and dcbst
misbehaviour.

I didnt check what happens with the TLB after tlbie(), I should do that.
But I suppose it gets wiped off? 

> > The problem is that it is treated as a write operation, but shouldnt.
> > 
> > Maybe it is related to dcbst's inability to set DAR?
> 
> Could be, but even if it isn't you are in trouble when dcbX instr.
> generates DTLB Misses/Errors Sooner or later you will end up with
> strange SEGV or hangs.

Hangs due to the dcbX misbehaviour wrt DAR setting, you mean? (which your 
patch corrects).

Yep, that makes sense.

> > BTW, about the CPU15 bug fix, has there been any effort to port/merge 
> > it in v2.6 ?
> 
> None that I know.
