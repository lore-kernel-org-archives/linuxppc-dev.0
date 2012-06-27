Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 812591007D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 17:53:43 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 07:44:06 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5R7jcQd4653486
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 17:45:39 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5R7rDtX015962
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 17:53:14 +1000
Message-ID: <1340783590.14360.9.camel@ThinkPad-T420>
Subject: [PATCH SLUB 1/2 v2] duplicate the cache name in saved_alias list
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Date: Wed, 27 Jun 2012 15:53:10 +0800
In-Reply-To: <1340617984.13778.37.camel@ThinkPad-T420>
References: <1340617984.13778.37.camel@ThinkPad-T420>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Christoph Lameter <cl@linux-foundation.org>,
 Glauber Costa <glommer@parallels.com>, Pekka Enberg <penberg@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 Matt Mackall <mpm@selenic.com>,
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

SLUB duplicates the cache name string passed into kmem_cache_create().
However if the cache could be merged to others during early boot, the
name pointer is saved in saved_alias list, and the string needs to be
kept valid before slab_sysfs_init() is finished. With this patch, the
name string (if kmalloced) could be kfreed after calling
kmem_cache_create().

Some more details:

kmem_cache_create() checks whether it is mergeable before creating one.
If not mergeable, the name is duplicated: n = kstrdup(name, GFP_KERNEL);

If it is mergeable, it calls sysfs_slab_alias(). If the sysfs is ready
(slab_state == SYSFS), then the name is duplicated (or dropped if no
SYSFS support) in sysfs_create_link() for use.

For the above cases, we could safely kfree the name string after calling
cache create. 

However, during early boot, before sysfs is ready (slab_state < SYSFS),
the sysfs_slab_alias() saves the pointer of name in the alias_list.
Those entries in the list are added to sysfs later in slab_sysfs_init()
to set up the sysfs stuff, and we need keep the name string passed in
valid until it finishes. By duplicating the name string here also, we
are able to safely kfree the name string after calling cache create.

v2: removed an unnecessary assignment in v1; some changes in change log,
added more details

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 mm/slub.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8c691fa..ed9f3c5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5372,7 +5372,11 @@ static int sysfs_slab_alias(struct kmem_cache *s,
const char *name)
 		return -ENOMEM;
 
 	al->s = s;
-	al->name = name;
+	al->name = kstrdup(name, GFP_KERNEL);
+	if (!al->name) {
+		kfree(al);
+		return -ENOMEM;
+	}
 	al->next = alias_list;
 	alias_list = al;
 	return 0;
@@ -5409,6 +5413,7 @@ static int __init slab_sysfs_init(void)
 		if (err)
 			printk(KERN_ERR "SLUB: Unable to add boot slab alias"
 					" %s to sysfs\n", s->name);
+		kfree(al->name);
 		kfree(al);
 	}
 
-- 
1.7.9.5
