Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZx0y480KzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 19:26:26 +1000 (AEST)
In-Reply-To: <1466143320-8203-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm/hash: Don't add memory coherence if cache inhibited is
 set
Message-Id: <3rZx0y2mKxz9t0d@ozlabs.org>
Date: Thu, 23 Jun 2016 19:26:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-17-06 at 06:02:00 UTC, "Aneesh Kumar K.V" wrote:
> H_ENTER hcall handling in qemu had assumptions that a cache inhibited
> hpte entry won't have memory conference set. Also older kernel
> mentioned that some version of pHyp required this (the code removed
> by the below commit says:
> 
>     /* Make pHyp happy */
>     if ((rflags & _PAGE_NO_CACHE) && !(rflags & _PAGE_WRITETHRU))
>             hpte_r &= ~HPTE_R_M;
> 
> But with older kernel we had some inconsistent memory conherence
> mapping. We always enabled memory conherence in the page fault path and
> removed memory conherence is _PAGE_NO_CACHE was set when we mapped the
> page via htab_bolt_mapping. The commit mentioned below tried to
> consolidate that by always enabling memory conherence. But as mentioned
> above that breaks Qemu H_ENTER handling.
> 
> This patch update this such that we enable memory conherence only if
> cache inhibited is not set and bring fault handling, lpar and bolt
> mapping in sync.
> 
> Fixes: commit 30bda41aba4e("powerpc/mm: Drop WIMG in favour of new constant")
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e568006b9d828403397668864d

cheers
