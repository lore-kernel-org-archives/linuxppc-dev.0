Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4756E2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 13:09:21 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 5 Feb 2014 19:09:18 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id DB4333E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 19:09:16 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1629Bux786906
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Feb 2014 03:09:16 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1628tSk029136
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Feb 2014 19:08:56 -0700
Date: Wed, 5 Feb 2014 18:08:33 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
Message-ID: <20140206020833.GD5433@linux.vnet.ibm.com>
References: <alpine.DEB.2.02.1401241618500.20466@chino.kir.corp.google.com>
 <20140125011041.GB25344@linux.vnet.ibm.com>
 <20140127055805.GA2471@lge.com>
 <20140128182947.GA1591@linux.vnet.ibm.com>
 <20140203230026.GA15383@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402032138070.17997@nuc>
 <20140204072630.GB10101@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402041436150.11222@nuc>
 <20140205001352.GC10101@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402051312430.21661@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1402051312430.21661@nuc>
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

On 05.02.2014 [13:28:03 -0600], Christoph Lameter wrote:
> On Tue, 4 Feb 2014, Nishanth Aravamudan wrote:
> 
> > > If the target node allocation fails (for whatever reason) then I would
> > > recommend for simplicities sake to change the target node to
> > > NUMA_NO_NODE and just take whatever is in the current cpu slab. A more
> > > complex solution would be to look through partial lists in increasing
> > > distance to find a partially used slab that is reasonable close to the
> > > current node. Slab has logic like that in fallback_alloc(). Slubs
> > > get_any_partial() function does something close to what you want.
> >
> > I apologize for my own ignorance, but I'm having trouble following.
> > Anton's original patch did fallback to the current cpu slab, but I'm not
> > sure any NUMA_NO_NODE change is necessary there. At the point we're
> > deactivating the slab (in the current code, in __slab_alloc()), we have
> > successfully allocated from somewhere, it's just not on the node we
> > expected to be on.
> 
> Right so if we are ignoring the node then the simplest thing to do is to
> not deactivate the current cpu slab but to take an object from it.

Ok, that's what Anton's patch does, I believe. Are you ok with that
patch as it is?

> > So perhaps you are saying to make a change lower in the code? I'm not
> > sure where it makes sense to change the target node in that case. I'd
> > appreciate any guidance you can give.
> 
> This not an easy thing to do. If the current slab is not the right node
> but would be the node from which the page allocator would be returning
> memory then the current slab can still be allocated from. If the fallback
> is to another node then the current cpu slab needs to be deactivated and
> the allocation from that node needs to proceeed. Have a look at
> fallback_alloc() in the slab allocator.
> 
> A allocation attempt from the page allocator can be restricted to a
> specific node through GFP_THIS_NODE.

Thanks for the pointers, I will try and take a look.

Thanks,
Nish
