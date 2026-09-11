Return-Path: <linuxppc-dev+bounces-27123-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128EFC88E4D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 12:36:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhDYs387Lz2ygK;
	Fri, 11 Sep 2026 22:36:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789130193;
	cv=none; b=E7onA+oAAoyWNxwhMyaCJqA2kKBfTgzJf25eXOZiy1PoUmRlTXI7AlR48ZLmV9mcvlUF4MELVqOVMshQkLlcl9UubaBydMCrKhYdmFc1nUytMbuQN9d3H0aXP29+Htzz8jsb3a+58Kzw7FKE43VrvUGUoE3aY3zODC/ikv5pxh6/hrI+2GZZ63E5Phyh0ou7tJRB8+40Tz2thXNFYT897w/EBqhdwNAwZSbx+F+f0iU77qVBv1gihcLrHMCnBaeaqKmyLIRpUoBUpQ8/8f8UxDi8g/hKt8wow7BgX9Mh5tgEe4gWNmfbzk6pQhVUnwAikYoarwwnQfDC9VsVSbnphA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789130193; c=relaxed/relaxed;
	bh=kYtmQzWImh1FZ8UPN3pnnVay1G/L6DByR/Zk2VvQLck=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=PZCJ1V2fDu2nCh1qBY/bIbwPMdQaMuf4YeTIpGgMG2QyPdRiY4xiyWO1fV96FPYfuHkk9HenNGrFi6w3FZBsNBRRwMA4tMKwnWPmDPyDk1ojDhZhWPpY3fsDHR57fc59dBvePHLn4R4A9a4gmqxx0dFj/WB26SPlmUwLhKH0ewqlVTmstcNK7BRXew3V4DaP1d3+GKfGfqzblprVmBLuLgcCjFGUIW8jdEmwdqTtBchU3BP2pIzly8vdMmns0MO9fFKZhtxDnn29k3gpGm6B1kaVFOeqL33P+u2Gh2DEZAmEFFYY39T+BYv89nuO5OEbKleFkhPXxenhYI+t7KfcdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iloosSm7; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iloosSm7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhDYr0Dgmz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 22:36:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3BF1A60A57;
	Fri, 11 Sep 2026 12:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298A51F000FF;
	Fri, 11 Sep 2026 12:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789130187;
	bh=kYtmQzWImh1FZ8UPN3pnnVay1G/L6DByR/Zk2VvQLck=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=iloosSm75n+QS7sZBsoBU9YTx2hIzAAFm0VAj3gwvXe4ZbJzJJOq0uogX6K4RYAuq
	 ePUqZO7tON04UQa4mHcpxyMLu70TdnnlPYWND9pWr2QPAs1df9EaEn0jmnKTRPqkFU
	 MsakJrHep+Op20yJfyQGqmNsgNdwdEpj1dUQRpFc=
Subject: Patch "PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value" has been added to the 6.18-stable tree
To: alifm@linux.ibm.com,bhelgaas@google.com,gregkh@linuxfoundation.org,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,sashal@kernel.org,tyreld@linux.ibm.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 11 Sep 2026 14:32:51 +0200
In-Reply-To: <20260909141434.2391408-1-sashal@kernel.org>
Message-ID: <2026091151-lustfully-haphazard-d38a@gregkh>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     pci-introduce-pci_slot_placeholder-constant-for-slot_nr-placeholder-value.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-319952-greg=kroah.com@vger.kernel.org Wed Sep  9 17:30:11 2026
From: Sasha Levin <sashal@kernel.org>
Date: Wed,  9 Sep 2026 10:14:33 -0400
Subject: PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value
To: stable@vger.kernel.org
Cc: Farhan Ali <alifm@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Tyrel Datwyler <tyreld@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Message-ID: <20260909141434.2391408-1-sashal@kernel.org>

From: Farhan Ali <alifm@linux.ibm.com>

[ Upstream commit c243e6c470c4695965cc8287767925bc1d9a7867 ]

