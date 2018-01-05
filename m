Return-Path: <bharata@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zChff5CL5zF0PR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 22:05:46 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 w05B5En6025628
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jan 2018 06:05:44 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fa49k9veu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jan 2018 06:05:43 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Fri, 5 Jan 2018 11:05:41 -0000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 mpe@ellerman.id.au, david@gibson.dropbear.id.au, anton@samba.org,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: [RFC FIX v1 2/2] powerpc: Fix memory unplug failure on radix guest
Date: Fri,  5 Jan 2018 16:35:21 +0530
In-Reply-To: <1515150321-24894-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1515150321-24894-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1515150321-24894-3-git-send-email-bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For a PowerKVM guest, it is possible to explicitly specify a DIMM device
in addition to the system RAM at boot time. When such a cold plugged DIMM
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
cold plugged memblock region explicitly as hotplugged so that the
region doesn't get merged with RAM. All the memory that is discovered
via ibm,dynamic-reconfiguration-memory is marked so(1). Next identify
such regions in radix_init_pgtable() and create separate mappings
within that region for each LMB so that they get don't get aligned
like RAM region at 1G (2).

(1) The effect of marking the memory as hotplugged is that the
marked memory falls into ZONE_MOVABLE if movable_node kernel command line
option is enabled. This means no kernel allocations can occur from this
memory. This should be reasonalble to expect for hotplugged memory but
has an undesirable effect on PowerVM. On PowerVM, all the memory except RMA
is represented via ibm,dynamic-reconfiguration-memory and hence we can't
mark that entire memory as hotpluggable and movable. However since radix
isn't supported on PowerVM, we make this marking conditional to radix
so that PowerVM isn't affected.

For PowerKVM guests, all boot time memory is represented via
memory@XXXX nodes and hot plugged/pluggable memory is represented via
ibm,dynamic-reconfiguration-memory property. We are marking all
the memory that is in ASSIGNED state during boot as hotplugged.
With this only cold plugged memory gets marked for PowerKVM.

(2) To create separate mappings for every LMB in the hot plugged
region, we need lmb-size. I am currently using memory_block_size_bytes()
API to get the lmb-size. Since this is early init time code, the
machine type isn't probed yet and hence memory_block_size_bytes()
would return the default LMB size as 16MB. Hence we end up creating
separate mappings at much lower granularity than what we can ideally
do for pseries machine.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom.c      |  2 ++
 arch/powerpc/mm/pgtable-radix.c | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 079d893..2ad8fb1 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -525,6 +525,8 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 					size = 0x80000000ul - base;
 			}
 			memblock_add(base, size);
+			if (early_radix_enabled())
+				memblock_mark_hotplug(base, size);
 		} while (--rngs);
 	}
 	memblock_dump_all();
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index cfbbee9..10ceced 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -17,6 +17,7 @@
 #include <linux/of_fdt.h>
 #include <linux/mm.h>
 #include <linux/string_helpers.h>
+#include <linux/memory.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -278,15 +279,25 @@ static void __init radix_init_pgtable(void)
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
