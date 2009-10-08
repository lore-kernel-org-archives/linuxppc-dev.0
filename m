Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E30FB7B70
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 09:24:21 +1100 (EST)
Subject: Re: [PATCH 3/6] 8xx: invalidate non present TLBs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <34A4641D-8121-4EBC-9880-26CB70DD3339@embeddedalley.com>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254950285.2409.10.camel@pasglop>
	<OF44C1983F.1C42E290-ONC1257649.0069CAF3-C1257649.006A78D1@transmode.se>
	<7A3C6D4C-E92B-434D-AF68-7AEEDE6DAD45@embeddedalley.com>
	<1255033705.2146.17.camel@pasglop>
	<34A4641D-8121-4EBC-9880-26CB70DD3339@embeddedalley.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Oct 2009 09:23:48 +1100
Message-Id: <1255040628.2146.54.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-08 at 15:08 -0700, Dan Malek wrote:
> Hi Ben.
> 
> On Oct 8, 2009, at 1:28 PM, Benjamin Herrenschmidt wrote:
> 
> > While you are around ... I have a question :-)
> 
> I'll try.  Many brain cells have been replaced or lost
> over the years :-)

Replaced ? You lucky ! I only lose mines :-)

> I thought we did a tlbie() (or whatever the equivalent is today)
> when the PTE was updated in the table.  An optimization was to
> load the TLB with the entry at that time to avoid a subsequent miss.
> In any case, the TLB entry has to be modified by the software.

Ok, that's my understanding too and I think we had the tlbie in
update_mmu_cache to do the trick, though the comment is misleading
making it think that the only reason it's there is for the dcbst
problem. At least that's my understanding. That was lost recently in 2.6
so I'll have to put it back properly.

I don't think we do the pre-load to avoid the second fault, but we
certainly could and should.

> I don't remember how C was used in the past, but I suspect
> it just mirrored the Linux VM state.  I'm quite certain the MMU
> HW would never change a TLB entry.  Where did you read this?

MPC855UM, chapter 8.6 "Memory attributes":

<<
• Reference and change bit updates—The MPC850 does not generate an exception for
  an R (reference) bit update. In fact, there is no entry for an R bit in the TLB.
  The change bit (C) is bit 23 in the level-two descriptor, described in Table 8-4.
  Software updates C (changed) bits, but hardware treats the C bit (negated) as a
  write-protect attribute. Therefore, attempting to write to a page marked unmodified
  invalidates that entry and causes an implementation-specific DTLB error exception.
  ^^^^^^^^^^^^^^^^^^^^^^
  If change bits are not needed, set the C bit to one by default in the PTEs.
>>

And yes, it's weird and that's the only place I think where this is
mentioned which makes me think it could well be a doco bug.

> For most of the 8xx "early days," I used to just mark all write
> pages as dirty.   For some reason I just overloaded the write/changed
> into one bit, it avoided TLB Error overhead and I think even some
> silicon bugs.  Since they were tiny and fairly static embedded
> systems, it didn't have any effect on the way VM was managed.

Well, nowadays at least, most of the time, a writeable page is also
dirty unless it's a writeable shared mapping, and in that later case
you really want to do proper dirty tracking. So I suspect we can
simplify some of that and let the generic code handle dirty by mapping
_PAGE_DIRTY to C and removing _PAGE_HWWRITE. We can also remove all
of the asm munging from DataTLBError, and let the generic C code fixup
DIRTY and ACCESSED when needed, since those should only rarely need a
fixup.

> The MMU HW on the 8xx is just a translator.  I'm now really
> certain it won't ever change a TLB entry.  It's completely up to
> software to make all TLB changes.

That makes sense.

> Just make it simple :-)

Yeah. I think we can simplify the current code a lot, which will speed
up TLB misses (well, nothing much you can do about the infamous errata
#6 but that's another story). It won't give 2.6 back the 2.4 speed due
to sheer bloat of the generic code but it might at least offset some of
the loss by improving the overall TLB miss performance.

Now, I don't have any 8xx gear, so it will be up to Joakim, Scott etc...
to get that stuff right :-)

Thanks for your feedback.

Cheers,
Ben.

> Thanks.
> 
> 	-- Dan