Introduce a constant for placeholder value and update the kerneldoc for
pci_create_slot() to reference PCI_SLOT_PLACEHOLDER instead of -1
throughout. No functional change.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://patch.msgid.link/20260805165518.794-2-alifm@linux.ibm.com

Stable backport: this tree predates 102c8b26b54e ("PCI: Allow all bus
devices to use the same slot"). Include its PCI_SLOT_ALL_DEVICES definition,
slot-number documentation, and core matching/address handling so that
subsequent commit dcc5bec09e23 ("PCI: Allow per function PCI slots to fix
slot reset on s390") applies without conflicts. Keep the PCIe hotplug
callers unchanged; enabling bus-wide slots there is outside this dependency.

Retain the stable tree's kzalloc() and ATTRIBUTE_GROUPS() implementations.
The placeholder conversion covers both PowerPC hotplug callers and the
PCI core. All code changes stay within existing functions.

Stable-dep-of: dcc5bec09e23 ("PCI: Allow per function PCI slots to fix slot reset on s390")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/hotplug/pnv_php.c     |    2 -
 drivers/pci/hotplug/rpaphp_slot.c |    2 -
 drivers/pci/slot.c                |   50 ++++++++++++++++++++++++++++----------
 include/linux/pci.h               |   13 +++++++++
 4 files changed, 51 insertions(+), 16 deletions(-)

--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -813,7 +813,7 @@ static struct pnv_php_slot *pnv_php_allo
 	if (dn->child && PCI_DN(dn->child))
 		php_slot->slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
 	else
-		php_slot->slot_no = -1;   /* Placeholder slot */
+		php_slot->slot_no = PCI_SLOT_PLACEHOLDER;   /* Placeholder slot */
 
 	kref_init(&php_slot->kref);
 	php_slot->state	                = PNV_PHP_STATE_INITIALIZED;
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -85,7 +85,7 @@ int rpaphp_register_slot(struct slot *sl
 	struct device_node *child;
 	u32 my_index;
 	int retval;
-	int slotno = -1;
+	int slotno = PCI_SLOT_PLACEHOLDER;
 
 	dbg("%s registering slot:path[%pOF] index[%x], name[%s] pdomain[%x] type[%d]\n",
 		__func__, slot->dn, slot->index, slot->name,
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -37,11 +37,20 @@ static const struct sysfs_ops pci_slot_s
 
 static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 {
-	if (slot->number == 0xff)
+	if (slot->number == PCI_SLOT_PLACEHOLDER)
 		return sysfs_emit(buf, "%04x:%02x\n",
 				  pci_domain_nr(slot->bus),
 				  slot->bus->number);
 
+	/*
+	 * Preserve legacy ABI expectations that hotplug drivers that manage
+	 * multiple devices per slot emit 0 for the device number.
+	 */
+	if (slot->number == PCI_SLOT_ALL_DEVICES)
+		return sysfs_emit(buf, "%04x:%02x:00\n",
+				  pci_domain_nr(slot->bus),
+				  slot->bus->number);
+
 	return sysfs_emit(buf, "%04x:%02x:%02x\n",
 			  pci_domain_nr(slot->bus),
 			  slot->bus->number,
@@ -73,7 +82,8 @@ static void pci_slot_release(struct kobj
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (slot->number == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = NULL;
 	up_read(&pci_bus_sem);
 
@@ -166,7 +176,8 @@ void pci_dev_assign_slot(struct pci_dev
 
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (slot->number == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = slot;
 	mutex_unlock(&pci_slot_mutex);
 }
@@ -188,7 +199,8 @@ static struct pci_slot *get_slot(struct
 /**
  * pci_create_slot - create or increment refcount for physical PCI slot
  * @parent: struct pci_bus of parent bridge
- * @slot_nr: PCI_SLOT(pci_dev->devfn) or -1 for placeholder
+ * @slot_nr: PCI_SLOT(pci_dev->devfn), PCI_SLOT_PLACEHOLDER for placeholder, or
+ *	PCI_SLOT_ALL_DEVICES
  * @name: user visible string presented in /sys/bus/pci/slots/<name>
  * @hotplug: set if caller is hotplug driver, NULL otherwise
  *
@@ -213,15 +225,26 @@ static struct pci_slot *get_slot(struct
  * In most cases, @pci_bus, @slot_nr will be sufficient to uniquely identify
  * a slot. There is one notable exception - pSeries (rpaphp), where the
  * @slot_nr cannot be determined until a device is actually inserted into
- * the slot. In this scenario, the caller may pass -1 for @slot_nr.
+ * the slot. In this scenario, the caller may pass PCI_SLOT_PLACEHOLDER for @slot_nr.
  *
  * The following semantics are imposed when the caller passes @slot_nr ==
- * -1. First, we no longer check for an existing %struct pci_slot, as there
- * may be many slots with @slot_nr of -1.  The other change in semantics is
- * user-visible, which is the 'address' parameter presented in sysfs will
- * consist solely of a dddd:bb tuple, where dddd is the PCI domain of the
- * %struct pci_bus and bb is the bus number. In other words, the devfn of
- * the 'placeholder' slot will not be displayed.
+ * PCI_SLOT_PLACEHOLDER. First, we no longer check for an existing %struct
+ * pci_slot, as there may be many slots with @slot_nr of
+ * PCI_SLOT_PLACEHOLDER. The other change in semantics is user-visible,
+ * which is the 'address' parameter presented in sysfs will consist solely
+ * of a dddd:bb tuple, where dddd is the PCI domain of the %struct pci_bus
+ * and bb is the bus number. In other words, the devfn of the 'placeholder'
+ * slot will not be displayed.
+ *
+ * Bus-wide slots:
+ * For PCIe hotplug, the physical slot encompasses the entire secondary
+ * bus, not just a single device number. If the device supports ARI and ARI
+ * Forwarding is enabled in the upstream bridge, a multi-function device
+ * may include functions that appear to have several different device
+ * numbers, i.e., PCI_SLOT() values.  Pass @slot_nr == PCI_SLOT_ALL_DEVICES
+ * to create a slot that matches all devices on the bus. Unlike placeholder
+ * slots, bus-wide slots go through normal slot lookup and reuse existing
+ * slots if present.
  */
 struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 				 const char *name,
@@ -234,7 +257,7 @@ struct pci_slot *pci_create_slot(struct
 
 	mutex_lock(&pci_slot_mutex);
 
-	if (slot_nr == -1)
+	if (slot_nr == PCI_SLOT_PLACEHOLDER)
 		goto placeholder;
 
 	/*
@@ -285,7 +308,8 @@ placeholder:
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot_nr)
+		if (slot_nr == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot_nr)
 			dev->slot = slot;
 	up_read(&pci_bus_sem);
 
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -72,12 +72,23 @@
 /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
 #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
 
+/*
+ * PCI_SLOT_ALL_DEVICES indicates a slot that covers all devices on the bus.
+ * Used for PCIe hotplug where the physical slot is the entire secondary bus,
+ * and, if ARI Forwarding is enabled, functions may appear to be on multiple
+ * devices.
+ */
+#define PCI_SLOT_ALL_DEVICES	0xfe
+
+/* Used to identify a slot as a placeholder */
+#define PCI_SLOT_PLACEHOLDER	0xff
+
 /* pci_slot represents a physical slot */
 struct pci_slot {
 	struct pci_bus		*bus;		/* Bus this slot is on */
 	struct list_head	list;		/* Node in list of slots */
 	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
-	unsigned char		number;		/* PCI_SLOT(pci_dev->devfn) */
+	unsigned char		number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
 	struct kobject		kobj;
 };
 


Patches currently in stable-queue which might be from sashal@kernel.org are

queue-6.18/i2c-qcom-cci-fix-autosuspend-cleanup.patch
queue-6.18/ring-buffer-show-persistent-buffer-dropped-events-in-trace_pipe-file.patch
queue-6.18/nvdimm-virtio_pmem-refcount-requests-for-token-lifetime.patch
queue-6.18/i3c-master-fix-recursive-locking-during-device-registration.patch
queue-6.18/mm-damon-sysfs-read-ops_id-only-once-in-damon_sysfs_.patch
queue-6.18/dma-buf-dma-heap-don-t-publish-fd-before-copy_to_user-succeeds.patch
queue-6.18/tracing-probes-fix-anon_stack-check-for-unnamed-bitfields-in-btf_find_struct_member.patch
queue-6.18/futex-optimize-futex-hash-bucket-access-patterns.patch
queue-6.18/tracing-take-trace_array-reference-when-opening-options-file.patch
queue-6.18/mm-secretmem-properly-account-locked-pages.patch
queue-6.18/compiler_types-move-lock-checking-attributes-to-compiler-context-analysis.h.patch
queue-6.18/io_uring-add-wrapper-type-for-io_req_tw_func_t-arg.patch
queue-6.18/platform-x86-int1092-fix-potential-memory-leak-in-sar_probe.patch
queue-6.18/platform-x86-hp-wmi-add-support-for-omen-max-16-ak0xxx-8dd6.patch
queue-6.18/fs-ntfs3-fix-slab-out-of-bounds-write-in-ni_create_attr_list.patch
queue-6.18/alsa-fcp-do-not-copy-out-an-uninitialised-init-response.patch
queue-6.18/accel-amdxdna-return-early-from-a-zero-length-flush.patch
queue-6.18/nvdimm-preserve-flush-callback-enomem.patch
queue-6.18/tracing-make-printk_trace-global-for-tracing-system.patch
queue-6.18/udf-move-udf_map_block-up.patch
queue-6.18/pci-allow-per-function-pci-slots-to-fix-slot-reset-on-s390.patch
queue-6.18/i3c-master-fix-device_register-error-path.patch
queue-6.18/mtd-rawnand-pl353-add-message-about-ecc-mode.patch
queue-6.18/nvme-fold-nvme_config_discard-into-nvme_update_disk_info.patch
queue-6.18/nvdimm-virtio_pmem-use-read_once-write_once-for-wait-flags.patch
queue-6.18/io_uring-waitid-avoid-siginfo-copy-during-ring-teardown.patch
queue-6.18/wifi-rtw89-pci-add-.shutdown-callback-to-stop-rfkill-polling-on-reboot.patch
queue-6.18/net-mlx5e-shampo-always-calculate-page-size.patch
queue-6.18/perf-core-fix-deadlock-in-perf_mmap-failure-path.patch
queue-6.18/usb-cdnsp-fix-wakeup-from-s3-after-controller-context-loss.patch
queue-6.18/staging-sm750fb-fix-mono-image-source-stride-mismatch-in-lynxfb_ops_imageblit.patch
queue-6.18/nvdimm-virtio_pmem-always-wake-enospc-waiters.patch
queue-6.18/mm-huge_memory-transfer-the-pmd-dirty-bit-to-the-folio-on-zap.patch
queue-6.18/batman-adv-fix-tx-priority-extraction-for-batadv_for.patch
queue-6.18/platform-x86-intel_sar-check-acpi_handle-against-null.patch
queue-6.18/tracing-probes-fix-btf-kflag-check-for-anonymous-struct-member-access.patch
queue-6.18/mtd-rawnand-pl353-make-sure-we-use-the-monolithic-helpers-for-raw-accesses.patch
queue-6.18/i3c-master-do-not-treat-master-device-as-a-duplicate-target.patch
queue-6.18/platform-x86-isst-validate-max-level-for-set-feature.patch
queue-6.18/asoc-tegra-fix-the-mixer-enable-default-value.patch
queue-6.18/ring-buffer-allow-splice-reads-on-static-buffers.patch
queue-6.18/i2c-qcom-cci-remove-overcautious-disable_irq-calls.patch
queue-6.18/drm-amd-display-scale-custom-brightness-curve-from-f.patch
queue-6.18/fs-ntfs3-fix-kmsan-uninit-value-in-ni_create_attr_list.patch
queue-6.18/io_uring-waitid-have-io_waitid_complete-remove-wait-queue-entry.patch
queue-6.18/nvme-skip-the-zoned-limits-update-if-the-zone-info-query-failed.patch
queue-6.18/futex-provide-rt_mutex_.-_schedule-equivalents-for-futex-scheduling.patch
queue-6.18/net-mlx5e-xsk-fix-unlocked-writing-to-icosq.patch
queue-6.18/asoc-tegra210_mixer-sort-the-register-default-table.patch
queue-6.18/tracing-clean-up-use-of-trace_create_maxlat_file.patch
queue-6.18/pci-introduce-pci_slot_placeholder-constant-for-slot_nr-placeholder-value.patch
queue-6.18/alsa-usb-audio-relax-__free-variable-declarations.patch
queue-6.18/platform-x86-amd-pmc-fix-msg_port-restoration-in-amd_stb_debugfs_open_v2.patch
queue-6.18/io_uring-waitid-honor-task_work-cancellation.patch
queue-6.18/batman-adv-bla-avoid-crc-corruption-due-to-parallel-.patch
queue-6.18/batman-adv-dat-atomically-update-mac-addresses.patch
queue-6.18/ftrace-take-trace_array-reference-before-accessing-its-ftrace_ops.patch
queue-6.18/platform-x86-isst-check-for-admin-capability-for-write-commands.patch
queue-6.18/misc-fastrpc-don-t-publish-fd-before-copy_to_user-succeeds.patch
queue-6.18/i2c-qcom-cci-do-not-check-return-value-of-cci_init.patch
queue-6.18/iio-light-apds9306-fix-pm-reference-leak-in-apds9306_read_data.patch
queue-6.18/mm-fix-incorrect-vm_flags-usage-when-checking-allowable-orders-for-tmpfs.patch
queue-6.18/udf-fix-data-loss-when-converting-inline-inodes-to-out-of-line.patch
queue-6.18/i3c-master-fix-use-after-free-of-master-this.patch
queue-6.18/tracing-probes-ignore-id-update-from-btf_type_skip_modifiers.patch
queue-6.18/clk-qcom-fix-test_ctl_hi-field-for-default_evo-plls.patch
queue-6.18/mm-mremap-reset-unfaulted-vma-page-offset-for-mremap_dontunmap.patch
queue-6.18/pm-runtime-wrapper-macros-for-acquire-acquire_err.patch
queue-6.18/net-mlx5e-do-not-hw-gro-coalesce-small-frames.patch
queue-6.18/staging-rtl8723bs-fix-oob-read-in-rtw_restruct_wmm_ie.patch
queue-6.18/perf-x86-intel-remove-anythread_deprecated-bit-from-perf_capabilities.patch
queue-6.18/nvdimm-pmem-keep-preflush-before-data-writes.patch
queue-6.18/io_uring-only-call-io_should_terminate_tw-once-for-ctx.patch
queue-6.18/io_uring-unify-task_work-cancelation-checks.patch
queue-6.18/drm-amd-display-fix-backlight-max_brightness-to-matc.patch
queue-6.18/wifi-mt76-mt7996-bound-the-device-eeprom-address-before-the-efuse-copy.patch
queue-6.18/perf-fix-use-after-free-when-perf-mmap-revival-races-with-the-last-munmap.patch
queue-6.18/nvdimm-virtio_pmem-stop-allocating-child-flush-bio.patch
queue-6.18/staging-rtl8723bs-fix-spacing-around-operators.patch
queue-6.18/usb-gadget-f_mass_storage-fix-null-pointer-dereference-in-fsg_common_set_num_buffers.patch

