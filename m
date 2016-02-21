Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A64E1A08EF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 09:46:13 +1100 (AEDT)
Date: Mon, 22 Feb 2016 09:31:56 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 0/9] powerpc/mm: Restructure Linux PTE on Book3S/64
 to radix format
Message-ID: <20160221223156.GA30309@fergus.ozlabs.ibm.com>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
 <87ziuvcun9.fsf@linux.vnet.ibm.com>
 <87povq7boi.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87povq7boi.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 21, 2016 at 01:11:17PM +0530, Aneesh Kumar K.V wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
> > Paul Mackerras <paulus@samba.org> writes:
> >
> >> This patch series modifies the Linux PTE format used on 64-bit Book3S
> >> processors (i.e. POWER server processors) to make the bits line up
> >> with the PTE format used in the radix trees defined in PowerISA v3.0.
> >> This will reduce the amount of further change required to make a
> >> kernel that can run with either a radix MMU or a hashed page table
> >> (HPT) MMU.
> >>
> >> This also changes the upper levels of the tree to use real addresses
> >> rather than kernel virtual addresses - that is, we no longer have the
> >> 0xc000... at the top of each PGD/PUD/PMD entry.  I made this change
> >> for all 64-bit machines, both embedded and server.
> >>
> >> The patch series is against v4.5-rc4 plus Aneesh's "powerpc/mm/hash:
> >> Clear the invalid slot information correctly" patch.
> >>
> >> I have compiled this for all the defconfigs in the tree, without
> >> error.  I have tested this, with the fixes branch of the powerpc tree
> >> merged in, both running bare-metal on a POWER8 and in a KVM guest on
> >> that POWER8 system.  In the guest I tested both 4k and 64k configs,
> >> with THP enabled; in the host I tested with 64k page size and THP
> >> enabled.  All these tests ran fine, including running a KVM guest on
> >> the bare-metal system.  So far I have done kernel compiles in a loop
> >> as the test, but I plan to run LTP and possibly some other tests.
> >>
> >> Comments welcome.
> >
> > I was expecting some complex changes in asm and other part of the code. That
> > is one of the reason I was holding of a series like this till I get the
> > radix merged. I should have really tried the radix/hash linux page table 
> > consolidation to see the impact.
> 
> One of the details that i hit last time with _PAGE_PTE was the usage of
> @h symbol in asm code. I did a quick look and I guess we are ok. But it
> will be good to double check. pmdp_splitting_flush (which got removed)
> had usages like %4@h etc

I have done some pretty thorough grepping in arch/powerpc.  There is
no assembly code left that manipulates Linux PTEs (on 64-bit Book 3S,
that is), because you converted it all to C code. :)  There are a
couple of bits of inline asm, but the only bit that is used as an
immediate value is _PAGE_BUSY, which goes from 0x800 to 0x200, and
could actually stay at 0x800 in fact.

Paul.
