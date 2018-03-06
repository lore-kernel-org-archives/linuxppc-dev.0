Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwcwH1DPVzF1R1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 00:25:35 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id w12-v6so109093plp.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 05:25:34 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 03/10] powerpc/mm/slice: tidy lpsizes and hpsizes update loops
Date: Tue,  6 Mar 2018 23:25:00 +1000
Message-Id: <20180306132507.10649-4-npiggin@gmail.com>
In-Reply-To: <20180306132507.10649-1-npiggin@gmail.com>
References: <20180306132507.10649-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make these loops look the same, and change their form so the
important part is not wrapped over so many lines.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slice.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index af4351b15d01..9625ceb35685 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -232,22 +232,24 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
 	spin_lock_irqsave(&slice_convert_lock, flags);
 
 	lpsizes = mm->context.low_slices_psize;
-	for (i = 0; i < SLICE_NUM_LOW; i++)
-		if (mask.low_slices & (1u << i)) {
-			mask_index = i & 0x1;
-			index = i >> 1;
-			lpsizes[index] = (lpsizes[index] &
-					  ~(0xf << (mask_index * 4))) |
+	for (i = 0; i < SLICE_NUM_LOW; i++) {
+		if (!(mask.low_slices & (1u << i)))
+			continue;
+
+		mask_index = i & 0x1;
+		index = i >> 1;
+		lpsizes[index] = (lpsizes[index] & ~(0xf << (mask_index * 4))) |
 				(((unsigned long)psize) << (mask_index * 4));
-		}
+	}
 
 	hpsizes = mm->context.high_slices_psize;
 	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++) {
+		if (!test_bit(i, mask.high_slices))
+			continue;
+
 		mask_index = i & 0x1;
 		index = i >> 1;
-		if (test_bit(i, mask.high_slices))
-			hpsizes[index] = (hpsizes[index] &
-					  ~(0xf << (mask_index * 4))) |
+		hpsizes[index] = (hpsizes[index] & ~(0xf << (mask_index * 4))) |
 				(((unsigned long)psize) << (mask_index * 4));
 	}
 
-- 
2.16.1
