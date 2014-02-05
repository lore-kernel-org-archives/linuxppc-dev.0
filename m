Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1679B2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 11:14:15 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 4 Feb 2014 17:14:10 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 3B1D26E803C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 19:14:03 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s150E7dg6291782
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Feb 2014 00:14:07 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s150E5aA030508
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 19:14:07 -0500
Date: Tue, 4 Feb 2014 16:13:52 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
Message-ID: <20140205001352.GC10101@linux.vnet.ibm.com>
References: <alpine.DEB.2.02.1401241543100.18620@chino.kir.corp.google.com>
 <20140125001643.GA25344@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1401241618500.20466@chino.kir.corp.google.com>
 <20140125011041.GB25344@linux.vnet.ibm.com>
 <20140127055805.GA2471@lge.com>
 <20140128182947.GA1591@linux.vnet.ibm.com>
 <20140203230026.GA15383@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402032138070.17997@nuc>
 <20140204072630.GB10101@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402041436150.11222@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1402041436150.11222@nuc>
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

On 04.02.2014 [14:39:32 -0600], Christoph Lameter wrote:
> On Mon, 3 Feb 2014, Nishanth Aravamudan wrote:
> 
> > Yes, sorry for my lack of clarity. I meant Joonsoo's latest patch for
> > the $SUBJECT issue.
> 
> Hmmm... I am not sure that this is a general solution. The fallback to
> other nodes can not only occur because a node has no memory as his patch
> assumes.

Thanks, Christoph. I see your point.

Something in this area would be nice, though, as it does produce a
fairly significant bump in the slab usage on our test system.

> If the target node allocation fails (for whatever reason) then I would
> recommend for simplicities sake to change the target node to
> NUMA_NO_NODE and just take whatever is in the current cpu slab. A more
> complex solution would be to look through partial lists in increasing
> distance to find a partially used slab that is reasonable close to the
> current node. Slab has logic like that in fallback_alloc(). Slubs
> get_any_partial() function does something close to what you want.

I apologize for my own ignorance, but I'm having trouble following.
Anton's original patch did fallback to the current cpu slab, but I'm not
sure any NUMA_NO_NODE change is necessary there. At the point we're
deactivating the slab (in the current code, in __slab_alloc()), we have
successfully allocated from somewhere, it's just not on the node we
expected to be on.

So perhaps you are saying to make a change lower in the code? I'm not
sure where it makes sense to change the target node in that case. I'd
appreciate any guidance you can give.

Thanks,
Nish
