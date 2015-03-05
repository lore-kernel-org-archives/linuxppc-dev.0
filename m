Return-Path: <htejun@gmail.com>
Received: from mail-qg0-x22a.google.com (mail-qg0-x22a.google.com
 [IPv6:2607:f8b0:400d:c04::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97ED41A0246
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 09:08:10 +1100 (AEDT)
Received: by qgaj5 with SMTP id j5so8411005qga.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2015 14:08:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 5 Mar 2015 17:08:04 -0500
From: Tejun Heo <tj@kernel.org>
To: David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH] powerpc/numa: reset node_possible_map to only
 node_online_map
Message-ID: <20150305220804.GF23912@htj.duckdns.org>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
 <1425592132.13327.0.camel@ellerman.id.au>
 <alpine.DEB.2.10.1503051352540.25375@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1503051352540.25375@chino.kir.corp.google.com>
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Thu, Mar 05, 2015 at 01:58:27PM -0800, David Rientjes wrote:
> I'm not sure why this is being proposed as a powerpc patch and now a patch 
> for mem_cgroup_css_alloc().  In other words, why do we have to allocate 
> for all possible nodes?  We should only be allocating for online nodes in 
> N_MEMORY with mem hotplug disabled initially and then have a mem hotplug 
> callback implemented to alloc_mem_cgroup_per_zone_info() for nodes that 
> transition from memoryless -> memory.  The extra bonus is that 
> alloc_mem_cgroup_per_zone_info() need never allocate remote memory and the 
> TODO in that function can be removed.

For cpus, the general direction is allocating for all possible cpus.
For iterations, we alternate between using all possibles and onlines
depending on the use case; however, the general idea is that the
possibles and onlines aren't gonna be very different.  NR_CPUS and
MAX_NUMNODES gotta accomodate the worst possible case the kernel may
run on but the possible masks should be set to the actually possible
subset during boot so that the kernel don't end up allocating for and
iterating over things which can't ever exist.

It can be argued that we should always stick to the online masks for
allocation and iteration; however, that usually requires more
complexity and the only cases where this mattered have been when the
boot code got it wrong and failed to set the possible masks correctly,
which also seems to be the case here.  I don't see any reason to
deviate here.

Thanks.

-- 
tejun
