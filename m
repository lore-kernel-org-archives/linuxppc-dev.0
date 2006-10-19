Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx1.americas.sgi.com (omx1-ext.sgi.com [192.48.179.11])
	by ozlabs.org (Postfix) with ESMTP id 0D1FA67BD9
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 02:16:37 +1000 (EST)
Date: Thu, 19 Oct 2006 09:16:29 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <17719.1849.245776.4501@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	<Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	<1160769226.11239.22.camel@farscape>
	<1160773040.11239.28.camel@farscape>
	<Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
	<1161026409.31903.15.camel@farscape>
	<Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	<1161031821.31903.28.camel@farscape>
	<Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	<17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	<17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	<17719.1849.245776.4501@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 19 Oct 2006, Paul Mackerras wrote:

> Get cache descritor

Attempt to allocate the first descriptor for the first cache.

> __cache_alloc

Attempt to allocate from the caches of node 0 (which are empty on 
bootstrap). We try to replenish the caches of node 0 which should have 
succeeded. I guess that this failed due to no pages available on 
node 0. This should not happen!

It worked before 2.6.19 because the slab allocator allowed the page 
allocator to fallback to node 1. However, we then put pages from node 1 
on the per node lists for node 0. This was fixed in 2.6.19 using 
GFP_THISNODE.

> __cache_alloc_node 0

No we go to __cache_alloc_node because it knows how to get memory from 
differnet nodes (we should not get here at all there should be memory on 
node 0!)

> fallback_alloc

We failed another attempt to get memory from node 0. Now we are going down 
the zonelist.

> __cache_alloc_node 0

First attempt on node 0 (the head of the fallback list) which again has no 
pages available.

> __cache_alloc_node 1

Attempt to allocate from node 1 (second zone on the fallback list)

> kernel BUG in __cache_alloc_node at /home/paulus/kernel/powerpc/mm/slab.c:3185!

Node 1 has not been setup yet since we have not completed bootstrap so we 
BUG out.

Would you please make memory available on the node that you bootstrap 
the slab allocator on? numa_node_id() must point to a node that has memory 
available.
