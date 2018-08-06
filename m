Return-Path: <srs0=0zbl=kv=linux.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kqNJ3KNzzDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 06:42:56 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41kqNJ2g4Sz8w0T
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 06:42:56 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41kqNH5b09z9ryt
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2018 06:42:55 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w76KchBv037205
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2018 16:42:54 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kpugjvnd7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 06 Aug 2018 16:42:53 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Mon, 6 Aug 2018 21:42:51 +0100
Subject: [PATCH v2 1/2] powerpc/fadump: handle crash memory ranges array
 index overflow
From: Hari Bathini <hbathini@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, stable@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Tue, 07 Aug 2018 02:12:45 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153358813908.15150.18359359970445648733.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Crash memory ranges is an array of memory ranges of the crashing kernel
to be exported as a dump via /proc/vmcore file. The size of the array
is set based on INIT_MEMBLOCK_REGIONS, which works alright in most cases
where memblock memory regions count is less than INIT_MEMBLOCK_REGIONS
value. But this count can grow beyond INIT_MEMBLOCK_REGIONS value since
commit 142b45a72e22 ("memblock: Add array resizing support").

On large memory systems with a few DLPAR operations, the memblock memory
regions count could be larger than INIT_MEMBLOCK_REGIONS value. On such
systems, registering fadump results in crash or other system failures
like below:

  task: c00007f39a290010 ti: c00000000b738000 task.ti: c00000000b738000
  NIP: c000000000047df4 LR: c0000000000f9e58 CTR: c00000000010f180
  REGS: c00000000b73b570 TRAP: 0300   Tainted: G          L   X  (4.4.140+)
  MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22004484  XER: 20000000
  CFAR: c000000000008500 DAR: 000007a450000000 DSISR: 40000000 SOFTE: 0
  GPR00: c0000000000f9e58 c00000000b73b7f0 c000000000f09a00 000000000000001a
  GPR04: c00007f3bf774c90 0000000000000004 c000000000eb9a00 0000000000000800
  GPR08: 0000000000000804 000007a450000000 c000000000fa9a00 c00007ffb169ca20
  GPR12: 0000000022004482 c00000000fa12c00 c00007f3a0ea97a8 0000000000000000
  GPR16: c00007f3a0ea9a50 c00000000b73bd60 0000000000000118 000000000001fe80
  GPR20: 0000000000000118 0000000000000000 c000000000b8c980 00000000000000d0
  GPR24: 000007ffb0b10000 c00007ffb169c980 0000000000000000 c000000000b8c980
  GPR28: 0000000000000004 c00007ffb169c980 000000000000001a c00007ffb169c980
  NIP [c000000000047df4] smp_send_reschedule+0x24/0x80
  LR [c0000000000f9e58] resched_curr+0x138/0x160
  Call Trace:
  [c00000000b73b7f0] [c0000000000f9e58] resched_curr+0x138/0x160 (unreliable)
  [c00000000b73b820] [c0000000000fb538] check_preempt_curr+0xc8/0xf0
  [c00000000b73b850] [c0000000000fb598] ttwu_do_wakeup+0x38/0x150
  [c00000000b73b890] [c0000000000fc9c4] try_to_wake_up+0x224/0x4d0
  [c00000000b73b900] [c00000000011ef34] __wake_up_common+0x94/0x100
  [c00000000b73b960] [c00000000034a78c] ep_poll_callback+0xac/0x1c0
  [c00000000b73b9b0] [c00000000011ef34] __wake_up_common+0x94/0x100
  [c00000000b73ba10] [c00000000011f810] __wake_up_sync_key+0x70/0xa0
  [c00000000b73ba60] [c00000000067c3e8] sock_def_readable+0x58/0xa0
  [c00000000b73ba90] [c0000000007848ac] unix_stream_sendmsg+0x2dc/0x4c0
  [c00000000b73bb70] [c000000000675a38] sock_sendmsg+0x68/0xa0
  [c00000000b73bba0] [c00000000067673c] ___sys_sendmsg+0x2cc/0x2e0
  [c00000000b73bd30] [c000000000677dbc] __sys_sendmsg+0x5c/0xc0
  [c00000000b73bdd0] [c0000000006789bc] SyS_socketcall+0x36c/0x3f0
  [c00000000b73be30] [c000000000009488] system_call+0x3c/0x100
  Instruction dump:
  4e800020 60000000 60420000 3c4c00ec 38421c30 7c0802a6 f8010010 60000000
  3d42000a e92ab420 2fa90000 4dde0020 <e9290000> 2fa90000 419e0044 7c0802a6
  ---[ end trace a6d1dd4bab5f8253 ]---

