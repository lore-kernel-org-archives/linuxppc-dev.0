Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 32/39] powerpc/powernv: Fix some PCI sparse errors and one LE
 bug
Date: Mon, 23 Sep 2013 12:05:06 +1000
Message-Id: <1379901913-5945-33-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pnv_pci_setup_bml_iommu was missing a byteswap of a device
tree property.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/opal.h           | 22 +++++++++++-----------
 arch/powerpc/platforms/powernv/opal.c     |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |  6 +++---
 arch/powerpc/platforms/powernv/pci.c      |  6 +++---
 arch/powerpc/platforms/powernv/pci.h      |  2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 3db5e82..51e3b26 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -551,7 +551,7 @@ int64_t opal_cec_power_down(uint64_t request);
 int64_t opal_cec_reboot(void);
 int64_t opal_read_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
 int64_t opal_write_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
-int64_t opal_handle_interrupt(uint64_t isn, uint64_t *outstanding_event_mask);
+int64_t opal_handle_interrupt(uint64_t isn, __be64 *outstanding_event_mask);
 int64_t opal_poll_events(__be64 *outstanding_event_mask);
 int64_t opal_pci_set_hub_tce_memory(uint64_t hub_id, uint64_t tce_mem_addr,
 				    uint64_t tce_mem_size);
@@ -560,9 +560,9 @@ int64_t opal_pci_set_phb_tce_memory(uint64_t phb_id, uint64_t tce_mem_addr,
 int64_t opal_pci_config_read_byte(uint64_t phb_id, uint64_t bus_dev_func,
 				  uint64_t offset, uint8_t *data);
 int64_t opal_pci_config_read_half_word(uint64_t phb_id, uint64_t bus_dev_func,
-				       uint64_t offset, uint16_t *data);
+				       uint64_t offset, __be16 *data);
 int64_t opal_pci_config_read_word(uint64_t phb_id, uint64_t bus_dev_func,
-				  uint64_t offset, uint32_t *data);
+				  uint64_t offset, __be32 *data);
 int64_t opal_pci_config_write_byte(uint64_t phb_id, uint64_t bus_dev_func,
 				   uint64_t offset, uint8_t data);
 int64_t opal_pci_config_write_half_word(uint64_t phb_id, uint64_t bus_dev_func,
@@ -570,14 +570,14 @@ int64_t opal_pci_config_write_half_word(uint64_t phb_id, uint64_t bus_dev_func,
 int64_t opal_pci_config_write_word(uint64_t phb_id, uint64_t bus_dev_func,
 				   uint64_t offset, uint32_t data);
 int64_t opal_set_xive(uint32_t isn, uint16_t server, uint8_t priority);
-int64_t opal_get_xive(uint32_t isn, uint16_t *server, uint8_t *priority);
+int64_t opal_get_xive(uint32_t isn, __be16 *server, uint8_t *priority);
 int64_t opal_register_exception_handler(uint64_t opal_exception,
 					uint64_t handler_address,
 					uint64_t glue_cache_line);
 int64_t opal_pci_eeh_freeze_status(uint64_t phb_id, uint64_t pe_number,
 				   uint8_t *freeze_state,
-				   uint16_t *pci_error_type,
-				   uint64_t *phb_status);
+				   __be16 *pci_error_type,
+				   __be64 *phb_status);
 int64_t opal_pci_eeh_freeze_clear(uint64_t phb_id, uint64_t pe_number,
 				  uint64_t eeh_action_token);
 int64_t opal_pci_shpc(uint64_t phb_id, uint64_t shpc_action, uint8_t *state);
@@ -614,13 +614,13 @@ int64_t opal_pci_msi_eoi(uint64_t phb_id, uint32_t hw_irq);
 int64_t opal_pci_set_xive_pe(uint64_t phb_id, uint32_t pe_number,
 			     uint32_t xive_num);
 int64_t opal_get_xive_source(uint64_t phb_id, uint32_t xive_num,
-			     int32_t *interrupt_source_number);
+			     __be32 *interrupt_source_number);
 int64_t opal_get_msi_32(uint64_t phb_id, uint32_t mve_number, uint32_t xive_num,
-			uint8_t msi_range, uint32_t *msi_address,
-			uint32_t *message_data);
+			uint8_t msi_range, __be32 *msi_address,
+			__be32 *message_data);
 int64_t opal_get_msi_64(uint64_t phb_id, uint32_t mve_number,
 			uint32_t xive_num, uint8_t msi_range,
-			uint64_t *msi_address, uint32_t *message_data);
+			__be64 *msi_address, __be32 *message_data);
 int64_t opal_start_cpu(uint64_t thread_number, uint64_t start_address);
 int64_t opal_query_cpu_status(uint64_t thread_number, uint8_t *thread_status);
 int64_t opal_write_oppanel(oppanel_line_t *lines, uint64_t num_lines);
