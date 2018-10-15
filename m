Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7EAC7112B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:46:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2294A2064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2294A2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YYV91J3rzF3F1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:46:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42YYCm6hH1zDr1F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:33:40 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id D044AAE807ED;
 Mon, 15 Oct 2018 05:33:07 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 2/5] powerpc/powernv/npu: Collect all static symbols
 under one struct
Date: Mon, 15 Oct 2018 20:32:58 +1100
Message-Id: <20181015093301.1007-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181015093301.1007-1-aik@ozlabs.ru>
References: <20181015093301.1007-1-aik@ozlabs.ru>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We are going to add a global list of NPUs in the system which is going
to be yet another static symbol. Let's reorganise the code and put all
static symbols into one struct for better tracking what is really needed
for NPU (this might become a driver data some day).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/pci.h            |  1 +
 arch/powerpc/platforms/powernv/npu-dma.c  | 77 ++++++++++++++++++-------------
 arch/powerpc/platforms/powernv/pci-ioda.c |  2 +
 3 files changed, 47 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 2af9ded..1a96075 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -129,5 +129,6 @@ extern void pcibios_scan_phb(struct pci_controller *hose);
 
 extern struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev);
 extern struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index);
+extern void pnv_npu2_devices_init(void);
 
 #endif /* __ASM_POWERPC_PCI_H */
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 13e5153..01402f9 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -22,20 +22,6 @@
 #include "pci.h"
 
 /*
- * spinlock to protect initialisation of an npu_context for a particular
- * mm_struct.
- */
-static DEFINE_SPINLOCK(npu_context_lock);
-
-/*
- * When an address shootdown range exceeds this threshold we invalidate the
- * entire TLB on the GPU for the given PID rather than each specific address in
- * the range.
- */
-static uint64_t atsd_threshold = 2 * 1024 * 1024;
-static struct dentry *atsd_threshold_dentry;
-
-/*
  * Other types of TCE cache invalidation are not functional in the
  * hardware.
  */
@@ -392,6 +378,33 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
 /*
  * NPU2 ATS
  */
