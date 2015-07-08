Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B63BC1A105E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 14:00:56 +1000 (AEST)
In-Reply-To: <20150702230202.GA2807@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC,1/2] powerpc/numa: fix cpu_to_node() usage during boot
Message-Id: <20150708040056.948A1140770@ozlabs.org>
Date: Wed,  8 Jul 2015 14:00:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-02-07 at 23:02:02 UTC, Nishanth Aravamudan wrote:
> Much like on x86, now that powerpc is using USE_PERCPU_NUMA_NODE_ID, we
> have an ordering issue during boot with early calls to cpu_to_node().

"now that .." implies we changed something and broke this. What commit was
it that changed the behaviour?

> The value returned by those calls now depend on the per-cpu area being
> setup, but that is not guaranteed to be the case during boot. Instead,
> we need to add an early_cpu_to_node() which doesn't use the per-CPU area
> and call that from certain spots that are known to invoke cpu_to_node()
> before the per-CPU areas are not configured.
> 
> On an example 2-node NUMA system with the following topology:
> 
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3
> node 0 size: 2029 MB
> node 0 free: 1753 MB
> node 1 cpus: 4 5 6 7
> node 1 size: 2045 MB
> node 1 free: 1945 MB
> node distances:
> node   0   1 
>   0:  10  40 
>   1:  40  10 
> 
> we currently emit at boot:
> 
> [    0.000000] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
> 
> After this commit, we correctly emit:
> 
> [    0.000000] pcpu-alloc: [0] 0 1 2 3 [1] 4 5 6 7 


So it looks fairly sane, and I guess it's a bug fix.

But I'm a bit reluctant to put it in straight away without some time in next.

It looks like the symptom is that the per-cpu areas are all allocated on node
0, is that all that goes wrong?

cheers
