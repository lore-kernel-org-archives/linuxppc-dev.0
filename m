Return-Path: <iamjoonsoo.kim@lge.com>
Received: from LGEAMRELO01.lge.com (lgeamrelo01.lge.com [156.147.1.125])
 by ozlabs.org (Postfix) with ESMTP id 6AB302C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 12:22:09 +1100 (EST)
Date: Mon, 10 Feb 2014 10:22:03 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [RFC PATCH 3/3] slub: fallback to get_numa_mem() node if we want
 to allocate on memoryless node
Message-ID: <20140210012203.GC12574@lge.com>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1391674026-20092-3-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.10.1402061127001.5348@nuc>
 <20140207054119.GA28952@lge.com>
 <alpine.DEB.2.10.1402071147390.15168@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1402071147390.15168@nuc>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, mpm@selenic.com,
 penberg@kernel.org, linux-mm@kvack.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, David Rientjes <rientjes@google.com>,
 linuxppc-dev@lists.ozlabs.org, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 07, 2014 at 11:49:57AM -0600, Christoph Lameter wrote:
> On Fri, 7 Feb 2014, Joonsoo Kim wrote:
> 
> > > This check wouild need to be something that checks for other contigencies
> > > in the page allocator as well. A simple solution would be to actually run
> > > a GFP_THIS_NODE alloc to see if you can grab a page from the proper node.
> > > If that fails then fallback. See how fallback_alloc() does it in slab.
> > >
> >
> > Hello, Christoph.
> >
> > This !node_present_pages() ensure that allocation on this node cannot succeed.
> > So we can directly use numa_mem_id() here.
> 
> Yes of course we can use numa_mem_id().
> 
> But the check is only for not having any memory at all on a node. There
> are other reason for allocations to fail on a certain node. The node could
> have memory that cannot be reclaimed, all dirty, beyond certain
> thresholds, not in the current set of allowed nodes etc etc.

Yes. There are many other cases, but I prefer that we think them separately.
Maybe they needs another approach. For now, to solve memoryless node problem,
my solution is enough and safe.

Thanks.