+static struct {
+	/*
+	 * spinlock to protect initialisation of an npu_context for
+	 * a particular mm_struct.
+	 */
+	spinlock_t context_lock;
+
+	/* Maximum index of npu2 hosts in the system. Always < NV_MAX_NPUS */
+	int max_index;
+
+	/*
+	 * When an address shootdown range exceeds this threshold we invalidate the
+	 * entire TLB on the GPU for the given PID rather than each specific address in
+	 * the range.
+	 */
+	uint64_t atsd_threshold;
+	struct dentry *atsd_threshold_dentry;
+
+} npu2_devices;
+
+void pnv_npu2_devices_init(void)
+{
+	memset(&npu2_devices, 0, sizeof(npu2_devices));
+	spin_lock_init(&npu2_devices.context_lock);
+	npu2_devices.atsd_threshold = 2 * 1024 * 1024;
+}
+
 static struct npu *npdev_to_npu(struct pci_dev *npdev)
 {
 	struct pnv_phb *nphb;
@@ -404,9 +417,6 @@ static struct npu *npdev_to_npu(struct pci_dev *npdev)
 /* Maximum number of nvlinks per npu */
 #define NV_MAX_LINKS 6
 
-/* Maximum index of npu2 hosts in the system. Always < NV_MAX_NPUS */
-static int max_npu2_index;
-
 struct npu_context {
 	struct mm_struct *mm;
 	struct pci_dev *npdev[NV_MAX_NPUS][NV_MAX_LINKS];
@@ -472,7 +482,7 @@ static void mmio_invalidate_pid(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
 	int i;
 	unsigned long launch;
 
-	for (i = 0; i <= max_npu2_index; i++) {
+	for (i = 0; i <= npu2_devices.max_index; i++) {
 		if (mmio_atsd_reg[i].reg < 0)
 			continue;
 
@@ -503,7 +513,7 @@ static void mmio_invalidate_va(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
 	int i;
 	unsigned long launch;
 
-	for (i = 0; i <= max_npu2_index; i++) {
+	for (i = 0; i <= npu2_devices.max_index; i++) {
 		if (mmio_atsd_reg[i].reg < 0)
 			continue;
 
@@ -536,7 +546,7 @@ static void mmio_invalidate_wait(
 	int i, reg;
 
 	/* Wait for all invalidations to complete */
-	for (i = 0; i <= max_npu2_index; i++) {
+	for (i = 0; i <= npu2_devices.max_index; i++) {
 		if (mmio_atsd_reg[i].reg < 0)
 			continue;
 
@@ -559,7 +569,7 @@ static void acquire_atsd_reg(struct npu_context *npu_context,
 	struct npu *npu;
 	struct pci_dev *npdev;
 
-	for (i = 0; i <= max_npu2_index; i++) {
+	for (i = 0; i <= npu2_devices.max_index; i++) {
 		mmio_atsd_reg[i].reg = -1;
 		for (j = 0; j < NV_MAX_LINKS; j++) {
 			/*
@@ -593,7 +603,7 @@ static void release_atsd_reg(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
 {
 	int i;
 
-	for (i = 0; i <= max_npu2_index; i++) {
+	for (i = 0; i <= npu2_devices.max_index; i++) {
 		/*
 		 * We can't rely on npu_context->npdev[][] being the same here
 		 * as when acquire_atsd_reg() was called, hence we use the
@@ -683,7 +693,7 @@ static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
 	struct npu_context *npu_context = mn_to_npu_context(mn);
 	unsigned long address;
 
-	if (end - start > atsd_threshold) {
+	if (end - start > npu2_devices.atsd_threshold) {
 		/*
 		 * Just invalidate the entire PID if the address range is too
 		 * large.
@@ -777,12 +787,12 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	 * We store the npu pci device so we can more easily get at the
 	 * associated npus.
 	 */
-	spin_lock(&npu_context_lock);
+	spin_lock(&npu2_devices.context_lock);
 	npu_context = mm->context.npu_context;
 	if (npu_context) {
 		if (npu_context->release_cb != cb ||
 			npu_context->priv != priv) {
-			spin_unlock(&npu_context_lock);
+			spin_unlock(&npu2_devices.context_lock);
 			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
 						PCI_DEVID(gpdev->bus->number,
 							gpdev->devfn));
@@ -791,12 +801,12 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 
 		WARN_ON(!kref_get_unless_zero(&npu_context->kref));
 	}
-	spin_unlock(&npu_context_lock);
+	spin_unlock(&npu2_devices.context_lock);
 
 	if (!npu_context) {
 		/*
 		 * We can set up these fields without holding the
-		 * npu_context_lock as the npu_context hasn't been returned to
+		 * npu2_devices.context_lock as the npu_context hasn't been returned to
 		 * the caller meaning it can't be destroyed. Parallel allocation
 		 * is protected against by mmap_sem.
 		 */
@@ -887,9 +897,9 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], NULL);
 	opal_npu_destroy_context(nphb->opal_id, npu_context->mm->context.id,
 				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
-	spin_lock(&npu_context_lock);
+	spin_lock(&npu2_devices.context_lock);
 	removed = kref_put(&npu_context->kref, pnv_npu2_release_context);
-	spin_unlock(&npu_context_lock);
+	spin_unlock(&npu2_devices.context_lock);
 
 	/*
 	 * We need to do this outside of pnv_npu2_release_context so that it is
@@ -958,9 +968,10 @@ int pnv_npu2_init(struct pnv_phb *phb)
 	static int npu_index;
 	uint64_t rc = 0;
 
-	if (!atsd_threshold_dentry) {
-		atsd_threshold_dentry = debugfs_create_x64("atsd_threshold",
-				   0600, powerpc_debugfs_root, &atsd_threshold);
+	if (!npu2_devices.atsd_threshold_dentry) {
+		npu2_devices.atsd_threshold_dentry = debugfs_create_x64(
+				"atsd_threshold", 0600, powerpc_debugfs_root,
+				&npu2_devices.atsd_threshold);
 	}
 
 	phb->npu.nmmu_flush =
@@ -988,7 +999,7 @@ int pnv_npu2_init(struct pnv_phb *phb)
 	npu_index++;
 	if (WARN_ON(npu_index >= NV_MAX_NPUS))
 		return -ENOSPC;
-	max_npu2_index = npu_index;
+	npu2_devices.max_index = npu_index;
 	phb->npu.index = npu_index;
 
 	return 0;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index e37b9cc..0cc81c0 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1279,6 +1279,8 @@ static void pnv_pci_ioda_setup_PEs(void)
 	struct pci_bus *bus;
 	struct pci_dev *pdev;
 
+	pnv_npu2_devices_init();
+
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		phb = hose->private_data;
 		if (phb->type == PNV_PHB_NPU_NVLINK) {
-- 
2.11.0

