Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgn2cP0zF0dd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:33 +1000 (AEST)
In-Reply-To: <20180601100121.393-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v4, 1/7] powerpc/64s/radix: do not flush TLB when relaxing access
Message-Id: <40zxgm1t2Fz9s5c@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-06-01 at 10:01:15 UTC, Nicholas Piggin wrote:
> Radix flushes the TLB when updating ptes to increase permissiveness
> of protection (increase access authority). Book3S does not require
> TLB flushing in this case, and it is not done on hash. This patch
> avoids the flush for radix.
> 
> >From Power ISA v3.0B, p.1090:
> 
>     Setting a Reference or Change Bit or Upgrading Access Authority
>     (PTE Subject to Atomic Hardware Updates)
> 
>     If the only change being made to a valid PTE that is subject to
>     atomic hardware updates is to set the Reference or Change bit to 1
>     or to add access authorities, a simpler sequence suffices because
>     the translation hardware will refetch the PTE if an access is
>     attempted for which the only problems were reference and/or change
>     bits needing to be set or insufficient access authority.
> 
> The nest MMU on POWER9 does not re-fetch the PTE after such an access
> attempt before faulting, so address spaces with a coprocessor
> attached will continue to flush in these cases.
> 
> This reduces tlbies for a kernel compile workload from 1.28M to 0.95M,
> tlbiels from 20.17M 19.68M.
> 
> fork --fork --exec benchmark improved 2.77% (12000->12300).
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e5f7cb58c2b77a0249c2028b6d1ec4

cheers
