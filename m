Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1698E1A0260
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 21:33:29 +1100 (AEDT)
In-Reply-To: <1427375622-3708-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [V4, 1/4] KVM: PPC: Use READ_ONCE when dereferencing pte_t pointer
Message-Id: <20150328103326.7568E14016B@ozlabs.org>
Date: Sat, 28 Mar 2015 21:33:26 +1100 (AEDT)
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-26-03 at 13:13:39 UTC, "Aneesh Kumar K.V" wrote:
> pte can get updated from other CPUs as part of multiple activities
> like THP split, huge page collapse, unmap. We need to make sure we
> don't reload the pte value again and again for different checks.
> 
> ---
>  arch/powerpc/include/asm/kvm_book3s_64.h |  5 ++++-
>  arch/powerpc/kvm/e500_mmu_host.c         | 20 ++++++++++++--------
>  2 files changed, 16 insertions(+), 9 deletions(-)

So this series is partly KVM but mostly powerpc.

I assume you can't split it into two separate series easily?

You haven't sent it to the KVM lists or to Alex AFAICS. You'll need to do that
for the KVM pieces at least. We can probably take it all via powerpc, but I'll
need an ACK from Alex at least.

cheers
