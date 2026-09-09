Return-Path: <linuxppc-dev+bounces-26922-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9576C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 12:59:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg19V06dqz2yqd;
	Wed, 09 Sep 2026 22:59:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788958781;
	cv=none; b=Urg6BArCWZRM7EjRv3sDOY+Ai1rMBk5d746WOdvgOjKSFe9R1uCMuSk8tCJ5McNapHTWn85tvFCF6i2p+3c1ZqnD1VFcD4dO1UiNvb+nuK5gFkr6Hsbsj3wCJ/L4FFzX0qzpFgni1EfzH6Fz2b7+EZpsLc2zhqSaMGpZBVx5xBvSX1pr9Go5Aao/FI3fkvVwbxATx2+N3rVIPPRw9wJjD3Qlk5purDfyxjDc6Adkj36ckDdT6P9Hc4euLt3gyZdh0lr7DLLUKs0SFgmyu9JVz5Qm9U0qodLqgfiodMFa+BuTuRGAbzpFGyQjyatb1TUBVvu1AJbw0ZhEBvNKBEiOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788958781; c=relaxed/relaxed;
	bh=LMiQoc+iBO72EkvWJBV0RA0MYK8/kPy8G50nsozKGvk=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=LMPEcWYKhgRhkSVQ76TWA0XwJ8w8P6yFVB7cb47npm7+mmRllCttgAwM4E6+x607yDtmwJ123vxyEoIAK5EYR+eS/reSuJ5ZBAEahTA3l+6Bc0jCjaAQlOmonaINMyr9d5FmTpuWwXlJ0FNb0mG9jmkFSOmmwVhe4u4n0yU4gnB9fl6eAtdOgHv09kJy60dG9IS0Vnszfylg84UF15WqG8SD2eKXDjeiFNah1AJV99CHvxHuMJF2YOYPQjl4EE7+mQqUJ0tjQ1xBvr7lrrsPKBFzisSfQmEd9A8Mamht2OmzAy5YOirHTCkqXEBAzx2P6YLoOPoELuUGwJcYiDTodA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KezNYus4; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KezNYus4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg19S3X6vz2ypw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 22:59:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 440AB60211;
	Wed,  9 Sep 2026 12:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC341F00A3D;
	Wed,  9 Sep 2026 12:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788958776;
	bh=LMiQoc+iBO72EkvWJBV0RA0MYK8/kPy8G50nsozKGvk=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=KezNYus480PoeV045we1XqfoMNZmWuBNrm1rSthesfHBeQC94GtEnAM+9/yE9l+wf
	 FHhUoLQXoYPGtw9wA4C2Gi7GY8LKpvKXeiIbPGCO0OC/Yt13joHwjw0eRKrm2BIfKV
	 yiHAL+scEutfz+lVLCFDo2t211U5tRIT3KWGO9zA=
Subject: Patch "PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value" has been added to the 7.2-stable tree
To: alifm@linux.ibm.com,bhelgaas@google.com,gregkh@linuxfoundation.org,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,sashal@kernel.org,tyreld@linux.ibm.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 14:59:10 +0200
In-Reply-To: <20260909114744.2013430-1-sashal@kernel.org>
Message-ID: <2026090910-refinance-gave-3ce5@gregkh>
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

to the 7.2-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     pci-introduce-pci_slot_placeholder-constant-for-slot_nr-placeholder-value.patch
and it can be found in the queue-7.2 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-319225-greg=kroah.com@vger.kernel.org Wed Sep  9 14:48:10 2026
From: Sasha Levin <sashal@kernel.org>
Date: Wed,  9 Sep 2026 07:47:43 -0400
Subject: PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value
To: stable@vger.kernel.org
Cc: Farhan Ali <alifm@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Tyrel Datwyler <tyreld@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Message-ID: <20260909114744.2013430-1-sashal@kernel.org>

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
Stable-dep-of: dcc5bec09e23 ("PCI: Allow per function PCI slots to fix slot reset on s390")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/hotplug/pnv_php.c     |    2 +-
 drivers/pci/hotplug/rpaphp_slot.c |    2 +-
 drivers/pci/slot.c                |   21 +++++++++++----------
 include/linux/pci.h               |    3 +++
 4 files changed, 16 insertions(+), 12 deletions(-)

--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -808,7 +808,7 @@ static struct pnv_php_slot *pnv_php_allo
 	if (dn->child && PCI_DN(dn->child))
 		php_slot->slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
 	else
