Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B7FE6DDFC0
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 15:00:32 +1000 (EST)
Date: Thu, 11 Oct 2007 14:53:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 3/7] [POWERPC] remove iSeries_vio_dev
Message-Id: <20071011145332.e3638c2e.sfr@canb.auug.org.au>
In-Reply-To: <20071011145055.1de13742.sfr@canb.auug.org.au>
References: <20071011144824.a5e3de59.sfr@canb.auug.org.au>
	<20071011145055.1de13742.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It was only being used to carry around dma_iommu_ops and vio_iommu_table
which we can use directly instead.  This also means that vio_bus_device
doesn't need to refer to them either.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Jens Axboe <jens.axboe@oracle.com>
---
 arch/powerpc/kernel/vio.c                   |    7 +-----
 arch/powerpc/platforms/iseries/iommu.c      |   30 +++++++++++++++++++++++++++
 arch/powerpc/platforms/iseries/mf.c         |   23 ++++++++------------
 arch/powerpc/platforms/iseries/viopath.c    |    6 +---
 drivers/cdrom/viocd.c                       |    5 +--
 drivers/char/viotape.c                      |    7 ++---
 include/asm-powerpc/iseries/hv_call_event.h |   10 +++++++++
 include/asm-powerpc/iseries/vio.h           |    4 ---
 8 files changed, 57 insertions(+), 35 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index fd631d4..eaf7f69 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -49,11 +49,8 @@ static struct vio_dev vio_bus_device  = { /* fake "parent" device */
 };
 
 #ifdef CONFIG_PPC_ISERIES
-struct device *iSeries_vio_dev = &vio_bus_device.dev;
-EXPORT_SYMBOL(iSeries_vio_dev);
-
 static struct iommu_table veth_iommu_table;
-static struct iommu_table vio_iommu_table;
+struct iommu_table vio_iommu_table;
 
 static void __init iommu_vio_init(void)
 {
@@ -66,8 +63,6 @@ static void __init iommu_vio_init(void)
 		printk("Virtual Bus VETH TCE table failed.\n");
 	if (!iommu_init_table(&vio_iommu_table, -1))
 		printk("Virtual Bus VIO TCE table failed.\n");
-	vio_bus_device.dev.archdata.dma_ops = &dma_iommu_ops;
-	vio_bus_device.dev.archdata.dma_data = &vio_iommu_table;
 }
 #else
 static void __init iommu_vio_init(void)
diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
index 3b6a966..3281f10 100644
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -28,6 +28,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/list.h>
 #include <linux/pci.h>
+#include <linux/module.h>
 
 #include <asm/iommu.h>
 #include <asm/tce.h>
@@ -36,6 +37,7 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #include <asm/iseries/hv_call_xm.h>
+#include <asm/iseries/hv_call_event.h>
 #include <asm/iseries/iommu.h>
 
 static void tce_build_iSeries(struct iommu_table *tbl, long index, long npages,
@@ -189,6 +191,34 @@ void iommu_devnode_init_iSeries(struct pci_dev *pdev, struct device_node *dn)
 }
 #endif
 
