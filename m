Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 27578B7D21
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 11 Apr 2010 18:39:39 +1000 (EST)
Subject: Re: Question regarding the DTLB Miss exceptions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bruce_Leonard@selinc.com
In-Reply-To: <OFD957C4B7.2DDD66CF-ON882576FF.0069A7B1-882576FF.006B689A@selinc.com>
References: <OF788A7534.456B03AA-ON882576F6.00228BC4-882576F6.00233EC1@selinc.com>
	<1270735170.19546.2.camel@concordia>
	<OFD957C4B7.2DDD66CF-ON882576FF.0069A7B1-882576FF.006B689A@selinc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 11 Apr 2010 18:39:11 +1000
Message-ID: <1270975151.6865.140.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <pmac@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-04-08 at 12:33 -0700, Bruce_Leonard@selinc.com wrote:

(CC'ing Paulus who wrote that code ages ago)

> > 616 DataAddressInvalid:
> >  617         mfspr   r3,SPRN_SRR1
> >  618         rlwinm  r1,r3,9,6,6     /* Get load/store bit */
> >  619         addis   r1,r1,0x2000  
> >  620         mtspr   SPRN_DSISR,r1
> > 
> > Is it trying to set DSISR_ISSTORE?
> > 
> > #define   DSISR_ISSTORE         0x02000000      /* access was a store */ 
>  
> > 
> Michael,
> 
> Thanks for the reply.
> 
> I mean line 619 above.  It's setting 0x20000000 (bit 2) in the DSISR. 
> 0x02000000 (bit 6 or DSISR_ISSTORE) is already set because it's a DTLB 
> Data Store Miss Exception.  But 0x20000000 is meaningless for the DSI 
> Exception about to be called.  According to the data sheet, it's supposed 
> to be cleared.  Someone wrote code to explicitly set a bit in the DSISR 
> that has no meaning in the PPC architecture.

I agree that setting a bit in DSISR is very very fishy... however it
works and it's not like there was going to be loads of new 603's so I
assume it's no big deal. As to the meaning of the bits, see below...

>   So I assume it's being 
> overloaded for some purpose, but I can't glean that purpose from the code. 
>  Equally perplexing to me is the following line of code from the DSI 
> Exception code:
> 
> andis.  r0,r10,0xa470   /* weird error? */
> 
> It's checking to see if the following bits of DSISR are set:
> 0 - set by DTLB miss if no hash table entry group is found

No. 0 means we hit a direct store segment. This is a historical feature
of the architecture which we don't use, so should not happen.

> 2 - an invalid bit

Not sure what 2 is about.

> 5 - an invalid bit

Nah, that is set on some processors such as 604 when doing a lwarx/stwcx
with W=1 or such forbidden settings, though I don't remember if it was
architected back then.

> 9 - set if breakpoint match
> 10 - invalid bit

Nah, that is set when missing on segments.

> 11 - set if the instruction is an ecwix or ecowx and EAR[E] = 0
>
> So it's checking to see if three bits not defined by the PPC architecture 
> are set and calling it a "weird error".  What the heck does that mean, a 
> "weird error"?

Nah. It's a bad name. It means it's an error that is either something we
don't support (like direct store) or something that doesn't need to go
through hash_page, such as a breakpoint match.

I suppose we should probably also test for bit 6 (protection violation)
since that will always land into do page fault. That would mean removing
the code to set DIRTY in the hash code and rely on the C code to do it,
and thus speeding up page faults a bit, but I don't see that as being a
big deal.

>   Obviously overloaded bits used for some totally 
> undocumented purpose that I can't figure out from the code and I'm just 
> trying to understand what they're used for to see if it's related to my 
> problem. 

I missed the earlier discussion, what is your problem ?

Cheers,
Ben.
