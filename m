Return-Path: <himangi774@gmail.com>
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com
 [IPv6:2607:f8b0:400e:c02::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 568731A01BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 04:10:29 +1000 (EST)
Received: by mail-pd0-f171.google.com with SMTP id z10so28010pdj.16
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 11:10:27 -0700 (PDT)
Date: Tue, 22 Jul 2014 23:40:19 +0530
From: Himangi Saraogi <himangi774@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/perf/hv-24x7: Use kmem_cache_free
Message-ID: <20140722181019.GA3222@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julia Lawall <julia.lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Free memory allocated using kmem_cache_zalloc using kmem_cache_free
rather than kfree.

The Coccinelle semantic patch that makes this change is as follows:

// <smpl>
@@
expression x,E,c;
@@

 x = \(kmem_cache_alloc\|kmem_cache_zalloc\|kmem_cache_alloc_node\)(c,...)
 ... when != x = E
     when != &x
?-kfree(x)
+kmem_cache_free(c,x)
// </smpl>

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 arch/powerpc/perf/hv-24x7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 66d0f17..70d4f74 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -223,7 +223,7 @@ e_free:
 		pr_err("h_get_24x7_catalog_page(ver=%lld, page=%lld) failed:"
 		       " rc=%ld\n",
 		       catalog_version_num, page_offset, hret);
-	kfree(page);
+	kmem_cache_free(hv_page_cache, page);
 
 	pr_devel("catalog_read: offset=%lld(%lld) count=%zu(%zu) catalog_len=%zu(%zu) => %zd\n",
 			offset, page_offset, count, page_count, catalog_len,
-- 
1.9.1