+extern struct iommu_table vio_iommu_table;
+
+void *iseries_hv_alloc(size_t size, dma_addr_t *dma_handle, gfp_t flag)
+{
+	return iommu_alloc_coherent(&vio_iommu_table, size, dma_handle,
+				DMA_32BIT_MASK, flag, -1);
+}
+EXPORT_SYMBOL_GPL(iseries_hv_alloc);
+
+void iseries_hv_free(size_t size, void *vaddr, dma_addr_t dma_handle)
+{
+	iommu_free_coherent(&vio_iommu_table, size, vaddr, dma_handle);
+}
+EXPORT_SYMBOL_GPL(iseries_hv_free);
+
+dma_addr_t iseries_hv_map(void *vaddr, size_t size,
+			enum dma_data_direction direction)
+{
+	return iommu_map_single(&vio_iommu_table, vaddr, size,
+				DMA_32BIT_MASK, direction);
+}
+
+void iseries_hv_unmap(dma_addr_t dma_handle, size_t size,
+			enum dma_data_direction direction)
+{
+	iommu_unmap_single(&vio_iommu_table, dma_handle, size, direction);
+}
+
 void iommu_init_early_iSeries(void)
 {
 	ppc_md.tce_build = tce_build_iSeries;
diff --git a/arch/powerpc/platforms/iseries/mf.c b/arch/powerpc/platforms/iseries/mf.c
index b1187d9..c0f2433 100644
--- a/arch/powerpc/platforms/iseries/mf.c
+++ b/arch/powerpc/platforms/iseries/mf.c
@@ -39,9 +39,9 @@
 #include <asm/paca.h>
 #include <asm/abs_addr.h>
 #include <asm/firmware.h>
-#include <asm/iseries/vio.h>
 #include <asm/iseries/mf.h>
 #include <asm/iseries/hv_lp_config.h>
+#include <asm/iseries/hv_lp_event.h>
 #include <asm/iseries/it_lp_queue.h>
 
 #include "setup.h"
@@ -870,8 +870,7 @@ static int proc_mf_dump_cmdline(char *page, char **start, off_t off,
 	if ((off + count) > 256)
 		count = 256 - off;
 
-	dma_addr = dma_map_single(iSeries_vio_dev, page, off + count,
-			DMA_FROM_DEVICE);
+	dma_addr = iseries_hv_map(page, off + count, DMA_FROM_DEVICE);
 	if (dma_mapping_error(dma_addr))
 		return -ENOMEM;
 	memset(page, 0, off + count);
@@ -883,8 +882,7 @@ static int proc_mf_dump_cmdline(char *page, char **start, off_t off,
 	vsp_cmd.sub_data.kern.length = off + count;
 	mb();
 	rc = signal_vsp_instruction(&vsp_cmd);
-	dma_unmap_single(iSeries_vio_dev, dma_addr, off + count,
-			DMA_FROM_DEVICE);
+	iseries_hv_unmap(dma_addr, off + count, DMA_FROM_DEVICE);
 	if (rc)
 		return rc;
 	if (vsp_cmd.result_code != 0)
@@ -919,8 +917,7 @@ static int mf_getVmlinuxChunk(char *buffer, int *size, int offset, u64 side)
 	int len = *size;
 	dma_addr_t dma_addr;
 
-	dma_addr = dma_map_single(iSeries_vio_dev, buffer, len,
-			DMA_FROM_DEVICE);
+	dma_addr = iseries_hv_map(buffer, len, DMA_FROM_DEVICE);
 	memset(buffer, 0, len);
 	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
 	vsp_cmd.cmd = 32;
@@ -938,7 +935,7 @@ static int mf_getVmlinuxChunk(char *buffer, int *size, int offset, u64 side)
 			rc = -ENOMEM;
 	}
 
-	dma_unmap_single(iSeries_vio_dev, dma_addr, len, DMA_FROM_DEVICE);
+	iseries_hv_unmap(dma_addr, len, DMA_FROM_DEVICE);
 
 	return rc;
 }
@@ -1149,8 +1146,7 @@ static int proc_mf_change_cmdline(struct file *file, const char __user *buffer,
 		goto out;
 
 	dma_addr = 0;
-	page = dma_alloc_coherent(iSeries_vio_dev, count, &dma_addr,
-			GFP_ATOMIC);
+	page = iseries_hv_alloc(count, &dma_addr, GFP_ATOMIC);
 	ret = -ENOMEM;
 	if (page == NULL)
 		goto out;
@@ -1170,7 +1166,7 @@ static int proc_mf_change_cmdline(struct file *file, const char __user *buffer,
 	ret = count;
 
 out_free:
-	dma_free_coherent(iSeries_vio_dev, count, page, dma_addr);
+	iseries_hv_free(count, page, dma_addr);
 out:
 	return ret;
 }
@@ -1190,8 +1186,7 @@ static ssize_t proc_mf_change_vmlinux(struct file *file,
 		goto out;
 
 	dma_addr = 0;
-	page = dma_alloc_coherent(iSeries_vio_dev, count, &dma_addr,
-			GFP_ATOMIC);
+	page = iseries_hv_alloc(count, &dma_addr, GFP_ATOMIC);
 	rc = -ENOMEM;
 	if (page == NULL) {
 		printk(KERN_ERR "mf.c: couldn't allocate memory to set vmlinux chunk\n");
@@ -1219,7 +1214,7 @@ static ssize_t proc_mf_change_vmlinux(struct file *file,
 	*ppos += count;
 	rc = count;
 out_free:
-	dma_free_coherent(iSeries_vio_dev, count, page, dma_addr);
+	iseries_hv_free(count, page, dma_addr);
 out:
 	return rc;
 }
diff --git a/arch/powerpc/platforms/iseries/viopath.c b/arch/powerpc/platforms/iseries/viopath.c
index 45f2fe3..df23331 100644
--- a/arch/powerpc/platforms/iseries/viopath.c
+++ b/arch/powerpc/platforms/iseries/viopath.c
@@ -124,8 +124,7 @@ static int proc_viopath_show(struct seq_file *m, void *v)
 	if (!buf)
 		return 0;
 
-	handle = dma_map_single(iSeries_vio_dev, buf, HW_PAGE_SIZE,
-				DMA_FROM_DEVICE);
+	handle = iseries_hv_map(buf, HW_PAGE_SIZE, DMA_FROM_DEVICE);
 
 	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
 			HvLpEvent_Type_VirtualIo,
@@ -146,8 +145,7 @@ static int proc_viopath_show(struct seq_file *m, void *v)
 	buf[HW_PAGE_SIZE-1] = '\0';
 	seq_printf(m, "%s", buf);
 
-	dma_unmap_single(iSeries_vio_dev, handle, HW_PAGE_SIZE,
-			 DMA_FROM_DEVICE);
+	iseries_hv_unmap(handle, HW_PAGE_SIZE, DMA_FROM_DEVICE);
 	kfree(buf);
 
 	seq_printf(m, "AVAILABLE_VETH=%x\n", vlanMap);
diff --git a/drivers/cdrom/viocd.c b/drivers/cdrom/viocd.c
index b88fdeb..c081e54 100644
--- a/drivers/cdrom/viocd.c
+++ b/drivers/cdrom/viocd.c
@@ -220,7 +220,7 @@ static void __init get_viocd_info(void)
 	struct cdrom_info *viocd_unitinfo;
 	dma_addr_t unitinfo_dmaaddr;
 
-	viocd_unitinfo = dma_alloc_coherent(iSeries_vio_dev,
+	viocd_unitinfo = iseries_hv_alloc(
 			sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
 			&unitinfo_dmaaddr, GFP_ATOMIC);
 	if (viocd_unitinfo == NULL) {
@@ -262,8 +262,7 @@ static void __init get_viocd_info(void)
 	}
 
 error_ret:
-	dma_free_coherent(iSeries_vio_dev,
-			sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
+	iseries_hv_free(sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
 			viocd_unitinfo, unitinfo_dmaaddr);
 }
 
diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
index e12275d..064c091 100644
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -392,8 +392,8 @@ static int get_viotape_info(void)
 	if (op == NULL)
 		return -ENOMEM;
 
-	viotape_unitinfo = dma_alloc_coherent(iSeries_vio_dev, len,
-		&viotape_unitinfo_token, GFP_ATOMIC);
+	viotape_unitinfo = iseries_hv_alloc(len, &viotape_unitinfo_token,
+		GFP_ATOMIC);
 	if (viotape_unitinfo == NULL) {
 		free_op_struct(op);
 		return -ENOMEM;
@@ -1103,8 +1103,7 @@ static void __exit viotap_exit(void)
 	class_destroy(tape_class);
 	unregister_chrdev(VIOTAPE_MAJOR, "viotape");
 	if (viotape_unitinfo)
-		dma_free_coherent(iSeries_vio_dev,
-				sizeof(viotape_unitinfo[0]) * VIOTAPE_MAX_TAPE,
+		iseries_hv_free(sizeof(viotape_unitinfo[0]) * VIOTAPE_MAX_TAPE,
 				viotape_unitinfo, viotape_unitinfo_token);
 	viopath_close(viopath_hostLp, viomajorsubtype_tape, VIOTAPE_MAXREQ + 2);
 	vio_clearHandler(viomajorsubtype_tape);
diff --git a/include/asm-powerpc/iseries/hv_call_event.h b/include/asm-powerpc/iseries/hv_call_event.h
index 4cec476..cc029d3 100644
--- a/include/asm-powerpc/iseries/hv_call_event.h
+++ b/include/asm-powerpc/iseries/hv_call_event.h
@@ -21,6 +21,9 @@
 #ifndef _ASM_POWERPC_ISERIES_HV_CALL_EVENT_H
 #define _ASM_POWERPC_ISERIES_HV_CALL_EVENT_H
 
+#include <linux/types.h>
+#include <linux/dma-mapping.h>
+
 #include <asm/iseries/hv_call_sc.h>
 #include <asm/iseries/hv_types.h>
 #include <asm/abs_addr.h>
@@ -113,6 +116,13 @@ static inline HvLpEvent_Rc HvCallEvent_signalLpEventFast(HvLpIndex targetLp,
 			eventData3, eventData4, eventData5);
 }
 
+extern void *iseries_hv_alloc(size_t size, dma_addr_t *dma_handle, gfp_t flag);
+extern void iseries_hv_free(size_t size, void *vaddr, dma_addr_t dma_handle);
+extern dma_addr_t iseries_hv_map(void *vaddr, size_t size,
+			enum dma_data_direction direction);
+extern void iseries_hv_unmap(dma_addr_t dma_handle, size_t size,
+			enum dma_data_direction direction);
+
 static inline HvLpEvent_Rc HvCallEvent_ackLpEvent(struct HvLpEvent *event)
 {
 	return HvCall1(HvCallEventAckLpEvent, virt_to_abs(event));
diff --git a/include/asm-powerpc/iseries/vio.h b/include/asm-powerpc/iseries/vio.h
index 7a95d29..5a5cd0f 100644
--- a/include/asm-powerpc/iseries/vio.h
+++ b/include/asm-powerpc/iseries/vio.h
@@ -150,8 +150,4 @@ enum viochar_rc {
 	viochar_rc_ebusy = 1
 };
 
-struct device;
-
-extern struct device *iSeries_vio_dev;
-
 #endif /* _ASM_POWERPC_ISERIES_VIO_H */
-- 
1.5.3.4
