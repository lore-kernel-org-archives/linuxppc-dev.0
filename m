Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w5YVP6KJ5zDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 00:21:33 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id g23so6425615pfj.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Apr 2017 07:21:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/64s: Minor fix for MCE TLB flush for radix
Date: Mon, 17 Apr 2017 00:21:19 +1000
Message-Id: <20170416142119.27242-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The TLB flush for radix first flushes TLB for radix configuration,
then flushes for hash configuration. The second flush is unnecessary
but does not affect correctness.

Fixes: 1a472c9dba6b9 ("powerpc/mm/radix: Add tlbflush routines")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce_power.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 763d6f58caa8..7b765aa9f2ff 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -72,10 +72,13 @@ void __flush_tlb_power8(unsigned int action)
 
 void __flush_tlb_power9(unsigned int action)
 {
-	if (radix_enabled())
-		flush_tlb_206(POWER9_TLB_SETS_RADIX, action);
+	unsigned int num_sets;
 
-	flush_tlb_206(POWER9_TLB_SETS_HASH, action);
+	if (radix_enabled())
+		num_sets = POWER9_TLB_SETS_RADIX;
+	else
+		num_sets = POWER9_TLB_SETS_HASH;
+	flush_tlb_206(num_sets, action);
 }
 
 
-- 
2.11.0
