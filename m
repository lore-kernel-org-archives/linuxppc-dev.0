Return-Path: <BATV+f9b51a8ca15fdac5c6a2+5227+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yysl868JxzDrkD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 01:10:12 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-nvdimm@lists.01.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 03/17] mm: don't export __add_pages
Date: Fri, 15 Dec 2017 15:09:33 +0100
Message-Id: <20171215140947.26075-4-hch@lst.de>
In-Reply-To: <20171215140947.26075-1-hch@lst.de>
References: <20171215140947.26075-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This function isn't used by any modules, and is only to be called
from core MM code.  This includes the calls for the add_pages wrapper
that might be inlined.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/memory_hotplug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c52aa05b106c..5c6f96e6b334 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -334,7 +334,6 @@ int __ref __add_pages(int nid, unsigned long phys_start_pfn,
 out:
 	return err;
 }
-EXPORT_SYMBOL_GPL(__add_pages);
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 /* find the smallest valid pfn in the range [start_pfn, end_pfn) */
-- 
2.14.2
