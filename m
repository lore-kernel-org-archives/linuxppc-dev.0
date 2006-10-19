Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id 0062D67B61
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 07:39:12 +1000 (EST)
Date: Thu, 19 Oct 2006 14:39:05 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <1161290229.8946.51.camel@farscape>
Message-ID: <Pine.LNX.4.64.0610191432540.10401@schroedinger.engr.sgi.com>
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
	<Pine.LNX.4.64.0610190959560.8433@schroedinger.engr.sgi.com>
	<1161290229.8946.51.camel@farscape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 19 Oct 2006, Will Schmidt wrote:

> This didnt fix the problem on my box.  I tried this both against mm and
> linux-2.6.git 

GFP_THISNODE is also set at a higher level for fallback but it should not 
be set for the initial allocation. If you try this with the debug printks
then please use this patch to make sure that all allocs fall back,

Index: linux-2.6.19-rc2-mm1/mm/slab.c
===================================================================
--- linux-2.6.19-rc2-mm1.orig/mm/slab.c	2006-10-19 11:54:24.000000000 -0500
+++ linux-2.6.19-rc2-mm1/mm/slab.c	2006-10-19 16:32:09.454825851 -0500
@@ -1589,7 +1589,10 @@ static void *kmem_getpages(struct kmem_c
 	 * the needed fallback ourselves since we want to serve from our
 	 * per node object lists first for other nodes.
 	 */
-	flags |= cachep->gfpflags | GFP_THISNODE;
+	if (g_cpucache_up != FULL)
+		flags |= cachep->gfpflags & ~__GFP_THISNODE;
+	else
+		flags |= cachep->gfpflags | GFP_THISNODE;
 
 	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
 	if (!page)
