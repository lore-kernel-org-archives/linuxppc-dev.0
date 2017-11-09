Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXqr65SYyzDrM8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 04:28:06 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id b6so4732724pfh.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Nov 2017 09:28:06 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2 3/5] powerpc/64s/hash: Allow MAP_FIXED allocations to cross
 128TB boundary
Date: Fri, 10 Nov 2017 04:27:38 +1100
Message-Id: <20171109172740.19681-4-npiggin@gmail.com>
In-Reply-To: <20171109172740.19681-1-npiggin@gmail.com>
References: <20171109172740.19681-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While mapping hints with a length that cross 128TB are disallowed,
MAP_FIXED allocations that cross 128TB are allowed. These are failing
on hash (on radix they succeed). Add an additional case for fixed
mappings to expand the addr_limit when crossing 128TB.

Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Fixes: f4ea6dcb08 ("powerpc/mm: Enable mappings above 128TB")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 3889201b560c..a4f93699194b 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -418,7 +418,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	unsigned long high_limit;
 
 	high_limit = DEFAULT_MAP_WINDOW;
-	if (addr >= high_limit)
+	if (addr >= high_limit || (fixed && (addr + len > high_limit)))
 		high_limit = TASK_SIZE;
 
 	if (len > high_limit)
-- 
2.15.0
