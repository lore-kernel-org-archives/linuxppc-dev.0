Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zkggl3kJQzDrTR
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Feb 2018 19:55:15 +1100 (AEDT)
In-Reply-To: <20180213074511.6210-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: powerpc/powernv: IMC fix out of bounds memory access at shutdown
Message-Id: <3zkggl2ldVz9ryg@ozlabs.org>
Date: Sun, 18 Feb 2018 19:55:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-02-13 at 07:45:11 UTC, Nicholas Piggin wrote:
> The OPAL IMC driver's shutdown handler disables nest PMU counters by
> walking nodes and taking the first CPU out of their cpumask, which is
> used to index into the paca (get_hard_smp_processor_id()). This does
> not always do the right thing, and in particular for CPU-less nodes it
> returns NR_CPUS and that overruns the paca and dereferences random
> memory.
> 
> Fix it by being more careful about checking returned CPU, and only
> using online CPUs. It's not clear this shutdown code makes sense
> after commit 885dcd709b ("powerpc/perf: Add nest IMC PMU support"),
> but this should not make things worse
> 
> Changing the way pacas are allocated to an array of pointers exposed
> this bug:
...
> 
> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Cc: Hemant Kumar <hemant@linux.vnet.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e7bde88cdb4f0e432398a7d29ca2a1

cheers
