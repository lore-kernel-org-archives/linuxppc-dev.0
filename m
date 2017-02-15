Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNjt06kbLzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 02:30:48 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vNjsz6gsGz9ryj
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2017 02:30:47 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1FFO8rx115283
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Feb 2017 10:30:46 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28mq9sf4c6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Feb 2017 10:30:45 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 01:30:43 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 821B12CE8054
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2017 02:30:39 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1FFUVcv15466650
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2017 02:30:39 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1FFTxTL011198
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2017 02:29:59 +1100
Subject: [PATCH] powerpc/fadump: set an upper limit for boot memory size
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Wed, 15 Feb 2017 20:59:35 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148717255648.1711.9357297790070400059.stgit@hbathini.in.ibm.com>
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

The implicit rule here is that the sum of the sizes of boot memory,
CPU state data, HPTE region and ELF core headers can't be greater than
the total memory size. But currently, a user is allowed to specify any
value as boot memory size. So, the above rule is violated when a boot
memory size closer to 50% of the total available memory is specified.
As the kernel is not handling this currently, it may lead to undefined
behavior. Fix it by setting an upper limit for boot memory size to 25%
of the total available memory.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

This patch is based on top of reuse-crashkernel-parameter-for-fadump patchset
(https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-January/152724.html)


 arch/powerpc/include/asm/fadump.h |    3 +++
 arch/powerpc/kernel/fadump.c      |   12 ++++++++++++
 2 files changed, 15 insertions(+)

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
index de7d39a..d5107f4 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -222,6 +222,18 @@ static inline unsigned long fadump_calculate_reserve_size(void)
 				&size, &base);
 	if (ret == 0 && size > 0) {
 		fw_dump.reserve_bootvar = (unsigned long)size;
+		/*
+		 * Adjust if the boot memory size specified is above
+		 * the upper limit.
+		 */
+		if (fw_dump.reserve_bootvar >
+		    (memblock_end_of_DRAM() / MAX_BOOT_MEM_RATIO)) {
+			fw_dump.reserve_bootvar = (memblock_end_of_DRAM() /
+						   MAX_BOOT_MEM_RATIO);
+			pr_info("Adjusted boot memory size to %luMB\n",
+				(fw_dump.reserve_bootvar >> 20));
+		}
+
 		return fw_dump.reserve_bootvar;
 	}
 
