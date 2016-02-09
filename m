Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F9CB1A0191
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 15:51:37 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 9 Feb 2016 14:51:36 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D67F13578054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 15:51:32 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u194pNvu47841416
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 15:51:31 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u194p0MD023205
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 15:51:00 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 4/4] powerpc/powernv: Simplify definitions of EEH debugfs
 handlers
Date: Tue,  9 Feb 2016 15:50:24 +1100
Message-Id: <1454993431-17068-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1454993431-17068-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1454993431-17068-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The EEH debugfs handlers have same prototype. This introduces
a macro to define them, then to simplify the code. No logical
changes.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 60 ++++++++++------------------
 1 file changed, 22 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 87f47e5..8119172 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -167,42 +167,26 @@ static int pnv_eeh_dbgfs_get(void *data, int offset, u64 *val)
 	return 0;
 }
 
-static int pnv_eeh_outb_dbgfs_set(void *data, u64 val)
-{
-	return pnv_eeh_dbgfs_set(data, 0xD10, val);
-}
-
-static int pnv_eeh_outb_dbgfs_get(void *data, u64 *val)
-{
-	return pnv_eeh_dbgfs_get(data, 0xD10, val);
-}
-
-static int pnv_eeh_inbA_dbgfs_set(void *data, u64 val)
-{
-	return pnv_eeh_dbgfs_set(data, 0xD90, val);
-}
-
-static int pnv_eeh_inbA_dbgfs_get(void *data, u64 *val)
-{
-	return pnv_eeh_dbgfs_get(data, 0xD90, val);
-}
-
-static int pnv_eeh_inbB_dbgfs_set(void *data, u64 val)
-{
-	return pnv_eeh_dbgfs_set(data, 0xE10, val);
-}
-
-static int pnv_eeh_inbB_dbgfs_get(void *data, u64 *val)
-{
-	return pnv_eeh_dbgfs_get(data, 0xE10, val);
-}
+#define PNV_EEH_DBGFS_ENTRY(name, reg)				\
+static int pnv_eeh_dbgfs_set_##name(void *data, u64 val)	\
+{								\
+	return pnv_eeh_dbgfs_set(data, reg, val);		\
+}								\
+								\
+static int pnv_eeh_dbgfs_get_##name(void *data, u64 *val)	\
+{								\
+	return pnv_eeh_dbgfs_get(data, reg, val);		\
+}								\
+								\
+DEFINE_SIMPLE_ATTRIBUTE(pnv_eeh_dbgfs_ops_##name,		\
+			pnv_eeh_dbgfs_get_##name,		\
+                        pnv_eeh_dbgfs_set_##name,		\
+			"0x%llx\n")
+
+PNV_EEH_DBGFS_ENTRY(outb, 0xD10);
+PNV_EEH_DBGFS_ENTRY(inbA, 0xD90);
+PNV_EEH_DBGFS_ENTRY(inbB, 0xE10);
 
-DEFINE_SIMPLE_ATTRIBUTE(pnv_eeh_outb_dbgfs_ops, pnv_eeh_outb_dbgfs_get,
-			pnv_eeh_outb_dbgfs_set, "0x%llx\n");
-DEFINE_SIMPLE_ATTRIBUTE(pnv_eeh_inbA_dbgfs_ops, pnv_eeh_inbA_dbgfs_get,
-			pnv_eeh_inbA_dbgfs_set, "0x%llx\n");
-DEFINE_SIMPLE_ATTRIBUTE(pnv_eeh_inbB_dbgfs_ops, pnv_eeh_inbB_dbgfs_get,
-			pnv_eeh_inbB_dbgfs_set, "0x%llx\n");
 #endif /* CONFIG_DEBUG_FS */
 
 /**
@@ -268,13 +252,13 @@ static int pnv_eeh_post_init(void)
 
 		debugfs_create_file("err_injct_outbound", 0600,
 				    phb->dbgfs, hose,
-				    &pnv_eeh_outb_dbgfs_ops);
+				    &pnv_eeh_dbgfs_ops_outb);
 		debugfs_create_file("err_injct_inboundA", 0600,
 				    phb->dbgfs, hose,
-				    &pnv_eeh_inbA_dbgfs_ops);
+				    &pnv_eeh_dbgfs_ops_inbA);
 		debugfs_create_file("err_injct_inboundB", 0600,
 				    phb->dbgfs, hose,
-				    &pnv_eeh_inbB_dbgfs_ops);
+				    &pnv_eeh_dbgfs_ops_inbB);
 #endif /* CONFIG_DEBUG_FS */
 	}
 
-- 
2.1.0
