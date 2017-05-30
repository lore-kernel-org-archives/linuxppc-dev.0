Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcSXF5WJczDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 19:11:25 +1000 (AEST)
In-Reply-To: <f6c49fcf42b78c0b8bdad17d6e659679c0288cd9.1494585671.git.ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [1/6] powernv:idle: Correctly initialize core_idle_state_ptr
Message-Id: <3wcSXF0gdMz9s0Z@ozlabs.org>
Date: Tue, 30 May 2017 19:11:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-05-16 at 08:49:43 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> The lower 8 bits of core_idle_state_ptr tracks the number of non-idle
> threads in the core. This is supposed to be initialized to bit-map
> corresponding to the threads_per_core. However, currently it is
> initialized to PNV_CORE_IDLE_THREAD_BITS (0xFF). This is correct for
> POWER8 which has 8 threads per core, but not for POWER9 which has 4
> threads per core.
> 
> As a result, on POWER9, core_idle_state_ptr gets initialized to
> 0xFF. In case when all the threads of the core are idle, the bits
> corresponding tracking the idle-threads are non-zero. As a result, the
> idle entry/exit code fails to save/restore per-core hypervisor state
> since it assumes that there are threads in the cores which are still
> active.
> 
> Fix this by correctly initializing the lower bits of the
> core_idle_state_ptr on the basis of threads_per_core.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5f221c3ca13dceaea8eefe21dbd85d

cheers
