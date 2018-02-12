Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgBw053xKzF0nL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 04:08:48 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id t4so6843816pgp.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 09:08:48 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 05/12] mm: make memblock_alloc_base_nid non-static
Date: Tue, 13 Feb 2018 03:08:15 +1000
Message-Id: <20180212170822.14612-6-npiggin@gmail.com>
In-Reply-To: <20180212170822.14612-1-npiggin@gmail.com>
References: <20180212170822.14612-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This will be used by powerpc to allocate per-cpu stacks and other
data structures node-local where possible.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/memblock.h | 5 ++++-
 mm/memblock.c            | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 7ed0f7782d16..c0a729c77340 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -316,9 +316,12 @@ static inline bool memblock_bottom_up(void)
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
index 46aacdfa4f4d..12e5e685e585 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1190,7 +1190,7 @@ phys_addr_t __init memblock_alloc_range(phys_addr_t size, phys_addr_t align,
 					flags);
 }
 
-static phys_addr_t __init memblock_alloc_base_nid(phys_addr_t size,
+phys_addr_t __init memblock_alloc_base_nid(phys_addr_t size,
 					phys_addr_t align, phys_addr_t max_addr,
 					int nid, ulong flags)
 {
-- 
2.16.1
