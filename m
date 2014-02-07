Return-Path: <cl@linux.com>
Received: from qmta01.emeryville.ca.mail.comcast.net
 (qmta01.emeryville.ca.mail.comcast.net [76.96.30.16])
 by ozlabs.org (Postfix) with ESMTP id F23C42C0096
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 04:50:04 +1100 (EST)
Date: Fri, 7 Feb 2014 11:49:57 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC PATCH 3/3] slub: fallback to get_numa_mem() node if we want
 to allocate on memoryless node
In-Reply-To: <20140207054119.GA28952@lge.com>
Message-ID: <alpine.DEB.2.10.1402071147390.15168@nuc>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1391674026-20092-3-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.10.1402061127001.5348@nuc> <20140207054119.GA28952@lge.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 7 Feb 2014, Joonsoo Kim wrote:

> > This check wouild need to be something that checks for other contigencies
> > in the page allocator as well. A simple solution would be to actually run
> > a GFP_THIS_NODE alloc to see if you can grab a page from the proper node.
> > If that fails then fallback. See how fallback_alloc() does it in slab.
> >
>
> Hello, Christoph.
>
> This !node_present_pages() ensure that allocation on this node cannot succeed.
> So we can directly use numa_mem_id() here.

Yes of course we can use numa_mem_id().

But the check is only for not having any memory at all on a node. There
are other reason for allocations to fail on a certain node. The node could
have memory that cannot be reclaimed, all dirty, beyond certain
thresholds, not in the current set of allowed nodes etc etc.
