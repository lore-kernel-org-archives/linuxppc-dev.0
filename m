Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7BF31A0D09
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:44:02 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 67EA12BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:00 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hplJ1704342
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:44:00 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546hPgl003268
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:27 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 25/42] powerpc/powernv: Supports slot ID
Date: Thu,  4 Jun 2015 16:41:54 +1000
Message-Id: <1433400131-18429-26-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PowerNV platform is running on top of skiboot firmware, which has
changes supporting PCI slots. PCI slots are identified by PHB's
OPAL ID (PHB slot) or combo of that and PCI slot ID. The patch
changes argument names of opal_pci_reset() and opal_pci_poll()
to reflect the firmware's change. pnv_eeh_phb_poll() is also
renamed to pnv_eeh_poll() to reflect the firmware's change.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Split from PATCH[v4 09/21]
---
 arch/powerpc/include/asm/opal.h              | 4 ++--
 arch/powerpc/platforms/powernv/eeh-powernv.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 042af1a..6d467df 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -129,7 +129,7 @@ int64_t opal_pci_map_pe_dma_window(uint64_t phb_id, uint16_t pe_number, uint16_t
 int64_t opal_pci_map_pe_dma_window_real(uint64_t phb_id, uint16_t pe_number,
 					uint16_t dma_window_number, uint64_t pci_start_addr,
 					uint64_t pci_mem_size);
-int64_t opal_pci_reset(uint64_t phb_id, uint8_t reset_scope, uint8_t assert_state);
+int64_t opal_pci_reset(uint64_t id, uint8_t reset_scope, uint8_t assert_state);
 
 int64_t opal_pci_get_hub_diag_data(uint64_t hub_id, void *diag_buffer,
 				   uint64_t diag_buffer_len);
@@ -145,7 +145,7 @@ int64_t opal_get_epow_status(__be64 *status);
 int64_t opal_set_system_attention_led(uint8_t led_action);
 int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
 			    __be16 *pci_error_type, __be16 *severity);
-int64_t opal_pci_poll(uint64_t phb_id);
+int64_t opal_pci_poll(uint64_t id, uint8_t *val);
 int64_t opal_return_cpu(void);
 int64_t opal_check_token(uint64_t token);
 int64_t opal_reinit_cpus(uint64_t flags);
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index dfdb31f..4fd8f15 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -743,12 +743,12 @@ static int pnv_eeh_get_state(struct eeh_pe *pe, int *delay)
 	return ret;
 }
 
-static s64 pnv_eeh_phb_poll(struct pnv_phb *phb)
+static s64 pnv_eeh_poll(uint64_t id)
 {
 	s64 rc = OPAL_HARDWARE;
 
 	while (1) {
-		rc = opal_pci_poll(phb->opal_id);
+		rc = opal_pci_poll(id, NULL);
 		if (rc <= 0)
 			break;
 
@@ -788,7 +788,7 @@ int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
 	 * reset followed by hot reset on root bus. So we also
 	 * need the PCI bus settlement delay.
 	 */
-	rc = pnv_eeh_phb_poll(phb);
+	rc = pnv_eeh_poll(phb->opal_id);
 	if (option == EEH_RESET_DEACTIVATE) {
 		if (system_state < SYSTEM_RUNNING)
 			udelay(1000 * EEH_PE_RST_SETTLE_TIME);
@@ -831,7 +831,7 @@ static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
 		goto out;
 
 	/* Poll state of the PHB until the request is done */
-	rc = pnv_eeh_phb_poll(phb);
+	rc = pnv_eeh_poll(phb->opal_id);
 	if (option == EEH_RESET_DEACTIVATE)
 		msleep(EEH_PE_RST_SETTLE_TIME);
 out:
-- 
2.1.0