@@ -642,7 +642,7 @@ int64_t opal_pci_fence_phb(uint64_t phb_id);
 int64_t opal_pci_reinit(uint64_t phb_id, uint8_t reinit_scope);
 int64_t opal_pci_mask_pe_error(uint64_t phb_id, uint16_t pe_number, uint8_t error_type, uint8_t mask_action);
 int64_t opal_set_slot_led_status(uint64_t phb_id, uint64_t slot_id, uint8_t led_type, uint8_t led_action);
-int64_t opal_get_epow_status(uint64_t *status);
+int64_t opal_get_epow_status(__be64 *status);
 int64_t opal_set_system_attention_led(uint8_t led_action);
 int64_t opal_pci_next_error(uint64_t phb_id, uint64_t *first_frozen_pe,
 			    uint16_t *pci_error_type, uint16_t *severity);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index c2391bb..09336f0 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -366,7 +366,7 @@ int opal_machine_check(struct pt_regs *regs)
 
 static irqreturn_t opal_interrupt(int irq, void *data)
 {
-	uint64_t events;
+	__be64 events;
 
 	opal_handle_interrupt(virq_to_hw(irq), &events);
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index f9cb6c5..a6531d2 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -455,7 +455,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 }
 
 static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
-					 u64 *startp, u64 *endp)
+					 __be64 *startp, __be64 *endp)
 {
 	__be64 __iomem *invalidate = (__be64 __iomem *)tbl->it_index;
 	unsigned long start, end, inc;
@@ -496,7 +496,7 @@ static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
 
 static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 					 struct iommu_table *tbl,
-					 u64 *startp, u64 *endp)
+					 __be64 *startp, __be64 *endp)
 {
 	unsigned long start, end, inc;
 	__be64 __iomem *invalidate = (__be64 __iomem *)tbl->it_index;
@@ -521,7 +521,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 }
 
 void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
-				 u64 *startp, u64 *endp)
+				 __be64 *startp, __be64 *endp)
 {
 	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
 					      tce32_table);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 2f73e0d..a26956c 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -412,7 +412,7 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 	if (direction != DMA_TO_DEVICE)
 		proto_tce |= TCE_PCI_WRITE;
 
-	tces = tcep = ((u64 *)tbl->it_base) + index - tbl->it_offset;
+	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
 	rpn = __pa(uaddr) >> TCE_SHIFT;
 
 	while (npages--)
@@ -432,7 +432,7 @@ static void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 {
 	__be64 *tcep, *tces;
 
-	tces = tcep = ((u64 *)tbl->it_base) + index - tbl->it_offset;
+	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
 
 	while (npages--)
 		*(tcep++) = cpu_to_be64(0);
@@ -484,7 +484,7 @@ static struct iommu_table *pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 	swinvp = of_get_property(hose->dn, "linux,tce-sw-invalidate-info",
 				 NULL);
 	if (swinvp) {
-		tbl->it_busno = swinvp[1];
+		tbl->it_busno = be64_to_cpu(swinvp[1]);
 		tbl->it_index = (unsigned long)ioremap(be64_to_cpup(swinvp), 8);
 		tbl->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE;
 	}
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index d633c64..dfe2010 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -193,6 +193,6 @@ extern void pnv_pci_init_p5ioc2_hub(struct device_node *np);
 extern void pnv_pci_init_ioda_hub(struct device_node *np);
 extern void pnv_pci_init_ioda2_phb(struct device_node *np);
 extern void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
-					u64 *startp, u64 *endp);
+					__be64 *startp, __be64 *endp);
 
 #endif /* __POWERNV_PCI_H */
-- 
1.8.1.2
