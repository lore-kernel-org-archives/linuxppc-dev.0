Return-Path: <rientjes@google.com>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 818502C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 20:57:44 +1100 (EST)
Received: by mail-pd0-f169.google.com with SMTP id v10so4147609pde.14
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Feb 2014 01:57:41 -0800 (PST)
Date: Sat, 8 Feb 2014 01:57:39 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for determining
 the fallback node
In-Reply-To: <20140207054819.GC28952@lge.com>
Message-ID: <alpine.DEB.2.02.1402080154140.9668@chino.kir.corp.google.com>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.02.1402060041040.21148@chino.kir.corp.google.com>
 <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
 <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
 <20140207054819.GC28952@lge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 7 Feb 2014, Joonsoo Kim wrote:

> > It seems like a better approach would be to do this when a node is brought 
> > online and determine the fallback node based not on the zonelists as you 
> > do here but rather on locality (such as through a SLIT if provided, see 
> > node_distance()).
> 
> Hmm...
> I guess that zonelist is base on locality. Zonelist is generated using
> node_distance(), so I think that it reflects locality. But, I'm not expert
> on NUMA, so please let me know what I am missing here :)
> 

The zonelist is, yes, but I'm talking about memoryless and cpuless nodes.  
If your solution is going to become the generic kernel API that determines 
what node has local memory for a particular node, then it will have to 
support all definitions of node.  That includes nodes that consist solely 
of I/O, chipsets, networking, or storage devices.  These nodes may not 
have memory or cpus, so doing it as part of onlining cpus isn't going to 
be generic enough.  You want a node_to_mem_node() API for all possible 
node types (the possible node types listed above are straight from the 
ACPI spec).  For 99% of people, node_to_mem_node(X) is always going to be 
X and we can optimize for that, but any solution that relies on cpu online 
is probably shortsighted right now.

I think it would be much better to do this as a part of setting a node to 
be online.
