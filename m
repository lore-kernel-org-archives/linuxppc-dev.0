Return-Path: <penberg@cs.helsinki.fi>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0C1BDB70B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 18:06:08 +1000 (EST)
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99939DDD1B
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 18:06:06 +1000 (EST)
Date: Sun, 7 Jun 2009 11:06:00 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [Powerpc/SLQB] Next June 06 : BUG during scsi initialization
In-Reply-To: <4A2909E8.6000507@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0906071105030.11309@melkki.cs.Helsinki.FI>
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com> <4A2909E8.6000507@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Piggin <npiggin@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sachin,

On Fri, 5 Jun 2009, Sachin Sant wrote:
> I can still recreate this bug on a Power 6 hardware with today's next tree.
> I can recreate this problem at will.
> Let me know if i can help in debugging this problem.

Can you please reproduce the issue with this debugging patch applied and 
post the result?

			Pekka

>From 27189e1e1d2890e98cb029bd1121c86b8c53ecd9 Mon Sep 17 00:00:00 2001
From: Pekka Enberg <penberg@cs.helsinki.fi>
Date: Sun, 7 Jun 2009 11:03:50 +0300
Subject: [PATCH] slqb: debugging

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---
 mm/slqb.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/mm/slqb.c b/mm/slqb.c
index 29bb005..dce39d4 100644
--- a/mm/slqb.c
+++ b/mm/slqb.c
@@ -1382,6 +1382,8 @@ static noinline void *__slab_alloc_page(struct kmem_cache *s,
 		l = &c->list;
 		page->list = l;
 
+		printk(KERN_INFO "%s: cpu=%d, cache_cpu=%p, cache_list=%p\n", __func__, cpu, c, l);
+
 		spin_lock(&l->page_lock);
 		l->nr_slabs++;
 		l->nr_partial++;
@@ -1393,11 +1395,15 @@ static noinline void *__slab_alloc_page(struct kmem_cache *s,
 	} else {
 #ifdef CONFIG_NUMA
 		struct kmem_cache_node *n;
+		int nid;
 
-		n = s->node_slab[slqb_page_to_nid(page)];
+		nid = slqb_page_to_nid(page);
+		n = s->node_slab[nid];
 		l = &n->list;
 		page->list = l;
 
+		printk(KERN_INFO "%s: nid=%d, cache_node=%p, cache_list=%p\n", __func__, nid, n, l);
+
 		spin_lock(&n->list_lock);
 		spin_lock(&l->page_lock);
 		l->nr_slabs++;
@@ -2028,6 +2034,8 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)
 	for_each_node_state(node, N_NORMAL_MEMORY) {
 		struct kmem_cache_node *n;
 
+		printk(KERN_INFO "%s: cache=%s, node=%d\n", __func__, s->name, node);
+
 		n = s->node_slab[node];
 		if (n) {
 			kmem_cache_free(&kmem_node_cache, n);
@@ -2043,8 +2051,11 @@ static int alloc_kmem_cache_nodes(struct kmem_cache *s)
 	for_each_node_state(node, N_NORMAL_MEMORY) {
 		struct kmem_cache_node *n;
 
+		printk(KERN_INFO "%s: cache=%s, node=%d\n", __func__, s->name, node);
+
 		n = kmem_cache_alloc_node(&kmem_node_cache, GFP_KERNEL, node);
 		if (!n) {
+			printk(KERN_INFO "%s: %s: kmem_cache_alloc_node() failed for node %d\n", __func__, s->name, node);
 			free_kmem_cache_nodes(s);
 			return 0;
 		}
-- 
1.5.6.4

> 
