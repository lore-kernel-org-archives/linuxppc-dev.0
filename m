Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z7JlC2xtszDqlG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Dec 2017 18:54:29 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Logan Gunthorpe <logang@deltatee.com>, Michal Hocko <mhocko@kernel.org>,
 linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/17] mm: don't export arch_add_memory
Date: Fri, 29 Dec 2017 08:53:51 +0100
Message-Id: <20171229075406.1936-3-hch@lst.de>
In-Reply-To: <20171229075406.1936-1-hch@lst.de>
References: <20171229075406.1936-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Only x86_64 and sh export this symbol, and it is not used by any
modular code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/sh/mm/init.c     | 1 -
 arch/x86/mm/init_64.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index bf726af5f1a5..afc54d593a26 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -498,7 +498,6 @@ int arch_add_memory(int nid, u64 start, u64 size, bool want_memblock)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(arch_add_memory);
 
 #ifdef CONFIG_NUMA
 int memory_add_physaddr_to_nid(u64 addr)
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 4a837289f2ad..8acdc35c2dfa 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -796,7 +796,6 @@ int arch_add_memory(int nid, u64 start, u64 size, bool want_memblock)
 
 	return add_pages(nid, start_pfn, nr_pages, want_memblock);
 }
-EXPORT_SYMBOL_GPL(arch_add_memory);
 
 #define PAGE_INUSE 0xFD
 
-- 
2.14.2
