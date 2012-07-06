Return-Path: <cl@linux.com>
Received: from smtp104.prem.mail.ac4.yahoo.com
 (smtp104.prem.mail.ac4.yahoo.com [76.13.13.43])
 by ozlabs.org (Postfix) with SMTP id EE46C2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 23:56:14 +1000 (EST)
Date: Fri, 6 Jul 2012 08:56:04 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [PATCH SLAB 1/2 v3] duplicate the cache name in SLUB's saved_alias
 list, SLAB, and SLOB
In-Reply-To: <1341561286.24895.9.camel@ThinkPad-T420>
Message-ID: <alpine.DEB.2.00.1207060855320.26441@router.home>
References: <1341561286.24895.9.camel@ThinkPad-T420>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, Glauber Costa <glommer@parallels.com>,
 Pekka Enberg <penberg@kernel.org>, linux-mm <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Matt Mackall <mpm@selenic.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Wanlong Gao <gaowanlong@cn.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I thought I posted this a couple of days ago. Would this not fix things
without having to change all the allocators?


Subject: slub: Dup name earlier in kmem_cache_create

Dup the name earlier in kmem_cache_create so that alias
processing is done using the copy of the string and not
the string itself.

Signed-off-by: Christoph Lameter <cl@linux.com>

---
 mm/slub.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

Index: linux-2.6/mm/slub.c
===================================================================
--- linux-2.6.orig/mm/slub.c	2012-06-11 08:49:56.000000000 -0500
+++ linux-2.6/mm/slub.c	2012-07-03 15:17:37.000000000 -0500
@@ -3933,8 +3933,12 @@ struct kmem_cache *kmem_cache_create(con
 	if (WARN_ON(!name))
 		return NULL;

+	n = kstrdup(name, GFP_KERNEL);
+	if (!n)
+		goto out;
+
 	down_write(&slub_lock);
-	s = find_mergeable(size, align, flags, name, ctor);
+	s = find_mergeable(size, align, flags, n, ctor);
 	if (s) {
 		s->refcount++;
 		/*
@@ -3944,7 +3948,7 @@ struct kmem_cache *kmem_cache_create(con
 		s->objsize = max(s->objsize, (int)size);
 		s->inuse = max_t(int, s->inuse, ALIGN(size, sizeof(void *)));

-		if (sysfs_slab_alias(s, name)) {
+		if (sysfs_slab_alias(s, n)) {
 			s->refcount--;
 			goto err;
 		}
@@ -3952,31 +3956,26 @@ struct kmem_cache *kmem_cache_create(con
 		return s;
 	}

-	n = kstrdup(name, GFP_KERNEL);
-	if (!n)
-		goto err;
-
 	s = kmalloc(kmem_size, GFP_KERNEL);
 	if (s) {
 		if (kmem_cache_open(s, n,
 				size, align, flags, ctor)) {
 			list_add(&s->list, &slab_caches);
 			up_write(&slub_lock);
-			if (sysfs_slab_add(s)) {
-				down_write(&slub_lock);
-				list_del(&s->list);
-				kfree(n);
-				kfree(s);
-				goto err;
-			}
-			return s;
+			if (!sysfs_slab_add(s))
+				return s;
+
+			down_write(&slub_lock);
+			list_del(&s->list);
 		}
 		kfree(s);
 	}
-	kfree(n);
+
 err:
+	kfree(n);
 	up_write(&slub_lock);

+out:
 	if (flags & SLAB_PANIC)
 		panic("Cannot create slabcache %s\n", name);
 	else
