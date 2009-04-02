Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75FB5DDE06
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 19:31:03 +1100 (EST)
Subject: Preliminary 64-bit Book3E support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 02 Apr 2009 19:30:56 +1100
Message-Id: <1238661056.17330.208.camel@pasglop>
Mime-Version: 1.0
Cc: Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

I've posted for those interested at:

http://gate.crashing.org/~benh/patches-preliminary-book3e.tar.gz

A work-in-progress set of patches for adding support for a new processor
type, which ultimately will be common to 32 and 64-bit, and will
represent processors compliant with the architecture 2.06 "embedded"
variant. (We -might- make that backward compatible with earlier FSL
chips as well at some stage).

The current set of patches is very rough, hackish, and incomplete as you
can expect :-) It's a partial forward-rebase of an internal patch set
based on an earlier kernel which I just got booting in a simulator
internally so I can push it out before I go on vacation.

Among other things:

  - It won't boot on anything you have access to :-)

  - Even if you did, it's missing any specific Book3E > 2.06 processor
in cputable since neither IBM nor FSL has anything announced at this
stagem and there's no platform neither

  - It only does the 64-bit part for now

  - It's missing various "features", for example, SMP probably doesn't
work (though it's likely details, the original work does SMP just fine),
hugetlbfs isn't there, etc...

  - Some of the early setup code makes assumptions that may not be valid
on all implementations and firmwares. This will have to be cleaned up.

  - The patches are gross :-) They need to be split better of course.
Some things might still want to be done a bit differently though it's
actually ported from a reasonably mature code base. For example, the TLB
invalidation code for virtual page tables & indirect entries is a bit
gross right now.

  - You may notice the complete lack of useful support for critical,
debug or machine check interrupts :-) There is some initial bits there,
debug interrupts -may- work to some extend from userspace only (though I
may not have ported all the bits to handle that on the C side) etc...
This will all be sorted in another batch later. There are issues that
need to be solved with those guys vs. the TLB miss state stack which
might have to be saved/restored or context switched.

  - The move of the kernel virtual space to 0x8000000000000000 is due to
the way the virtual page tables work (when you don't have a HW table
walk, I create a giant linear virtual mapping of the page tables of a
given process so that the TLB miss handler doesn't have to walk down 3
or 4 levels of page table tree each time). It's a bit annoying though,
and I may change that back to 0xD000* using a different technique to
identify VPTs.

   - And probably more I don't have off the top of my mind right now

Don't bother looking if that stuff isn't your cup of tea and it's
definitely not in any shape to be merged any time soon, but at least
it's out so those who do care can have a look, discuss, comment, etc...

I'll probably do a new drop some time in May or June.

Cheers,
Ben.
