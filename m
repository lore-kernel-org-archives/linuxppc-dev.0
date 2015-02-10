Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1634A1A014B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:27:22 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 21:27:20 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A8F3B38C8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 21:27:15 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2RFEP29687852
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 02:27:15 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2RDv7015450
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 21:27:14 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 03/18] powerpc/powernv:
 s/OPAL_PCI_SET_PHB_CXL_MODE/OPAL_PCI_SET_PHB_CAPI_MODE/ to match firmware
Date: Tue, 10 Feb 2015 13:26:45 +1100
Message-Id: <1423535220-6322-4-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL/IBM calls it CAPI and Linux calls it CXL because CAPI was taken.

In order to have opal.h match between firmware and Linux, we're going
to just deal with one call used in a place be CAPI rather than CXL to
match what's in firmware.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                |    4 ++--
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c      |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 80cb4d3..e8d9bfc 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -158,7 +158,7 @@ struct opal_sg_list {
 #define OPAL_SET_PARAM				90
 #define OPAL_DUMP_RESEND			91
 #define OPAL_ELOG_SEND				92	/* Deprecated */
-#define OPAL_PCI_SET_PHB_CXL_MODE		93
+#define OPAL_PCI_SET_PHB_CAPI_MODE		93
 #define OPAL_DUMP_INFO2				94
 #define OPAL_WRITE_OPPANEL_ASYNC		95
 #define OPAL_PCI_ERR_INJECT			96
@@ -923,7 +923,7 @@ int64_t opal_handle_hmi(void);
 int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
 int64_t opal_unregister_dump_region(uint32_t id);
 int64_t opal_slw_set_reg(uint64_t cpu_pir, uint64_t sprn, uint64_t val);
-int64_t opal_pci_set_phb_cxl_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
+int64_t opal_pci_set_phb_capi_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
 int64_t opal_ipmi_send(uint64_t interface, struct opal_ipmi_msg *msg,
 		uint64_t msg_len);
 int64_t opal_ipmi_recv(uint64_t interface, struct opal_ipmi_msg *msg,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 0509bca..03eb6e3 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -286,7 +286,7 @@ OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
 OPAL_CALL(opal_slw_set_reg,			OPAL_SLW_SET_REG);
 OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
 OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
-OPAL_CALL(opal_pci_set_phb_cxl_mode,		OPAL_PCI_SET_PHB_CXL_MODE);
+OPAL_CALL(opal_pci_set_phb_capi_mode,		OPAL_PCI_SET_PHB_CAPI_MODE);
 OPAL_CALL(opal_tpo_write,			OPAL_WRITE_TPO);
 OPAL_CALL(opal_tpo_read,			OPAL_READ_TPO);
 OPAL_CALL(opal_ipmi_send,			OPAL_IPMI_SEND);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fac88ed..3bc5917 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1481,9 +1481,9 @@ int pnv_phb_to_cxl(struct pci_dev *dev)
 
 	pe_info(pe, "Switching PHB to CXL\n");
 
-	rc = opal_pci_set_phb_cxl_mode(phb->opal_id, 1, pe->pe_number);
+	rc = opal_pci_set_phb_capi_mode(phb->opal_id, 1, pe->pe_number);
 	if (rc)
-		dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode failed: %i\n", rc);
+		dev_err(&dev->dev, "opal_pci_set_phb_capi_mode failed: %i\n", rc);
 
 	return rc;
 }
-- 
1.7.10.4