as array index overflow is not checked for while setting up crash memory
ranges causing memory corruption. To resolve this issue, dynamically
allocate memory for crash memory ranges and resize it incrementally,
in units of pagesize, on hitting array size limit.

Fixes: 2df173d9e85d ("fadump: Initialize elfcore header and add PT_LOAD program headers.")
Cc: stable@vger.kernel.org
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v2:
* Allocating memory for crash ranges in pagesize unit.
* freeing memory allocated while cleaning up.
* Moved the changes to coalesce memory ranges into patch 2/2.


 arch/powerpc/include/asm/fadump.h |    4 +-
 arch/powerpc/kernel/fadump.c      |   91 +++++++++++++++++++++++++++++++------
 2 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 5a23010..3abc738 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -195,8 +195,8 @@ struct fadump_crash_info_header {
 	struct cpumask	online_mask;
 };
 
-/* Crash memory ranges */
-#define INIT_CRASHMEM_RANGES	(INIT_MEMBLOCK_REGIONS + 2)
+/* Crash memory ranges size unit (pagesize) */
+#define CRASHMEM_RANGES_ALLOC_SIZE		PAGE_SIZE
 
 struct fad_crash_memory_ranges {
 	unsigned long long	base;
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 07e8396..2ec5704 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -47,8 +47,10 @@ static struct fadump_mem_struct fdm;
 static const struct fadump_mem_struct *fdm_active;
 
 static DEFINE_MUTEX(fadump_mutex);
-struct fad_crash_memory_ranges crash_memory_ranges[INIT_CRASHMEM_RANGES];
+struct fad_crash_memory_ranges *crash_memory_ranges;
+int crash_memory_ranges_size;
 int crash_mem_ranges;
+int max_crash_mem_ranges;
 
 /* Scan the Firmware Assisted dump configuration details. */
 int __init early_init_dt_scan_fw_dump(unsigned long node,
@@ -868,22 +870,67 @@ static int __init process_fadump(const struct fadump_mem_struct *fdm_active)
 	return 0;
 }
 
-static inline void fadump_add_crash_memory(unsigned long long base,
-					unsigned long long end)
+static void free_crash_memory_ranges(void)
+{
+	kfree(crash_memory_ranges);
+	crash_memory_ranges = NULL;
+	crash_memory_ranges_size = 0;
+	max_crash_mem_ranges = 0;
+}
+
+/*
+ * Allocate or reallocate crash memory ranges array in incremental units
+ * of CRASHMEM_RANGES_ALLOC_SIZE.
+ */
+static int allocate_crash_memory_ranges(void)
+{
+	u64 new_size;
+	struct fad_crash_memory_ranges *new_array;
+
+	new_size = crash_memory_ranges_size + CRASHMEM_RANGES_ALLOC_SIZE;
+	pr_debug("Allocating %llu bytes of memory for crash memory ranges\n",
+		 new_size);
+
+	new_array = krealloc(crash_memory_ranges, new_size, GFP_KERNEL);
+	if (new_array == NULL) {
+		pr_err("Insufficient memory for setting up crash memory ranges\n");
+		free_crash_memory_ranges();
+		return -ENOMEM;
+	}
+
+	crash_memory_ranges = new_array;
+	crash_memory_ranges_size = new_size;
+	max_crash_mem_ranges = (new_size /
+				sizeof(struct fad_crash_memory_ranges));
+	return 0;
+}
+
+static inline int fadump_add_crash_memory(unsigned long long base,
+					  unsigned long long end)
 {
 	if (base == end)
-		return;
+		return 0;
+
+	if (crash_mem_ranges == max_crash_mem_ranges) {
+		int ret;
+
+		ret = allocate_crash_memory_ranges();
+		if (ret)
+			return ret;
+	}
 
 	pr_debug("crash_memory_range[%d] [%#016llx-%#016llx], %#llx bytes\n",
 		crash_mem_ranges, base, end - 1, (end - base));
 	crash_memory_ranges[crash_mem_ranges].base = base;
 	crash_memory_ranges[crash_mem_ranges].size = end - base;
 	crash_mem_ranges++;
+	return 0;
 }
 
-static void fadump_exclude_reserved_area(unsigned long long start,
+static int fadump_exclude_reserved_area(unsigned long long start,
 					unsigned long long end)
 {
+	int ret = 0;
 	unsigned long long ra_start, ra_end;
 
 	ra_start = fw_dump.reserve_dump_area_start;
@@ -891,15 +938,20 @@ static void fadump_exclude_reserved_area(unsigned long long start,
 
 	if ((ra_start < end) && (ra_end > start)) {
 		if ((start < ra_start) && (end > ra_end)) {
-			fadump_add_crash_memory(start, ra_start);
-			fadump_add_crash_memory(ra_end, end);
+			ret = fadump_add_crash_memory(start, ra_start);
+			if (ret)
+				return ret;
+
+			ret = fadump_add_crash_memory(ra_end, end);
 		} else if (start < ra_start) {
-			fadump_add_crash_memory(start, ra_start);
+			ret = fadump_add_crash_memory(start, ra_start);
 		} else if (ra_end < end) {
-			fadump_add_crash_memory(ra_end, end);
+			ret = fadump_add_crash_memory(ra_end, end);
 		}
 	} else
-		fadump_add_crash_memory(start, end);
+		ret = fadump_add_crash_memory(start, end);
+
+	return ret;
 }
 
 static int fadump_init_elfcore_header(char *bufp)
@@ -939,8 +991,9 @@ static int fadump_init_elfcore_header(char *bufp)
  * Traverse through memblock structure and setup crash memory ranges. These
  * ranges will be used create PT_LOAD program headers in elfcore header.
  */
-static void fadump_setup_crash_memory_ranges(void)
+static int fadump_setup_crash_memory_ranges(void)
 {
+	int ret;
 	struct memblock_region *reg;
 	unsigned long long start, end;
 
@@ -953,7 +1006,9 @@ static void fadump_setup_crash_memory_ranges(void)
 	 * specified during fadump registration. We need to create a separate
 	 * program header for this chunk with the correct offset.
 	 */
-	fadump_add_crash_memory(RMA_START, fw_dump.boot_memory_size);
+	ret = fadump_add_crash_memory(RMA_START, fw_dump.boot_memory_size);
+	if (ret)
+		return ret;
 
 	for_each_memblock(memory, reg) {
 		start = (unsigned long long)reg->base;
@@ -973,8 +1028,12 @@ static void fadump_setup_crash_memory_ranges(void)
 		}
 
 		/* add this range excluding the reserved dump area. */
-		fadump_exclude_reserved_area(start, end);
+		ret = fadump_exclude_reserved_area(start, end);
+		if (ret)
+			return ret;
 	}
+
+	return 0;
 }
 
 /*
@@ -1095,6 +1154,7 @@ static unsigned long init_fadump_header(unsigned long addr)
 
 static int register_fadump(void)
 {
+	int ret;
 	unsigned long addr;
 	void *vaddr;
 
@@ -1105,7 +1165,9 @@ static int register_fadump(void)
 	if (!fw_dump.reserve_dump_area_size)
 		return -ENODEV;
 
-	fadump_setup_crash_memory_ranges();
+	ret = fadump_setup_crash_memory_ranges();
+	if (ret)
+		return ret;
 
 	addr = be64_to_cpu(fdm.rmr_region.destination_address) + be64_to_cpu(fdm.rmr_region.source_len);
 	/* Initialize fadump crash info header. */
@@ -1183,6 +1245,7 @@ void fadump_cleanup(void)
 	} else if (fw_dump.dump_registered) {
 		/* Un-register Firmware-assisted dump if it was registered. */
 		fadump_unregister_dump(&fdm);
+		free_crash_memory_ranges();
 	}
 }
 
