Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C29EB1A1146
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 10:21:15 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v2 04/21] powerpc: Add cxl context to device archdata
Date: Tue, 26 May 2015 10:20:01 +1000
Message-Id: <1432599618-26844-5-git-send-email-mikey@neuling.org>
In-Reply-To: <1432599618-26844-1-git-send-email-mikey@neuling.org>
References: <1432599618-26844-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add cxl context pointer to archdata.  We'll want to create one of these for cxl
PCI devices.  Put them here until we can get a pci_dev specific private data.

This location was suggested by benh.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/device.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 9f1371b..e9bdda8 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -46,6 +46,9 @@ struct dev_archdata {
 #ifdef CONFIG_FAIL_IOMMU
 	int fail_iommu;
 #endif
+#ifdef CONFIG_CXL_BASE
+	struct cxl_context	*cxl_ctx;
+#endif
 };
 
 struct pdev_archdata {
-- 
2.1.0
