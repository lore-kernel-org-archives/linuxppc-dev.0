Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vV9Kb1VYVzDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 23:25:07 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vV9KZ4Q5lz9s7t
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 23:25:06 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1OCOTtk145979
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 07:25:04 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28tm1vhw9w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 07:25:04 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 24 Feb 2017 22:25:01 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 13C743578053
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 23:24:58 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1OCOoYS55640204
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 23:24:58 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1OCOO3U025290
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 23:24:25 +1100
Subject: [PATCH v2] powerpc/fadump: set an upper limit for boot memory size
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 17:54:02 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148793853573.16182.16113694193326906522.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By default, 5% of system RAM is reserved for preserving boot memory.
Alternatively, a user can specify the amount of memory to reserve.
See Documentation/powerpc/firmware-assisted-dump.txt for details. In
addition to the memory reserved for preserving boot memory, some more
memory is reserved, to save HPTE region, CPU state data and ELF core
headers.

Memory Reservation during first kernel looks like below:

  Low memory                                        Top of memory
  0      boot memory size                                       |
  |           |                       |<--Reserved dump area -->|
  V           V                       |   Permanent Reservation V
  +-----------+----------/ /----------+---+----+-----------+----+
  |           |                       |CPU|HPTE|  DUMP     |ELF |
  +-----------+----------/ /----------+---+----+-----------+----+
        |                                           ^
        |                                           |
        \                                           /
         -------------------------------------------
          Boot memory content gets transferred to
          reserved area by firmware at the time of
          crash

This implicitly means that the sum of the sizes of boot memory, CPU
state data, HPTE region, DUMP preserving area and ELF core headers
can't be greater than the total memory size. But currently, a user is
allowed to specify any value as boot memory size. So, the above rule
is violated when a boot memory size around 50% of the total available
memory is specified. As the kernel is not handling this currently, it
may lead to undefined behavior. Fix it by setting an upper limit for
boot memory size to 25% of the total available memory. Also, instead
of using memblock_end_of_DRAM(), which doesn't take the holes, if any,
in the memory layout into account, use memblock_phys_mem_size() to
calculate the percentage of total available memory.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

This patch is based on top of the patchset to reuse-crashkernel-parameter-
for-fadump (http://patchwork.ozlabs.org/patch/711522).

Changes from v1:
* Using memblock_phys_mem_size() instead of memblock_end_of_DRAM() to
  get system RAM size.


 arch/powerpc/include/asm/fadump.h |    3 +++
 arch/powerpc/kernel/fadump.c      |   16 +++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 60b9108..a3de219 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -43,6 +43,9 @@
 #define MIN_BOOT_MEM	(((RMA_END < (0x1UL << 28)) ? (0x1UL << 28) : RMA_END) \
 			+ (0x1UL << 26))
 
+/* The upper limit percentage for user specified boot memory size (25%) */
+#define MAX_BOOT_MEM_RATIO			4
+
 #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
 
 /* Firmware provided dump sections */
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index e013f8f..21d5404 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -221,12 +221,26 @@ static inline unsigned long fadump_calculate_reserve_size(void)
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&size, &base);
 	if (ret == 0 && size > 0) {
+		unsigned long max_size;
+
 		fw_dump.reserve_bootvar = (unsigned long)size;
+
+		/*
+		 * Adjust if the boot memory size specified is above
+		 * the upper limit.
+		 */
+		max_size = memblock_phys_mem_size() / MAX_BOOT_MEM_RATIO;
+		if (fw_dump.reserve_bootvar > max_size) {
+			fw_dump.reserve_bootvar = max_size;
+			pr_info("Adjusted boot memory size to %luMB\n",
+				(fw_dump.reserve_bootvar >> 20));
+		}
+
 		return fw_dump.reserve_bootvar;
 	}
 
 	/* divide by 20 to get 5% of value */
-	size = memblock_end_of_DRAM() / 20;
+	size = memblock_phys_mem_size() / 20;
 
 	/* round it down in multiples of 256 */
 	size = size & ~0x0FFFFFFFUL;
