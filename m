Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xmqZ6nkMzDqrV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 02:26:02 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7OGNqeC098655
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 12:26:01 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m2msq9k7g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 12:26:00 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Fri, 24 Aug 2018 10:25:59 -0600
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
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH 01/11] powerpc/svm: Detect Secure Virtual Machine (SVM)
 platform
Date: Fri, 24 Aug 2018 13:25:25 -0300
In-Reply-To: <20180824162535.22798-1-bauerman@linux.ibm.com>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
Message-Id: <20180824162535.22798-2-bauerman@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

A guest requests to be moved to secure memory early at the kernel
startup (in prom_init). Define a flag that can be easily checked by other
parts of the kernel so that they can set things up accordingly. This is
done by checking the MSR(S) bit, which is always set for secure VMs.

Also add a new config option CONFIG_PPC_SVM to wrap all these code to
prevent it from being executed from non subscribing platforms. This SVM
platform detection is applicable only to guest kernels that will run under
an Ultravisor as a secure guest.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/Kconfig           | 11 +++++++++++
 arch/powerpc/include/asm/reg.h |  3 +++
 arch/powerpc/include/asm/svm.h | 22 ++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9f2b75fe2c2d..f786c962edf0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -440,6 +440,17 @@ config MATH_EMULATION_HW_UNIMPLEMENTED
 
 endchoice
 
+config PPC_SVM
+       bool "Secure virtual machine (SVM) support for POWERPC"
+       default n
+       depends on PPC_PSERIES
+       help
+         Support secure guests on POWERPC. There are certain POWER platforms
+	 which support secure guests with the help of an Ultravisor executing
+	 below the hypervisor layer. This enables the support for those guests.
+
+	 If unsure, say "N".
+
 config PPC_TRANSACTIONAL_MEM
        bool "Transactional Memory support for POWERPC"
        depends on PPC_BOOK3S_64
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 562568414cf4..fcf7b79356d0 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -36,6 +36,7 @@
 #define MSR_TM_LG	32		/* Trans Mem Available */
 #define MSR_VEC_LG	25	        /* Enable AltiVec */
 #define MSR_VSX_LG	23		/* Enable VSX */
+#define MSR_S_LG	22		/* Secure VM bit */
 #define MSR_POW_LG	18		/* Enable Power Management */
 #define MSR_WE_LG	18		/* Wait State Enable */
 #define MSR_TGPR_LG	17		/* TLB Update registers in use */
@@ -69,11 +70,13 @@
 #define MSR_SF		__MASK(MSR_SF_LG)	/* Enable 64 bit mode */
 #define MSR_ISF		__MASK(MSR_ISF_LG)	/* Interrupt 64b mode valid on 630 */
 #define MSR_HV 		__MASK(MSR_HV_LG)	/* Hypervisor state */
+#define MSR_S 		__MASK(MSR_S_LG)	/* Secure state */
 #else
 /* so tests for these bits fail on 32-bit */
 #define MSR_SF		0
 #define MSR_ISF		0
 #define MSR_HV		0
+#define MSR_S		0
 #endif
 
 /*
diff --git a/arch/powerpc/include/asm/svm.h b/arch/powerpc/include/asm/svm.h
new file mode 100644
index 000000000000..6f89e5d6d37f
--- /dev/null
+++ b/arch/powerpc/include/asm/svm.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SVM helper functions
+ *
+ * Copyright 2018 Anshuman Khandual, IBM Corporation.
+ */
+
+#ifndef _ASM_POWERPC_SVM_H
+#define _ASM_POWERPC_SVM_H
+
+#ifdef CONFIG_PPC_SVM
+static bool is_svm_platform(void)
+{
+	return mfmsr() & MSR_S;
+}
+#else
+static inline bool is_svm_platform(void)
+{
+	return false;
+}
+#endif
+#endif /* _ASM_POWERPC_SVM_H */
