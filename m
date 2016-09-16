Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbBcy3VQJzDsdH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:18 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8GAbc5R062998
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 06:40:16 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25ftr8ew8f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 06:40:16 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 16 Sep 2016 20:40:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7E9E32BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:09 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8GAe94n26607762
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:09 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8GAe8ih000828
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:09 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, benh@kernel.crashing.org,
 gwshan@linux.vnet.ibm.com
Subject: [RFC 2/3] powerpc/powernv: add opal_pci_get_phb_capi_mode() call
Date: Fri, 16 Sep 2016 20:39:45 +1000
In-Reply-To: <cover.303079d6fcc8cba76e4648314eee9a30def3d969.1474022276.git-series.andrew.donnellan@au1.ibm.com>
References: <cover.303079d6fcc8cba76e4648314eee9a30def3d969.1474022276.git-series.andrew.donnellan@au1.ibm.com>
In-Reply-To: <cover.303079d6fcc8cba76e4648314eee9a30def3d969.1474022276.git-series.andrew.donnellan@au1.ibm.com>
References: <cover.303079d6fcc8cba76e4648314eee9a30def3d969.1474022276.git-series.andrew.donnellan@au1.ibm.com>
Message-Id: <c1566d41802d5ebec3c9d5cbe7195f74c0877dca.1474022276.git-series.andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

opal_pci_get_phb_capi_mode() returns OPAL_PHB_CAPI_MODE_CAPI if the PHB is
in CAPI mode, and OPAL_PHB_CAPI_MODE_PCIE if it isn't.

We're going to use this call to determine if a PHB requires a complete
reset during initialisation in order to disable CAPI mode (on sufficiently
new skiboots that support this).

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Corresponding skiboot RFC: http://patchwork.ozlabs.org/patch/670781/
---
 arch/powerpc/include/asm/opal-api.h            | 3 ++-
 arch/powerpc/include/asm/opal.h                | 1 +
 arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0e2e57b..078ce77 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -167,7 +167,8 @@
 #define OPAL_INT_EOI				124
 #define OPAL_INT_SET_MFRR			125
 #define OPAL_PCI_TCE_KILL			126
-#define OPAL_LAST				126
+#define OPAL_PCI_GET_PHB_CAPI_MODE		128
+#define OPAL_LAST				128
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ee05bd2..501d32a 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -228,6 +228,7 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 int64_t opal_rm_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 			     uint32_t pe_num, uint32_t tce_size,
 			     uint64_t dma_addr, uint32_t npages);
+int64_t opal_pci_get_phb_capi_mode(uint64_t phb_id);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3d29d40..338d034 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -308,3 +308,4 @@ OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
 OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
+OPAL_CALL(opal_pci_get_phb_capi_mode,		OPAL_PCI_GET_PHB_CAPI_MODE);
-- 
git-series 0.8.10
