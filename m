Return-Path: <npiggin@suse.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 495B9B70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 00:19:14 +1000 (EST)
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7A599DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 00:19:12 +1000 (EST)
Date: Tue, 9 Jun 2009 16:19:03 +0200
From: Nick Piggin <npiggin@suse.de>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [Powerpc/SLQB] Next June 06 : BUG during scsi initialization
Message-ID: <20090609141903.GE15219@wotan.suse.de>
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com> <4A2909E8.6000507@in.ibm.com>
	<Pine.LNX.4.64.0906071105030.11309@melkki.cs.Helsinki.FI>
	<4A2D001E.5060802@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A2D001E.5060802@in.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Pekka J Enberg <penberg@cs.helsinki.fi>,
	linux-next@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 08, 2009 at 05:42:14PM +0530, Sachin Sant wrote:
> Pekka J Enberg wrote:
> >Hi Sachin,
> __slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_list=c0000000de01ba00
> __slab_alloc_page: nid=2, cache_node=c0000000de01bd00, cache_list=c0000000de01bd00
> __slab_alloc_page: nid=2, cache_node=c0000000de01ba00, cache_lisBUG: spinlock bad magic on CPU#1, modprobe/62
>  lock: c0000000008c4280, .magic: 7dcc61f0, .owner:  || status == __GCONV_INCOMPLETE_INPUT || status == __GCONV_FULL_OUTPUT/724596736, .owner_cpu: 4095
> Call Trace:
> [c0000000c7da36d0] [c0000000000116e0] .show_stack+0x6c/0x16c (unreliable)
> [c0000000c7da3780] [c000000000365bcc] .spin_bug+0xb0/0xd4
> [c0000000c7da3810] [c000000000365e94] ._raw_spin_lock+0x48/0x184
> [c0000000c7da38b0] [c0000000005de4f8] ._spin_lock+0x10/0x24
> [c0000000c7da3920] [c000000000141240] .__slab_alloc_page+0x410/0x4b4
> [c0000000c7da39e0] [c000000000142804] .kmem_cache_alloc+0x13c/0x21c
> [c0000000c7da3aa0] [c0000000001431dc] .kmem_cache_create+0x294/0x2a8
> [c0000000c7da3b90] [d000000000ea1438] .scsi_init_queue+0x38/0x170 [scsi_mod]
> [c0000000c7da3c20] [d000000000ea1334] .init_scsi+0x1c/0xe8 [scsi_mod]
> [c0000000c7da3ca0] [c0000000000092c0] .do_one_initcall+0x80/0x19c
> [c0000000c7da3d90] [c0000000000c09c8] .SyS_init_module+0xe0/0x244
> [c0000000c7da3e30] [c000000000008534] syscall_exit+0x0/0x40

I can't really work it out. It seems to be the kmem_cache_cache which has
a problem, but there have already been lots of caches created and even
this samw cache_node already used right beforehand with no problem.

Unless a CPU or node comes up or something right at this point or the
caller is scheduled onto a different CPU... oopses seem to all
have CPU#1, wheras boot CPU is probably #0 (these CPUs are node 0
and memory is only on node 1 and 2 where there are no CPUs if I read
correctly).

I still can't see the reason for the failure, but can you try this
patch please and show dmesg?

---
 mm/slqb.c |   34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

