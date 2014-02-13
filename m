Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D8BCB2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 17:52:20 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 12 Feb 2014 23:52:17 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E83021FF001A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 23:52:13 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1D6pfEs62718120
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 07:51:46 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1D6pqdi016673
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 23:51:53 -0700
Date: Wed, 12 Feb 2014 22:51:37 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for
 determining the fallback node
Message-ID: <20140213065137.GA10860@linux.vnet.ibm.com>
References: <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.02.1402060041040.21148@chino.kir.corp.google.com>
 <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
 <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
 <20140207054819.GC28952@lge.com>
 <alpine.DEB.2.10.1402071150090.15168@nuc>
 <alpine.DEB.2.10.1402071245040.20246@nuc>
 <20140210191321.GD1558@linux.vnet.ibm.com>
 <20140211074159.GB27870@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140211074159.GB27870@lge.com>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joonsoo,

On 11.02.2014 [16:42:00 +0900], Joonsoo Kim wrote:
> On Mon, Feb 10, 2014 at 11:13:21AM -0800, Nishanth Aravamudan wrote:
> > Hi Christoph,
> > 
> > On 07.02.2014 [12:51:07 -0600], Christoph Lameter wrote:
> > > Here is a draft of a patch to make this work with memoryless nodes.
> > > 
> > > The first thing is that we modify node_match to also match if we hit an
> > > empty node. In that case we simply take the current slab if its there.
> > > 
> > > If there is no current slab then a regular allocation occurs with the
> > > memoryless node. The page allocator will fallback to a possible node and
> > > that will become the current slab. Next alloc from a memoryless node
> > > will then use that slab.
> > > 
> > > For that we also add some tracking of allocations on nodes that were not
> > > satisfied using the empty_node[] array. A successful alloc on a node
> > > clears that flag.
> > > 
> > > I would rather avoid the empty_node[] array since its global and there may
> > > be thread specific allocation restrictions but it would be expensive to do
> > > an allocation attempt via the page allocator to make sure that there is
> > > really no page available from the page allocator.
> > 
> > With this patch on our test system (I pulled out the numa_mem_id()
> > change, since you Acked Joonsoo's already), on top of 3.13.0 + my
> > kthread locality change + CONFIG_HAVE_MEMORYLESS_NODES + Joonsoo's RFC
> > patch 1):
> > 
> > MemTotal:        8264704 kB
> > MemFree:         5924608 kB
> > ...
> > Slab:            1402496 kB
> > SReclaimable:     102848 kB
> > SUnreclaim:      1299648 kB
> > 
> > And Anton's slabusage reports:
> > 
> > slab                                   mem     objs    slabs
> >                                       used   active   active
> > ------------------------------------------------------------
> > kmalloc-16384                       207 MB   98.60%  100.00%
> > task_struct                         134 MB   97.82%  100.00%
> > kmalloc-8192                        117 MB  100.00%  100.00%
> > pgtable-2^12                        111 MB  100.00%  100.00%
> > pgtable-2^10                        104 MB  100.00%  100.00%
> > 
> > For comparison, Anton's patch applied at the same point in the series:
> > 
> > meminfo:
> > 
> > MemTotal:        8264704 kB
> > MemFree:         4150464 kB
> > ...
> > Slab:            1590336 kB
> > SReclaimable:     208768 kB
> > SUnreclaim:      1381568 kB
> > 
> > slabusage:
> > 
> > slab                                   mem     objs    slabs
> >                                       used   active   active
> > ------------------------------------------------------------
> > kmalloc-16384                       227 MB   98.63%  100.00%
> > kmalloc-8192                        130 MB  100.00%  100.00%
> > task_struct                         129 MB   97.73%  100.00%
> > pgtable-2^12                        112 MB  100.00%  100.00%
> > pgtable-2^10                        106 MB  100.00%  100.00%
> > 
> > 
> > Consider this patch:
> > 
> > Acked-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> > Tested-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> 
> Hello,
> 
> I still think that there is another problem.
> Your report about CONFIG_SLAB said that SLAB uses just 200MB.
> Below is your previous report.
> 
>   Ok, with your patches applied and CONFIG_SLAB enabled:
> 
>   MemTotal:        8264640 kB
>   MemFree:         7119680 kB
>   Slab:             207232 kB
>   SReclaimable:      32896 kB
>   SUnreclaim:       174336 kB
> 
> The number on CONFIG_SLUB with these patches tell us that SLUB uses 1.4GB.
> There is large difference on slab usage.

Agreed. But, at least for now, this gets us to not OOM all the time :) I
think that's significant progress. I will continue to look at this
issue for where the other gaps are, but would like to see Christoph's
latest patch get merged (pending my re-testing).

> And, I should note that number of active objects on slabinfo can be
> wrong on some situation, since it doesn't consider cpu slab (and cpu
> partial slab).

Well, I grabbed everything from /sys/kernel/slab for you in the
tarballs, I believe.

> I recommend to confirm page_to_nid() and other things as I mentioned
> earlier.

I believe these all work once CONFIG_HAVE_MEMORYLESS_NODES was set for
ppc64, but will test it again when I have access to the test system.

Also, given that only ia64 and (hopefuly soon) ppc64 can set
CONFIG_HAVE_MEMORYLESS_NODES, does that mean x86_64 can't have
memoryless nodes present? Even with fakenuma? Just curious.

-Nish
