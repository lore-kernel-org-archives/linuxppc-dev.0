Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CBE36140085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:10 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 14 May 2014 14:12:09 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D40B23578047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:06 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4E3odEJ63766596
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 13:50:40 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4E4C5g3022852
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:06 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 5/8] powerpc/powernv: Sync OPAL header file with firmware
Date: Wed, 14 May 2014 14:11:59 +1000
Message-Id: <1400040722-29608-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, agraf@suse.de, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch synchronizes OPAL header file with firmware so that the
host kernel can make OPAL call to do error injection.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                | 65 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 2 files changed, 66 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 66ad7a7..ca55d9c 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -175,6 +175,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_SET_PARAM				90
 #define OPAL_DUMP_RESEND			91
 #define OPAL_DUMP_INFO2				94
+#define OPAL_ERR_INJECT				96
 
 #ifndef __ASSEMBLY__
 
@@ -219,6 +220,69 @@ enum OpalPciErrorSeverity {
 	OPAL_EEH_SEV_INF	= 5
 };
 
+enum OpalErrinjctType {
+	OpalErrinjctTypeFirst			= 0,
+	OpalErrinjctTypeFatal			= 1,
+	OpalErrinjctTypeRecoverRandomEvent	= 2,
+	OpalErrinjctTypeRecoverSpecialEvent	= 3,
+	OpalErrinjctTypeCorruptedPage		= 4,
+	OpalErrinjctTypeCorruptedSlb		= 5,
+	OpalErrinjctTypeTranslatorFailure	= 6,
+	OpalErrinjctTypeIoaBusError		= 7,
+	OpalErrinjctTypeIoaBusError64		= 8,
+	OpalErrinjctTypePlatformSpecific	= 9,
+	OpalErrinjctTypeDcacheStart		= 10,
+	OpalErrinjctTypeDcacheEnd		= 11,
+	OpalErrinjctTypeIcacheStart		= 12,
+	OpalErrinjctTypeIcacheEnd		= 13,
+	OpalErrinjctTypeTlbStart		= 14,
+	OpalErrinjctTypeTlbEnd			= 15,
+	OpalErrinjctTypeUpstreamIoError		= 16,
+	OpalErrinjctTypeLast			= 17,
+
+	/* IoaBusError & IoaBusError64 */
+	OpalEjtIoaLoadMemAddr			= 0,
+	OpalEjtIoaLoadMemData			= 1,
+	OpalEjtIoaLoadIoAddr			= 2,
+	OpalEjtIoaLoadIoData			= 3,
+	OpalEjtIoaLoadConfigAddr		= 4,
+	OpalEjtIoaLoadConfigData		= 5,
+	OpalEjtIoaStoreMemAddr			= 6,
+	OpalEjtIoaStoreMemData			= 7,
+	OpalEjtIoaStoreIoAddr			= 8,
+	OpalEjtIoaStoreIoData			= 9,
+	OpalEjtIoaStoreConfigAddr		= 10,
+	OpalEjtIoaStoreConfigData		= 11,
+	OpalEjtIoaDmaReadMemAddr		= 12,
+	OpalEjtIoaDmaReadMemData		= 13,
+	OpalEjtIoaDmaReadMemMaster		= 14,
+	OpalEjtIoaDmaReadMemTarget		= 15,
+	OpalEjtIoaDmaWriteMemAddr		= 16,
+	OpalEjtIoaDmaWriteMemData		= 17,
+	OpalEjtIoaDmaWriteMemMaster		= 18,
+	OpalEjtIoaDmaWriteMemTarget		= 19,
+};
+
+struct OpalErrinjct {
+	int32_t type;
+	union {
+		struct {
+			uint32_t addr;
+			uint32_t mask;
+			uint64_t phb_id;
+			uint32_t pe;
+			uint32_t function;
+		}ioa;
+		struct {
+			uint64_t addr;
+			uint64_t mask;
+			uint64_t phb_id;
+			uint32_t pe;
+			uint32_t function;
+		}ioa64;
+	};
+};
+
 enum OpalShpcAction {
 	OPAL_SHPC_GET_LINK_STATE = 0,
 	OPAL_SHPC_GET_SLOT_STATE = 1
@@ -839,6 +903,7 @@ int64_t opal_pci_get_phb_diag_data(uint64_t phb_id, void *diag_buffer,
 				   uint64_t diag_buffer_len);
 int64_t opal_pci_get_phb_diag_data2(uint64_t phb_id, void *diag_buffer,
 				    uint64_t diag_buffer_len);
+int64_t opal_err_injct(void *data);
 int64_t opal_pci_fence_phb(uint64_t phb_id);
 int64_t opal_pci_reinit(uint64_t phb_id, uint64_t reinit_scope, uint64_t data);
 int64_t opal_pci_mask_pe_error(uint64_t phb_id, uint16_t pe_number, uint8_t error_type, uint8_t mask_action);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index f531ffe..46265de 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -119,6 +119,7 @@ OPAL_CALL(opal_pci_next_error,			OPAL_PCI_NEXT_ERROR);
 OPAL_CALL(opal_pci_poll,			OPAL_PCI_POLL);
 OPAL_CALL(opal_pci_msi_eoi,			OPAL_PCI_MSI_EOI);
 OPAL_CALL(opal_pci_get_phb_diag_data2,		OPAL_PCI_GET_PHB_DIAG_DATA2);
+OPAL_CALL(opal_err_injct,			OPAL_ERR_INJECT);
 OPAL_CALL(opal_xscom_read,			OPAL_XSCOM_READ);
 OPAL_CALL(opal_xscom_write,			OPAL_XSCOM_WRITE);
 OPAL_CALL(opal_lpc_read,			OPAL_LPC_READ);
-- 
1.8.3.2
