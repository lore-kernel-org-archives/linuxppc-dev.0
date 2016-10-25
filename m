Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0113.hostedemail.com
 [216.40.44.113])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2zvQ0gRmzDvYH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 15:00:18 +1100 (AEDT)
From: Joe Perches <joe@perches.com>
To: Anatolij Gustschin <agust@denx.de>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Use pr_warn instead of pr_warning
Date: Mon, 24 Oct 2016 21:00:08 -0700
Message-Id: <af9bcd9cdbc64f2c2638ba869979de003ba4671c.1477367819.git.joe@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At some point, pr_warning will be removed so all logging messages use
a consistent <prefix>_warn style.

Update arch/powerpc/

Miscellanea:

o Coalesce formats
o Realign arguments
o Use %s, __func__ instead of embedded function names
o Remove unnecessary line continuations

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/kernel/pci-common.c                |  4 ++--
 arch/powerpc/mm/init_64.c                       |  5 ++---
 arch/powerpc/mm/mem.c                           |  3 +--
 arch/powerpc/platforms/512x/mpc512x_shared.c    |  4 ++--
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c |  7 +++----
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c      |  2 +-
 arch/powerpc/platforms/pasemi/dma_lib.c         |  4 ++--
 arch/powerpc/platforms/powernv/opal.c           |  8 ++++----
 arch/powerpc/platforms/powernv/pci-ioda.c       | 10 +++++-----
 arch/powerpc/platforms/ps3/device-init.c        | 12 +++++-------
 arch/powerpc/platforms/ps3/mm.c                 |  4 ++--
 arch/powerpc/platforms/ps3/os-area.c            |  2 +-
 arch/powerpc/platforms/pseries/iommu.c          |  8 +++-----
 arch/powerpc/platforms/pseries/setup.c          |  4 ++--
 arch/powerpc/sysdev/fsl_pci.c                   |  9 +++------
 arch/powerpc/sysdev/mpic.c                      | 10 ++++------
 arch/powerpc/sysdev/xics/icp-native.c           | 10 ++++------
 arch/powerpc/sysdev/xics/ics-opal.c             |  4 +--
 arch/powerpc/sysdev/xics/ics-rtas.c             |  4 ++--
 arch/powerpc/sysdev/xics/xics-common.c          |  8 ++++----
 20 files changed, 54 insertions(+), 68 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 74bec5498972..338f7f7dbfb2 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1267,8 +1267,8 @@ static void pcibios_allocate_bus_resources(struct pci_bus *bus)
 						i + PCI_BRIDGE_RESOURCES) == 0)
 				continue;
 		}
