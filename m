Return-Path: <cl@linux.com>
Received: from qmta07.emeryville.ca.mail.comcast.net
 (qmta07.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:43:76:96:30:64])
 by ozlabs.org (Postfix) with ESMTP id 50A882C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 03:03:03 +1100 (EST)
Date: Thu, 20 Feb 2014 10:02:58 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for determining
 the fallback node
In-Reply-To: <alpine.DEB.2.02.1402191404030.31921@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.10.1402201001430.11829@nuc>
References: <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.02.1402060041040.21148@chino.kir.corp.google.com>
 <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
 <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
 <20140207054819.GC28952@lge.com> <alpine.DEB.2.10.1402071150090.15168@nuc>
 <alpine.DEB.2.10.1402071245040.20246@nuc>
 <20140210191321.GD1558@linux.vnet.ibm.com> <20140211074159.GB27870@lge.com>
 <alpine.DEB.2.10.1402121612270.8183@nuc> <20140217065257.GD3468@lge.com>
 <alpine.DEB.2.10.1402181033480.28964@nuc>
 <alpine.DEB.2.02.1402191404030.31921@chino.kir.corp.google.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Matt Mackall <mpm@selenic.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 19 Feb 2014, David Rientjes wrote:

> On Tue, 18 Feb 2014, Christoph Lameter wrote:
>
> > Its an optimization to avoid calling the page allocator to figure out if
> > there is memory available on a particular node.
> Thus this patch breaks with memory hot-add for a memoryless node.

As soon as the per cpu slab is exhausted the node number of the so far
"empty" node will be used for allocation. That will be sucessfull and the
node will no longer be marked as empty.
