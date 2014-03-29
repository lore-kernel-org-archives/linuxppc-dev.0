Return-Path: <cl@linux.com>
Received: from qmta02.emeryville.ca.mail.comcast.net
 (qmta02.emeryville.ca.mail.comcast.net [76.96.30.24])
 by ozlabs.org (Postfix) with ESMTP id 19E641400AB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Mar 2014 16:40:47 +1100 (EST)
Date: Sat, 29 Mar 2014 00:40:41 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: Bug in reclaim logic with exhausted nodes?
In-Reply-To: <20140327203354.GA16651@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1403290038200.24286@nuc>
References: <20140311210614.GB946@linux.vnet.ibm.com>
 <20140313170127.GE22247@linux.vnet.ibm.com>
 <20140324230550.GB18778@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251116490.16557@nuc>
 <20140325162303.GA29977@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251152250.16870@nuc>
 <20140325181010.GB29977@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251323030.26744@nuc>
 <20140327203354.GA16651@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mm@kvack.org, mgorman@suse.de, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, rientjes@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 27 Mar 2014, Nishanth Aravamudan wrote:

> > That looks to be the correct way to handle things. Maybe mark the node as
> > offline or somehow not present so that the kernel ignores it.
>
> This is a SLUB condition:
>
> mm/slub.c::early_kmem_cache_node_alloc():
> ...
>         page = new_slab(kmem_cache_node, GFP_NOWAIT, node);
> ...

So the page allocation from the node failed. We have a strange boot
condition where the OS is aware of anode but allocations on that node
fail.

 >         if (page_to_nid(page) != node) {
>                 printk(KERN_ERR "SLUB: Unable to allocate memory from "
>                                 "node %d\n", node);
>                 printk(KERN_ERR "SLUB: Allocating a useless per node structure "
>                                 "in order to be able to continue\n");
>         }
> ...
>
> Since this is quite early, and we have not set up the nodemasks yet,
> does it make sense to perhaps have a temporary init-time nodemask that
> we set bits in here, and "fix-up" those nodes when we setup the
> nodemasks?

Please take care of this earlier than this. The page allocator in general
should allow allocations from all nodes with memory during boot,
