Return-Path: <srs0=w+32=kp=linux.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fyfL1mTvzF14l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 23:56:42 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41fyfK69QHz8twr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 23:56:41 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41fyfK1h3Qz9s2g
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2018 23:56:40 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6VDdNS8001758
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2018 09:56:39 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kjqj0mc0v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2018 09:56:38 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 31 Jul 2018 14:56:36 +0100
Subject: [PATCH] powerpc/fadump: handle crash memory ranges array overflow
From: Hari Bathini <hbathini@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, stable@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Tue, 31 Jul 2018 19:26:30 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153304539025.23724.13483958866671131484.stgit@hbathini.in.ibm.com>
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
ranges causing memory corruption. To resolve this issue, resize crash
memory ranges array on hitting array size limit.

But without a hard limit on the number of crash memory ranges, there is
a possibility of program headers count overflow in the /proc/vmcore ELF
file while exporting each of this memory ranges as PT_LOAD segments. To
reduce the likelihood of such scenario, fold adjacent memory ranges to
minimize the total number of crash memory ranges.

Fixes: 2df173d9e85d ("fadump: Initialize elfcore header and add PT_LOAD program headers.")
Cc: stable@vger.kernel.org
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/include/asm/fadump.h |    2 +
 arch/powerpc/kernel/fadump.c      |   63 ++++++++++++++++++++++++++++++++++---
 2 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 5a23010..ff708b3 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -196,7 +196,7 @@ struct fadump_crash_info_header {
 };
 
 /* Crash memory ranges */
-#define INIT_CRASHMEM_RANGES	(INIT_MEMBLOCK_REGIONS + 2)
+#define INIT_CRASHMEM_RANGES	INIT_MEMBLOCK_REGIONS
 
 struct fad_crash_memory_ranges {
 	unsigned long long	base;
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 07e8396..1c1df4f 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -47,7 +47,9 @@ static struct fadump_mem_struct fdm;
 static const struct fadump_mem_struct *fdm_active;
 
 static DEFINE_MUTEX(fadump_mutex);
-struct fad_crash_memory_ranges crash_memory_ranges[INIT_CRASHMEM_RANGES];
+struct fad_crash_memory_ranges init_crash_memory_ranges[INIT_CRASHMEM_RANGES];
+int max_crash_mem_ranges = INIT_CRASHMEM_RANGES;
+struct fad_crash_memory_ranges *crash_memory_ranges = init_crash_memory_ranges;
 int crash_mem_ranges;
 
 /* Scan the Firmware Assisted dump configuration details. */
@@ -871,14 +873,65 @@ static int __init process_fadump(const struct fadump_mem_struct *fdm_active)
 static inline void fadump_add_crash_memory(unsigned long long base,
 					unsigned long long end)
 {
+	u64  start, size;
+	bool is_adjacent = false;
+
 	if (base == end)
 		return;
 
+	/*
+	 * Fold adjacent memory ranges to bring down the memory ranges/
+	 * PT_LOAD segments count.
+	 */
+	if (crash_mem_ranges) {
+		start = crash_memory_ranges[crash_mem_ranges-1].base;
+		size = crash_memory_ranges[crash_mem_ranges-1].size;
+
+		if ((start + size) == base)
+			is_adjacent = true;
+	}
+
+	if (!is_adjacent) {
+		/* resize the array on reaching the limit */
+		if (crash_mem_ranges == max_crash_mem_ranges) {
+			u64 old_size, new_max;
+			struct fad_crash_memory_ranges *new_array;
+
+			old_size = max_crash_mem_ranges;
+			old_size *= sizeof(struct fad_crash_memory_ranges);
+
+			new_max = max_crash_mem_ranges + INIT_CRASHMEM_RANGES;
+			size = new_max * sizeof(struct fad_crash_memory_ranges);
+
+			pr_debug("Resizing crash memory ranges count from %d to %d\n",
+				 max_crash_mem_ranges, new_max);
+
+			new_array = kmalloc(size, GFP_KERNEL);
+			if (new_array == NULL) {
+				pr_warn("Insufficient memory for setting up crash memory ranges\n");
+				return;
+			}
+
+			/*
+			 * Copy the old memory ranges into the new array before
+			 * free'ing it.
+			 */
+			memcpy(new_array, crash_memory_ranges, old_size);
+			if (crash_memory_ranges != init_crash_memory_ranges)
+				kfree(crash_memory_ranges);
+
+			crash_memory_ranges = new_array;
+			max_crash_mem_ranges = new_max;
+		}
+		start = base;
+		crash_memory_ranges[crash_mem_ranges].base = start;
+		crash_mem_ranges++;
+	}
+
+	crash_memory_ranges[crash_mem_ranges-1].size = (end - start);
+
 	pr_debug("crash_memory_range[%d] [%#016llx-%#016llx], %#llx bytes\n",
-		crash_mem_ranges, base, end - 1, (end - base));
-	crash_memory_ranges[crash_mem_ranges].base = base;
-	crash_memory_ranges[crash_mem_ranges].size = end - base;
-	crash_mem_ranges++;
+		(crash_mem_ranges - 1), start, end - 1, (end - start));
 }
 
 static void fadump_exclude_reserved_area(unsigned long long start,
