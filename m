Return-Path: <linuxppc-dev+bounces-28559-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E511DCA5FC7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:05:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvxds2ZP9z2y24;
	Thu, 01 Oct 2026 00:05:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790777137;
	cv=none; b=IqrE4mf6UCA7n6CwopTd4ZwTGFu4DqEpUNqCK81/OCBr6E1JJY6ZtRch5Cn1AkDooJy7GgVTiS+/IEX9/FgMCpgoyOWcikgCaHxBLGpSF4oXEkXc+dgR0iVdgjC/wsyxqyl4VQgODczdWnEEvqPoHQfqKsA8lOQd5EmIw+5EHIpbsfYrOBA4s1txEnnp7izAWIpqP1kOIu6xdmMrYZDSels6QoZiZOPXMRzh6EdSzulg1DeftPZVDNsC+yYRpFVaDs1j+KdySFnfNp+dPO2GaHQQXpri5Odxq5qw2V2ZlhNo8fTlnHXKzQcXj6WlMjZ9KcnkaiOhLD7D0t2Db3jseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790777137; c=relaxed/relaxed;
	bh=mCzzkQclLdAAOGtVnNP3WwWC05CIp+8o2/d5CbTUnbg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=G8TJCzAhiQNYtS/RO14ig5VjHDzHL/bv/FORWlx2NMkvdcfpaJhfjNQnr78olmM9qye/67JHAhECuimxEM5LlUufQ8OR1jwv37eMw0v6rgtqUkC5mqOpYLF4QguapKgZhq9rn8Wm9xc1HOvQe7o8dPoDUFImBVLDbUbxoq2fz4fQ9UtGIILqNYfpliRC/DzOkbHW+Nbguin5ZxFMv1U6Q0ybk8WPuvsIuoLUjFvHDvoZNUEplkQno5mCLs+t6w0nJOxd8FJT04aVvL9w6A7kw0LIA4i2v9K2QYili7YvL/TrbXAvM+BOl4Vp5s5MO8hbTgs4tu/4kSsUppUuDF/w7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=v6XuYavc; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=v6XuYavc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvxdp4wxXz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:05:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1BB2E400B0;
	Wed, 30 Sep 2026 14:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453FB1F0089A;
	Wed, 30 Sep 2026 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790777132;
	bh=mCzzkQclLdAAOGtVnNP3WwWC05CIp+8o2/d5CbTUnbg=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=v6XuYavcPnh7CC7wgbgGdOFRP6hdRvCL4j+NLye+Go433T3CTJjX6JgZUIrBUfEYk
	 j0KxsgRQLgZLo3PBV6fujjmtePnqICT3jUfeqsX7IroKUeMFoilV2CncMcLwa2pNTx
	 9nqTnpwOEC2AW90VL3cHNuAzCaZjWoSMXkp8MJ1I=
