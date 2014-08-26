Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F7B01A077F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 17:56:39 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 26 Aug 2014 13:26:36 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 92AB9394005C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 13:26:32 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7Q7uuEs57278560
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 13:26:56 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7Q7uSxA025486
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 13:26:28 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc/powernv: Sync header with firmware
Date: Tue, 26 Aug 2014 17:56:16 +1000
Message-Id: <1409039779-392-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1409039779-392-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1409039779-392-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: qiudayu@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mike Qiu <qiudayu@linux.vnet.ibm.com>

The patch synchronizes firmware header file (opal.h) for PCI error
injection.

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                | 30 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 2 files changed, 31 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 4593a93..9113653 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -148,6 +148,7 @@ struct opal_sg_list {
 #define OPAL_SET_PARAM				90
 #define OPAL_DUMP_RESEND			91
 #define OPAL_DUMP_INFO2				94
+#define OPAL_PCI_ERR_INJCT			96
 #define OPAL_PCI_EEH_FREEZE_SET			97
 #define OPAL_HANDLE_HMI				98
 #define OPAL_REGISTER_DUMP_REGION		101
@@ -200,6 +201,33 @@ enum OpalPciErrorSeverity {
 	OPAL_EEH_SEV_INF	= 5
 };
 
+enum OpalErrinjctType {
+	OpalErrinjctTypeIoaBusError	= 0,
+	OpalErrinjctTypeIoaBusError64	= 1,
+
+	/* IoaBusError & IoaBusError64 */
+	OpalEjtIoaLoadMemAddr		= 0,
+	OpalEjtIoaLoadMemData		= 1,
+	OpalEjtIoaLoadIoAddr		= 2,
+	OpalEjtIoaLoadIoData		= 3,
+	OpalEjtIoaLoadConfigAddr	= 4,
+	OpalEjtIoaLoadConfigData	= 5,
+	OpalEjtIoaStoreMemAddr		= 6,
+	OpalEjtIoaStoreMemData		= 7,
+	OpalEjtIoaStoreIoAddr		= 8,
+	OpalEjtIoaStoreIoData		= 9,
+	OpalEjtIoaStoreConfigAddr	= 10,
+	OpalEjtIoaStoreConfigData	= 11,
+	OpalEjtIoaDmaReadMemAddr	= 12,
+	OpalEjtIoaDmaReadMemData	= 13,
+	OpalEjtIoaDmaReadMemMaster	= 14,
+	OpalEjtIoaDmaReadMemTarget	= 15,
+	OpalEjtIoaDmaWriteMemAddr	= 16,
+	OpalEjtIoaDmaWriteMemData	= 17,
+	OpalEjtIoaDmaWriteMemMaster	= 18,
+	OpalEjtIoaDmaWriteMemTarget	= 19,
+};
+
 enum OpalShpcAction {
 	OPAL_SHPC_GET_LINK_STATE = 0,
 	OPAL_SHPC_GET_SLOT_STATE = 1
@@ -825,6 +853,8 @@ int64_t opal_pci_eeh_freeze_clear(uint64_t phb_id, uint64_t pe_number,
 				  uint64_t eeh_action_token);
 int64_t opal_pci_eeh_freeze_set(uint64_t phb_id, uint64_t pe_number,
 				uint64_t eeh_action_token);
+int64_t opal_pci_err_inject(uint64_t phb_id, uint32_t pe_no, uint32_t type,
+			    uint32_t function, uint64_t addr, uint64_t mask);
 int64_t opal_pci_shpc(uint64_t phb_id, uint64_t shpc_action, uint8_t *state);
 
 
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 5718855..9c68501 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -184,6 +184,7 @@ OPAL_CALL(opal_register_exception_handler,	OPAL_REGISTER_OPAL_EXCEPTION_HANDLER)
 OPAL_CALL(opal_pci_eeh_freeze_status,		OPAL_PCI_EEH_FREEZE_STATUS);
 OPAL_CALL(opal_pci_eeh_freeze_clear,		OPAL_PCI_EEH_FREEZE_CLEAR);
 OPAL_CALL(opal_pci_eeh_freeze_set,		OPAL_PCI_EEH_FREEZE_SET);
+OPAL_CALL(opal_pci_err_inject,			OPAL_PCI_ERR_INJCT);
 OPAL_CALL(opal_pci_shpc,			OPAL_PCI_SHPC);
 OPAL_CALL(opal_pci_phb_mmio_enable,		OPAL_PCI_PHB_MMIO_ENABLE);
 OPAL_CALL(opal_pci_set_phb_mem_window,		OPAL_PCI_SET_PHB_MEM_WINDOW);
-- 
1.8.3.2
