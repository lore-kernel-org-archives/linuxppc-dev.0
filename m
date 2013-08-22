Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 789F52C008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 09:31:04 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: Detecting LD/ST instruction
In-reply-to: <20130822225525.GA5214@us.ibm.com>
References: <20130822225525.GA5214@us.ibm.com>
Date: Fri, 23 Aug 2013 09:31:04 +1000
Message-ID: <5184.1377214264@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I am working on implementing the 'perf mem' command for Power
> systems. This would for instance, let us know where in the memory
> hierarchy (L1, L2, Local RAM etc) the data for a load/store
> instruction was found (hit).
> 
> On Power7, if the mcmcra[DCACHE_MISS] is clear _and_ the
> instruction is a load/store, then it implies a L1-hit.
> 
> Unlike on Power8, the Power7 event vector has no indication
> if the instruction was load/store.
> 
> In the context of a PMU interrupt, is there any way to determine
> if an instruction is a load/store ?

You could read the instruction from memory and work it out.  

We do something similar to this in power_pmu_bhrb_to() where we read the
instruction and work out where the branch is going to.

If you do this, please use and/or extend the functions in
arch/powerpc/lib/code-patching.c

Mikey
