Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcmHh3lmczDqM0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 22:01:52 +1000 (AEST)
In-Reply-To: <20170724042803.25848-3-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Subject: Re: [3/6] powerpc/mm: Ensure cpumask update is ordered
Message-Id: <3xcmHh2ZQZz9sCZ@ozlabs.org>
Date: Wed, 23 Aug 2017 22:01:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-24 at 04:28:00 UTC, Benjamin Herrenschmidt wrote:
> There is no guarantee that the various isync's involved with
> the context switch will order the update of the CPU mask with
> the first TLB entry for the new context being loaded by the HW.
> 
> Be safe here and add a memory barrier to order any subsequent
> load/store which may bring entries into the TLB.
> 
> The corresponding barrier on the other side already exists as
> pte updates use pte_xchg() which uses __cmpxchg_u64 which has
> a sync after the atomic operation.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/1a92a80ad386a1a6e3b36d576d52a1

cheers
