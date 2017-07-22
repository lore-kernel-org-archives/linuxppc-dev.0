Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDqWp70BzzDqxy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 11:18:14 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a11so5889420pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 18:18:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 07/11] mm: make memblock_alloc_base_nid non-static
Date: Sat, 22 Jul 2017 11:17:37 +1000
Message-Id: <20170722011741.13942-8-npiggin@gmail.com>
In-Reply-To: <20170722011741.13942-1-npiggin@gmail.com>
References: <20170722011741.13942-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/memblock.h | 5 ++++-
 mm/memblock.c            | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 77d427974f57..03731a1ffa76 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -298,9 +298,12 @@ static inline bool memblock_bottom_up(void)
 #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
 #define MEMBLOCK_ALLOC_ACCESSIBLE	0
 
-phys_addr_t __init memblock_alloc_range(phys_addr_t size, phys_addr_t align,
+phys_addr_t memblock_alloc_range(phys_addr_t size, phys_addr_t align,
 					phys_addr_t start, phys_addr_t end,
 					ulong flags);
+phys_addr_t memblock_alloc_base_nid(phys_addr_t size,
+					phys_addr_t align, phys_addr_t max_addr,
+					int nid, ulong flags);
 phys_addr_t memblock_alloc_base(phys_addr_t size, phys_addr_t align,
 				phys_addr_t max_addr);
 phys_addr_t __memblock_alloc_base(phys_addr_t size, phys_addr_t align,
diff --git a/mm/memblock.c b/mm/memblock.c
index 2cb25fe4452c..29c6b483581f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1194,7 +1194,7 @@ phys_addr_t __init memblock_alloc_range(phys_addr_t size, phys_addr_t align,
 					flags);
 }
 
-static phys_addr_t __init memblock_alloc_base_nid(phys_addr_t size,
+phys_addr_t __init memblock_alloc_base_nid(phys_addr_t size,
 					phys_addr_t align, phys_addr_t max_addr,
 					int nid, ulong flags)
 {
-- 
2.11.0
