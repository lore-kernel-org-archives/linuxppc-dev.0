Return-Path: <rcjenn@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 266B8DE245
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Aug 2008 06:17:37 +1000 (EST)
Received: from e5.ny.us.ibm.com ([192.168.1.105])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m7FJ88wZ001223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:08:10 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7FJ7t0S024641
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:07:55 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7FJ7VE2150630
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:07:31 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7FJ7VM3018137
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:07:31 -0400
Date: Fri, 15 Aug 2008 14:07:31 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc: make CMO paging space pool ID and page size
	available
Message-ID: <20080815190730.GB20629@austin.ibm.com>
References: <20080815190230.GA20629@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080815190230.GA20629@austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

During platform setup, save off the primary/secondary paging space pool IDs
and the page size.  Added accessors in hvcall.h for these variables.

Submitted-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 arch/powerpc/include/asm/hvcall.h      |   21 +++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c |   28 ++++++++++++++++++++--------
 2 files changed, 41 insertions(+), 8 deletions(-)

Index: b/arch/powerpc/include/asm/hvcall.h
===================================================================
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -292,6 +292,27 @@ struct hvcall_mpp_data {
 
 int h_get_mpp(struct hvcall_mpp_data *);
 
+#ifdef CONFIG_PPC_PSERIES
+extern int CMO_PrPSP;
+extern int CMO_SecPSP;
+extern unsigned long CMO_PageSize;
+
+static inline int cmo_get_primary_psp(void)
+{
+	return CMO_PrPSP;
+}
+
+static inline int cmo_get_secondary_psp(void)
+{
+	return CMO_SecPSP;
+}
+
+static inline unsigned long cmo_get_page_size(void)
+{
+	return CMO_PageSize;
+}
+#endif /* CONFIG_PPC_PSERIES */
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_HVCALL_H */
Index: b/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -68,6 +68,9 @@
 #include "plpar_wrappers.h"
 #include "pseries.h"
 
+int CMO_PrPSP = -1;
+int CMO_SecPSP = -1;
+unsigned long CMO_PageSize = (ASM_CONST(1) << IOMMU_PAGE_SHIFT);
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
 
@@ -325,8 +328,7 @@ void pSeries_cmo_feature_init(void)
 {
 	char *ptr, *key, *value, *end;
 	int call_status;
-	int PrPSP = -1;
-	int SecPSP = -1;
+	int page_order = IOMMU_PAGE_SHIFT;
 
 	pr_debug(" -> fw_cmo_feature_init()\n");
 	spin_lock(&rtas_data_buf_lock);
@@ -365,21 +367,31 @@ void pSeries_cmo_feature_init(void)
 				break;
 			}
 
-			if (0 == strcmp(key, "PrPSP"))
-				PrPSP = simple_strtol(value, NULL, 10);
+			if (0 == strcmp(key, "CMOPageSize"))
+				page_order = simple_strtol(value, NULL, 10);
+			else if (0 == strcmp(key, "PrPSP"))
+				CMO_PrPSP = simple_strtol(value, NULL, 10);
 			else if (0 == strcmp(key, "SecPSP"))
-				SecPSP = simple_strtol(value, NULL, 10);
+				CMO_SecPSP = simple_strtol(value, NULL, 10);
 			value = key = ptr + 1;
 		}
 		ptr++;
 	}
 
-	if (PrPSP != -1 || SecPSP != -1) {
+	/* Page size is returned as the power of 2 of the page size,
+	 * convert to the page size in bytes before returning
+	 */
+	CMO_PageSize = 1 << page_order;
+	pr_debug("CMO_PageSize = %lu\n", CMO_PageSize);
+
+	if (CMO_PrPSP != -1 || CMO_SecPSP != -1) {
 		pr_info("CMO enabled\n");
-		pr_debug("CMO enabled, PrPSP=%d, SecPSP=%d\n", PrPSP, SecPSP);
+		pr_debug("CMO enabled, PrPSP=%d, SecPSP=%d\n", CMO_PrPSP,
+		         CMO_SecPSP);
 		powerpc_firmware_features |= FW_FEATURE_CMO;
 	} else
-		pr_debug("CMO not enabled, PrPSP=%d, SecPSP=%d\n", PrPSP, SecPSP);
+		pr_debug("CMO not enabled, PrPSP=%d, SecPSP=%d\n", CMO_PrPSP,
+		         CMO_SecPSP);
 	spin_unlock(&rtas_data_buf_lock);
 	pr_debug(" <- fw_cmo_feature_init()\n");
 }
