Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C9D8A67BB4
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Oct 2006 03:10:28 +1000 (EST)
Date: Fri, 20 Oct 2006 10:09:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
Message-Id: <20061020100904.ed1fa0af.akpm@osdl.org>
In-Reply-To: <4538F2A2.5040305@shadowen.org>
References: <1161026409.31903.15.camel@farscape>
	<Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	<1161031821.31903.28.camel@farscape>
	<Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	<17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	<17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	<17719.1849.245776.4501@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
	<20061019163044.GB5819@krispykreme>
	<Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
	<17719.64246.555371.701194@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610191527040.10880@schroedinger.engr.sgi.com>
	<17720.30804.180390.197567@cargo.ozlabs.ibm.com>
	<4538DACC.5050605@shadowen.org> <4538F2A2.5040305@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Oct 2006 17:00:34 +0100
Andy Whitcroft <apw@shadowen.org> wrote:

> > I'll follow up to this email with the reversion patch we used in
> > testing.  It seems to sort this problem out at least, though now its
> > blam'ing in ibmveth, so am retesting with yet another patch.  This patch
> > reverts the two patches above and updates the commentry on the Kconfig
> > entry.
> 
> Ok, I've just gotten a successful boot on this box for the first time in
> like 15 git releases.  I needed the three patches below:
> 
> clameter-fallback_alloc_fix2 -- from earlier in this thread, under the
> message ID below:
>     <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>

That's this:

Here is another fall back fix checking if the slab has already been setup 
for this node. MPOL_INTERLEAVE could redirect the allocation.

Index: linux-2.6.19-rc1-mm1/mm/slab.c
===================================================================
--- linux-2.6.19-rc1-mm1.orig/mm/slab.c	2006-10-10 21:47:12.949563383 -0500
+++ linux-2.6.19-rc1-mm1/mm/slab.c	2006-10-13 17:21:31.937863714 -0500
@@ -3158,12 +3158,15 @@ void *fallback_alloc(struct kmem_cache *
 	struct zone **z;
 	void *obj = NULL;
 
-	for (z = zonelist->zones; *z && !obj; z++)
+	for (z = zonelist->zones; *z && !obj; z++) {
+		int nid = zone_to_nid(*z);
+
 		if (zone_idx(*z) <= ZONE_NORMAL &&
-				cpuset_zone_allowed(*z, flags))
+				cpuset_zone_allowed(*z, flags) &&
+				cache->nodelists[nid])
 			obj = __cache_alloc_node(cache,
-					flags | __GFP_THISNODE,
-					zone_to_nid(*z));
+					flags | __GFP_THISNODE, nid);
+	}
 	return obj;
 }
 

Christoph, can you please finalise and resend that?

> Reintroduce-NODES_SPAN_OTHER_NODES-for-powerpc -- the patch I just
> submitted, under the message ID below:
>     <8a76dfd735e544016c5f04c98617b87d@pinky>

OK, I got that.

> ibmveth-fix-index-increment-calculation -- this patch is already in -mm.

Normally a Jeff thing, but small-and-simple.  I'll send that in to Linus
today.
