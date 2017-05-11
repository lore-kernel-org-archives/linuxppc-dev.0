Return-Path: <srs0=8qzd=4r=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wP32z4N4szDqfm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 05:24:59 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wP32z3sKbz8sx7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 05:24:59 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wP32y6ppnz9s3s
 for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2017 05:24:58 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4BJO6hK140470
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 15:24:56 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2actxtfxpn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 15:24:56 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 12 May 2017 05:24:53 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4BJOg7t5177776
 for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2017 05:24:50 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4BJOGFs026608
 for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2017 05:24:17 +1000
Subject: [PATCH v2 3/3] powerpc/fadump: provide a helpful error message
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Pingfan Liu <piliu@redhat.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 12 May 2017 00:53:58 +0530
In-Reply-To: <149453053109.32468.3382678673815454269.stgit@hbathini.in.ibm.com>
References: <149453053109.32468.3382678673815454269.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149453062910.32468.5568998057663345872.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fadump fails to register when there are holes in boot memory area.
Provide a helpful error message to the user in such case.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

Changes since v1:
* Introducing this patch to provide better error message on failure.


 arch/powerpc/kernel/fadump.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4ba7db9..b1aaa8d 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -130,6 +130,38 @@ int is_fadump_active(void)
 	return fw_dump.dump_active;
 }
 
+/*
+ * Returns 1, if there are no holes in boot memory area,
+ * 0 otherwise.
+ */
+static int is_boot_memory_area_contiguous(void)
+{
+	struct memblock_region *reg;
+	unsigned long tstart, tend;
+	unsigned long start_pfn = PHYS_PFN(RMA_START);
+	unsigned long end_pfn = PHYS_PFN(RMA_START + fw_dump.boot_memory_size);
+	unsigned int ret = 0;
+
+	for_each_memblock(memory, reg) {
+		tstart = max(start_pfn, memblock_region_memory_base_pfn(reg));
+		tend = min(end_pfn, memblock_region_memory_end_pfn(reg));
+		if (tstart < tend) {
+			/* Memory hole from start_pfn to tstart */
+			if (tstart > start_pfn)
+				break;
+
+			if (tend == end_pfn) {
+				ret = 1;
+				break;
+			}
+
+			start_pfn = tend + 1;
+		}
+	}
+
+	return ret;
+}
+
 /* Print firmware assisted dump configurations for debugging purpose. */
 static void fadump_show_config(void)
 {
@@ -414,6 +446,10 @@ static void register_fw_dump(struct fadump_mem_struct *fdm)
 			" dump. Hardware Error(%d).\n", rc);
 		break;
 	case -3:
+		if (!is_boot_memory_area_contiguous())
+			pr_err("Can't have holes in boot memory area while "
+			       "registering fadump\n");
+
 		printk(KERN_ERR "Failed to register firmware-assisted kernel"
 			" dump. Parameter Error(%d).\n", rc);
 		break;