Subject: Patch "PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value" has been added to the 6.12-stable tree
To: alifm@linux.ibm.com,bhelgaas@google.com,gregkh@linuxfoundation.org,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,sashal@kernel.org,tyreld@linux.ibm.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Sep 2026 15:56:22 +0200
In-Reply-To: <20260909141842.2422116-1-sashal@kernel.org>
Message-ID: <2026093022-recharger-seltzer-1225@gregkh>
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

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     pci-introduce-pci_slot_placeholder-constant-for-slot_nr-placeholder-value.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-320047-greg=kroah.com@vger.kernel.org Wed Sep  9 18:45:09 2026
From: Sasha Levin <sashal@kernel.org>
Date: Wed,  9 Sep 2026 10:18:41 -0400
Subject: PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value
To: stable@vger.kernel.org
Cc: Farhan Ali <alifm@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Tyrel Datwyler <tyreld@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Message-ID: <20260909141842.2422116-1-sashal@kernel.org>

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
@@ -800,7 +800,7 @@ static struct pnv_php_slot *pnv_php_allo
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
@@ -38,11 +38,20 @@ static const struct sysfs_ops pci_slot_s
 
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
@@ -74,7 +83,8 @@ static void pci_slot_release(struct kobj
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (slot->number == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = NULL;
 	up_read(&pci_bus_sem);
 
@@ -167,7 +177,8 @@ void pci_dev_assign_slot(struct pci_dev
 
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (slot->number == PCI_SLOT_ALL_DEVICES ||
+		    PCI_SLOT(dev->devfn) == slot->number)
 			dev->slot = slot;
 	mutex_unlock(&pci_slot_mutex);
 }
@@ -189,7 +200,8 @@ static struct pci_slot *get_slot(struct
 /**
  * pci_create_slot - create or increment refcount for physical PCI slot
  * @parent: struct pci_bus of parent bridge
- * @slot_nr: PCI_SLOT(pci_dev->devfn) or -1 for placeholder
+ * @slot_nr: PCI_SLOT(pci_dev->devfn), PCI_SLOT_PLACEHOLDER for placeholder, or
+ *	PCI_SLOT_ALL_DEVICES
  * @name: user visible string presented in /sys/bus/pci/slots/<name>
  * @hotplug: set if caller is hotplug driver, NULL otherwise
  *
@@ -214,15 +226,26 @@ static struct pci_slot *get_slot(struct
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
@@ -235,7 +258,7 @@ struct pci_slot *pci_create_slot(struct
 
 	mutex_lock(&pci_slot_mutex);
 
-	if (slot_nr == -1)
+	if (slot_nr == PCI_SLOT_PLACEHOLDER)
 		goto placeholder;
 
 	/*
@@ -287,7 +310,8 @@ placeholder:
 
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

queue-6.12/usb-typec-tcpm-constrain-tcpm_sourcing_vbus-event-handling.patch
queue-6.12/pci-fix-bar-resize-for-devices-on-a-root-bus.patch
queue-6.12/tcp-fix-use-after-free-of-retransmit_skb_hint-in-tcp.patch
queue-6.12/genetlink-report-the-real-command-id-for-dump-only-o.patch
queue-6.12/ksmbd-return-buffer-overflow-for-partial-filesystem-.patch
queue-6.12/wifi-mac80211-add-he-6-ghz-capability-in-the-scan-el.patch
queue-6.12/rdma-mad-fix-receive-buffer-leak-when-pkey-enforceme.patch
queue-6.12/net-bridge-mst-move-switchdev-call-outside-rcu.patch
queue-6.12/bpf-restrict-co-re-poisoning-to-relocatable-instruct.patch
queue-6.12/tipc-fix-a-data-race-on-mon-peer_cnt-in-mon_timeout.patch
queue-6.12/ipv4-icmp-reject-rtn_unreachable-input-routes-in-icm.patch
queue-6.12/net-sched-cls_u32-fix-manual-hash-table-handle-idr-a.patch
queue-6.12/drop_monitor-synchronize-tracepoint-unregistration-o.patch
queue-6.12/tcp-introduce-icsk-icsk_keepalive_timer.patch
queue-6.12/sctp-hold-asoc-or-transport-before-mod_timer-in-time.patch
queue-6.12/tracing-remove-get_trigger_ops-and-add-count_func-from-trigger-ops.patch
queue-6.12/lockd-fix-swapped-arguments-in-nlmsvc_match_ip.patch
queue-6.12/bpf-skip-unsettled-links-in-link-iterator.patch
queue-6.12/phy-mediatek-phy-mtk-hdmi-mt8195-fix-tmds-clk-bit-ra.patch
queue-6.12/drm-sysfb-simpledrm-improve-stride-validation.patch
queue-6.12/net-ethernet-ti-netcp-fix-pm_runtime-usage-counter-l.patch
queue-6.12/drm-msm-dpu-clear-pending-peripheral-flush-state.patch
queue-6.12/arm64-percpu-fix-lse-operations-on-8-16-bit-types.patch
queue-6.12/xhci-cleanup-candence-controller-pci-device-and-vendor-id-usage.patch
queue-6.12/wifi-mt76-mt7915-bound-the-device-eeprom-address-before-the-efuse-copy.patch
queue-6.12/mptcp-do-not-reschedule-the-rtx-timer-for-fallback-sockets.patch
queue-6.12/bridge-check-llc_mac_hdr_init-return-value-in-br_sen.patch
queue-6.12/wifi-rtw89-hide-some-errors-when-the-device-is-unplugged.patch
queue-6.12/neighbour-skip-default-parms-when-resumed-in-neightb.patch
queue-6.12/bluetooth-bnep-fix-out-of-bounds-reads-on-short-rx-t.patch
queue-6.12/kvm-x86-move-the-bulk-of-register-specific-code-from-x86.c-to-regs.c.patch
queue-6.12/smb-client-refactor-acl-setting-control-flow-in-id_mode_to_cifs_acl.patch
queue-6.12/mptcp-pm-rename-add_entry-structure-to-add_addr.patch
queue-6.12/clk-scpi-bound-check-dvfs-index-in-scpi_dvfs_recalc_.patch
queue-6.12/drm-bridge-samsung-dsim-fix-te-gpio-lifetime-for-hos.patch
queue-6.12/rdma-core-reject-unregistering-netdevs-in-ib_get_eth.patch
queue-6.12/bpf-fix-divide-by-zero-in-btf_struct_walk.patch
queue-6.12/wifi-mac80211-reset-the-ap_vlan-tailroom-counter-on-.patch
queue-6.12/net-macb-initialize-ptp-state-before-registering-clock.patch
queue-6.12/macsec-add-some-of-the-lower-device-s-features-when-.patch
queue-6.12/drm-client-pass-force-parameter-to-client-restore.patch
queue-6.12/vlan-require-the-mac-header-to-be-present-in-__vlan_insert_inner_tag.patch
queue-6.12/neighbour-convert-rtm_getneigh-to-rcu.patch
queue-6.12/sched-rework-prev_balance-to-avoid-stale-prev-references.patch
queue-6.12/net-netsec-fix-device_node-reference-leak-on-phy_np.patch
queue-6.12/ring-buffer-show-persistent-buffer-dropped-events-in-trace_pipe-file.patch
queue-6.12/cifs-fix-specification-of-function-pointers.patch
queue-6.12/media-chips-media-wave5-add-timeout-while-stop_streaming.patch
queue-6.12/perf-x86-intel-ensure-kvm-guest-pebs-path-doesn-t-se.patch
queue-6.12/media-i2c-imx355-replace-client-dev-usage.patch
queue-6.12/platform-x86-amd-pmc-define-enum-for-s2d-pmc-msg_port-and-add-helper-function.patch
queue-6.12/platform-x86-amd-pmc-restore-msg_port-on-amd_stb_s2d_init-error-paths.patch
queue-6.12/arm-socfpga-select-the-pl310-erratum-753970-workarou.patch
queue-6.12/wifi-mac80211-don-t-start-a-roc-while-scanning.patch
queue-6.12/net-bcmgenet-validate-ethernet-address-in-bcmgenet_s.patch
queue-6.12/tools-bootconfig-fix-integer-overflow-and-truncation-in-size-checks.patch
queue-6.12/nvdimm-virtio_pmem-refcount-requests-for-token-lifetime.patch
queue-6.12/mptcp-pm-kernel-drop-pending-add_addr-when-removing-id0.patch
queue-6.12/scsi-qla2xxx-fix-soft-lockup-polling-continuation-iocb-signature.patch
queue-6.12/iommu-msm-use-helper-function-devm_clk_get_prepared.patch
queue-6.12/bluetooth-rfcomm-avoid-socket-lock-inversion-in-list.patch
queue-6.12/scsi-qla2xxx-use-memset_io-to-clear-qlafx00-request-ring-slot.patch
queue-6.12/drm-amdgpu-failed-to-check-various-return-code.patch
queue-6.12/drm-sysfb-simpledrm-improve-panel-size-validation.patch
queue-6.12/mmc-via-sdmmc-cancel-card-detect-work-on-remove.patch
queue-6.12/wifi-mac80211-use-vif-radio-mask-to-limit-ibss-scan-.patch
queue-6.12/s390-debug-fix-null-pointer-dereference-in-debug_inf.patch
queue-6.12/bpf-fix-uaf-due-to-concurrent-consumption-of-ttrace-.patch
queue-6.12/net-sched-sch_teql-fix-shadowed-err-in-__teql_resolv.patch
queue-6.12/bluetooth-iso-fix-parent-socket-leak-in-iso_conn_rea.patch
queue-6.12/platform-x86-think-lmi-fix-certificate-thumbprint-sysfs-output.patch
queue-6.12/mptcp-pm-userspace-fix-address-id-overflow.patch
queue-6.12/dma-buf-dma-heap-don-t-publish-fd-before-copy_to_user-succeeds.patch
queue-6.12/tracing-probes-fix-anon_stack-check-for-unnamed-bitfields-in-btf_find_struct_member.patch
queue-6.12/s390-cio-fix-cio_update_schib-to-not-cache-invalid-s.patch
queue-6.12/s390-cio-check-pmcw.dnv-before-pmcw.ena-in-i-o-entry.patch
queue-6.12/kvm-s390-zero-initialize-data-structures-for-inject_pfault_token.patch
queue-6.12/bpf-disallow-bpf_skb_pull_data-for-lwt_seg6local.patch
queue-6.12/dmaengine-add-devm_dma_request_chan.patch
queue-6.12/cgroup-selftests-move-memcontrol-specific-helpers-ou.patch
queue-6.12/net-stmmac-selftests-check-the-dev-features-for-s-ta.patch
queue-6.12/tcp-do-not-let-tcp_rmem-be-set-below-4096.patch
queue-6.12/net-ena-fix-mmio-read-buffer-leak-on-probe-failure.patch
queue-6.12/tracing-take-trace_array-reference-when-opening-options-file.patch
queue-6.12/mm-secretmem-properly-account-locked-pages.patch
queue-6.12/alsa-hda-trace-pcm-open-only-after-assigning-a-strea.patch
queue-6.12/drm-client-fix-restore-of-partially-initialized-client.patch
queue-6.12/drm-amdgpu-add-a-helper-to-calculate-ring-distance.patch
queue-6.12/nfc-pn533-fix-oob-read-in-pn533_acr122_is_rx_frame_v.patch
queue-6.12/tracing-constify-struct-event_trigger_ops.patch
queue-6.12/remoteproc-qcom-pas-guard-dtb-metadata-release-with-dtb_pas_id-check.patch
queue-6.12/drm-nouveau-clk-don-t-clobber-reclock-status-when-re.patch
queue-6.12/scsi-qla2xxx-serialize-nvme-unsol-ctx-list-with-a-per-fcport-lock.patch
queue-6.12/risc-v-kvm-serialize-imsic-attributes-with-vcpu-migration.patch
queue-6.12/bpf-fix-immediate-jmp-jeq-jne-on-mips32.patch
queue-6.12/bluetooth-rfcomm-reject-short-ea-0-frames-in-rfcomm_.patch
queue-6.12/perf-aux-allocate-non-contiguous-aux-pages-by-default.patch
queue-6.12/bluetooth-btintel_pcie-validate-device-supplied-dma-.patch
queue-6.12/ipv6-move-ipv6_fl_list-from-ipv6_pinfo-to-inet_sock.patch
queue-6.12/risc-v-kvm-preserve-firmware-counter-value-across-st.patch
queue-6.12/nvme-refactor-the-atomic-write-unit-detection.patch
queue-6.12/netfilter-flowtable-publish-hw_dead-after-worker-is-.patch
queue-6.12/media-imx355-avoid-calling-imx355_power_off-twice-in-error-path.patch
queue-6.12/ipv6-mcast-use-copy-on-write-rcu-updates-in-ip6_mc_s.patch
queue-6.12/landlock-fix-tcp-fast-open-connection-bypass.patch
queue-6.12/wifi-mwifiex-fix-irq-leak-using-wrong-index-in-msi-x.patch
queue-6.12/compiler_types-move-lock-checking-attributes-to-compiler-context-analysis.h.patch
queue-6.12/edac-altera-use-parent-device-for-devres-in-altr_portb_setup.patch
queue-6.12/bluetooth-smp-reject-security-request-over-br-edr.patch
queue-6.12/hid-amd_sfh-validate-pci-bar-size-before-mapping.patch
queue-6.12/autofs-fix-sbi-pipe-file-reference-leak-in-autofs_ki.patch
queue-6.12/wifi-mac80211-don-t-allow-link-changes-when-iface-is.patch
queue-6.12/netfilter-nfnetlink_queue-hold-nfnl-mutex-in-event-n.patch
queue-6.12/drm-nouveau-disp-r535-add-scanline-position-support-head-state-support.patch
queue-6.12/perf-x86-intel-make-data-a-mandatory-param-for-intel.patch
queue-6.12/nfc-llcp-fix-wks-sap-hijacking-via-prefix-match-in-n.patch
queue-6.12/net-cpsw_new-execute-ndo_set_rx_mode-callback-in-a-w.patch
queue-6.12/netfilter-nft_synproxy-use-the-family-aware-checksum.patch
queue-6.12/drm-xe-flush-lsc-untyped-l1-dataport-cache-after-rcs-ccs-batches.patch
queue-6.12/wifi-mac80211-don-t-warn-when-an-ibss-has-no-channel.patch
queue-6.12/drm-fix-drm_pending_vblank_event-leak-in-error-path-.patch
queue-6.12/rculist-add-list_splice_rcu-for-private-lists.patch
queue-6.12/macsec-initialize-secy-before-registering-the-netdev.patch
queue-6.12/squashfs-add-dictionary-size-range-check-to-prevent-.patch
queue-6.12/xfs-remove-the-i_ino-field-in-struct-xfs_inode.patch
queue-6.12/ipv6-mcast-don-t-hold-rtnl-for-ipv6_drop_membership-.patch
queue-6.12/wifi-cfg80211-don-t-filter-by-bss-type-when-removing.patch
queue-6.12/platform-x86-int1092-fix-potential-memory-leak-in-sar_probe.patch
queue-6.12/net-bcmgenet-allow-return-of-power-up-status.patch
queue-6.12/kvm-svm-flush-cache-only-on-cpus-running-sev-guest.patch
queue-6.12/alsa-usb-audio-optimize-the-copy-of-packet-sizes-for-implicit-fb-handling.patch
queue-6.12/smb-client-fix-oob-struct-field-reads-in-move_smb2_ea_to_cifs.patch
queue-6.12/ip6_gre-call-ip6erspan_tunnel_unlink_md-in-ip6erspan.patch
queue-6.12/kvm-x86-rename-__-g-s-et_sregs2-kvm_vcpu_ioctl_x86_-g-s-et_sregs2.patch
queue-6.12/net-gue-reject-invalid-remcsum-offsets.patch
queue-6.12/sched-core-make-core-sched-flips-wait-for-in-flight-selections.patch
queue-6.12/neighbour-add-missing-rcu-annotation-for-neightbl_du.patch
queue-6.12/nvme-fix-atomic-write-size-validation.patch
queue-6.12/smb-client-fix-reparse-buffer-bounds-in-cifs_query_reparse_point.patch
queue-6.12/firmware-sysfb-move-bpp-depth-calculation-into-screen_info-helper.patch
queue-6.12/wifi-mac80211-set-up-the-tx-info-early-to-fix-failur.patch
queue-6.12/net-sched-act_gate-budget-the-per-entry-list-in-get_.patch
queue-6.12/neighbour-use-rtnl_register_many.patch
queue-6.12/alsa-hda-realtek-limit-star-labs-internal-mic-boost.patch
queue-6.12/scsi-qla2xxx-unlink-nvme-unsol-ctx-before-freeing-on-ls-reject-error.patch
queue-6.12/kvm-arm64-vgic-its-skip-unreachable-devices-instead-.patch
queue-6.12/dmaengine-xilinx_dma-fix-hardware-buffer-descriptor-.patch-14663
queue-6.12/wifi-mac80211-don-t-access-the-tsf-of-a-down-interfa.patch
queue-6.12/bpf-fix-bswap-32-and-16-on-mips64.patch
queue-6.12/drm-i915-psr-clear-stale-sel-fetch-enable-bits-on-se.patch
queue-6.12/pinctrl-meson-fix-typo-in-s4-group-name.patch
queue-6.12/ring-buffer-fix-subbuf-resize-race-with-ring_buffer_alloc_read_page.patch
queue-6.12/bluetooth-iso-set-bt_listen-before-requesting-a-big-.patch
queue-6.12/nvdimm-preserve-flush-callback-enomem.patch
queue-6.12/risc-v-kvm-fix-null-pointer-dereference-in-kvm_riscv_aia_imsic_rw_attr.patch
queue-6.12/wifi-wcn36xx-fix-potential-use-after-free-in-tx-ack-timer-teardown.patch
queue-6.12/i2c-mxs-fix-dma-channel-leak-on-probe-error.patch
queue-6.12/selftests-landlock-add-tests-for-access-through-disc.patch
queue-6.12/risc-v-kvm-report-snapshot-write-failure-to-the-gues.patch
queue-6.12/xfrm-fix-dev-use-after-free-in-xfrm-async-resumption.patch
queue-6.12/bpf-reject-dev-bound-only-programs-on-other-devices.patch
queue-6.12/vlan-ensure-sufficient-headroom-in-vlan_dev_hard_hea.patch
queue-6.12/udf-move-udf_map_block-up.patch
queue-6.12/net-cpsw-execute-ndo_set_rx_mode-callback-in-a-work-.patch
queue-6.12/dma-coherent-report-a-failed-reserved-memory-assignm.patch
queue-6.12/rdma-siw-clear-association-under-lock-if-siw_qp_modi.patch
queue-6.12/wifi-mac80211-track-mu-mimo-configuration-on-disabled-interfaces.patch
queue-6.12/i2c-qcom-cci-fix-device_node-refcount-leak-in-cci_probe-cci_remove.patch
queue-6.12/eth-bnxt-store-rx-buffer-size-per-queue.patch
queue-6.12/hid-asus-fortify-keyboard-handshake.patch
queue-6.12/ipv4-use-rcu-in-ip_fib_check_default.patch
queue-6.12/risc-v-kvm-fix-perf-backed-counter-accounting-across.patch
queue-6.12/pci-allow-per-function-pci-slots-to-fix-slot-reset-on-s390.patch
queue-6.12/wifi-cfg80211-expose-cfg80211_chandef_get_width.patch
queue-6.12/drm-i915-psr-add-new-su-area-calculation-helper-to-a.patch
queue-6.12/nfc-st21nfca-validate-received-frame-size.patch
queue-6.12/phy-renesas-rcar-gen3-usb2-avoid-long-delay-in-atomic-context.patch
queue-6.12/esp-downgrade-zerocopy-managed-frags-before-mutating.patch
queue-6.12/llc-fix-skb-uaf-and-leaks-on-llc_mac_hdr_init-failur.patch
queue-6.12/s390-boot-add-sized_strscpy-to-enable-strscpy-usage.patch
queue-6.12/mm-rmap-allocate-anon_vma_chain-objects-unlocked-when-possible.patch
queue-6.12/net-ethernet-cortina-ack-rx-overrun-interrupt-correc.patch
queue-6.12/netmem-add-a-couple-of-page-helper-wrappers.patch
queue-6.12/xfrm-refactor-xfrm_input-lock-to-reduce-contention-w.patch
queue-6.12/io_uring-net-don-t-overconsume-buffers-when-using-msg_trunc.patch
queue-6.12/drm-amdgpu-plumb-timedout-fence-through-to-force-completion.patch
queue-6.12/packet-use-ubuf_info-completion-for-tx_ring-packets.patch
queue-6.12/docs-s390-pci-improve-and-update-pci-documentation.patch
queue-6.12/firmware-qcom_scm-rename-peripheral-as-pas_id.patch
queue-6.12/net-usb-catc-bound-the-rx-packet-length-in-catc_rx_d.patch
queue-6.12/arm64-use-load-lse-atomics-for-the-non-return-per-cpu-atomic-operations.patch
queue-6.12/usb-storage-realtek_cr-fix-use-after-free-on-disconnect.patch
queue-6.12/xfrm-save-input-state-data-before-secpath-resets.patch
queue-6.12/ipv6-honor-oif-when-choosing-nexthop-for-locally-gen.patch
queue-6.12/usb-typec-tcpm-fix-debug-accessory-mode-detection-for-sink-ports.patch
queue-6.12/mtd-rawnand-pl353-add-message-about-ecc-mode.patch
queue-6.12/usb-dwc3-clear-forcerm-when-issuing-endtransfer.patch
queue-6.12/driver-core-add-device-probe-log-helper-dev_warn_pro.patch
queue-6.12/net-mvpp2-prevent-buffer-overflow-in-page_pool-alloc.patch
queue-6.12/nvdimm-virtio_pmem-use-read_once-write_once-for-wait-flags.patch
queue-6.12/dmaengine-fix-device-kref-underflow-in-dma_chan_put.patch
queue-6.12/nfc-st21nfca-validate-iso15693-inventory-length.patch
queue-6.12/bluetooth-hci_core-print-number-of-packets-in-conn-d.patch
queue-6.12/kvm-ppc-book3s-hv-fix-use-after-free-in-kvmhv_emulat.patch
queue-6.12/i2c-qcom-geni-fix-hardcoded-clock-index-in-se_geni_clk_sel.patch
queue-6.12/io_uring-waitid-avoid-siginfo-copy-during-ring-teardown.patch
queue-6.12/wifi-rtw89-pci-add-.shutdown-callback-to-stop-rfkill-polling-on-reboot.patch
queue-6.12/eth-fbnic-handle-maximum-standalone-channels.patch
queue-6.12/net-mlx5e-shampo-always-calculate-page-size.patch
queue-6.12/dmaengine-fix-use-after-free-in-dma_chan_put-and-dma.patch
queue-6.12/drop_monitor-fix-out-of-bounds-write-in-reset_per_cp.patch
queue-6.12/drm-virtio-fix-object-leak-in-virtio_gpu_resource_cr.patch
queue-6.12/f2fs-convert-clear_node_page_dirty-to-clear_node_folio_dirty.patch
queue-6.12/kvm-x86-mmu-split-kvm_mmu_zap_all_fast-into-front-and-back-halves.patch
queue-6.12/ipv6-fix-dst-leak-for-uncached-routes.patch
queue-6.12/f2fs-dirty-directory-inodes-on-mtime-ctime-update.patch
queue-6.12/pidfd-hold-exec_update_lock-around-namespace-ioctl.patch
queue-6.12/pci-starfive-use-regulator-apis-to-control-the-3v3-power-supply-of-pcie-slots.patch
queue-6.12/perf-x86-intel-don-t-write-pebs_enabled-on-host-gues.patch
queue-6.12/nfp-hold-ipsec-rx-state-under-the-xarray-lock.patch
queue-6.12/swiotlb-use-the-adjusted-address-for-the-highmem-page-lookup.patch
queue-6.12/wifi-mac80211-require-a-peer-station-for-tdls-setup-.patch
queue-6.12/genetlink-pin-family-module-during-policy-dump.patch
queue-6.12/net-ethernet-mtk_eth_soc-unregister-net_devices-in-c.patch
queue-6.12/netfilter-nft_nat-fully-initialise-new_addr-in-netma.patch
queue-6.12/net-ipconfig-bound-dhcp-option-construction.patch
queue-6.12/bonding-crypto-offload-enabled-non-offload-slave-fai.patch
queue-6.12/xfs-fix-under-reservation-of-blocks-when-repairing-sf-directories.patch
queue-6.12/drm-nouveau-clk-fix-list-cursor-use-after-loop-in-nv.patch
queue-6.12/asoc-ux500-parenthesize-msp_-rx-tx-_clkpol_bit-argum.patch
queue-6.12/virtio_mmio-disable-irq-wake-before-free_irq.patch
queue-6.12/f2fs-validate-move_range-destination-size.patch
queue-6.12/s390-cio-guard-pmcw-field-accesses-with-dnv-check.patch
queue-6.12/usb-cdnsp-fix-wakeup-from-s3-after-controller-context-loss.patch
queue-6.12/drm-sysfb-simpledrm-improve-framebuffer-size-validation.patch
queue-6.12/net-macb-fix-ordering-around-ptp-timestamp-read.patch
queue-6.12/staging-sm750fb-fix-mono-image-source-stride-mismatch-in-lynxfb_ops_imageblit.patch
queue-6.12/nvdimm-virtio_pmem-always-wake-enospc-waiters.patch
queue-6.12/smb-client-send-lease-break-acks-thru-correct-session-for-multiuser-mounts.patch
queue-6.12/mm-hugetlb-do-not-dissolve-gigantic-pages-without-runtime-support.patch
queue-6.12/wifi-mac80211-suppress-chanctx-warning-for-debugfs-r.patch
queue-6.12/perf-arm-cmn-fix-wp_dev_sel2-setting-for-multi-dtm-c.patch
queue-6.12/ip_gre-reject-enabling-collect-metadata-through-chan.patch
queue-6.12/arm64-io-reject-non-user-protection-in-ioremap_prot.patch
queue-6.12/ipv6-flowlabel-cap-duplicate-leases-per-socket.patch
queue-6.12/selftests-landlock-add-tests-for-whiteout-object-cre.patch
queue-6.12/smb-client-fail-dacl-rewrite-when-the-new-dacl-exceeds-64k.patch
queue-6.12/platform-x86-intel_sar-check-acpi_handle-against-null.patch
queue-6.12/mptcp-return-sk_wait_data-errors-from-recvmsg.patch
queue-6.12/ipv6-select-best-matching-nexthop-object-in-fib6_tab.patch
queue-6.12/alsa-pcm-set-timer-private_data-before-registering-t.patch
queue-6.12/selftests-landlock-add-missing-connect-minimal-af_un.patch
queue-6.12/selftests-nci-correct-pthread_create-return-value-ch.patch
queue-6.12/nfc-llcp-fix-list-corruption-refcount-desync-in-nfc_.patch
queue-6.12/tracing-probes-fix-btf-kflag-check-for-anonymous-struct-member-access.patch
queue-6.12/mtd-rawnand-pl353-make-sure-we-use-the-monolithic-helpers-for-raw-accesses.patch
queue-6.12/neighbour-convert-rtm_getneightbl-to-rcu.patch
queue-6.12/net-mlx5-bridge-don-t-fail-switchdev-events-of-sibli.patch
queue-6.12/erofs-add-sysfs-feature-entry-for-xattr-prefixes.patch
queue-6.12/i3c-master-do-not-treat-master-device-as-a-duplicate-target.patch
queue-6.12/platform-x86-isst-validate-max-level-for-set-feature.patch
queue-6.12/net-bcmgenet-move-bcmgenet_power_up-into-resume_noir.patch
queue-6.12/bnxt_en-propagate-tpa-buffer-allocation-failures-in-bnxt_queue_mem_alloc.patch
queue-6.12/asoc-codecs-aw88261-only-check-pll-and-clock-state-at-power-up.patch
queue-6.12/mm-memblock-show-all-region-flags-in-debugfs.patch
queue-6.12/ib-isert-wait-for-deferred-control-pdu-completions-b.patch
queue-6.12/ipv6-mcast-don-t-hold-rtnl-for-ipv6_add_membership-a.patch
queue-6.12/drm-i915-dp_mst-fix-configuring-fec-for-a-disconnected-stream.patch
queue-6.12/tracing-merge-struct-event_trigger_ops-into-struct-event_command.patch
queue-6.12/asoc-tegra-fix-the-mixer-enable-default-value.patch
queue-6.12/selftests-nci-fix-out-of-bounds-store-on-thread-join.patch
queue-6.12/s390-vfio-ap-fix-missing-lock-required-to-access-list-of-ap_matrix_mdev-objects.patch
queue-6.12/netfilter-nf_tables-join-hook-list-via-splice_list_r.patch
queue-6.12/ring-buffer-allow-splice-reads-on-static-buffers.patch
queue-6.12/f2fs-don-t-allow-unaligned-truncation-to-smaller-equal-size-on-pinned-file.patch
queue-6.12/bpf-register-dtor-for-freeing-special-fields.patch
queue-6.12/drm-imagination-clamp-freelist-reconstruction-reques.patch
queue-6.12/nfc-llcp-fix-enomem-on-connect-with-zero-length-serv.patch
queue-6.12/drm-i915-mst-add-mst-sub-struct-to-struct-intel_dp.patch
queue-6.12/idpf-fix-kernel-doc-descriptions-to-avoid-warnings.patch
queue-6.12/macsec-inherit-lower-device-s-tso-limits-when-offloa.patch
queue-6.12/neighbour-make-neigh_valid_get_req-return-ndmsg.patch
queue-6.12/rdma-rxe-insert-mcg-into-mcg_tree-only-after-rxe_mca.patch
queue-6.12/scsi-megaraid_sas-protect-megasas_get_ctrl_info-in-m.patch
queue-6.12/net-skbuff-fix-pull-bound-underflow-in-skb_checksum_.patch
queue-6.12/f2fs-embed-f2fs_gc_kthread-in-f2fs_sb_info.patch
queue-6.12/btrfs-take-commit-root-semaphore-when-iterating-in-mark_block_group_to_copy.patch
queue-6.12/bpf-sockmap-reject-max_entries-int_max-in-sock_map_a.patch
queue-6.12/ksmbd-keep-compound-responses-on-query-info-errors.patch
queue-6.12/scsi-qla2xxx-bound-vp-index-against-vp_ctrl-iocb-bitmap-size.patch
queue-6.12/platform-x86-amd-pmc-propagate-smu-errors-and-validate-s2d-address.patch
queue-6.12/drm-amdgpu-fix-missing-unwind-in-amdgpu_ib_schedule-error-path.patch
queue-6.12/ocfs2-make-ocfs2_calc_xattr_init-return-void.patch
queue-6.12/neighbour-allocate-skb-in-neigh_get.patch
queue-6.12/netfilter-nf_tables-simplify-chain-netdev-notifier.patch
queue-6.12/drm-vc4-use-managed-kms-polling-to-fix-uaf-on-unbind.patch
queue-6.12/btrfs-tree-checker-print-dev-extent-offset-in-error-.patch
queue-6.12/io_uring-waitid-have-io_waitid_complete-remove-wait-queue-entry.patch
queue-6.12/neighbour-move-two-validations-from-neigh_get-to-nei.patch
queue-6.12/xfrm-add-missing-rcu_read_lock-skb_dst_force-and-dev.patch
queue-6.12/scsi-qla2xxx-zero-dport-diagnostics-buffer-to-avoid-info-leak.patch
queue-6.12/drm-amdgpu-avoid-force-completing-uninitialized-uvd-rings.patch
queue-6.12/9p-fix-v9fs_issue_write-to-update-i_size-and-remote_i_size.patch
queue-6.12/net-dsa-mt7530-fix-null-dereference-on-unbind-of-mt7.patch
queue-6.12/net-bcmgenet-do-not-skip-wol-power-up-on-genet-v1.patch
queue-6.12/dmaengine-mmp_pdma-fix-wrong-sg-length-in-mmp_pdma_p.patch
queue-6.12/configfs-get_target-release-path-as-soon-as-we-grab-configfs_item-reference.patch
queue-6.12/net-bcmgenet-fix-64-bit-rtnl-stats-reading-in-ethtoo.patch
queue-6.12/wifi-cfg80211-skip-regulatory-for-punctured-subchann.patch
queue-6.12/ipv6-mcast-don-t-hold-rtnl-for-mcast_-socket-options.patch
queue-6.12/alsa-bcd2000-fix-race-between-rawmidi-and-disconnect.patch
queue-6.12/wifi-libipw-reject-tkip-frames-without-a-full-mic.patch
queue-6.12/bpf-sockmap-fix-self-redirect-copied_seq-double-coun.patch
queue-6.12/configfs-unhash-the-dentry-before-dropping-the-item-in-rmdir.patch
queue-6.12/iommufd-fix-uaf-in-selftest-iopf-reporting.patch
queue-6.12/kvm-x86-mmu-dynamically-allocate-shadow-mmu-s-hashed-page-list.patch
queue-6.12/landlock-fix-use-after-free-of-the-source-s-parent-directory.patch
queue-6.12/drm-amdgpu-fix-rmmio-iounmap-skipped-on-device-removal.patch
queue-6.12/bpf-fix-out-of-bounds-read-of-rtt_min-in-sock_ops.patch
queue-6.12/net-ena-remove-autopolling-mode.patch
queue-6.12/neighbour-move-neigh_find_table-to-neigh_get.patch
queue-6.12/mptcp-pm-use-for_each_subflow-helper.patch
queue-6.12/platform-x86-think-lmi-fix-current-password-length-check.patch
queue-6.12/net-stmmac-selftests-capture-all-packets-for-vlan-ch.patch
queue-6.12/netfilter-cttimeout-detach-dataplane-timeout-policy-and-repurpose-refcount.patch
queue-6.12/rdma-irdma-enforce-local-fence-for-ib_wr_reg_mr.patch
queue-6.12/s390-debug-do-not-register-views-for-failed-static-d.patch
queue-6.12/drm-xe-vm-nuke-pts-only-after-unlinking-contested-vmas.patch
queue-6.12/sunvdc-fix-eio-issue-due-to-lack-of-retries.patch
queue-6.12/scsi-qla2xxx-fix-use-after-free-of-qpair-work-on-queue-teardown.patch
queue-6.12/nvme-skip-the-zoned-limits-update-if-the-zone-info-query-failed.patch
queue-6.12/soundwire-cadence_master-wait-and-cancel-cdns-work-b.patch
queue-6.12/drm-virtio-fix-object-leaks-in-virtio_gpu_resource_c.patch
queue-6.12/rdma-rxe-validate-access-flags-before-swapping-the-m.patch
queue-6.12/futex-provide-rt_mutex_.-_schedule-equivalents-for-futex-scheduling.patch
queue-6.12/nfc-llcp-fix-race-condition-in-accept_queue-lifecycl.patch
queue-6.12/power-supply-ab8500_fg-fix-use-after-free-on-remove.patch
queue-6.12/ipv6-reorganise-struct-ipv6_pinfo.patch
queue-6.12/perf-x86-intel-don-t-pointlessly-context-switch-ds_a.patch
queue-6.12/tracing-fix-memory-corruption-from-a-stacktrace-histogram-key.patch
queue-6.12/xfs-don-t-stash-removename-operations-with-unknown-f.patch
queue-6.12/bpf-fix-bpf_skb_change_tail-wrt-csum-partial-skbs.patch
queue-6.12/hwmon-pwm-fan-stop-rpm-timer-before-freeing-tach-data.patch
queue-6.12/rdma-rtrs-clt-fix-cq-pool-leak-when-connect-is-inter.patch
queue-6.12/pci-starfive-fix-resource-leaks-on-error-paths-in-host_init.patch
queue-6.12/net-usb-sr9700-include-receive-overhead-in-the-lengt.patch
queue-6.12/hwrng-stm32-fix-runtime-pm-cleanup-on-registration-failure.patch
queue-6.12/netfilter-ctnetlink-fix-suspicious-rcu-usage-in-expe.patch
queue-6.12/net-xps-reject-an-out-of-range-traffic-class.patch
queue-6.12/scsi-qla2xxx-validate-bsg-request_len-before-reading-vendor_cmd.patch
queue-6.12/asoc-tegra210_mixer-sort-the-register-default-table.patch
queue-6.12/smb-client-fix-use-after-free-of-iface-in-cifs_try_adding_channels.patch
queue-6.12/firmware-arm_scpi-reject-dvfs-opp-count-above-max_dv.patch
queue-6.12/s390-pci-docs-fix-sriov_numvfs-attribute-name.patch
queue-6.12/alsa-usb-audio-clamp-implicit-feedback-packet-count-to-urb-capacity.patch
queue-6.12/kvm-x86-disallow-efer.lme-and-efer.lma-if-long-mode-is-not-supported.patch
queue-6.12/smb-mark-the-new-channel-addition-log-as-informational-log-with-cifs_info.patch
queue-6.12/wifi-mt76-mt7915-set-correct-background-radar-capability.patch
queue-6.12/wifi-mac80211-abort-chanswitch-when-leaving-a-mesh.patch
queue-6.12/net-macb-replace-open-coded-implementation-with-napi_schedule.patch
queue-6.12/dma-coherent-warn-if-of-reserved-memory-is-beyond-cu.patch
queue-6.12/dmaengine-xilinx_dma-fix-hardware-buffer-descriptor-.patch
queue-6.12/ipv6-mcast-use-in6_dev_get-in-ipv6_dev_mc_dec.patch
queue-6.12/mm-hugetlb-fix-surplus-pages-in-dissolve_free_huge_page.patch
queue-6.12/wifi-mac80211-don-t-offload-tc-setup-on-ap_vlan-inte.patch
queue-6.12/media-video-i2c-fix-buffer-queue-ordering.patch
queue-6.12/bpf-fix-out-of-bounds-read-of-sk_protocol-in-bpf_soc.patch
queue-6.12/tracing-clean-up-use-of-trace_create_maxlat_file.patch
queue-6.12/revert-hwmon-emc1403-rely-on-subsystem-locking.patch
queue-6.12/net-lock-the-socket-in-sock_gettstamp.patch
queue-6.12/ksmbd-fix-partial-file-information-responses.patch
queue-6.12/kvm-arm64-return-einval-for-an-empty-smccc-filter-ra.patch
queue-6.12/pci-introduce-pci_slot_placeholder-constant-for-slot_nr-placeholder-value.patch
queue-6.12/remoteproc-pas-replace-metadata-context-with-pas-context-structure.patch
queue-6.12/octeontx2-af-fix-memory-scaling-limitation-in-sr-iov.patch
queue-6.12/drm-amdgpu-check-ras-and-obj-before-dereference.patch
queue-6.12/drm-sysfb-ofdrm-fix-integer-overflow-in-fb_size-calculation.patch
queue-6.12/sysctl-move-the-cad_pid-entry-from-pid_table-to-kern_reboot_table.patch
queue-6.12/alsa-hda-ext-preserve-pplcctl-bits-when-clearing-reset.patch
queue-6.12/sock-add-sock_kmemdup-helper.patch
queue-6.12/scsi-qla2xxx-fix-the-ql2xfc2target-parameter-descrip.patch
queue-6.12/smb-client-fix-security-flag-calculation-when-setting-security-descriptors.patch
queue-6.12/wifi-mac80211-reset-state-when-starting-ap-fails.patch
queue-6.12/net-tls-fix-silent-data-drop-under-pipe-back-pressur.patch
queue-6.12/nfc-llcp-fix-slab-out-of-bounds-reads-when-logging-s.patch
queue-6.12/wifi-mac80211-don-t-rcu-dereference-the-mesh-csa-set.patch
queue-6.12/kvm-x86-pmu-move-intel-pmu-global-msrs-to-intel_is_v.patch
queue-6.12/mm-damon-rename-damon_min_region-to-damon_min_region_sz.patch
queue-6.12/wifi-mac80211-refuse-to-make-a-monitor-active-when-it-has-no-queue.patch
queue-6.12/kvm-arm64-vgic-its-add-stronger-type-checking-to-the.patch
queue-6.12/net-macb-unify-device-pointer-naming-convention.patch
queue-6.12/bpf-fix-bpf_sock-context-code-generation.patch
queue-6.12/veth-manage-xdp-program-pointers-during-channel-resi.patch
queue-6.12/ipvs-revalidate-ihl-before-icmp_send.patch
queue-6.12/bluetooth-btmtk-fix-wrong-status-for-short-wmt-func_.patch
queue-6.12/rdma-siw-bound-fragmented-header-copies-by-the-remai.patch
queue-6.12/hwrng-drivers-switch-back-to-struct-platform_driver-remove.patch
queue-6.12/bluetooth-hci_core-fix-queuing-tx_work-after-workque.patch
queue-6.12/f2fs-accurately-adjust-free_sections-during-free_segment_range.patch
queue-6.12/scsi-qla2xxx-skip-vport-under-deletion-in-report-id-acquisition.patch
queue-6.12/drm-nouveau-disp-don-t-reject-hdmi-config-on-cards-w.patch
queue-6.12/alsa-hda-realtek-add-starfighter-hda-ssid.patch
queue-6.12/ring-buffer-make-cpu_buffer-free_page-a-buffer_data_read_page.patch
queue-6.12/bluetooth-mgmt-dequeue-pending-mesh_send_sync-entrie.patch
queue-6.12/gpio-cdev-fix-kernel-stack-leak-to-user-space-in-error-path.patch
queue-6.12/net-bcmgenet-initialize-u64-stats-seq-counter-for-al.patch
queue-6.12/page_pool-disable-sync-for-cpu-for-dmabuf-memory-provider.patch
queue-6.12/selftests-nci-fix-uninitialized-family-id-on-missing.patch
queue-6.12/i2c-qcom-cci-remove-the-unused-variable-cci_clk_rate.patch
queue-6.12/bpf-bail-out-early-in-__htab_map_lookup_and_delete_e.patch
queue-6.12/wifi-libipw-reject-too-short-beacon-and-probe-respon.patch
queue-6.12/bpf-check-params-size-before-reading-reserved-fields.patch
queue-6.12/s390-boot-avoid-ipl-parameter-append-past-command-li.patch
queue-6.12/mips-octeon-apply-usb-fdt-fixups-also-when-usb-is-mo.patch
queue-6.12/usb-cdns3-rename-hibernated-argument-of-role-resume-to-lost_power.patch
queue-6.12/alsa-usb-6fire-avoid-embedded-urbs.patch
queue-6.12/usb-dwc3-gadget-reinitiate-stream-for-all-host-nostream-behavior.patch
queue-6.12/scsi-qla2xxx-null-out-freed-pointers-in-qla2x00_mem_alloc-error-path.patch
queue-6.12/asoc-add-codec_ch_mask-to-snd_soc_dai_link_ch_map.patch
queue-6.12/nvme-all-namespaces-in-a-subsystem-must-adhere-to-a-common-atomic-write-size.patch
queue-6.12/xfs-report-healthy-filesystem-events-in-scrub-stats.patch
queue-6.12/drm-sysfb-ofdrm-fix-is_avivo-constant-comparison-bug.patch
queue-6.12/ftrace-take-trace_array-reference-before-accessing-its-ftrace_ops.patch
queue-6.12/rdma-rxe-fix-integer-overflow-in-mr_check_range-lead.patch
queue-6.12/bpf-bound-ownership-depth-through-local-kptrs-and-gr.patch
queue-6.12/net-smc-stop-killed-freed-and-out_of_sync-sharing-a-byte.patch
queue-6.12/scsi-qla2xxx-use-ring-slot-helpers-in-__qla2x00_alloc_iocbs.patch
queue-6.12/gpio-virtuser-skip-free_irq-when-no-irq-is-installed.patch
queue-6.12/hid-elecom-fix-bus-type-for-m-xgl20dlbk.patch
queue-6.12/thermal-gov_step_wise-fix-stale-mitigation-vote-with.patch
queue-6.12/tcp-don-t-call-skb_clone_and_charge_r-for-close-d-li.patch
queue-6.12/ipv4-remove-fib_devindex_hashfn.patch
queue-6.12/mptcp-pm-drop-match-in-userspace_pm_append_new_local_addr.patch
queue-6.12/net-mlx5-bridge-don-t-fail-unlink-of-untracked-unsup.patch
queue-6.12/net-sched-act_ct-avoid-modifying-shared-unconfirmed-ct-entry.patch
queue-6.12/configfs-pin-the-symlink-target-s-dirent-instead-of-chasing-ci_dentry.patch
queue-6.12/net-phy-mediatek-do-not-report-link-and-per-speed-led-rules-together.patch
queue-6.12/xfs-strengthen-the-is-cow-staging-helpers-in-scrub.patch
queue-6.12/wifi-rtw88-fix-the-random-error-beacon-valid-message.patch
queue-6.12/bluetooth-btintel_pcie-fix-off-by-one-bounds-check-i.patch
queue-6.12/ib-iser-reject-a-remote-invalidation-of-an-unregiste.patch
queue-6.12/platform-x86-isst-check-for-admin-capability-for-write-commands.patch
queue-6.12/ib-ipoib-avoid-restoring-oper_up-after-multicast-flu.patch
queue-6.12/ipv4-remove-fib_info_devhash.patch
queue-6.12/nvme-add-missing-srcu-grace-period-in-error-path.patch
queue-6.12/drm-msm-dsi-round-the-byte-clock-rate-after-reparent.patch
queue-6.12/virtio-mmio-remove-virtqueue-list-from-mmio-device.patch
queue-6.12/xfrm-avoid-rcu-warnings-around-the-per-netns-netlink.patch
queue-6.12/selftests-cgroup-give-the-o_tmpfile-open-in-get_temp.patch
queue-6.12/kvm-s390-fix-irq-injection-with-sigp-stop-and-store-.patch
queue-6.12/drm-amdgpu-fix-acpi-device-leak-in-amdgpu_acpi_enumerate_xcc.patch
queue-6.12/net-page_pool-rename-page_pool_alloc_netmem-to-_netmems.patch
queue-6.12/ipmr-account-multicast-table-and-route-memory.patch
queue-6.12/powerpc-iommu-fix-the-overflow-validation-in-iommu_t.patch
queue-6.12/tg3-clean-up-phylib-resources-on-probe-failure.patch
queue-6.12/kvm-arm64-vgic-its-free-the-caches-when-gits_baser-c.patch
queue-6.12/rdma-efa-keep-eq-resources-alive-while-irq-is-regist.patch
queue-6.12/scsi-sd_zbc-reject-disks-with-too-many-zones.patch
queue-6.12/nfc-llcp-fix-sdreq-tlv-list-leak-on-parse-alloc-send.patch
queue-6.12/tg3-use-random-mac-address-when-tg3_get_device_addre.patch
queue-6.12/net-pcs-xpcs-fix-clock-reference-leak-on-xpcs_init_c.patch
queue-6.12/vrf-stop-corrupting-skb-csum-when-capturing-checksum.patch
queue-6.12/net-fddi-skfp-fix-null-deref-when-setting-the-mac-ad.patch
queue-6.12/hid-hid-alps-use-pm_ptr-instead-of-ifdef-config_pm.patch
queue-6.12/perf-x86-intel-remove-incorrect-lioncove-pebs-data-source-constraints.patch
queue-6.12/drm-amdgpu-umsch-remove-vpe-test-from-umsch.patch
queue-6.12/xsk-use-a-32-bit-compare-in-xsk_map_gen_lookup.patch
queue-6.12/wifi-mac80211_hwsim-don-t-hand-frames-to-mac80211-wh.patch
queue-6.12/reboot-fix-cad_pid-use-after-free-race.patch
queue-6.12/asoc-soc-pcm-apply-snd_soc_dai_link_ch_map.codec_ch_.patch
queue-6.12/wifi-virt_wifi-don-t-transfer-operstate-before-regis.patch
queue-6.12/netfilter-cttimeout-prevent-uaf-during-module-unload.patch
queue-6.12/nfc-nfcmrvl-validate-helper-command-length-before-pu.patch
queue-6.12/tracing-undo-the-registration-when-enabling-the-histogram-trigger-fails.patch
queue-6.12/sctp-avoid-livelock-while-updating-retransmit-path.patch
queue-6.12/remoteproc-qcom_q6v5_adsp-fix-iommu_unmap-usage.patch
queue-6.12/net-skbuff-do-not-leave-stale-header-offsets-after-p.patch
queue-6.12/pci-fix-resizable-bar-restore-order.patch
queue-6.12/mm-fix-incorrect-vm_flags-usage-when-checking-allowable-orders-for-tmpfs.patch
queue-6.12/mptcp-pm-reset-retrans_time-when-add_addr-entry-is-reused.patch
queue-6.12/drm-bridge-tc358768-enforce-input-bus-flags-via-atomic_check.patch
queue-6.12/mm-damon-vaddr-avoid-hw-driven-pte-updates-during-damon_hugetlb_mkold.patch
queue-6.12/udf-fix-data-loss-when-converting-inline-inodes-to-out-of-line.patch
queue-6.12/platform-x86-amd-pmc-move-stb-block-into-amd_pmc_s2d_init.patch
queue-6.12/wifi-brcmfmac-fix-lost-802.1x-tx-completion-wakeup.patch
queue-6.12/tools-bootconfig-cleanup-bootconfig-footer-size-calculations.patch
queue-6.12/mm-rmap-fix-missing-barrier-between-anon_vma-init-and-vma-anon_vma-publish.patch
queue-6.12/kvm-arm64-fix-fgt-mapping-for-hfgitr_el2.ngcsepp.patch
queue-6.12/pppoatm-ensure-a-writable-skb-header-and-linear-data.patch
queue-6.12/wifi-virt_wifi-free-skb-when-disconnected.patch
queue-6.12/kvm-ppc-book3s-hv-fix-secure-device-page-leak-on-uv_.patch
queue-6.12/net-mlx5-devcom-base-component-size-on-linked-device.patch
queue-6.12/i3c-master-fix-use-after-free-of-master-this.patch
queue-6.12/bna-prevent-ioc-timer-rearm-during-teardown.patch
queue-6.12/f2fs-limit-recovery-filename-logging-to-stored-length.patch
queue-6.12/erofs-fix-large-folio-race-in-erofs_fscache_req_comp.patch
queue-6.12/wifi-mac80211-mesh-release-the-channel-if-start-fail.patch
queue-6.12/dmaengine-wait-for-rcu-readers-before-releasing-dma_.patch
queue-6.12/drm-virtio-fix-object-leak-when-drm_gem_handle_creat.patch
queue-6.12/net-ipconfig-remove-outdated-comment-and-indent-code-block.patch
queue-6.12/bnxt-fix-memory-leak-in-bnxt_queue_mem_alloc-error-cases.patch
queue-6.12/selftests-landlock-add-test-for-tcp-fast-open.patch
queue-6.12/wifi-ath11k-cleanup-arsta-in-ath11k_mac_peer_cleanup.patch
queue-6.12/bpf-remove-migrate_-disable-enable-in-map_for_each_c.patch
queue-6.12/wifi-cfg80211-don-t-get-the-radio-mask-for-netdev-le.patch
queue-6.12/iommu-msm-unwind-probe-state-on-registration-failure.patch
queue-6.12/kvm-x86-check-efer-validity-on-kvm_set_sregs.patch
queue-6.12/dpll-use-exact-lookup-for-reference-sync-pin-id.patch
queue-6.12/clk-qcom-fix-test_ctl_hi-field-for-default_evo-plls.patch
queue-6.12/libbpf-reject-truncated-ldimm64-co-re-relocations.patch
queue-6.12/landlock-clarify-documentation-for-the-ioctl-access-right.patch
queue-6.12/mm-hugetlb-create-hstate_is_gigantic_no_runtime-helper.patch
queue-6.12/wifi-mac80211-mesh-reset-the-csa-state-when-leaving.patch
queue-6.12/drm-amdgpu-set-the-vm-pointer-to-null-in-amdgpu_job_prepare.patch
queue-6.12/input-trackpoint-fix-the-inertia-attribute-name-in-t.patch
queue-6.12/kvm-x86-extract-regs-and-sregs-runtime-sync-code-to-helpers.patch
queue-6.12/wifi-mac80211-unlist-vifs-when-their-netdev-is-unreg.patch
queue-6.12/mm-mremap-reset-unfaulted-vma-page-offset-for-mremap_dontunmap.patch
queue-6.12/fs-avoid-repeated-scans-in-evict_inodes.patch
queue-6.12/asoc-codecs-aw88261-reduce-log-spam.patch
queue-6.12/ipe-fix-use-after-free-when-auditing-a-newly-loaded-policy.patch
queue-6.12/power-supply-ab8500_fg-remove-redundant-dev_err-dev_err_probe.patch
queue-6.12/drm-virtio-release-the-gem-object-on-virtio_gpu_vram.patch
queue-6.12/phy-mediatek-phy-mtk-hdmi-mt8195-fix-pll-calc-diviso.patch
queue-6.12/scsi-qla2xxx-fix-queue-teardown-null-dma_free-and-bitmap-locking.patch
queue-6.12/alsa-6fire-fix-oob-write-from-device-reported-iso-le.patch
queue-6.12/bnxt_en-don-t-free-the-live-ring-s-tpa-state-on-queue-restart-failure.patch
queue-6.12/f2fs-convert-f2fs_i_sb-to-sbi-in-f2fs_setattr.patch
queue-6.12/keys-fix-lost-wakeup-when-reaping-a-dead-key-type.patch
queue-6.12/hid-alps-unregister-dualpoint-stick-input-device-on-remove.patch
queue-6.12/scsi-qla2xxx-clamp-max_npiv_vports-to-vp_ctrl-bitmap-capacity.patch
queue-6.12/net-mlx5e-do-not-hw-gro-coalesce-small-frames.patch
queue-6.12/wifi-rtw89-cleanup-unused-rtwdev-roc_work.patch
queue-6.12/ring-buffer-add-helper-functions-for-allocations.patch
queue-6.12/staging-rtl8723bs-fix-oob-read-in-rtw_restruct_wmm_ie.patch
queue-6.12/btrfs-abort-transaction-on-failure-to-update-inode-f.patch
queue-6.12/media-rkvdec-propagate-platform_get_irq-errors.patch
queue-6.12/net-sched-act_ct-don-t-warn-on-benign-flow_offload_a.patch
queue-6.12/net-stmmac-dwmac4-use-the-correct-bufzise-when-the-l.patch
queue-6.12/netfilter-nf_tables-tolerate-chains-with-no-remainin.patch
queue-6.12/dmaengine-sprd-fix-runtime-pm-reference-leak-in-prob.patch
queue-6.12/bnxt_en-do-not-set-eop-on-rx-agg-bds-on-5760x-chips.patch
queue-6.12/bluetooth-coredump-quiesce-dump-work-on-unregister.patch
queue-6.12/drm-amdgpu-hold-a-runtime-pm-reference-for-p2p-dma-buf-attachments.patch
queue-6.12/xfs-fix-short-ifork-reaping-computation-in-xreap_bmapi_binval.patch
queue-6.12/arm64-hibernate-clone-only-the-linear-map-that-exist.patch
queue-6.12/bootconfig-fix-integer-overflow-in-initrd-size-check.patch
queue-6.12/perf-x86-intel-remove-anythread_deprecated-bit-from-perf_capabilities.patch
queue-6.12/f2fs-fix-to-clear-dirty-flag-on-folio-in-error-path.patch
queue-6.12/alsa-6fire-clean-ups-with-guard.patch
queue-6.12/xfs-fix-backwards-mergeability-logic-in-refcount-scrubber.patch
queue-6.12/nvdimm-pmem-keep-preflush-before-data-writes.patch
queue-6.12/tracing-take-trace_array-reference-when-opening-a-tracer-options-file.patch
queue-6.12/bpf-factor-out-htab_elem_value-helper.patch
queue-6.12/rtc-rzn1-handle-unset-alarm-weekday-in-rzn1_rtc_read_alarm.patch
queue-6.12/bluetooth-btmtksdio-fix-pm-runtime-reference-leak-in.patch
queue-6.12/ipv6-make-ipv6_pinfo.saddr_cache-a-boolean.patch
queue-6.12/mm-damon-core-allow-esz-to-be-set-to-zero.patch
queue-6.12/drm-amdgpu-use-gfp_nowait-for-memory-allocations.patch
queue-6.12/seg6-set-ipskb_l3slave-from-ip6skb_l3slave-on-ipip-d.patch
queue-6.12/f2fs-fix-dentry-folio-leak-in-find_in_level.patch
queue-6.12/xfrm-fix-compat-allocspi-request-use-after-free.patch
queue-6.12/wifi-cfg80211-add-option-for-vif-allowed-radios.patch
queue-6.12/i2c-qcom-cci-stop-complaining-about-dt-set-clock-rate.patch
queue-6.12/tracing-take-the-reference-before-publishing-the-named-histogram-trigger.patch
queue-6.12/perf-x86-intel-fix-grt-pebs-load-store-direction-for-latency-events-to-fix-sample-classification.patch
queue-6.12/wifi-libipw-reject-too-short-association-responses.patch
queue-6.12/idpf-disable-dim-work-before-freeing-q_vectors.patch
queue-6.12/selftests-ftrace-fix-unique-symbol-check-in-kprobe_n.patch
queue-6.12/net-stmmac-do-not-overwrite-phc_index-when-no-ptp-cl.patch
queue-6.12/idpf-introduce-idpf_q_vec_rsrc-struct-and-move-vector-resources-to-it.patch
queue-6.12/iommufd-pass-pasid-through-the-device-attach-replace-path.patch
queue-6.12/rdma-efa-keep-admin-queues-alive-while-irq-is-regist.patch
queue-6.12/revert-hwmon-emc1403-drop-hysteresis-for-low-limit-t.patch
queue-6.12/mm-huge_memory-use-folio-s-memcg-inside-__folio_spli.patch
queue-6.12/io_uring-rw-end-write-accounting-from-ki_complete.patch
queue-6.12/netfilter-flowtable-hold-reference-on-ct-until-flow-.patch
queue-6.12/tracing-set-the-trace-clock-before-registering-the-histogram-trigger.patch
queue-6.12/asoc-hdmi-codec-report-a-change-when-the-channel-sta.patch
queue-6.12/net-ethernet-stmmac-dwmac-rk-fix-bulk-clock-leak-whe.patch
queue-6.12/wifi-mt76-mt7996-bound-the-device-eeprom-address-before-the-efuse-copy.patch
queue-6.12/documentation-tracing-add-documentation-about-eprobes.patch
queue-6.12/asoc-rename-snd_soc_dai_link_ch_map.ch_mask-to-cpu_c.patch
queue-6.12/net-sched-act_ct-fix-helper-uaf-due-to-extensions-realloc.patch
queue-6.12/bpf-fix-bounds-check-for-skb-backed-dynptrs.patch
queue-6.12/wifi-cfg80211-check-ip-header-size-in-cfg80211_class.patch
queue-6.12/vxlan-use-one-headroom-snapshot-for-neighbour-replie.patch
queue-6.12/net-stmmac-propagate-fpe-preemption-class-mapping-er.patch
queue-6.12/net-bcmgenet-mask-dma_timeout_mask-when-reading-dma_.patch
queue-6.12/nvdimm-virtio_pmem-stop-allocating-child-flush-bio.patch
queue-6.12/staging-rtl8723bs-fix-spacing-around-operators.patch
queue-6.12/mptcp-prevent-race-between-disconnect-and-rtx.patch
queue-6.12/wifi-mac80211-don-t-allow-injecting-frames-wider-tha.patch
queue-6.12/spi-spi-zynqmp-gqspi-stop-the-controller-on-shutdown.patch
queue-6.12/scsi-fnic-fix-missed-link-up-when-critical-irq-targets-offline-cpu.patch
queue-6.12/net-macb-use-netif_napi_add_tx-instead-of-netif_napi_add-for-tx-napi.patch
queue-6.12/nfc-virtual_ncidev-add-missing-ioctl-compat-handler.patch
queue-6.12/x86-fred-reconstruct-the-gp-context-for-rejected-int.patch
queue-6.12/usb-gadget-f_mass_storage-fix-null-pointer-dereference-in-fsg_common_set_num_buffers.patch
queue-6.12/net-bridge-use-option-bits-for-cfm-mrp-frame-handlers.patch
queue-6.12/net-stmmac-selftests-support-running-selftests-on-ds.patch
queue-6.12/kvm-sev-do-cache-maintenance-on-the-source-vm-during-intra-host-migration.patch
queue-6.12/net-smc-address-spelling-errors.patch
queue-6.12/hid-bpf-fix-__hid_bpf_hw_check_params-report-length.patch
queue-6.12/power-supply-qcom_battmgr-fix-use-after-free.patch
queue-6.12/net-sched-sch_hfsc-bound-the-classify-inner-filter-w.patch
queue-6.12/tcp-skip-cond_resched-in-inet_csk_listen_stop-under-.patch
queue-6.12/bpf-avoid-soft-lockup-in-__htab_map_lookup_and_delet.patch
queue-6.12/bpf-arm64-set-up-the-frame-pointer-for-the-exception.patch
queue-6.12/net-smc-fix-uaf-on-lgr-list-traversal-in-smcr_port_e.patch
queue-6.12/smb-client-fix-busy-dentry-warning-on-unmount-after-.patch
queue-6.12/platform-x86-think-lmi-improve-check-if-bios-account-security-enabled.patch
queue-6.12/platform-x86-amd-pmc-move-stb-functionality-to-a-new-file-for-better-code-organization.patch
queue-6.12/perf-x86-intel-update-event-constraints-and-cache_extra_regsfor-lnl.patch
queue-6.12/mptcp-use-sock_kmemdup-for-address-entry.patch
queue-6.12/f2fs-fix-to-avoid-potential-section-unaligned-pinfile.patch
queue-6.12/wifi-rtw88-tx-qos-null-data-the-same-way-as-null-dat.patch
queue-6.12/perf-x86-intel-update-event-constraints-and-cache_extra_regsfor-adl.patch
queue-6.12/edac-altera-use-ecc-manager-compatible-to-select-a10-s10-irq-layout.patch
queue-6.12/selftests-landlock-add-disconnected-leafs-and-branch.patch
queue-6.12/wifi-cfg80211-only-group-hidden-bsses-with-beacon-en.patch
queue-6.12/super-make-iterate_supers_type-deletion-safe.patch
queue-6.12/drm-add-drm_memory_stats_is_zero.patch
queue-6.12/drm-amd-display-set-gpuvm-min-page-size-to-4k-on-dcn35-36.patch
queue-6.12/scsi-qla2xxx-fix-64g-link-speed-reporting-in-get_data_rate.patch
queue-6.12/eth-fbnic-set-aw_flush_mode-alongside-aw_flush-when-.patch
queue-6.12/input-hp_sdc-shut-down-kicker-timer-on-module-exit.patch

