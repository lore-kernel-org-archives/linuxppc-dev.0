Return-Path: <cl@linux.com>
Received: from qmta14.emeryville.ca.mail.comcast.net
 (qmta14.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:44:76:96:27:212])
 by ozlabs.org (Postfix) with ESMTP id 1E3BF2C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 07:02:54 +1100 (EST)
Date: Mon, 24 Feb 2014 13:54:35 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for determining
 the fallback node
In-Reply-To: <20140224050851.GB14814@lge.com>
Message-ID: <alpine.DEB.2.10.1402241353070.20839@nuc>
References: <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
 <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
 <20140207054819.GC28952@lge.com> <alpine.DEB.2.10.1402071150090.15168@nuc>
 <alpine.DEB.2.10.1402071245040.20246@nuc>
 <20140210191321.GD1558@linux.vnet.ibm.com> <20140211074159.GB27870@lge.com>
 <alpine.DEB.2.10.1402121612270.8183@nuc> <20140217065257.GD3468@lge.com>
 <alpine.DEB.2.10.1402181033480.28964@nuc> <20140224050851.GB14814@lge.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, linuxppc-dev@lists.ozlabs.org,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 24 Feb 2014, Joonsoo Kim wrote:

> > It will not common get there because of the tracking. Instead a per cpu
> > object will be used.
> > > get_partial_node() always fails even if there are some partial slab on
> > > memoryless node's neareast node.
> >
> > Correct and that leads to a page allocator action whereupon the node will
> > be marked as empty.
>
> Why do we need to request to a page allocator if there is partial slab?
> Checking whether node is memoryless or not is really easy, so we don't need
> to skip this. To skip this is suboptimal solution.

The page allocator action is also used to determine to which other node we
should fall back if the node is empty. So we need to call the page
allocator when the per cpu slab is exhaused with the node of the
memoryless node to get memory from the proper fallback node.
