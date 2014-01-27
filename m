Return-Path: <cl@linux.com>
Received: from qmta07.emeryville.ca.mail.comcast.net
 (qmta07.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:43:76:96:30:64])
 by ozlabs.org (Postfix) with ESMTP id 23FE92C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 03:24:42 +1100 (EST)
Date: Mon, 27 Jan 2014 10:16:20 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
In-Reply-To: <alpine.DEB.2.02.1401241543100.18620@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.10.1401271014340.2215@nuc>
References: <20140107132100.5b5ad198@kryten> <20140107074136.GA4011@lge.com>
 <52dce7fe.e5e6420a.5ff6.ffff84a0SMTPIN_ADDED_BROKEN@mx.google.com>
 <alpine.DEB.2.10.1401201612340.28048@nuc>
 <52e1d960.2715420a.3569.1013SMTPIN_ADDED_BROKEN@mx.google.com>
 <52e1da8f.86f7440a.120f.25f3SMTPIN_ADDED_BROKEN@mx.google.com>
 <alpine.DEB.2.10.1401240946530.12886@nuc>
 <alpine.DEB.2.02.1401241301120.10968@chino.kir.corp.google.com>
 <20140124232902.GB30361@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1401241543100.18620@chino.kir.corp.google.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, penberg@kernel.org,
 linux-mm@kvack.org, paulus@samba.org, Anton Blanchard <anton@samba.org>,
 mpm@selenic.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 24 Jan 2014, David Rientjes wrote:

> kmalloc_node(nid) and kmem_cache_alloc_node(nid) should fallback to nodes
> other than nid when memory can't be allocated, these functions only
> indicate a preference.

The nid passed indicated a preference unless __GFP_THIS_NODE is specified.
Then the allocation must occur on that node.
