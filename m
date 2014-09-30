Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 852941A076F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:18 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 12:39:16 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E7EE33578048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:13 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8U2f0Fv34930806
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:41:00 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8U2dDM4007790
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:13 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/21] powerpc/powernv: Sync header with firmware
Date: Tue, 30 Sep 2014 12:38:55 +1000
Message-Id: <1412044750-24460-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Mike Qiu <qiudayu@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch synchronizes firmware header file (opal.h) for PCI error
injection.

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v2: Seperate enum error type and function and adjust the names
    according to mpe's suggestion. Also replacing "injct" with
    "inject"
---
 arch/powerpc/include/asm/opal.h                | 32 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 2 files changed, 33 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 7127b87..f157941 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -148,6 +148,7 @@ struct opal_sg_list {
 #define OPAL_SET_PARAM				90
 #define OPAL_DUMP_RESEND			91
 #define OPAL_DUMP_INFO2				94
+#define OPAL_PCI_ERR_INJECT			96
 #define OPAL_PCI_EEH_FREEZE_SET			97
 #define OPAL_HANDLE_HMI				98
 #define OPAL_REGISTER_DUMP_REGION		101
@@ -200,6 +201,35 @@ enum OpalPciErrorSeverity {
 	OPAL_EEH_SEV_INF	= 5
 };
 
+enum OpalErrinjectType {
+	OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR	= 0,
+	OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64	= 1,
+};
+
+enum OpalErrinjectFunc {
+	/* IOA bus specific errors */
+	OPAL_ERR_INJECT_FUNC_IOA_LD_MEM_ADDR	= 0,
+	OPAL_ERR_INJECT_FUNC_IOA_LD_MEM_DATA	= 1,
+	OPAL_ERR_INJECT_FUNC_IOA_LD_IO_ADDR	= 2,
+	OPAL_ERR_INJECT_FUNC_IOA_LD_IO_DATA	= 3,
+	OPAL_ERR_INJECT_FUNC_IOA_LD_CFG_ADDR	= 4,
+	OPAL_ERR_INJECT_FUNC_IOA_LD_CFG_DATA	= 5,
+	OPAL_ERR_INJECT_FUNC_IOA_ST_MEM_ADDR	= 6,
+	OPAL_ERR_INJECT_FUNC_IOA_ST_MEM_DATA	= 7,
+	OPAL_ERR_INJECT_FUNC_IOA_ST_IO_ADDR	= 8,
+	OPAL_ERR_INJECT_FUNC_IOA_ST_IO_DATA	= 9,
+	OPAL_ERR_INJECT_FUNC_IOA_ST_CFG_ADDR	= 10,
+	OPAL_ERR_INJECT_FUNC_IOA_ST_CFG_DATA	= 11,
+	OPAL_ERR_INJECT_FUNC_IOA_DMA_RD_ADDR	= 12,
+	OPAL_ERR_INJECT_FUNC_IOA_DMA_RD_DATA	= 13,
+	OPAL_ERR_INJECT_FUNC_IOA_DMA_RD_MASTER	= 14,
+	OPAL_ERR_INJECT_FUNC_IOA_DMA_RD_TARGET	= 15,
+	OPAL_ERR_INJECT_FUNC_IOA_DMA_WR_ADDR	= 16,
+	OPAL_ERR_INJECT_FUNC_IOA_DMA_WR_DATA	= 17,
+	OPAL_ERR_INJECT_FUNC_IOA_DMA_WR_MASTER	= 18,
+	OPAL_ERR_INJECT_FUNC_IOA_DMA_WR_TARGET	= 19,
+};
+
 enum OpalShpcAction {
 	OPAL_SHPC_GET_LINK_STATE = 0,
 	OPAL_SHPC_GET_SLOT_STATE = 1
@@ -820,6 +850,8 @@ int64_t opal_pci_eeh_freeze_clear(uint64_t phb_id, uint64_t pe_number,
 				  uint64_t eeh_action_token);
 int64_t opal_pci_eeh_freeze_set(uint64_t phb_id, uint64_t pe_number,
 				uint64_t eeh_action_token);
+int64_t opal_pci_err_inject(uint64_t phb_id, uint32_t pe_no, uint32_t type,
+			    uint32_t func, uint64_t addr, uint64_t mask);
 int64_t opal_pci_shpc(uint64_t phb_id, uint64_t shpc_action, uint8_t *state);
 
 
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 5718855..15942b6 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -184,6 +184,7 @@ OPAL_CALL(opal_register_exception_handler,	OPAL_REGISTER_OPAL_EXCEPTION_HANDLER)
 OPAL_CALL(opal_pci_eeh_freeze_status,		OPAL_PCI_EEH_FREEZE_STATUS);
 OPAL_CALL(opal_pci_eeh_freeze_clear,		OPAL_PCI_EEH_FREEZE_CLEAR);
 OPAL_CALL(opal_pci_eeh_freeze_set,		OPAL_PCI_EEH_FREEZE_SET);
+OPAL_CALL(opal_pci_err_inject,			OPAL_PCI_ERR_INJECT);
 OPAL_CALL(opal_pci_shpc,			OPAL_PCI_SHPC);
 OPAL_CALL(opal_pci_phb_mmio_enable,		OPAL_PCI_PHB_MMIO_ENABLE);
 OPAL_CALL(opal_pci_set_phb_mem_window,		OPAL_PCI_SET_PHB_MEM_WINDOW);
-- 
1.8.3.2
