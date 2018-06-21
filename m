Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BFLV5BlDzF0wj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 18:32:18 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5L8SfdK025588
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 04:32:13 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jr6bvnm98-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 04:32:13 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 21 Jun 2018 04:32:11 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 1/2] powerpc/mm: Check memblock_add against MAX_PHYSMEM_BITS
 range
Date: Thu, 21 Jun 2018 14:01:57 +0530
Message-Id: <20180621083158.30849-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With SPARSEMEM config enabled, we make sure that we don't add sections beyond
MAX_PHYSMEM_BITS range. This results in not building vmemmap mapping for
range beyond max range. But our memblock layer looks the device tree and create
mapping for the full memory range. Prevent this by checking against
MAX_PHSYSMEM_BITS when doing memblock_add.

We don't do similar check for memeblock_reserve_range. If reserve range is beyond
MAX_PHYSMEM_BITS we expect that to be configured with 'nomap'. Any other
reserved range should come from existing memblock ranges which we already
filtered while adding.

This avoids crash as below when running on a system with system ram config above
MAX_PHSYSMEM_BITS

 Unable to handle kernel paging request for data at address 0xc00a001000000440
 Faulting instruction address: 0xc000000001034118
 cpu 0x0: Vector: 300 (Data Access) at [c00000000124fb30]
     pc: c000000001034118: __free_pages_bootmem+0xc0/0x1c0
     lr: c00000000103b258: free_all_bootmem+0x19c/0x22c
     sp: c00000000124fdb0
    msr: 9000000002001033
    dar: c00a001000000440
  dsisr: 40000000
   current = 0xc00000000120dd00
   paca    = 0xc000000001f60000^I irqmask: 0x03^I irq_happened: 0x01
     pid   = 0, comm = swapper
 [c00000000124fe20] c00000000103b258 free_all_bootmem+0x19c/0x22c
 [c00000000124fee0] c000000001010a68 mem_init+0x3c/0x5c
 [c00000000124ff00] c00000000100401c start_kernel+0x298/0x5e4
 [c00000000124ff90] c00000000000b57c start_here_common+0x1c/0x520

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/kernel/prom.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 05e7fb47a7a4..8f32f14ba508 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -440,6 +440,29 @@ static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
 	return 1;
 }
 
+/*
+ * Compare the range against max mem limit and update
+ * size if it cross the limit.
+ */
+
+#ifdef CONFIG_SPARSEMEM
+static bool validate_mem_limit(u64 base, u64 *size)
+{
+	u64 max_mem = 1UL << (MAX_PHYSMEM_BITS);
+
+	if (base >= max_mem)
+		return false;
+	if ((base + *size) > max_mem)
+		*size = max_mem - base;
+	return true;
+}
+#else
+static bool validate_mem_limit(u64 base, u64 *size)
+{
+	return true;
+}
+#endif
+
 #ifdef CONFIG_PPC_PSERIES
 /*
  * Interpret the ibm dynamic reconfiguration memory LMBs.
@@ -494,7 +517,8 @@ static void __init early_init_drmem_lmb(struct drmem_lmb *lmb,
 		}
 
 		DBG("Adding: %llx -> %llx\n", base, size);
-		memblock_add(base, size);
+		if (validate_mem_limit(base, &size))
+			memblock_add(base, size);
 	} while (--rngs);
 }
 #endif /* CONFIG_PPC_PSERIES */
@@ -548,8 +572,10 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 	}
 
 	/* Add the chunk to the MEMBLOCK list */
-	if (add_mem_to_memblock)
-		memblock_add(base, size);
+	if (add_mem_to_memblock) {
+		if (validate_mem_limit(base, &size))
+			memblock_add(base, size);
+	}
 }
 
 static void __init early_reserve_mem_dt(void)
-- 
2.17.1