-		pr_warning("PCI: Cannot allocate resource region "
-			   "%d of PCI bridge %d, will remap\n", i, bus->number);
+		pr_warn("PCI: Cannot allocate resource region %d of PCI bridge %d, will remap\n",
+			i, bus->number);
 	clear_resource:
 		/* The resource might be figured out when doing
 		 * reassignment based on the resources required
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 16ada1eb7e26..b5c18fe202e5 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -267,9 +267,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 
 		rc = vmemmap_create_mapping(start, page_size, __pa(p));
 		if (rc < 0) {
-			pr_warning(
-				"vmemmap_populate: Unable to create vmemmap mapping: %d\n",
-				rc);
+			pr_warn("%s: Unable to create vmemmap mapping: %d\n",
+				__func__, rc);
 			return -EFAULT;
 		}
 	}
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5f844337de21..c4ec6e63ed43 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -139,8 +139,7 @@ int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
 	start = (unsigned long)__va(start);
 	rc = create_section_mapping(start, start + size);
 	if (rc) {
-		pr_warning(
-			"Unable to create mapping for hot added memory 0x%llx..0x%llx: %d\n",
+		pr_warn("Unable to create mapping for hot added memory 0x%llx..0x%llx: %d\n",
 			start, start + size, rc);
 		return -EFAULT;
 	}
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 6b4f4cb7009a..1592b7ce9635 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -387,8 +387,8 @@ static unsigned int __init get_fifo_size(struct device_node *np,
 	if (fp)
 		return *fp;
 
-	pr_warning("no %s property in %s node, defaulting to %d\n",
-		   prop_name, np->full_name, DEFAULT_FIFO_SIZE);
+	pr_warn("no %s property in %s node, defaulting to %d\n",
+		prop_name, np->full_name, DEFAULT_FIFO_SIZE);
 
 	return DEFAULT_FIFO_SIZE;
 }
diff --git a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
index 82f8490b5aa7..38d4ba9f37b5 100644
--- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -252,8 +252,7 @@ static int socrates_fpga_pic_host_xlate(struct irq_domain *h,
 		/* type is configurable */
 		if (intspec[1] != IRQ_TYPE_LEVEL_LOW &&
 		    intspec[1] != IRQ_TYPE_LEVEL_HIGH) {
-			pr_warning("FPGA PIC: invalid irq type, "
-				   "setting default active low\n");
+			pr_warn("FPGA PIC: invalid irq type, setting default active low\n");
 			*out_flags = IRQ_TYPE_LEVEL_LOW;
 		} else {
 			*out_flags = intspec[1];
@@ -267,7 +266,7 @@ static int socrates_fpga_pic_host_xlate(struct irq_domain *h,
 	if (intspec[2] <= 2)
 		fpga_irq->irq_line = intspec[2];
 	else
-		pr_warning("FPGA PIC: invalid irq routing\n");
+		pr_warn("FPGA PIC: invalid irq routing\n");
 
 	return 0;
 }
@@ -293,7 +292,7 @@ void socrates_fpga_pic_init(struct device_node *pic)
 	for (i = 0; i < 3; i++) {
 		socrates_fpga_irqs[i] = irq_of_parse_and_map(pic, i);
 		if (!socrates_fpga_irqs[i]) {
-			pr_warning("FPGA PIC: can't get irq%d.\n", i);
+			pr_warn("FPGA PIC: can't get irq%d\n", i);
 			continue;
 		}
 		irq_set_chained_handler(socrates_fpga_irqs[i],
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index a0e989ed4b6f..17c6cd3d02e6 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -101,7 +101,7 @@ static int __init mpc86xx_hpcn_probe(void)
 
 	/* Be nice and don't give silent boot death.  Delete this in 2.6.27 */
 	if (of_machine_is_compatible("mpc86xx")) {
-		pr_warning("WARNING: your dts/dtb is old. You must update before the next kernel release\n");
+		pr_warn("WARNING: your dts/dtb is old. You must update before the next kernel release.\n");
 		return 1;
 	}
 
diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index aafa01ba062f..2c72263ad6ab 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -589,7 +589,7 @@ int pasemi_dma_init(void)
 	pasemi_write_dma_reg(PAS_DMA_COM_RXCMD, 0);
 	while (pasemi_read_dma_reg(PAS_DMA_COM_RXSTA) & 1) {
 		if (time_after(jiffies, timeout)) {
-			pr_warning("Warning: Could not disable RX section\n");
+			pr_warn("Warning: Could not disable RX section\n");
 			break;
 		}
 	}
@@ -598,7 +598,7 @@ int pasemi_dma_init(void)
 	pasemi_write_dma_reg(PAS_DMA_COM_TXCMD, 0);
 	while (pasemi_read_dma_reg(PAS_DMA_COM_TXSTA) & 1) {
 		if (time_after(jiffies, timeout)) {
-			pr_warning("Warning: Could not disable TX section\n");
+			pr_warn("Warning: Could not disable TX section\n");
 			break;
 		}
 	}
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 6c9a65b52e63..b3246ed8881a 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -220,8 +220,8 @@ int opal_message_notifier_register(enum opal_msg_type msg_type,
 					struct notifier_block *nb)
 {
 	if (!nb || msg_type >= OPAL_MSG_TYPE_MAX) {
-		pr_warning("%s: Invalid arguments, msg_type:%d\n",
-			   __func__, msg_type);
+		pr_warn("%s: Invalid arguments, msg_type:%d\n",
+			__func__, msg_type);
 		return -EINVAL;
 	}
 
@@ -262,8 +262,8 @@ static void opal_handle_message(void)
 
 	/* check for errors. */
 	if (ret) {
-		pr_warning("%s: Failed to retrieve opal message, err=%lld\n",
-				__func__, ret);
+		pr_warn("%s: Failed to retrieve opal message, err=%lld\n",
+			__func__, ret);
 		return;
 	}
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d4b33dd2d9e7..b2fff2c72a4d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1042,8 +1042,8 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 
 	pe = pnv_ioda_alloc_pe(phb);
 	if (!pe) {
-		pr_warning("%s: Not enough PE# available, disabling device\n",
-			   pci_name(dev));
+		pr_warn("%s: Not enough PE# available, disabling device\n",
+			pci_name(dev));
 		return NULL;
 	}
 
@@ -1147,7 +1147,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 		pe = pnv_ioda_alloc_pe(phb);
 
 	if (!pe) {
-		pr_warning("%s: Not enough PE# available for PCI bus %04x:%02x\n",
+		pr_warn("%s: Not enough PE# available for PCI bus %04x:%02x\n",
 			__func__, pci_domain_nr(bus), bus->number);
 		return NULL;
 	}
@@ -3110,7 +3110,7 @@ static void pnv_pci_ioda_create_dbgfs(void)
 		sprintf(name, "PCI%04x", hose->global_number);
 		phb->dbgfs = debugfs_create_dir(name, powerpc_debugfs_root);
 		if (!phb->dbgfs) {
-			pr_warning("%s: Error on creating debugfs on PHB#%x\n",
+			pr_warn("%s: Error on creating debugfs on PHB#%x\n",
 				__func__, hose->global_number);
 			continue;
 		}
@@ -3827,7 +3827,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	/* Reset IODA tables to a clean state */
 	rc = opal_pci_reset(phb_id, OPAL_RESET_PCI_IODA_TABLE, OPAL_ASSERT_RESET);
 	if (rc)
-		pr_warning("  OPAL Error %ld performing IODA table reset !\n", rc);
+		pr_warn("  OPAL Error %ld performing IODA table reset !\n", rc);
 
 	/*
 	 * If we're running in kdump kernel, the previous kernel never
diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index e48462447ff0..e7075aaff1bb 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -663,8 +663,8 @@ static void ps3_find_and_add_device(u64 bus_id, u64 dev_id)
 		if (rem)
 			break;
 	}
-	pr_warning("%s:%u: device %llu:%llu not found\n", __func__, __LINE__,
-		   bus_id, dev_id);
+	pr_warn("%s:%u: device %llu:%llu not found\n",
+		__func__, __LINE__, bus_id, dev_id);
 	return;
 
 found:
@@ -859,11 +859,9 @@ static int ps3_probe_thread(void *data)
 
 		if (notify_event->event_type != notify_region_probe ||
 		    notify_event->bus_id != dev.sbd.bus_id) {
-			pr_warning("%s:%u: bad notify_event: event %llu, "
-				   "dev_id %llu, dev_type %llu\n",
-				   __func__, __LINE__, notify_event->event_type,
-				   notify_event->dev_id,
-				   notify_event->dev_type);
+			pr_warn("%s:%u: bad notify_event: event %llu, dev_id %llu, dev_type %llu\n",
+				__func__, __LINE__, notify_event->event_type,
+				notify_event->dev_id, notify_event->dev_type);
 			continue;
 		}
 
diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index b0f34663b1ae..7f870ec29daf 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -607,8 +607,8 @@ static int dma_ioc0_map_pages(struct ps3_dma_region *r, unsigned long phys_addr,
 				       r->ioid,
 				       iopte_flag);
 		if (result) {
-			pr_warning("%s:%d: lv1_put_iopte failed: %s\n",
-				   __func__, __LINE__, ps3_result(result));
+			pr_warn("%s:%d: lv1_put_iopte failed: %s\n",
+				__func__, __LINE__, ps3_result(result));
 			goto fail_map;
 		}
 		DBG("%s: pg=%d bus=%#lx, lpar=%#lx, ioid=%#x\n", __func__,
diff --git a/arch/powerpc/platforms/ps3/os-area.c b/arch/powerpc/platforms/ps3/os-area.c
index 3db53e8aff92..cdbfc5cfd6f3 100644
--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -699,7 +699,7 @@ static void os_area_queue_work_handler(struct work_struct *work)
 
 	error = update_flash_db();
 	if (error)
-		pr_warning("%s: Could not update FLASH ROM\n", __func__);
+		pr_warn("%s: Could not update FLASH ROM\n", __func__);
 
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 }
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 0024e451bb36..71316e815688 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -781,16 +781,14 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 	ret = tce_clearrange_multi_pSeriesLP(0,
 		1ULL << (be32_to_cpu(dwp->window_shift) - PAGE_SHIFT), dwp);
 	if (ret)
-		pr_warning("%s failed to clear tces in window.\n",
-			 np->full_name);
+		pr_warn("%s failed to clear tces in window\n", np->full_name);
 	else
 		pr_debug("%s successfully cleared tces in window.\n",
 			 np->full_name);
 
 	ret = rtas_call(ddw_avail[2], 1, 1, NULL, liobn);
 	if (ret)
-		pr_warning("%s: failed to remove direct window: rtas returned "
-			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
+		pr_warn("%s: failed to remove direct window: rtas returned %d to ibm,remove-pe-dma-window(%x) %llx\n",
 			np->full_name, ret, ddw_avail[2], liobn);
 	else
 		pr_debug("%s: successfully removed direct window: rtas returned "
@@ -801,7 +799,7 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 	if (remove_prop)
 		ret = of_remove_property(np, win64);
 	if (ret)
-		pr_warning("%s: failed to remove direct window property: %d\n",
+		pr_warn("%s: failed to remove direct window property: %d\n",
 			np->full_name, ret);
 }
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 7736352f7279..205e9f912e58 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -362,8 +362,8 @@ void pseries_disable_reloc_on_exc(void)
 		mdelay(get_longbusy_msecs(rc));
 	}
 	if (rc != H_SUCCESS)
-		pr_warning("Warning: Failed to disable relocation on "
-			   "exceptions: %ld\n", rc);
+		pr_warn("Warning: Failed to disable relocation on exceptions: %ld\n",
+			rc);
 }
 EXPORT_SYMBOL(pseries_disable_reloc_on_exc);
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index d3a597456b6e..2b0f00c28dc0 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -449,9 +449,7 @@ static void setup_pci_atmu(struct pci_controller *hose)
 #endif
 		/* adjusting outbound windows could reclaim space in mem map */
 		if (paddr_hi < 0xffffffffull)
-			pr_warning("%s: WARNING: Outbound window cfg leaves "
-				"gaps in memory map. Adjusting the memory map "
-				"could reduce unnecessary bounce buffering.\n",
+			pr_warn("%s: WARNING: Outbound window cfg leaves gaps in memory map. Adjusting the memory map could reduce unnecessary bounce buffering.\n",
 				name);
 
 		pr_info("%s: DMA window size is 0x%llx\n", name,
@@ -532,7 +530,7 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 	dev = pdev->dev.of_node;
 
 	if (!of_device_is_available(dev)) {
-		pr_warning("%s: disabled\n", dev->full_name);
+		pr_warn("%s: disabled\n", dev->full_name);
 		return -ENODEV;
 	}
 
@@ -809,8 +807,7 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	is_mpc83xx_pci = 1;
 
 	if (!of_device_is_available(dev)) {
-		pr_warning("%s: disabled by the firmware.\n",
-			   dev->full_name);
+		pr_warn("%s: disabled by the firmware\n", dev->full_name);
 		return -ENODEV;
 	}
 	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index b9aac951a90f..b0df83487c5f 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1008,9 +1008,8 @@ static int mpic_host_map(struct irq_domain *h, unsigned int virq,
 	if (hw == mpic->spurious_vec)
 		return -EINVAL;
 	if (mpic->protected && test_bit(hw, mpic->protected)) {
-		pr_warning("mpic: Mapping of source 0x%x failed, "
-			   "source protected by firmware !\n",\
-			   (unsigned int)hw);
+		pr_warn("mpic: Mapping of source 0x%x failed, source protected by firmware !\n",
+			(unsigned int)hw);
 		return -EPERM;
 	}
 
@@ -1040,9 +1039,8 @@ static int mpic_host_map(struct irq_domain *h, unsigned int virq,
 		return 0;
 
 	if (hw >= mpic->num_sources) {
-		pr_warning("mpic: Mapping of source 0x%x failed, "
-			   "source out of range !\n",\
-			   (unsigned int)hw);
+		pr_warn("mpic: Mapping of source 0x%x failed, source out of range !\n",
+			(unsigned int)hw);
 		return -EINVAL;
 	}
 
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 8a6a043e239b..97d2cf7dc66f 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -251,18 +251,16 @@ static int __init icp_native_map_one_cpu(int hw_id, unsigned long addr,
 			  cpu, hw_id);
 
 	if (!request_mem_region(addr, size, rname)) {
-		pr_warning("icp_native: Could not reserve ICP MMIO"
-			   " for CPU %d, interrupt server #0x%x\n",
-			   cpu, hw_id);
+		pr_warn("icp_native: Could not reserve ICP MMIO for CPU %d, interrupt server #0x%x\n",
+			cpu, hw_id);
 		return -EBUSY;
 	}
 
 	icp_native_regs[cpu] = ioremap(addr, size);
 	kvmppc_set_xics_phys(cpu, addr);
 	if (!icp_native_regs[cpu]) {
-		pr_warning("icp_native: Failed ioremap for CPU %d, "
-			   "interrupt server #0x%x, addr %#lx\n",
-			   cpu, hw_id, addr);
+		pr_warn("icp_native: Failed ioremap for CPU %d, interrupt server #0x%x, addr %#lx\n",
+			cpu, hw_id, addr);
 		release_mem_region(addr, size);
 		return -ENOMEM;
 	}
diff --git a/arch/powerpc/sysdev/xics/ics-opal.c b/arch/powerpc/sysdev/xics/ics-opal.c
index 1c6bf4b66f56..f85f916ba432 100644
--- a/arch/powerpc/sysdev/xics/ics-opal.c
+++ b/arch/powerpc/sysdev/xics/ics-opal.c
@@ -131,8 +131,8 @@ static int ics_opal_set_affinity(struct irq_data *d,
 
 	wanted_server = xics_get_irq_server(d->irq, cpumask, 1);
 	if (wanted_server < 0) {
-		pr_warning("%s: No online cpus in the mask %*pb for irq %d\n",
-			   __func__, cpumask_pr_args(cpumask), d->irq);
+		pr_warn("%s: No online cpus in the mask %*pb for irq %d\n",
+			__func__, cpumask_pr_args(cpumask), d->irq);
 		return -1;
 	}
 	server = ics_opal_mangle_server(wanted_server);
diff --git a/arch/powerpc/sysdev/xics/ics-rtas.c b/arch/powerpc/sysdev/xics/ics-rtas.c
index 78ee5c778ef8..17fc8e8c0524 100644
--- a/arch/powerpc/sysdev/xics/ics-rtas.c
+++ b/arch/powerpc/sysdev/xics/ics-rtas.c
@@ -140,8 +140,8 @@ static int ics_rtas_set_affinity(struct irq_data *d,
 
 	irq_server = xics_get_irq_server(d->irq, cpumask, 1);
 	if (irq_server == -1) {
-		pr_warning("%s: No online cpus in the mask %*pb for irq %d\n",
-			   __func__, cpumask_pr_args(cpumask), d->irq);
+		pr_warn("%s: No online cpus in the mask %*pb for irq %d\n",
+			__func__, cpumask_pr_args(cpumask), d->irq);
 		return -1;
 	}
 
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 69d858e51ac7..b25e2776e0b7 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -245,8 +245,8 @@ void xics_migrate_irqs_away(void)
 
 		/* This is expected during cpu offline. */
 		if (cpu_online(cpu))
-			pr_warning("IRQ %u affinity broken off cpu %u\n",
-			       virq, cpu);
+			pr_warn("IRQ %u affinity broken off cpu %u\n",
+				virq, cpu);
 
 		/* Reset affinity to all cpus */
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
@@ -455,7 +455,7 @@ void __init xics_init(void)
 		    rc = icp_opal_init();
 	}
 	if (rc < 0) {
-		pr_warning("XICS: Cannot find a Presentation Controller !\n");
+		pr_warn("XICS: Cannot find a Presentation Controller !\n");
 		return;
 	}
 
@@ -470,7 +470,7 @@ void __init xics_init(void)
 	if (rc < 0)
 		rc = ics_opal_init();
 	if (rc < 0)
-		pr_warning("XICS: Cannot find a Source Controller !\n");
+		pr_warn("XICS: Cannot find a Source Controller !\n");
 
 	/* Initialize common bits */
 	xics_get_server_size();
-- 
2.10.0.rc2.1.g053435c
