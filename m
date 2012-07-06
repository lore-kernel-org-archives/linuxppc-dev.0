Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3E2F42C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 17:57:52 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 6 Jul 2012 07:48:10 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q667o3je65405132
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jul 2012 17:50:03 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q667vkde018924
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jul 2012 17:57:48 +1000
Message-ID: <1341561460.24895.12.camel@ThinkPad-T420>
Subject: [PATCH powerpc 2/2 v3] kfree the cache name of pgtable cache
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Date: Fri, 06 Jul 2012 15:57:40 +0800
In-Reply-To: <1341561286.24895.9.camel@ThinkPad-T420>
References: <1341561286.24895.9.camel@ThinkPad-T420>
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

This patch tries to kfree the cache name of pgtables cache. It depends
on patch 1/2 -- ([PATCH SLAB 1/2 v3] duplicate the cache name in SLUB's
saved_alias list, SLAB, and SLOB) in this mail thread. 

For SLUB, as the pgtables cache might be mergeable to other caches.
During early boot, the name string is saved in the save_alias list. In
this case, the name could be safely kfreed after calling
kmem_cache_create() with patch 1.

For SLAB/SLOB, we need the changes in patch 1, which duplicates the name
strings in cache create.

v3: with patch 1/2 updated to make slab/slob consistent, #ifdef
CONFIG_SLUB is no longer needed. 

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/mm/init_64.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 620b7ac..bc7f462 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -130,6 +130,7 @@ void pgtable_cache_add(unsigned shift, void
(*ctor)(void *))
 	align = max_t(unsigned long, align, minalign);
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
 	new = kmem_cache_create(name, table_size, align, 0, ctor);
+	kfree(name);
 	PGT_CACHE(shift) = new;
 
 	pr_debug("Allocated pgtable cache for order %d\n", shift);
-- 
1.7.1
