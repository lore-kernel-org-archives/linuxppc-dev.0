Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQ2MZ3B2xzDrcD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 22:56:57 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u81CqiVo105359
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 08:56:53 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2569vg9jvj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Sep 2016 08:56:53 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Thu, 1 Sep 2016 09:56:51 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 35098352005F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 08:56:26 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u81CumHH4288526
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 09:56:48 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u81Cumpl031209
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 09:56:48 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: jthumshirn@suse.com, duwe@suse.com
Subject: [PATCH] powerpc: add kernel parameter iommu_alloc_quiet
Date: Thu,  1 Sep 2016 09:56:42 -0300
Message-Id: <1472734602-14330-1-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch introduces the 'iommu_alloc_quiet=driver_name' parameter
to suppress the 'iommu_alloc failures' messages for that one driver.

This is an additional approach for this 'problem' of flooding logs,
not as fine-grained and not enabled by default as DMA_ATTR_NO_WARN,
but it has the advantage that it doesn't introduce any ABI changes.

That is important/requirement for the distribution kernels - where
the DMA_ATTR_NO_WARN changes to 'enum dma_attr' are not acceptable
because it breaks the kernel ABI.

Tested on next-20160825 + nvme changed not to use DMA_ATTR_NO_WARN.

 - test-case: default / no iommu_alloc_quiet
 - result:    messages occur

    # dmesg -c | grep iommu_alloc_quiet
    #

    # dd if=/dev/zero of=/dev/nvme0n1p1 bs=64k count=128k 2>/dev/null; dmesg -c
    <...>
    [   31.753230] nvme 0000:00:06.0: iommu_alloc failed, tbl c0000003f7080c00 vaddr c00000022bf30000 npages 16

 - test-case: iommu_alloc_quiet=(null)
 - result:    messages occur

    # dmesg -c | grep iommu_alloc_quiet
    [    0.000000] Kernel command line: root=<...> ro disable_ddw iommu_alloc_quiet=
    [    0.000000] iommu_alloc_quiet: driver ''

    # dd if=/dev/zero of=/dev/nvme0n1p1 bs=64k count=128k 2>/dev/null; dmesg -c
    <...>
    [   29.032848] nvme 0000:00:06.0: iommu_alloc failed, tbl c0000003f7190c00 vaddr c000000238fc0000 npages 16

 - test-case: iommu_alloc_quiet=(length overflow)
 - result:    messages occur

    # dmesg -c | grep iommu_alloc_quiet
    [    0.000000] Kernel command line: root=<...> ro disable_ddw iommu_alloc_quiet=0123456789abcdef0123456789abcdef
    [    0.000000] iommu_alloc_quiet: driver '0123456789abcde'

    # dd if=/dev/zero of=/dev/nvme0n1p1 bs=64k count=128k 2>/dev/null; dmesg -c
    <...>
    [   54.913279] nvme 0000:00:06.0: iommu_alloc failed, tbl c0000003f7120c00 vaddr c00000022d960000 npages 16

 - test-case: iommu_alloc_quiet=nvme
 - result:    messages do not occur

    # dmesg -c | grep iommu_alloc_quiet
    [    0.000000] Kernel command line: root=<...> ro disable_ddw iommu_alloc_quiet=nvme
    [    0.000000] iommu_alloc_quiet: driver 'nvme'

    # dd if=/dev/zero of=/dev/nvme0n1p1 bs=64k count=128k 2>/dev/null; dmesg -c

    # dd if=/dev/zero of=/dev/nvme0n1p1 bs=64k count=128k 2>/dev/null; dmesg -c

    # dd if=/dev/zero of=/dev/nvme0n1p1 bs=64k count=128k 2>/dev/null; dmesg -c

    # dd if=/dev/zero of=/dev/nvme0n1p1 bs=64k count=128k 2>/dev/null; dmesg -c

    # dd if=/dev/zero of=/dev/nvme0n1p1 bs=64k count=128k 2>/dev/null; dmesg -c

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/iommu.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 5f202a5..8524d91 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -65,6 +65,23 @@ static int __init setup_iommu(char *str)
 
 __setup("iommu=", setup_iommu);
 
+/*
+ * iommu_alloc_quiet: string with one driver name
+ * not to print 'iommu_alloc failed' messages for.
+ */
+#define IOMMU_ALLOC_QUIET_LEN	16 /* includes '\0' */
+static char iommu_alloc_quiet[IOMMU_ALLOC_QUIET_LEN];
+
+static int __init setup_iommu_alloc_quiet(char *str)
+{
+	strncpy(iommu_alloc_quiet, str, IOMMU_ALLOC_QUIET_LEN);
+	iommu_alloc_quiet[IOMMU_ALLOC_QUIET_LEN - 1] = '\0';
+	pr_info("iommu_alloc_quiet: driver '%s'\n", iommu_alloc_quiet);
+	return 1;
+}
+
+__setup("iommu_alloc_quiet=", setup_iommu_alloc_quiet);
+
 static DEFINE_PER_CPU(unsigned int, iommu_pool_hash);
 
 /*
@@ -479,8 +496,8 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 
 		/* Handle failure */
 		if (unlikely(entry == DMA_ERROR_CODE)) {
-			if (!(attrs & DMA_ATTR_NO_WARN) &&
-			    printk_ratelimit())
+			if (strncmp(iommu_alloc_quiet, dev->driver->name, IOMMU_ALLOC_QUIET_LEN) &&
+			    !(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 				dev_info(dev, "iommu_alloc failed, tbl %p "
 					 "vaddr %lx npages %lu\n", tbl, vaddr,
 					 npages);
@@ -777,8 +794,8 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 					 mask >> tbl->it_page_shift, align,
 					 attrs);
 		if (dma_handle == DMA_ERROR_CODE) {
-			if (!(attrs & DMA_ATTR_NO_WARN) &&
-			    printk_ratelimit())  {
+			if (strncmp(iommu_alloc_quiet, dev->driver->name, IOMMU_ALLOC_QUIET_LEN) &&
+			    !(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit()) {
 				dev_info(dev, "iommu_alloc failed, tbl %p "
 					 "vaddr %p npages %d\n", tbl, vaddr,
 					 npages);
-- 
1.8.3.1
