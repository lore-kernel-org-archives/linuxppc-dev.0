Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3B8C1A024F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 09:43:23 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 28 May 2014 19:43:21 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CAFAA6E8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 19:43:09 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4SNhHX065142860
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 23:43:17 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4SNhGwD012227
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 19:43:17 -0400
Date: Wed, 28 May 2014 16:43:12 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v2 1/2] powerpc: numa: enable USE_PERCPU_NUMA_NODE_ID
Message-ID: <20140528234312.GA9251@linux.vnet.ibm.com>
References: <20140516233945.GI8941@linux.vnet.ibm.com>
 <20140519181423.GL8941@linux.vnet.ibm.com>
 <20140527234420.GE4104@linux.vnet.ibm.com>
 <1401234974.8262.8.camel@pasglop>
 <20140528000958.GF4104@linux.vnet.ibm.com>
 <20140528163607.e1f0ced83a5b736cca7fa530@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140528163607.e1f0ced83a5b736cca7fa530@linux-foundation.org>
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

On 28.05.2014 [16:36:07 -0700], Andrew Morton wrote:
> On Tue, 27 May 2014 17:09:58 -0700 Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote:
> 
> > On 28.05.2014 [09:56:14 +1000], Benjamin Herrenschmidt wrote:
> > > On Tue, 2014-05-27 at 16:44 -0700, Nishanth Aravamudan wrote:
> > > > > Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> > > > 
> > > > Ping on this and patch 2/2. Ben, would you be willing to pull these
> > > > into
> > > > your -next branch so they'd get some testing?
> > > > 
> > > > http://patchwork.ozlabs.org/patch/350368/
> > > > http://patchwork.ozlabs.org/patch/349838/
> > > > 
> > > > Without any further changes, these two help quite a bit with the slab
> > > > consumption on CONFIG_SLUB kernels when memoryless nodes are present.
> > > 
> > > I don't mind at all :-) I haven't really been following that story
> > > so I was waiting for the dust to settle and maybe acks from MM people
> > > but if you tell me they are good I'm prepared to trust you.
> > 
> > The patches themselves are pretty minimal and similar to the ia64
> > changes (and the affected code seems like it hasn't changed in some
> > time, beyond in the common code). I'd mostly like to get some
> > broad-range build & boot testing.
> > 
> > Also, is NUMA a sufficient symbol to depend, you think? I figure most of
> > the PPC NUMA systems are the pSeries/IBM variety, which is where I've
> > run into memoryless nodes in the first place.
> 
> It's a powerpc-only patchset so I didn't do anything.
> 
> Nits:
> 
> - When referring to git commits, use 12 digits of hash and include
>   the name of the patch as well (because patches can have different
>   hashes in different trees).  So
> 
>        Based on 3bccd996276b ("numa: ia64: use generic percpu
>        var numa_node_id() implementation") for ia64.
> 
> - It's nice to include a diffstat.  If there's a [0/n] patch then
>   that's a great place for it, so people can see the overall impact at
>   a glance.

Thanks for the notes, I'll include those in any updated patches.

-Nish
