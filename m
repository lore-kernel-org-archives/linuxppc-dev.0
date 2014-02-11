Return-Path: <cl@linux.com>
Received: from qmta13.emeryville.ca.mail.comcast.net
 (qmta13.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:44:76:96:27:243])
 by ozlabs.org (Postfix) with ESMTP id E80FF2C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 05:45:33 +1100 (EST)
Date: Tue, 11 Feb 2014 12:45:28 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for determining
 the fallback node
In-Reply-To: <20140210012918.GD12574@lge.com>
Message-ID: <alpine.DEB.2.10.1402111244381.28186@nuc>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.02.1402060041040.21148@chino.kir.corp.google.com>
 <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
 <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
 <20140207054819.GC28952@lge.com> <alpine.DEB.2.10.1402071150090.15168@nuc>
 <alpine.DEB.2.10.1402071245040.20246@nuc>
 <20140210012918.GD12574@lge.com>
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

On Mon, 10 Feb 2014, Joonsoo Kim wrote:

> On Fri, Feb 07, 2014 at 12:51:07PM -0600, Christoph Lameter wrote:
> > Here is a draft of a patch to make this work with memoryless nodes.
> >
> > The first thing is that we modify node_match to also match if we hit an
> > empty node. In that case we simply take the current slab if its there.
>
> Why not inspecting whether we can get the page on the best node such as
> numa_mem_id() node?

Its expensive to do so.

> empty_node cannot be set on memoryless node, since page allocation would
> succeed on different node.

Ok then we need to add a check for being on the rignt node there too.
