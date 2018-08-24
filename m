Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xmr92QZkzDqn2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 02:26:33 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7OGNv8Q176950
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 12:26:30 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m2ms41yum-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 12:26:30 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Fri, 24 Aug 2018 10:26:29 -0600
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
Subject: [RFC PATCH 07/11] powerpc/svm: Use shared memory for Debug Trace Log
 (DTL)
Date: Fri, 24 Aug 2018 13:25:31 -0300
In-Reply-To: <20180824162535.22798-1-bauerman@linux.ibm.com>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
Message-Id: <20180824162535.22798-8-bauerman@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

On Ultravisor platform kmem_cache for DTL buffers must use a constructor
function which converts the underlying buddy allocated SLUB cache pages
into shared memory so that they are accessible to the hypervisor.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/svm.h         |  1 +
 arch/powerpc/kernel/svm.c              | 30 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c |  5 ++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/svm.h b/arch/powerpc/include/asm/svm.h
index 95d69e472e52..e00688761704 100644
--- a/arch/powerpc/include/asm/svm.h
+++ b/arch/powerpc/include/asm/svm.h
@@ -16,6 +16,7 @@ static bool is_svm_platform(void)
 
 extern void mem_convert_shared(unsigned long pfn, unsigned long npages);
 extern void mem_convert_secure(unsigned long pfn, unsigned long npages);
+extern void dtl_cache_ctor(void *addr);
 #else
 static inline bool is_svm_platform(void)
 {
diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
index 891db2de8c04..1af5caa955f5 100644
--- a/arch/powerpc/kernel/svm.c
+++ b/arch/powerpc/kernel/svm.c
@@ -66,3 +66,33 @@ int set_memory_decrypted(unsigned long addr, int numpages)
 
 	return 0;
 }
+
+/* There's one dispatch log per CPU. */
+#define NR_DTL_PAGE (DISPATCH_LOG_BYTES * CONFIG_NR_CPUS / PAGE_SIZE)
+
+static struct page *dtl_page_store[NR_DTL_PAGE];
+static long dtl_nr_pages;
+
+static bool is_dtl_page_shared(struct page *page)
+{
+	long i;
+
+	for (i = 0; i < dtl_nr_pages; i++)
+		if (dtl_page_store[i] == page)
+			return true;
+
+	return false;
+}
+
+void dtl_cache_ctor(void *addr)
+{
+	unsigned long pfn = PHYS_PFN(__pa(addr));
+	struct page *page = pfn_to_page(pfn);
+
+	if (!is_dtl_page_shared(page)) {
+		dtl_page_store[dtl_nr_pages] = page;
+		dtl_nr_pages++;
+		WARN_ON(dtl_nr_pages >= NR_DTL_PAGE);
+		mem_convert_shared(pfn, PAGE_SIZE);
+	}
+}
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 139f0af6c3d9..50ba77c802d2 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -69,6 +69,7 @@
 #include <asm/kexec.h>
 #include <asm/isa-bridge.h>
 #include <asm/security_features.h>
+#include <asm/svm.h>
 
 #include "pseries.h"
 
@@ -288,8 +289,10 @@ static inline int alloc_dispatch_logs(void)
 
 static int alloc_dispatch_log_kmem_cache(void)
 {
+	void (*ctor)(void *) = is_svm_platform() ? dtl_cache_ctor : NULL;
+
 	dtl_cache = kmem_cache_create("dtl", DISPATCH_LOG_BYTES,
-						DISPATCH_LOG_BYTES, 0, NULL);
+						DISPATCH_LOG_BYTES, 0, ctor);
 	if (!dtl_cache) {
 		pr_warn("Failed to create dispatch trace log buffer cache\n");
 		pr_warn("Stolen time statistics will be unreliable\n");
