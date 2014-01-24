Return-Path: <cl@linux.com>
Received: from qmta09.emeryville.ca.mail.comcast.net
 (qmta09.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:43:76:96:30:96])
 by ozlabs.org (Postfix) with ESMTP id 110E32C0086
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jan 2014 02:58:37 +1100 (EST)
Date: Fri, 24 Jan 2014 09:50:17 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Wanpeng Li <liwanp@linux.vnet.ibm.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
In-Reply-To: <52e1da8f.86f7440a.120f.25f3SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <alpine.DEB.2.10.1401240946530.12886@nuc>
References: <20140107132100.5b5ad198@kryten> <20140107074136.GA4011@lge.com>
 <52dce7fe.e5e6420a.5ff6.ffff84a0SMTPIN_ADDED_BROKEN@mx.google.com>
 <alpine.DEB.2.10.1401201612340.28048@nuc>
 <52e1d960.2715420a.3569.1013SMTPIN_ADDED_BROKEN@mx.google.com>
 <52e1da8f.86f7440a.120f.25f3SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: nacc@linux.vnet.ibm.com, David Rientjes <rientjes@google.com>,
 penberg@kernel.org, linux-mm@kvack.org,
 Han Pingtian <hanpt@linux.vnet.ibm.com>, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, mpm@selenic.com,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 24 Jan 2014, Wanpeng Li wrote:

> >
> >diff --git a/mm/slub.c b/mm/slub.c
> >index 545a170..a1c6040 100644
> >--- a/mm/slub.c
> >+++ b/mm/slub.c
> >@@ -1700,6 +1700,9 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
> > 	void *object;
> >	int searchnode = (node == NUMA_NO_NODE) ? numa_node_id() : node;

This needs to be numa_mem_id() and numa_mem_id would need to be
consistently used.

> >
> >+	if (!node_present_pages(searchnode))
> >+		searchnode = numa_mem_id();

Probably wont need that?

> >+
> >	object = get_partial_node(s, get_node(s, searchnode), c, flags);
> >	if (object || node != NUMA_NO_NODE)
> >		return object;
> >
>
> The bug still can't be fixed w/ this patch.

Some more detail would be good. If memory is requested from a particular
node then it would be best to use one that has memory. Callers also may
have used numa_node_id() and that also would need to be fixed.
