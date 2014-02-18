Return-Path: <cl@linux.com>
Received: from qmta08.emeryville.ca.mail.comcast.net
 (qmta08.emeryville.ca.mail.comcast.net [76.96.30.80])
 by ozlabs.org (Postfix) with ESMTP id E2F922C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 06:58:28 +1100 (EST)
Date: Tue, 18 Feb 2014 13:58:20 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for determining
 the fallback node
In-Reply-To: <20140218172832.GD31998@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1402181356120.2910@nuc>
References: <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
 <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
 <20140207054819.GC28952@lge.com> <alpine.DEB.2.10.1402071150090.15168@nuc>
 <alpine.DEB.2.10.1402071245040.20246@nuc>
 <20140210191321.GD1558@linux.vnet.ibm.com> <20140211074159.GB27870@lge.com>
 <20140213065137.GA10860@linux.vnet.ibm.com> <20140217070051.GE3468@lge.com>
 <alpine.DEB.2.10.1402181051560.1291@nuc>
 <20140218172832.GD31998@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 18 Feb 2014, Nishanth Aravamudan wrote:

>
> Well, on powerpc, with the hypervisor providing the resources and the
> topology, you can have cpuless and memoryless nodes. I'm not sure how
> "fake" the NUMA is -- as I think since the resources are virtualized to
> be one system, it's logically possible that the actual topology of the
> resources can be CPUs from physical node 0 and memory from physical node
> 2. I would think with KVM on a sufficiently large (physically NUMA
> x86_64) and loaded system, one could cause the same sort of
> configuration to occur for a guest?

Ok but since you have a virtualized environment: Why not provide a fake
home node with fake memory that could be anywhere? This would avoid the
whole problem of supporting such a config at the kernel level.

Do not have a fake node that has no memory.

> In any case, these configurations happen fairly often on long-running
> (not rebooted) systems as LPARs are created/destroyed, resources are
> DLPAR'd in and out of LPARs, etc.

Ok then also move the memory of the local node somewhere?

> I might look into it, as it might have sped up testing these changes.

I guess that will be necessary in order to support the memoryless nodes
long term.
