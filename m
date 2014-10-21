Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 29DF11A0035
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 15:36:28 +1100 (AEDT)
In-Reply-To: <20141018005040.GB3969@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com> 
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/2] powerpc/numa: ensure per-cpu NUMA mappings are correct on
 topology update
Message-Id: <20141021043627.99A4F14008C@ozlabs.org>
Date: Tue, 21 Oct 2014 15:36:27 +1100 (AEDT)
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Michael Wang <wangyun@linux.vnet.ibm.com>, Li Zhong <zhong@linux.vnet.ibm.com>,
 jstancek@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-18-10 at 00:50:40 UTC, Nishanth Aravamudan wrote:
> We received a report of warning in kernel/sched/core.c where the sched
> group was NULL on an LPAR after a topology update. This seems to occur
> because after the topology update has moved the CPUs, cpu_to_node is
> returning the old value still, which ends up breaking the consistency of
> the NUMA topology in the per-cpu maps. Ensure that we update the per-cpu
> fields when we re-map CPUs.

This looks like a bug fix, I assume you want it to go in for 3.18 ?

cheers
