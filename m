Return-Path: <rientjes@google.com>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3C37E2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 07:52:16 +1100 (EST)
Received: by mail-pa0-f54.google.com with SMTP id fa1so2198623pad.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Feb 2014 12:52:13 -0800 (PST)
Date: Thu, 6 Feb 2014 12:52:11 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Joonsoo Kim <js1304@gmail.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for determining
 the fallback node
In-Reply-To: <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.02.1402060041040.21148@chino.kir.corp.google.com>
 <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Matt Mackall <mpm@selenic.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Christoph Lameter <cl@linux.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 6 Feb 2014, Joonsoo Kim wrote:

> From bf691e7eb07f966e3aed251eaeb18f229ee32d1f Mon Sep 17 00:00:00 2001
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Date: Thu, 6 Feb 2014 17:07:05 +0900
> Subject: [RFC PATCH 2/3 v2] topology: support node_numa_mem() for
> determining the
>  fallback node
> 
> We need to determine the fallback node in slub allocator if the allocation
> target node is memoryless node. Without it, the SLUB wrongly select
> the node which has no memory and can't use a partial slab, because of node
> mismatch. Introduced function, node_numa_mem(X), will return
> a node Y with memory that has the nearest distance. If X is memoryless
> node, it will return nearest distance node, but, if
> X is normal node, it will return itself.
> 
> We will use this function in following patch to determine the fallback
> node.
> 

I like the approach and it may fix the problem today, but it may not be 
sufficient in the future: nodes may not only be memoryless but they may 
also be cpuless.  It's possible that a node can only have I/O, networking, 
or storage devices and we can define affinity for them that is remote from 
every cpu and/or memory by the ACPI specification.

It seems like a better approach would be to do this when a node is brought 
online and determine the fallback node based not on the zonelists as you 
do here but rather on locality (such as through a SLIT if provided, see 
node_distance()).

Also, the names aren't very descriptive: {get,set}_numa_mem() doesn't make 
a lot of sense in generic code.  I'd suggest something like 
node_to_mem_node().
