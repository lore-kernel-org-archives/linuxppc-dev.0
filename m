Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 620811A060E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 11:30:47 +1100 (AEDT)
Message-ID: <1456101047.4690.5.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 0/9] powerpc/mm: Restructure Linux PTE on Book3S/64
 to radix format
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Paul Mackerras
 via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 22 Feb 2016 11:30:47 +1100
In-Reply-To: <87ziuvcun9.fsf@linux.vnet.ibm.com>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
 <87ziuvcun9.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-02-20 at 20:10 +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@samba.org> writes:
> 
> > This patch series modifies the Linux PTE format used on 64-bit Book3S
> > processors (i.e. POWER server processors) to make the bits line up
> > with the PTE format used in the radix trees defined in PowerISA v3.0.
> > This will reduce the amount of further change required to make a
> > kernel that can run with either a radix MMU or a hashed page table
> > (HPT) MMU.
> > 
> > This also changes the upper levels of the tree to use real addresses
> > rather than kernel virtual addresses - that is, we no longer have the
> > 0xc000... at the top of each PGD/PUD/PMD entry.  I made this change
> > for all 64-bit machines, both embedded and server.
> > 
> > The patch series is against v4.5-rc4 plus Aneesh's "powerpc/mm/hash:
> > Clear the invalid slot information correctly" patch.
> > 
> > I have compiled this for all the defconfigs in the tree, without
> > error.  I have tested this, with the fixes branch of the powerpc tree
> > merged in, both running bare-metal on a POWER8 and in a KVM guest on
> > that POWER8 system.  In the guest I tested both 4k and 64k configs,
> > with THP enabled; in the host I tested with 64k page size and THP
> > enabled.  All these tests ran fine, including running a KVM guest on
> > the bare-metal system.  So far I have done kernel compiles in a loop
> > as the test, but I plan to run LTP and possibly some other tests.
> > 
> > Comments welcome.
> 
> I was expecting some complex changes in asm and other part of the code. That
> is one of the reason I was holding of a series like this till I get the
> radix merged.

Yeah, but you actually rewrote most/all of that code in C as part of your
earlier refactoring :)

> Now how do we want to go with this series ?. If we are taking this
> series before the books3 hash linux abstraction series, I will have to
> redo that series now on top of this.

I'd prefer to merge this first.

I know you'll have to redo your series, but hopefully some of your series can
just go away, because we don't need to abstract the PTE bits anymore.

cheers
