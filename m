Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BF71BB7088
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 11:34:24 +1100 (EST)
Subject: Re: [PATCH 3/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFB8E4035A.83748CF0-ONC1257646.0080A097-C1257646.00819DD6@transmode.se>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254773824.7122.33.camel@pasglop>
	<OF3182684B.BB80DBCF-ONC1257646.0073D59B-C1257646.0075AB6F@transmode.se>
	<1254778643.7122.43.camel@pasglop>
	<OF16069D5F.03682AAC-ONC1257646.00774BB8-C1257646.0078E24B@transmode.se>
	<1254780556.7122.47.camel@pasglop>
	<OF346FF2E6.3CCDA0FA-ONC1257646.007C13A0-C1257646.007DF396@transmode.se>
	<1254784539.7122.52.camel@pasglop>
	<OFB8E4035A.83748CF0-ONC1257646.0080A097-C1257646.00819DD6@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Oct 2009 11:34:15 +1100
Message-Id: <1254789255.7122.95.camel@pasglop>
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

On Tue, 2009-10-06 at 01:35 +0200, Joakim Tjernlund wrote:
> 
> > Well, if the HW has the ability to enforce trap when store with !
> DIRTY,
> 
> Yes, provided that the kernel invalidates the TLB too so the next
> access
> will provoke a TLB Miss, which will then provoke a TLB error. The TLB
> error routine checks VALID, RW and USER(if not a kernel access), then
> sets
> ACCESSED & DIRTY and writes the TLB(RPN reg).
> 
> Perhaps the missing invalidate is haunting us here?

No, the kernel will invalidate when clearing dirty or accessed, I don't
think that's our problem.

This is still all inefficient, we end up basically with two traps.

8xx provides backup GPRs when doing TLB misses ? What does it cost to
jump out of a TLB miss back into "normal" context ?

IE. What I do on 440 is I set a mask of required bits, basically
_PAGE_PRESENT | _PAGE_ACCESSED is the base. The DTLB miss also sticks
in _PAGE_RW | _PAGE_DIRTY when it's a store fault.

Then, I andc. the PTE value off that mask, and if the result is non-0
(which means one of the required bits is missing), I get out of the TLB
miss immediately and go to the data (or instruction) access interrupt.

Once you've done that, you should be able to have data and instruction
access go straight to C. Missing _PAGE_ACCESSED and _PAGE_DIRTY are
going to be fixed up by generic code.

> > then that's fine, just map it that way, but you shouldn't have to
> handle
> > it in the DTLB error neither, the kernel will fix it up for you in
> > handle_pte_fault().
> 
> Does not all ppc have the Changed bit?

No. BookE doesn't.

> Please do, get the mpc862 users manual :)

Ok :-)

Cheers,
Ben.
