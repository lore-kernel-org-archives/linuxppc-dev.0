Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xmqs0C7ZzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 02:26:16 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7OGNqkA059743
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 12:26:15 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m2mry1w3y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 12:26:14 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Fri, 24 Aug 2018 10:26:13 -0600
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Anshuman Khandual <anshuman.linux@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christoph Hellwig <hch@lst.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Mike Anderson <andmike@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ram Pai <linuxram@us.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH 04/11] powerpc/svm: Convert SWIOTLB buffers to shared
 memory
Date: Fri, 24 Aug 2018 13:25:28 -0300
In-Reply-To: <20180824162535.22798-1-bauerman@linux.ibm.com>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
Message-Id: <20180824162535.22798-5-bauerman@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Hook the shared memory conversion functions into the ARCH_HAS_MEM_ENCRYPT
framework and call swiotlb_update_mem_attributes() to convert SWIOTLB's
buffers to shared memory.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/Kconfig                   |  4 ++++
 arch/powerpc/include/asm/mem_encrypt.h | 19 +++++++++++++++++++
 arch/powerpc/kernel/svm.c              | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 90f73d15f58a..1466d1234723 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -440,12 +440,16 @@ config MATH_EMULATION_HW_UNIMPLEMENTED
 
 endchoice
 
+config ARCH_HAS_MEM_ENCRYPT
+	def_bool n
+
 config PPC_SVM
        bool "Secure virtual machine (SVM) support for POWERPC"
        default n
        depends on PPC_PSERIES
        select DMA_DIRECT_OPS
        select SWIOTLB
+       select ARCH_HAS_MEM_ENCRYPT
        help
          Support secure guests on POWERPC. There are certain POWER platforms
 	 which support secure guests with the help of an Ultravisor executing
diff --git a/arch/powerpc/include/asm/mem_encrypt.h b/arch/powerpc/include/asm/mem_encrypt.h
new file mode 100644
index 000000000000..2b6e37ea446c
--- /dev/null
+++ b/arch/powerpc/include/asm/mem_encrypt.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SVM helper functions
+ *
+ * Copyright 2018 IBM Corporation
+ */
+
+#ifndef _ASM_POWERPC_MEM_ENCRYPT_H
+#define _ASM_POWERPC_MEM_ENCRYPT_H
+
+#define sme_me_mask	0ULL
+
+static inline bool sme_active(void) { return false; }
+static inline bool sev_active(void) { return false; }
+
+int set_memory_encrypted(unsigned long addr, int numpages);
+int set_memory_decrypted(unsigned long addr, int numpages);
+
+#endif /* _ASM_POWERPC_MEM_ENCRYPT_H */
diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
index 37437cf92df5..eab2a64d8643 100644
--- a/arch/powerpc/kernel/svm.c
+++ b/arch/powerpc/kernel/svm.c
@@ -7,6 +7,20 @@
  */
 
 #include <linux/mm.h>
+#include <linux/swiotlb.h>
+#include <asm/machdep.h>
+#include <asm/svm.h>
+
+static int __init init_svm(void)
+{
+	if (!is_svm_platform())
+		return 0;
+
+	swiotlb_update_mem_attributes();
+
+	return 0;
+}
+machine_early_initcall(pseries, init_svm);
 
 void mem_convert_shared(unsigned long pfn, unsigned long npages)
 {
@@ -31,3 +45,23 @@ void mem_convert_secure(unsigned long pfn, unsigned long npages)
 	 * ucall_convert_secure(paddr, size)
 	 */
 }
+
+int set_memory_encrypted(unsigned long addr, int numpages)
+{
+	if (!PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	mem_convert_secure(PHYS_PFN(__pa(addr)), numpages);
+
+	return 0;
+}
+
+int set_memory_decrypted(unsigned long addr, int numpages)
+{
+	if (!PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	mem_convert_shared(PHYS_PFN(__pa(addr)), numpages);
+
+	return 0;
+}
