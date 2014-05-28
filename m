Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by lists.ozlabs.org (Postfix) with ESMTP id 9D6631A024F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 09:36:10 +1000 (EST)
Date: Wed, 28 May 2014 16:36:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 1/2] powerpc: numa: enable USE_PERCPU_NUMA_NODE_ID
Message-Id: <20140528163607.e1f0ced83a5b736cca7fa530@linux-foundation.org>
In-Reply-To: <20140528000958.GF4104@linux.vnet.ibm.com>
References: <20140516233945.GI8941@linux.vnet.ibm.com>
 <20140519181423.GL8941@linux.vnet.ibm.com>
 <20140527234420.GE4104@linux.vnet.ibm.com>
 <1401234974.8262.8.camel@pasglop>
 <20140528000958.GF4104@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Lee Schermerhorn <lee.schermerhorn@hp.com>,
 Christoph Lameter <cl@linux-foundation.org>, Mel Gorman <mel@csn.ul.ie>,
 linux-mm@kvack.org, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 27 May 2014 17:09:58 -0700 Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote:

> On 28.05.2014 [09:56:14 +1000], Benjamin Herrenschmidt wrote:
> > On Tue, 2014-05-27 at 16:44 -0700, Nishanth Aravamudan wrote:
> > > > Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> > > 
> > > Ping on this and patch 2/2. Ben, would you be willing to pull these
> > > into
> > > your -next branch so they'd get some testing?
> > > 
> > > http://patchwork.ozlabs.org/patch/350368/
> > > http://patchwork.ozlabs.org/patch/349838/
> > > 
> > > Without any further changes, these two help quite a bit with the slab
> > > consumption on CONFIG_SLUB kernels when memoryless nodes are present.
> > 
> > I don't mind at all :-) I haven't really been following that story
> > so I was waiting for the dust to settle and maybe acks from MM people
> > but if you tell me they are good I'm prepared to trust you.
> 
> The patches themselves are pretty minimal and similar to the ia64
> changes (and the affected code seems like it hasn't changed in some
> time, beyond in the common code). I'd mostly like to get some
> broad-range build & boot testing.
> 
> Also, is NUMA a sufficient symbol to depend, you think? I figure most of
> the PPC NUMA systems are the pSeries/IBM variety, which is where I've
> run into memoryless nodes in the first place.

It's a powerpc-only patchset so I didn't do anything.

Nits:

- When referring to git commits, use 12 digits of hash and include
  the name of the patch as well (because patches can have different
  hashes in different trees).  So

       Based on 3bccd996276b ("numa: ia64: use generic percpu
       var numa_node_id() implementation") for ia64.

- It's nice to include a diffstat.  If there's a [0/n] patch then
  that's a great place for it, so people can see the overall impact at
  a glance.
