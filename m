Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xmql4m2CzDqx4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 02:26:11 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7OGNqSw059744
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 12:26:09 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m2mry1w1x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 12:26:09 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Fri, 24 Aug 2018 10:26:08 -0600
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
Subject: [RFC PATCH 03/11] powerpc/svm: Add memory conversion (shared/secure)
 helper functions
Date: Fri, 24 Aug 2018 13:25:27 -0300
In-Reply-To: <20180824162535.22798-1-bauerman@linux.ibm.com>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
Message-Id: <20180824162535.22798-4-bauerman@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Add the following helper functions to convert PAGE_SIZE aligned memory
buffers as shared or secure (i.e., accessible to the hypervisor or not) via
Ultravisor calls.

1. mem_convert_shared(unsigned long pfn, unsigned long npages)
2. mem_convert_secure(unsigned long pfn, unsigned long npages)

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/svm.h |  3 +++
 arch/powerpc/kernel/Makefile   |  1 +
 arch/powerpc/kernel/svm.c      | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/powerpc/include/asm/svm.h b/arch/powerpc/include/asm/svm.h
index 6f89e5d6d37f..95d69e472e52 100644
--- a/arch/powerpc/include/asm/svm.h
+++ b/arch/powerpc/include/asm/svm.h
@@ -13,6 +13,9 @@ static bool is_svm_platform(void)
 {
 	return mfmsr() & MSR_S;
 }
+
+extern void mem_convert_shared(unsigned long pfn, unsigned long npages);
+extern void mem_convert_secure(unsigned long pfn, unsigned long npages);
 #else
 static inline bool is_svm_platform(void)
 {
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2b4c40b255e4..98780b4e924c 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -113,6 +113,7 @@ ifeq ($(CONFIG_HAVE_IMA_KEXEC)$(CONFIG_IMA),yy)
 obj-y				+= ima_kexec.o
 endif
 
+obj-$(CONFIG_PPC_SVM)		+= svm.o
 obj-$(CONFIG_AUDIT)		+= audit.o
 obj64-$(CONFIG_AUDIT)		+= compat_audit.o
 
diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
new file mode 100644
index 000000000000..37437cf92df5
--- /dev/null
+++ b/arch/powerpc/kernel/svm.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Secure VM platform
+ *
+ * Copyright 2018 IBM Corporation
+ * Author: Anshuman Khandual <khandual@linux.vnet.ibm.com>
+ */
+
+#include <linux/mm.h>
+
+void mem_convert_shared(unsigned long pfn, unsigned long npages)
+{
+	if (!pfn_valid(pfn))
+		return;
+
+	/*
+	 * FIXME: Insert real UV call when ready
+	 *
+	 * ucall_convert_shared(paddr, size)
+	 */
+}
+
+void mem_convert_secure(unsigned long pfn, unsigned long npages)
+{
+	if (!pfn_valid(pfn))
+		return;
+
+	/*
+	 * FIXME: Insert real UV call when ready
+	 *
+	 * ucall_convert_secure(paddr, size)
+	 */
+}
