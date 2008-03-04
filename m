Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.171.30])
	by ozlabs.org (Postfix) with ESMTP id 5BFE5DE284
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 06:56:50 +1100 (EST)
Date: Tue, 4 Mar 2008 11:56:42 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [BUG] 2.6.25-rc3-mm1 kernel panic while bootup on powerpc ()
In-Reply-To: <84144f020803041141x5bb55832r495d7fde92356e27@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0803041151360.18160@schroedinger.engr.sgi.com>
References: <20080304011928.e8c82c0c.akpm@linux-foundation.org>
	<47CD4AB3.3080409@linux.vnet.ibm.com>
	<20080304103636.3e7b8fdd.akpm@linux-foundation.org>
	<47CDA081.7070503@cs.helsinki.fi> <20080304193532.GC9051@csn.ul.ie>
	<84144f020803041141x5bb55832r495d7fde92356e27@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mm@kvack.org, Mel Gorman <mel@csn.ul.ie>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 4 Mar 2008, Pekka Enberg wrote:

> >  > I suspect the WARN_ON() is bogus although I really don't know that part
> >  > of the code all too well. Mel?
> >  >
> >
> >  The warn-on is valid. A situation should not exist that allows both flags to
> >  be set. I suspect  if remove-set_migrateflags.patch was reverted from -mm
> >  the warning would not trigger. Christoph, would it be reasonable to always
> >  clear __GFP_MOVABLE when __GFP_RECLAIMABLE is set for SLAB_RECLAIM_ACCOUNT.

Slab allocations should never be passed these flags since the slabs do 
their own thing there.

The following patch would clear these in slub:

---
 mm/slub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.25-rc3-mm1/mm/slub.c
===================================================================
--- linux-2.6.25-rc3-mm1.orig/mm/slub.c	2008-03-04 11:53:47.600342756 -0800
+++ linux-2.6.25-rc3-mm1/mm/slub.c	2008-03-04 11:55:40.153855150 -0800
@@ -1033,8 +1033,8 @@ static struct page *allocate_slab(struct
 	struct page *page;
 	int pages = 1 << s->order;
 
+	flags &= ~GFP_MOVABLE_MASK;
 	flags |= s->allocflags;
-
 	page = alloc_slab_page(flags | __GFP_NOWARN | __GFP_NORETRY,
 								node, s->order);
 	if (unlikely(!page)) {
