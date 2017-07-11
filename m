Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6MMH5zDPzDqg2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 22:48:27 +1000 (AEST)
In-Reply-To: <20170706105128.6317-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/powernv: Fix local TLB flush for boot and MCE on POWER9
Message-Id: <3x6MMH5CYxz9t0F@ozlabs.org>
Date: Tue, 11 Jul 2017 22:48:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-06 at 10:51:28 UTC, Nicholas Piggin wrote:
> There are two cases outside the normal address space management
> where a CPU's local TLB is to be flushed:
> 
>   1. Host boot; in case something has left stale entries in the
>      TLB (e.g., kexec).
> 
>   2. Machine check; to clean corrupted TLB entries.
> 
> CPU state restore from deep idle states also flushes the TLB.
> However this seems to be a side effect of reusing the boot code to set
> CPU state, rather than a requirement itself.
> 
> The current flushing has a number of problems with ISA v3.0B:
> 
> - The current radix mode of the MMU is not taken into account. tlbiel
>   is undefined if the R field does not match the current radix mode.
> 
> - ISA v3.0B hash must flush the partition and process table caches.
> 
> - ISA v3.0B radix must flush partition and process scoped translations,
>   partition and process table caches, and also the page walk cache.
> 
> Add POWER9 cases to handle these, with radix vs hash determined by the
> host MMU mode.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/41d0c2ecde19cfe93071ed7b979a53

cheers
