Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CF6F1A0427
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 10:41:21 +1100 (AEDT)
Message-ID: <1427672463.20500.40.camel@kernel.crashing.org>
Subject: Re: [V4,1/4] KVM: PPC: Use READ_ONCE when dereferencing pte_t pointer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 30 Mar 2015 10:41:03 +1100
In-Reply-To: <87384nn43n.fsf@linux.vnet.ibm.com>
References: <20150328103326.7568E14016B@ozlabs.org>
 <87384nn43n.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-03-29 at 22:16 +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > On Thu, 2015-26-03 at 13:13:39 UTC, "Aneesh Kumar K.V" wrote:
> >> pte can get updated from other CPUs as part of multiple activities
> >> like THP split, huge page collapse, unmap. We need to make sure we
> >> don't reload the pte value again and again for different checks.
> >> 
> >> ---
> >>  arch/powerpc/include/asm/kvm_book3s_64.h |  5 ++++-
> >>  arch/powerpc/kvm/e500_mmu_host.c         | 20 ++++++++++++--------
> >>  2 files changed, 16 insertions(+), 9 deletions(-)
> >
> > So this series is partly KVM but mostly powerpc.
> >
> > I assume you can't split it into two separate series easily?
> 
> Yes, will do. But before that I was looking for feedback from Ben or
> Paul.
> 
> >
> > You haven't sent it to the KVM lists or to Alex AFAICS. You'll need to do that
> > for the KVM pieces at least. We can probably take it all via powerpc, but I'll
> > need an ACK from Alex at least.
> >
> 
> If I can get an ack from Ben, that makes it easy for the kvm list.

Ack. Using ACCESS_ONCE in a lockless access of the PTE that does
multiple checks makes sense.

Cheers,
Ben.
