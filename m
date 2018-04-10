Return-Path: <srs0=vlyx=g7=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40L7cb3KkLzDqfk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 23:41:32 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40L7cS1jslz8sys
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 23:41:28 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40L7cP4LgPz9s3B
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2018 23:41:24 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3ADdHgL014649
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2018 09:41:23 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h8w114cgv-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2018 09:41:22 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 10 Apr 2018 14:41:20 +0100
Subject: [PATCH v2 1/2] powerpc/fadump: exclude memory holes while reserving
 memory in second kernel
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2018 19:11:16 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152336766167.8374.13811759102783227353.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The second kernel, during early boot after the crash, reserves rest of
the memory above boot memory size to make sure it does not touch any of the
dump memory area. It uses memblock_reserve() that reserves the specified
memory region irrespective of memory holes present within that region.
There are chances where previous kernel would have hot removed some of
its memory leaving memory holes behind. In such cases fadump kernel reports
incorrect number of reserved pages through arch_reserved_kernel_pages()
hook causing kernel to hang or panic.

Fix this by excluding memory holes while reserving rest of the memory
above boot memory size during second kernel boot after crash.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

Changes in v2:
* Split crash dump memory reservation into a separate function.



 arch/powerpc/kernel/fadump.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 3c2c268..bea8d5f 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -335,6 +335,26 @@ static unsigned long get_fadump_area_size(void)
 	return size;
 }
 
+static void __init fadump_reserve_crash_area(unsigned long base,
+					     unsigned long size)
+{
+	struct memblock_region *reg;
+	unsigned long mstart, mend, msize;
+
+	for_each_memblock(memory, reg) {
+		mstart = max_t(unsigned long, base, reg->base);
+		mend = reg->base + reg->size;
+		mend = min(base + size, mend);
+
+		if (mstart < mend) {
+			msize = mend - mstart;
+			memblock_reserve(mstart, msize);
+			pr_info("Reserved %ldMB of memory at %#016lx for saving crash dump\n",
+				(msize >> 20), mstart);
+		}
+	}
+}
+
 int __init fadump_reserve_mem(void)
 {
 	unsigned long base, size, memory_boundary;
@@ -380,7 +400,8 @@ int __init fadump_reserve_mem(void)
 		memory_boundary = memblock_end_of_DRAM();
 
 	if (fw_dump.dump_active) {
-		printk(KERN_INFO "Firmware-assisted dump is active.\n");
+		pr_info("Firmware-assisted dump is active.\n");
+
 		/*
 		 * If last boot has crashed then reserve all the memory
 		 * above boot_memory_size so that we don't touch it until
@@ -389,11 +410,7 @@ int __init fadump_reserve_mem(void)
 		 */
 		base = fw_dump.boot_memory_size;
 		size = memory_boundary - base;
-		memblock_reserve(base, size);
-		printk(KERN_INFO "Reserved %ldMB of memory at %ldMB "
-				"for saving crash dump\n",
-				(unsigned long)(size >> 20),
-				(unsigned long)(base >> 20));
+		fadump_reserve_crash_area(base, size);
 
 		fw_dump.fadumphdr_addr =
 				be64_to_cpu(fdm_active->rmr_region.destination_address) +
