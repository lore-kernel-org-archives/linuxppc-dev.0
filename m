Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcSX74hdQzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 19:11:19 +1000 (AEST)
In-Reply-To: <20170511174040.19728-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/3] powerpc/64s: tool to flag direct branches from unrelocated
 interrupt vectors
Message-Id: <3wcSX73tslz9s65@ozlabs.org>
Date: Tue, 30 May 2017 19:11:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-05-11 at 17:40:38 UTC, Nicholas Piggin wrote:
> Direct banches from code below __end_interrupts to code above
> __end_interrupts when built with CONFIG_RELOCATABLE are disallowed
> because they will break when the kernel is not located at 0.
> 
> Sample output:
> 
>     WARNING: Unrelocated relative branches
>     c000000000000118 bl-> 0xc000000000038fb8 <pnv_restore_hyp_resource>
>     c00000000000013c b-> 0xc0000000001068a4 <kvm_start_guest>
>     c000000000000148 b-> 0xc00000000003919c <pnv_wakeup_loss>
>     c00000000000014c b-> 0xc00000000003923c <pnv_wakeup_noloss>
>     c0000000000005a4 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
>     c000000000001af0 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
>     c000000000001b24 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
>     c000000000001b58 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4ea80652dc75482dca1739762075dd

cheers
