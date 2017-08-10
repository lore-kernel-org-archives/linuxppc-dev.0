Return-Path: <srs0=4evi=7m=linux.vnet.ibm.com=bharata@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSjQZ3YlLzDqrx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 19:24:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xSjQZ322xz8syC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 19:24:54 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xSjQY70S3z9s2G
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2017 19:24:53 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7A9OiY2033904
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2017 05:24:51 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c8cykseg0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2017 05:24:51 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Thu, 10 Aug 2017 19:24:48 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7A9ObJH17891402
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2017 19:24:45 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7A9OC2c025673
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2017 19:24:13 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: nfont@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: [FIX PATCH v0] powerpc: Fix memory unplug failure on radix guest
Date: Thu, 10 Aug 2017 14:53:48 +0530
Message-Id: <1502357028-27465-1-git-send-email-bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For a PowerKVM guest, it is possible to specify a DIMM device in
addition to the system RAM at boot time. When such a cold plugged DIMM
device is removed from a radix guest, we hit the following warning in the
guest kernel resulting in the eventual failure of memory unplug:

remove_pud_table: unaligned range
WARNING: CPU: 3 PID: 164 at arch/powerpc/mm/pgtable-radix.c:597 remove_pagetable+0x468/0xca0
Call Trace:
remove_pagetable+0x464/0xca0 (unreliable)
radix__remove_section_mapping+0x24/0x40
remove_section_mapping+0x28/0x60
arch_remove_memory+0xcc/0x120
remove_memory+0x1ac/0x270
dlpar_remove_lmb+0x1ac/0x210
dlpar_memory+0xbc4/0xeb0
pseries_hp_work_fn+0x1a4/0x230
process_one_work+0x1cc/0x660
worker_thread+0xac/0x6d0
kthread+0x16c/0x1b0
ret_from_kernel_thread+0x5c/0x74

The DIMM memory that is cold plugged gets merged to the same memblock
region as RAM and hence gets mapped at 1G alignment. However since the
removal is done for one LMB (lmb size 256MB) at a time, the address
of the LMB (which is 256MB aligned) would get flagged as unaligned
in remove_pud_table() resulting in the above failure.

This problem is not seen for hot plugged memory because for the
hot plugged memory, the mappings are created separately for each
LMB and hence they all get aligned at 256MB.

To fix this problem for the cold plugged memory, let us mark the
cold plugged memblock region explicitly as HOTPLUGGED so that the
region doesn't get merged with RAM. All the memory that is discovered
via ibm,dynamic-memory-configuration is marked so(1). Next identify
such regions in radix_init_pgtable() and create separate mappings
within that region for each LMB so that they get don't get aligned
like RAM region at 1G (2).

(1) For PowerKVM guests, all boot time memory is represented via
memory@XXXX nodes and hot plugged/pluggable memory is represented via
ibm,dynamic-memory-reconfiguration property. We are marking all
hotplugged memory that is in ASSIGNED state during boot as HOTPLUGGED.
With this only cold plugged memory gets marked for PowerKVM but
need to check how this will affect PowerVM guests.

(2) To create separate mappings for every LMB in the hot plugged
region, we need lmb-size. I am currently using memory_block_size_bytes()
API to get the lmb-size. Since this is early init time code, the
machine type isn't probed yet and hence memory_block_size_bytes()
would return the default LMB size as 16MB. Hence we end up creating
separate mappings at much lower granularity than what we can ideally
do for pseries machine.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom.c      |  1 +
 arch/powerpc/mm/pgtable-radix.c | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f830562..24ecf53 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -524,6 +524,7 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 					size = 0x80000000ul - base;
 			}
 			memblock_add(base, size);
+			memblock_mark_hotplug(base, size);
 		} while (--rngs);
 	}
 	memblock_dump_all();
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 671a45d..180d25a 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -12,6 +12,7 @@
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/mm.h>
+#include <linux/memory.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -255,15 +256,25 @@ static void __init radix_init_pgtable(void)
 {
 	unsigned long rts_field;
 	struct memblock_region *reg;
+	phys_addr_t addr;
+	u64 lmb_size = memory_block_size_bytes();
 
 	/* We don't support slb for radix */
 	mmu_slb_size = 0;
 	/*
 	 * Create the linear mapping, using standard page size for now
 	 */
-	for_each_memblock(memory, reg)
-		WARN_ON(create_physical_mapping(reg->base,
-						reg->base + reg->size));
+	for_each_memblock(memory, reg) {
+		if (memblock_is_hotpluggable(reg)) {
+			for (addr = reg->base; addr < (reg->base + reg->size);
+				addr += lmb_size)
+				WARN_ON(create_physical_mapping(addr,
+					addr + lmb_size));
+		} else {
+			WARN_ON(create_physical_mapping(reg->base,
+							reg->base + reg->size));
+		}
+	}
 
 	/* Find out how many PID bits are supported */
 	if (cpu_has_feature(CPU_FTR_HVMODE)) {
-- 
2.7.4
