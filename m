Return-Path: <iamjoonsoo.kim@lge.com>
Received: from LGEAMRELO02.lge.com (lgeamrelo02.lge.com [156.147.1.126])
 by ozlabs.org (Postfix) with ESMTP id CF6472C0082
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 16:48:32 +1100 (EST)
Date: Fri, 7 Feb 2014 14:48:19 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for
 determining the fallback node
Message-ID: <20140207054819.GC28952@lge.com>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.02.1402060041040.21148@chino.kir.corp.google.com>
 <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
 <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Matt Mackall <mpm@selenic.com>, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 06, 2014 at 12:52:11PM -0800, David Rientjes wrote:
> On Thu, 6 Feb 2014, Joonsoo Kim wrote:
> 
> > From bf691e7eb07f966e3aed251eaeb18f229ee32d1f Mon Sep 17 00:00:00 2001
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Date: Thu, 6 Feb 2014 17:07:05 +0900
> > Subject: [RFC PATCH 2/3 v2] topology: support node_numa_mem() for
> > determining the
> >  fallback node
> > 
> > We need to determine the fallback node in slub allocator if the allocation
> > target node is memoryless node. Without it, the SLUB wrongly select
> > the node which has no memory and can't use a partial slab, because of node
> > mismatch. Introduced function, node_numa_mem(X), will return
> > a node Y with memory that has the nearest distance. If X is memoryless
> > node, it will return nearest distance node, but, if
> > X is normal node, it will return itself.
> > 
> > We will use this function in following patch to determine the fallback
> > node.
> > 
> 
> I like the approach and it may fix the problem today, but it may not be 
> sufficient in the future: nodes may not only be memoryless but they may 
> also be cpuless.  It's possible that a node can only have I/O, networking, 
> or storage devices and we can define affinity for them that is remote from 
> every cpu and/or memory by the ACPI specification.
> 
> It seems like a better approach would be to do this when a node is brought 
> online and determine the fallback node based not on the zonelists as you 
> do here but rather on locality (such as through a SLIT if provided, see 
> node_distance()).

Hmm...
I guess that zonelist is base on locality. Zonelist is generated using
node_distance(), so I think that it reflects locality. But, I'm not expert
on NUMA, so please let me know what I am missing here :)

> Also, the names aren't very descriptive: {get,set}_numa_mem() doesn't make 
> a lot of sense in generic code.  I'd suggest something like 
> node_to_mem_node().

It's much better!
If this patch eventually will be needed, I will update it.

Thanks.
