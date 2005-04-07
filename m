Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F7AB67B20
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 11:05:05 +1000 (EST)
Date: Thu, 7 Apr 2005 16:38:46 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Message-ID: <20050407193846.GE19449@logos.cnet>
References: <20050407120013.GF14822@logos.cnet>
	<BCEFJBPJCGFCNMMMIDBHGEGHCLAA.Joakim.Tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHGEGHCLAA.Joakim.Tjernlund@lumentis.se>
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

Joakim,

On Thu, Apr 07, 2005 at 10:35:30PM +0200, Joakim Tjernlund wrote:
> > -----Original Message-----
> > From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com]
> > Sent: den 7 april 2005 14:00
> > On Wed, Apr 06, 2005 at 11:24:46PM +0200, Joakim Tjernlund wrote:
> > > > On Tue, Apr 05, 2005 at 11:51:42PM +0200, Joakim Tjernlund wrote:
> > > > > Hi Marcelo
> > > > > 
> > > > > Reading your report it doesn't sound likely but I will ask anyway:
> > > > > Is it possible that the problem you are seeing isn't caused by the
> > > > > "famous" CPU bug mentioned here: 
> > > > > http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016351.html
> > > > > 
> > > > > The DTLB error handler needs DAR to be set correctly and since the
> > > > > dcbX instructions doesn't set DAR in either DTLB Miss nor DTLB Error you
> > > > > may end up trying to fix the wrong address.
> > > > 
> > > > Hi Joakim,
> > > > 
> > > > First of all, thanks your care!
> > > 
> > > NP, I want to be able to run 8xx on 2.6 in the future.
> > >  
> > > > 
> > > > Well, I dont think the above issue is exactly what we're hitting because
> > > > DAR is correctly updated on our case with "dcbst".
> > > 
> > > Are you sure? Cant remeber all details but this looks a bit strange to me
> > > SPR  826 : 0x00001f00         7936
> > > is not 0x00001 supposed to be the physical page? 
> > 
> > SPR 826 contains the page attributes, not Physical Page Number (which is held 
> > by SPR 825).
> 
> Yes, my memory is getting really bad :)
> 
> Does SPR 825 hould the correct physical page? 0x000001e0 looks like
> Zero to me(I should probably bring the manual home so i don't have the rely on
> my bad memory :)

Yes, it is zero. That is because there is no pte entry for the page yet (DataStoreTLBMiss
sets the pte even if its zero). Thats when DataTLBError (EA present in TLB entry but valid
bit not set) gets called.

> > > Also DSISR: C2000000 looks strange and "impossible". Are you sure this value
> > > is correct?  
> > 
> > As defined by the PEM, bit 1 indicates "data-store error exception", bit 2 
> > indicates:

I meant "bit 0 and bit 1".

> > "Set if the translation of an attempted access is not found in the primary hash 
> > table entry group (HTEG), or in the rehashed secondary HTEG, or in the range of a 
> > DBAT register (page fault condition); otherwise cleared." 
> > 
> > And bit 6 indicates a store operation (shouldnt be set). 
> 
> Yes, but bit 0 is also set and if I remember correctly(don't have the manual handy)
> it should always be zero?

Well, bit 0 and bit 1 are set. 

> > > Don't understand why the "tlbie()" call works around the problem. Can you
> > > explain that a bit more?
> > 
> > It must be because the TLB entry is now removed from the cache, which avoids 
> > dcbst from faulting as a store.
> > 
> > There must be some relation to the invalid present TLB entry and dcbst
> > misbehaviour.
> > 
> > I didnt check what happens with the TLB after tlbie(), I should do that.
> > But I suppose it gets wiped off?
> 
> Unless the pte gets populated(valid) before the next TLB miss I think you
> will repeat the same sequence that caused the error in the first place. 
> So why does that work? 

It does get populated.

The sequence is:

1)  userspace access triggers DataTLBMiss

2) DataTLBMiss sets TLB from Linux pte. At this stage pte entry is still 
zeroed (pte table entry clear). Thats why PPN points to page "00000".

3) DataTLBError (TLB EA match but valid bit not set) - jumps to page fault
handler

4) do_no_page() 
	- allocates a page
	- set pte accordingly 
	- update_mmu_cache()  (dcbst access faults as a write)

So, there must be some relation over dcbst's misbehaviour and the _invalid_ 
zero RPN TLB entry. 

Thing is dcbst is not supposed to fault as a store operation, from what PEM
indicates.

As I understand 8xx deviates from other PPC's in many aspects. Dan says: 

"The PEM cache instructions are all implemented in a microcode that
uses the 8xx unique cache control SPRs.  Depending upon the state
of the cache and MMU, it seems in some cases the EA translation is
subject to a "normal" protection match instead of a load operation
match.
                                                                                                                                                                                   
The behavior of these operations isn't consistent across all of the 8xx
processor revisions, especially with early silicon if people are still
using those.  During conversations with Freescale engineers, it seems
the only guaranteed operation was to use the 8xx unique SPRs, but
I think I only did that in 8xx specific functions." 

I'll check what the tlbie does precisely (tomorrow). I suppose it wipes the TLB
entry completly.

Would be nice to have someone from 8xx team look into this? 

> > > > The problem is that it is treated as a write operation, but shouldnt.
> > > > 
> > > > Maybe it is related to dcbst's inability to set DAR?
> > > 
> > > Could be, but even if it isn't you are in trouble when dcbX instr.
> > > generates DTLB Misses/Errors Sooner or later you will end up with
> > > strange SEGV or hangs.
> > 
> > Hangs due to the dcbX misbehaviour wrt DAR setting, you mean? (which your 
> > patch corrects).
> 
> Yes.
> 
> > 
> > Yep, that makes sense.
> > 
> > > > BTW, about the CPU15 bug fix, has there been any effort to port/merge 
> > > > it in v2.6 ?
> > > 
> > > None that I know.

I'll try cpu15.c on v2.6 tomorrow.