Index: linux-2.6/mm/slqb.c
===================================================================
--- linux-2.6.orig/mm/slqb.c
+++ linux-2.6/mm/slqb.c
@@ -963,6 +963,7 @@ static struct slqb_page *allocate_slab(s
 
 	flags |= s->allocflags;
 
+	flags &= ~0x2000;
 	page = (struct slqb_page *)alloc_pages_node(node, flags, s->order);
 	if (!page)
 		return NULL;
@@ -1357,6 +1358,8 @@ static noinline void *__slab_alloc_page(
 	unsigned int colour;
 	void *object;
 
+	if (gfpflags & 0x2000)
+		printk("SLQB: __slab_alloc_page cpu=%d request node=%d\n", smp_processor_id(), node);
 	c = get_cpu_slab(s, smp_processor_id());
 	colour = c->colour_next;
 	c->colour_next += s->colour_off;
@@ -1374,6 +1377,8 @@ static noinline void *__slab_alloc_page(
 	if (unlikely(!page))
 		return page;
 
+	if (gfpflags & 0x2000)
+		printk("SLQB: __slab_alloc_page cpu=%d,nid=%d request node=%d page node=%d\n", smp_processor_id(), numa_node_id(), node, slqb_page_to_nid(page));
 	if (!NUMA_BUILD || likely(slqb_page_to_nid(page) == numa_node_id())) {
 		struct kmem_cache_cpu *c;
 		int cpu = smp_processor_id();
@@ -1382,6 +1387,7 @@ static noinline void *__slab_alloc_page(
 		l = &c->list;
 		page->list = l;
 
+		printk("SLQB: __slab_alloc_page spin_lock(%p)\n", &l->page_lock);
 		spin_lock(&l->page_lock);
 		l->nr_slabs++;
 		l->nr_partial++;
@@ -1398,6 +1404,8 @@ static noinline void *__slab_alloc_page(
 		l = &n->list;
 		page->list = l;
 
+		printk("SLQB: __slab_alloc_page spin_lock(%p)\n", &n->list_lock);
+		printk("SLQB: __slab_alloc_page spin_lock(%p)\n", &l->page_lock);
 		spin_lock(&n->list_lock);
 		spin_lock(&l->page_lock);
 		l->nr_slabs++;
@@ -1411,6 +1419,7 @@ static noinline void *__slab_alloc_page(
 #endif
 	}
 	VM_BUG_ON(!object);
+	printk("SLQB: __slab_alloc_page OK\n");
 	return object;
 }
 
@@ -1440,6 +1449,8 @@ static void *__remote_slab_alloc_node(st
 	struct kmem_cache_list *l;
 	void *object;
 
+	if (gfpflags & 0x2000)
+		printk("SLQB: __remote_slab_alloc_node cpu=%d request node=%d\n", smp_processor_id(), node);
 	n = s->node_slab[node];
 	if (unlikely(!n)) /* node has no memory */
 		return NULL;
@@ -1541,7 +1552,11 @@ static __always_inline void *slab_alloc(
 
 again:
 	local_irq_save(flags);
+	if (gfpflags & 0x2000)
+		printk("SLQB: slab_alloc cpu=%d,nid=%d request node=%d\n", smp_processor_id(), numa_node_id(), node);
 	object = __slab_alloc(s, gfpflags, node);
+	if (gfpflags & 0x2000)
+		printk("SLQB: slab_alloc cpu=%d return=%p\n", smp_processor_id(), object);
 	local_irq_restore(flags);
 
 	if (unlikely(slab_debug(s)) && likely(object)) {
@@ -2869,9 +2884,12 @@ void __init kmem_cache_init(void)
 #endif
 
 #ifdef CONFIG_SMP
+	printk("SLQB: kmem_cache_init possible CPUs: ");
 	for_each_possible_cpu(i) {
 		struct kmem_cache_cpu *c;
 
+		printk("%d ", i);
+
 		c = &per_cpu(kmem_cache_cpus, i);
 		init_kmem_cache_cpu(&kmem_cache_cache, c);
 		kmem_cache_cache.cpu_slab[i] = c;
@@ -2886,14 +2904,18 @@ void __init kmem_cache_init(void)
 		kmem_node_cache.cpu_slab[i] = c;
 #endif
 	}
+	printk("\n");
 #else
 	init_kmem_cache_cpu(&kmem_cache_cache, &kmem_cache_cache.cpu_slab);
 #endif
 
 #ifdef CONFIG_NUMA
-	for_each_node_state(i, N_NORMAL_MEMORY) {
+	printk("SLQB: kmem_cache_init possible nodes: ");
+	for_each_node_state(i, N_POSSIBLE) {
 		struct kmem_cache_node *n;
 
+		printk("%d ", i);
+
 		n = &per_cpu(kmem_cache_nodes, i);
 		init_kmem_cache_node(&kmem_cache_cache, n);
 		kmem_cache_cache.node_slab[i] = n;
@@ -2906,6 +2928,7 @@ void __init kmem_cache_init(void)
 		init_kmem_cache_node(&kmem_node_cache, n);
 		kmem_node_cache.node_slab[i] = n;
 	}
+	printk("\n");
 #endif
 
 	/* Caches that are not of the two-to-the-power-of size */
@@ -3040,12 +3063,17 @@ struct kmem_cache *kmem_cache_create(con
 	if (!kmem_cache_create_ok(name, size, align, flags))
 		goto err;
 
-	s = kmem_cache_alloc(&kmem_cache_cache, GFP_KERNEL);
+	printk("SLQB: kmem_cache_create %s size=%d align=%d flags=%lx\n", name, (int)size, (int)align, flags);
+
+	s = kmem_cache_alloc(&kmem_cache_cache, GFP_KERNEL|0x2000);
 	if (!s)
 		goto err;
 
-	if (kmem_cache_open(s, name, size, align, flags, ctor, 1))
+	printk("SLQB: kmem_cache_create %s kmem_cache allocated\n", name);
+	if (kmem_cache_open(s, name, size, align, flags, ctor, 1)) {
+		printk("SLQB: kmem_cache_create %s kmem_cache opened\n", name);
 		return s;
+	}
 
 	kmem_cache_free(&kmem_cache_cache, s);
 
