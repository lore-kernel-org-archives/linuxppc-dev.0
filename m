Return-Path: <cl@linux.com>
Received: from qmta13.westchester.pa.mail.comcast.net
 (qmta13.westchester.pa.mail.comcast.net [IPv6:2001:558:fe14:44:76:96:59:243])
 by ozlabs.org (Postfix) with ESMTP id 7EA212C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 06:36:27 +1100 (EST)
Date: Wed, 5 Feb 2014 13:28:03 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
In-Reply-To: <20140205001352.GC10101@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1402051312430.21661@nuc>
References: <alpine.DEB.2.02.1401241543100.18620@chino.kir.corp.google.com>
 <20140125001643.GA25344@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1401241618500.20466@chino.kir.corp.google.com>
 <20140125011041.GB25344@linux.vnet.ibm.com> <20140127055805.GA2471@lge.com>
 <20140128182947.GA1591@linux.vnet.ibm.com>
 <20140203230026.GA15383@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402032138070.17997@nuc>
 <20140204072630.GB10101@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402041436150.11222@nuc>
 <20140205001352.GC10101@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 David Rientjes <rientjes@google.com>, penberg@kernel.org, linux-mm@kvack.org,
 paulus@samba.org, Anton Blanchard <anton@samba.org>, mpm@selenic.com,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 4 Feb 2014, Nishanth Aravamudan wrote:

> > If the target node allocation fails (for whatever reason) then I would
> > recommend for simplicities sake to change the target node to
> > NUMA_NO_NODE and just take whatever is in the current cpu slab. A more
> > complex solution would be to look through partial lists in increasing
> > distance to find a partially used slab that is reasonable close to the
> > current node. Slab has logic like that in fallback_alloc(). Slubs
> > get_any_partial() function does something close to what you want.
>
> I apologize for my own ignorance, but I'm having trouble following.
> Anton's original patch did fallback to the current cpu slab, but I'm not
> sure any NUMA_NO_NODE change is necessary there. At the point we're
> deactivating the slab (in the current code, in __slab_alloc()), we have
> successfully allocated from somewhere, it's just not on the node we
> expected to be on.

Right so if we are ignoring the node then the simplest thing to do is to
not deactivate the current cpu slab but to take an object from it.

> So perhaps you are saying to make a change lower in the code? I'm not
> sure where it makes sense to change the target node in that case. I'd
> appreciate any guidance you can give.

This not an easy thing to do. If the current slab is not the right node
but would be the node from which the page allocator would be returning
memory then the current slab can still be allocated from. If the fallback
is to another node then the current cpu slab needs to be deactivated and
the allocation from that node needs to proceeed. Have a look at
fallback_alloc() in the slab allocator.

A allocation attempt from the page allocator can be restricted to a
specific node through GFP_THIS_NODE.
