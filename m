Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 016611401D6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:57 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:27:56 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C61382CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:54 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516lM227066482
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:47 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451Rsft011489
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:54 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 06/22] powerpc/eeh: Function for address mapping
Date: Mon,  5 May 2014 11:27:55 +1000
Message-Id: <1399253291-3975-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces function kvm_vfio_eeh_dev_map(), which is
expected to be called on IOCTL command issued to the VM device, in
order to build the address mapping for VFIO PCI device.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c | 88 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/kvm_host.h     | 14 +++++++
 2 files changed, 102 insertions(+)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 9e73188..200cd5a 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -332,6 +332,94 @@ struct eeh_dev *eeh_vfio_dev_get(struct eeh_vfio_pci_addr *addr)
 	return NULL;
 }
 
+/**
+ * kvm_vfio_eeh_dev_map - Build the address mapping for VFIO device
+ *
+ * @kvm: VM descriptor
+ * @domain: host domain of PCI device
+ * @bdn: host bus/device/function number
+ * @buid: BUID of guest PHB
+ * @gbdn: guest bus/device/function number
+ *
+ * Build the address mapping between host and guest deivce. It's called
+ * while passing through PCI device from host to guest.
+ */
+int kvm_vfio_eeh_dev_map(struct kvm *kvm, int domain,
+			 int bdn, unsigned long buid, int gbdn)
+{
+	struct pci_bus *bus, *pe_bus;
+	struct pci_dev *dev;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	int bus_no, devfn;
+
+	/* Find the PCI device in host side */
+	bus_no = (bdn >> 8) & 0xff;
+	devfn = bdn & 0xff;
+	bus = pci_find_bus(domain, bus_no);
+	if (!bus) {
+		pr_warn("%s: PCI bus %04x:%02x not found\n",
+			__func__, domain, bus_no);
+		return -ENODEV;
+	}
+
+	dev = pci_get_slot(bus, devfn);
+	if (!dev) {
+		pr_warn("%s: PCI device %04x:%02x:%02x.%01x not found\n",
+			__func__, domain, bus_no,
+			PCI_SLOT(devfn), PCI_FUNC(devfn));
+		return -ENODEV;
+	}
+
+	/*
+	 * Mark the EEH device as passed. We allow dynamic change
+	 * on the address mapping.
+	 */
+	edev = pci_dev_to_eeh_dev(dev);
+	if (!edev) {
+		pr_warn("%s: No EEH dev for PCI device %s\n",
+			__func__, pci_name(dev));
+		return -ENODEV;
+	}
+
+	/*
+	 * The PE configuration address is exactly PCI config address
+	 * of the PE primary bus. That has format 00BBSS00 defined in
+	 * PAPR.
+	 */
+	pe = edev->pe;
+	if (!eeh_pe_passed(pe)) {
+		pe_bus = eeh_pe_bus_get(pe);
+		BUG_ON(!pe_bus);
+
+		pe->gaddr.kvm		= kvm;
+		pe->gaddr.buid_hi	= BUID_HI(buid);
+		pe->gaddr.buid_lo	= BUID_LO(buid);
+		pe->gaddr.pe_addr	= pe_bus->number << 16;
+		eeh_pe_set_passed(pe, true);
+	} else if (pe->gaddr.kvm != kvm ||
+		   pe->gaddr.buid_hi != BUID_HI(buid) ||
+		   pe->gaddr.buid_lo != BUID_LO(buid)) {
+		pr_warn("%s: Mismatched VM or PHB on passing %s\n",
+			__func__, pci_name(dev));
+		return -EINVAL;
+	}
+
+	edev->gaddr.kvm		= kvm;
+	edev->gaddr.buid_hi	= BUID_HI(buid);
+	edev->gaddr.buid_lo	= BUID_LO(buid);
+	edev->gaddr.bus		= (gbdn >> 8) & 0xff;
+	edev->gaddr.devfn	= gbdn & 0xff;
+	eeh_dev_set_passed(edev, true);
+
+	pr_debug("EEH: Host PCI device %s passed to %lx-%02x:%02x.%01x\n",
+		 pci_name(dev), buid, (gbdn >> 8) & 0xff,
+		 PCI_SLOT(gbdn & 0xff), PCI_FUNC(gbdn & 0xff));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_vfio_eeh_dev_map);
+
 static void *__kvmppc_eeh_vfio_release(void *data, void *flag)
 {
 	struct eeh_pe *pe = (struct eeh_pe *)data;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7d21cf9..294ce48 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1102,5 +1102,19 @@ static inline void kvm_vcpu_set_dy_eligible(struct kvm_vcpu *vcpu, bool val)
 {
 }
 #endif /* CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT */
+
+#ifdef CONFIG_KVM_EEH
+typedef int (*kvm_vfio_dev_eeh_map)(struct kvm *kvm, int domain,
+				    int bdn, unsigned long buid, int gbdn);
+extern int kvm_vfio_eeh_dev_map(struct kvm *kvm, int domain,
+				int bdn, unsigned long buid, int gbdn);
+#else
+static inline int kvm_vfio_eeh_dev_map(struct kvm *kvm, int domain,
+				       int bdn, unsigned long buid, int gbdn)
+{
+	return 0;
+}
+#endif /* CONFIG_KVM_EEH */
+
 #endif
 
-- 
1.8.3.2
