Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVp6d1DpvzDrJn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 21:03:37 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id p87so7374376pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 02:03:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH 2/5] powerpc/64s/hash: Allow MAP_FIXED allocations to cross
 128TB boundary
Date: Mon,  6 Nov 2017 21:03:12 +1100
Message-Id: <20171106100315.29720-3-npiggin@gmail.com>
In-Reply-To: <20171106100315.29720-1-npiggin@gmail.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
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
 arch/powerpc/mm/slice.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 567db541c0a1..f980397b449d 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -419,7 +419,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	/*
 	 * Check if we need to expland slice area.
 	 */
-	if (unlikely(addr > mm->context.addr_limit &&
+	if (unlikely(((addr > mm->context.addr_limit) ||
+			(fixed && addr + len > mm->context.addr_limit)) &&
 		     mm->context.addr_limit != TASK_SIZE)) {
 		mm->context.addr_limit = TASK_SIZE;
 		on_each_cpu(slice_flush_segments, mm, 1);
-- 
2.15.0
