Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDCsF13M2zDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 20:30:57 +1000 (AEST)
In-Reply-To: <1493204267-5752-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com, ego@linux.vnet.ibm.com
Subject: Re: powerpc/powernv: Fix oops on P9 DD1 in cause_ipi()
Message-Id: <3wDCsF059Pz9sNY@ozlabs.org>
Date: Thu, 27 Apr 2017 20:30:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-26 at 10:57:47 UTC, Michael Ellerman wrote:
> Recently we merged the native xive support for Power9, and then separately some
> reworks for doorbell IPI support. In isolation both series were OK, but the
> merged result had a bug in one case.
> 
> On P9 DD1 we use pnv_p9_dd1_cause_ipi() which tries to use doorbells, and then
> falls back to the interrupt controller. However the fallback is implemented by
> calling icp_ops->cause_ipi. But now that xive support is merged we might be
> using xive, in which case icp_ops is not initialised, it's a xics specific
> structure. This leads to an oops such as:
> 
>   Unable to handle kernel paging request for data at address 0x00000028
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   NIP pnv_p9_dd1_cause_ipi+0x74/0xe0
>   LR smp_muxed_ipi_message_pass+0x54/0x70
> 
> To fix it, rather than using icp_ops which might be NULL, have both xics and
> xive set smp_ops->cause_ipi, and then in the powernv code we save that as
> ic_cause_ipi before overriding smp_ops->cause_ipi. For paranoia add a WARN_ON()
> to check if somehow smp_ops->cause_ipi is NULL.
> 
> Fixes: b866cc2199d6 ("powerpc: Change the doorbell IPI calling convention")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/45b21cfeb22087795f0b49397fbe52

cheers
