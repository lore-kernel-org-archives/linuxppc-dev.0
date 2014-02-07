Return-Path: <cl@linux.com>
Received: from qmta09.emeryville.ca.mail.comcast.net
 (qmta09.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:43:76:96:30:96])
 by ozlabs.org (Postfix) with ESMTP id 7A52C2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 04:54:01 +1100 (EST)
Date: Fri, 7 Feb 2014 11:53:57 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for determining
 the fallback node
In-Reply-To: <20140207054819.GC28952@lge.com>
Message-ID: <alpine.DEB.2.10.1402071150090.15168@nuc>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.02.1402060041040.21148@chino.kir.corp.google.com>
 <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
 <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
 <20140207054819.GC28952@lge.com>
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

On Fri, 7 Feb 2014, Joonsoo Kim wrote:

> >
> > It seems like a better approach would be to do this when a node is brought
> > online and determine the fallback node based not on the zonelists as you
> > do here but rather on locality (such as through a SLIT if provided, see
> > node_distance()).
>
> Hmm...
> I guess that zonelist is base on locality. Zonelist is generated using
> node_distance(), so I think that it reflects locality. But, I'm not expert
> on NUMA, so please let me know what I am missing here :)

The next node can be found by going through the zonelist of a node and
checking for available memory. See fallback_alloc().

There is a function node_distance() that determines the relative
performance of a memory access from one to the other node.
The building of the fallback list for every node in build_zonelists()
relies on that.
