Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AD0E2B6FAC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 19:53:21 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 25 Jun 2012 15:23:13 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5P9r8aR63045796
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 15:23:08 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5PFNkoR015829
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2012 01:23:47 +1000
Message-ID: <1340617984.13778.37.camel@ThinkPad-T420>
Subject: [PATCH SLUB 1/2] duplicate the cache name in saved_alias list
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Date: Mon, 25 Jun 2012 17:53:04 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Christoph Lameter <cl@linux-foundation.org>,
 Pekka Enberg <penberg@kernel.org>, linux-mm <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Matt Mackall <mpm@selenic.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SLUB duplicates the cache name in kmem_cache_create(). However if the
cache could be merged to others during early booting, the name pointer
is saved in saved_alias list, and the string needs to be kept valid
before slab_sysfs_init() is called. 

This patch tries to duplicate the cache name in saved_alias list, so
that the cache name could be safely kfreed after calling
kmem_cache_create(), if that name is kmalloced. 

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 mm/slub.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8c691fa..3dc8ed5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5373,6 +5373,11 @@ static int sysfs_slab_alias(struct kmem_cache *s,
const char *name)
 
 	al->s = s;
 	al->name = name;
+	al->name = kstrdup(name, GFP_KERNEL);
+	if (!al->name) {
+		kfree(al);
+		return -ENOMEM;
+	}
 	al->next = alias_list;
 	alias_list = al;
 	return 0;
@@ -5409,6 +5414,7 @@ static int __init slab_sysfs_init(void)
 		if (err)
 			printk(KERN_ERR "SLUB: Unable to add boot slab alias"
 					" %s to sysfs\n", s->name);
+		kfree(al->name);
 		kfree(al);
 	}
 
-- 
1.7.1
