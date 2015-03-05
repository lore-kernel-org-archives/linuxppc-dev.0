Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 116B91A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 10:22:36 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 5 Mar 2015 16:22:35 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 690D6C40002
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 16:13:45 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t25NKoa625886928
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 16:20:58 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t25NM0K4029588
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 16:22:01 -0700
Date: Thu, 5 Mar 2015 15:21:35 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] powerpc/numa: reset node_possible_map to only
 node_online_map
Message-ID: <20150305232135.GE30570@linux.vnet.ibm.com>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
 <1425592132.13327.0.camel@ellerman.id.au>
 <alpine.DEB.2.10.1503051352540.25375@chino.kir.corp.google.com>
 <20150305220804.GF23912@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150305220804.GF23912@htj.duckdns.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05.03.2015 [17:08:04 -0500], Tejun Heo wrote:
> Hello,
> 
> On Thu, Mar 05, 2015 at 01:58:27PM -0800, David Rientjes wrote:
> > I'm not sure why this is being proposed as a powerpc patch and now a patch 
> > for mem_cgroup_css_alloc().  In other words, why do we have to allocate 
> > for all possible nodes?  We should only be allocating for online nodes in 
> > N_MEMORY with mem hotplug disabled initially and then have a mem hotplug 
> > callback implemented to alloc_mem_cgroup_per_zone_info() for nodes that 
> > transition from memoryless -> memory.  The extra bonus is that 
> > alloc_mem_cgroup_per_zone_info() need never allocate remote memory and the 
> > TODO in that function can be removed.
> 
> For cpus, the general direction is allocating for all possible cpus.
> For iterations, we alternate between using all possibles and onlines
> depending on the use case; however, the general idea is that the
> possibles and onlines aren't gonna be very different.  NR_CPUS and
> MAX_NUMNODES gotta accomodate the worst possible case the kernel may
> run on but the possible masks should be set to the actually possible
> subset during boot so that the kernel don't end up allocating for and
> iterating over things which can't ever exist.

Makes sense to me.

> It can be argued that we should always stick to the online masks for
> allocation and iteration; however, that usually requires more
> complexity and the only cases where this mattered have been when the
> boot code got it wrong and failed to set the possible masks correctly,
> which also seems to be the case here.  I don't see any reason to
> deviate here.

So, do you agree with the general direction of my change? :)

Thanks,
Nish