-		php_slot->slot_no = -1;   /* Placeholder slot */
+		php_slot->slot_no = PCI_SLOT_PLACEHOLDER;   /* Placeholder slot */
 
 	kref_init(&php_slot->kref);
 	php_slot->state	                = PNV_PHP_STATE_INITIALIZED;
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -84,7 +84,7 @@ int rpaphp_register_slot(struct slot *sl
 	struct hotplug_slot *php_slot = &slot->hotplug_slot;
 	u32 my_index;
 	int retval;
-	int slotno = -1;
+	int slotno = PCI_SLOT_PLACEHOLDER;
 
 	dbg("%s registering slot:path[%pOF] index[%x], name[%s] pdomain[%x] type[%d]\n",
 		__func__, slot->dn, slot->index, slot->name,
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -37,7 +37,7 @@ static const struct sysfs_ops pci_slot_s
 
 static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 {
-	if (slot->number == 0xff)
+	if (slot->number == PCI_SLOT_PLACEHOLDER)
 		return sysfs_emit(buf, "%04x:%02x\n",
 				  pci_domain_nr(slot->bus),
 				  slot->bus->number);
@@ -210,7 +210,7 @@ static struct pci_slot *get_slot(struct
 /**
  * pci_create_slot - create or increment refcount for physical PCI slot
  * @parent: struct pci_bus of parent bridge
- * @slot_nr: PCI_SLOT(pci_dev->devfn), -1 for placeholder, or
+ * @slot_nr: PCI_SLOT(pci_dev->devfn), PCI_SLOT_PLACEHOLDER for placeholder, or
  *	PCI_SLOT_ALL_DEVICES
  * @name: user visible string presented in /sys/bus/pci/slots/<name>
  * @hotplug: set if caller is hotplug driver, NULL otherwise
@@ -236,15 +236,16 @@ static struct pci_slot *get_slot(struct
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
  *
  * Bus-wide slots:
  * For PCIe hotplug, the physical slot encompasses the entire secondary
@@ -267,7 +268,7 @@ struct pci_slot *pci_create_slot(struct
 
 	mutex_lock(&pci_slot_mutex);
 
-	if (slot_nr == -1)
+	if (slot_nr == PCI_SLOT_PLACEHOLDER)
 		goto placeholder;
 
 	/*
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -81,6 +81,9 @@
  */
 #define PCI_SLOT_ALL_DEVICES	0xfe
 
+/* Used to identify a slot as a placeholder */
+#define PCI_SLOT_PLACEHOLDER	0xff
+
 /* pci_slot represents a physical slot */
 struct pci_slot {
 	struct pci_bus		*bus;		/* Bus this slot is on */


Patches currently in stable-queue which might be from sashal@kernel.org are

queue-7.2/bpf-factor-stackid_init-function-from-__bpf_get_stackid.patch
queue-7.2/kvm-x86-mmu-use-split-zap-all-fast-helpers-when-invalidating-memslot.patch
queue-7.2/net-skbuff-don-t-skb_tx_error-the-source-skb-in-skb_.patch
queue-7.2/remoteproc-qcom-pas-guard-dtb-metadata-release-with-dtb_pas_id-check.patch
queue-7.2/zram-move-lockmap-to-be-per-zram-instead-per-table.patch
queue-7.2/usb-gadget-ffs-fix-mm-lifetime-handling.patch
queue-7.2/bpf-disable-preemption-in-bpf_get_stackid.patch
queue-7.2/acpi-battery-protect-all-properties-with-a-separated-mutex.patch
queue-7.2/pci-allow-per-function-pci-slots-to-fix-slot-reset-on-s390.patch
queue-7.2/bpf-factor-stackid_new_bucket-from-__bpf_get_stackid.patch
queue-7.2/bpf-factor-stackid_fastpath-function-from-__bpf_get_stackid.patch
queue-7.2/kvm-x86-mmu-fold-kvm_mmu_zap_memslot-into-kvm_arch_flush_shadow_memslot.patch
queue-7.2/kvm-x86-mmu-split-kvm_mmu_zap_all_fast-into-front-and-back-halves.patch
queue-7.2/nfsd-prevent-client-use-after-free-during-blocked-lock-reaping.patch
queue-7.2/nfsd-prevent-client-use-after-free-during-close_lru-reaping.patch
queue-7.2/nfsd-annotate-caller-preconditions-for-the-state-table-walkers.patch
queue-7.2/kvm-sev-forcefully-invalidate-snp-vmsa-if-its-backing-gmem-page-is-zapped.patch
queue-7.2/nfsd-guard-admin-state-revocation-walks-with-nfsd_net_up.patch
queue-7.2/power-supply-ab8500_fg-fix-use-after-free-on-remove.patch
queue-7.2/ceph-properly-decrypt-filenames-in-vmalloc-buffers.patch
queue-7.2/zram-fix-slot-lock-bit-position-on-big-endian-64-bit.patch
queue-7.2/pci-introduce-pci_slot_placeholder-constant-for-slot_nr-placeholder-value.patch
queue-7.2/nfsd-prevent-client-use-after-free-during-export-state-revocation.patch
queue-7.2/hid-sony-clean-up-device-list-on-probe-failure.patch
queue-7.2/bpf-use-stack-id-functions-instead-of-__bpf_get_stackid.patch
queue-7.2/rpcrdma-arm-rn_done-before-publishing-the-notification.patch
queue-7.2/power-supply-ab8500_fg-remove-redundant-dev_err-dev_err_probe.patch
queue-7.2/usb-gadget-f_fs-fix-use-after-free-in-aio-error-path.patch
queue-7.2/acpi-battery-use-kstrtoul-over-sscanf-lu-n.patch
queue-7.2/mm-page_alloc-don-t-spin_trylock-in-nmi-on-up.patch
queue-7.2/hid-sony-use-guard-and-scoped_guard.patch
queue-7.2/nfsd-consolidate-the-revocation-path-client-unpin.patch

