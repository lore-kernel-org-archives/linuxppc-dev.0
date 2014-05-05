Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 027091401B0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:59 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:27:57 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8CBB22CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:55 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516dT153412018
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:39 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451RsgL011691
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:55 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 07/22] powerpc/eeh: Function to tear down address mapping
Date: Mon,  5 May 2014 11:27:56 +1000
Message-Id: <1399253291-3975-8-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch introduces function kvm_vfio_eeh_dev_unmap(), which is
expected to be called on IOCTL command issued to the VM device, in
order to tear down the address mapping for VFIO PCI device.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/kvm_host.h     |  7 ++++
 2 files changed, 89 insertions(+)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 200cd5a..8398efc 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -420,6 +420,88 @@ int kvm_vfio_eeh_dev_map(struct kvm *kvm, int domain,
 }
 EXPORT_SYMBOL_GPL(kvm_vfio_eeh_dev_map);
 
+ /**
+  * kvm_vfio_eeh_dev_unmap - Tear down address mapping for VFIO PCI device
+  *
+  * @kvm: VM descriptor
+  * @domain: host domain
+  * @bdn: host bus/device/function number
+  *
+  * Tear down address mapping for VFIO PCI device.
+  */
+int kvm_vfio_eeh_dev_unmap(struct kvm *kvm, int domain, int bdn)
+{
+	struct pci_bus *bus;
+	struct pci_dev *dev;
+	struct eeh_pe *pe;
+	struct eeh_dev *edev, *tmp;
+	int bus_no, devfn;
+	bool passed;
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
+	/* Mark the EEH device as non-passed */
+	edev = pci_dev_to_eeh_dev(dev);
+	if (!edev) {
+		pr_warn("%s: No EEH dev for PCI device %s\n",
+			__func__, pci_name(dev));
+		return -ENODEV;
+	} else if (!eeh_dev_passed(edev)    ||
+		   !eeh_pe_passed(edev->pe) ||
+		   edev->gaddr.kvm != kvm   ||
+		   edev->pe->gaddr.kvm != kvm) {
+		pr_warn("%s: Non-passsed PCI dev %s or PE\n",
+			__func__, pci_name(dev));
+		return 0;
+	}
+	memset(&edev->gaddr, 0, sizeof(edev->gaddr));
+	eeh_dev_set_passed(edev, false);
+	pr_debug("EEH: Host PCI device %s returned\n",
+		pci_name(dev));
+
+	/*
+	 * Mark the PE as non-passed if all PCI devices
+	 * except P2P bridges are non-passed.
+	 */
+	pe = edev->pe;
+	passed = false;
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		dev = eeh_dev_to_pci_dev(edev);
+		if (dev && dev->subordinate)
+			continue;
+		if (eeh_dev_passed(edev)) {
+			passed = true;
+			break;
+		}
+	}
+
+	if (!passed) {
+		memset(&pe->gaddr, 0, sizeof(pe->gaddr));
+		eeh_pe_set_passed(pe, false);
+		pr_debug("EEH: PHB#%x-PE#%x returned to host\n",
+			pe->phb->global_number, pe->addr);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_vfio_eeh_dev_unmap);
+
 static void *__kvmppc_eeh_vfio_release(void *data, void *flag)
 {
 	struct eeh_pe *pe = (struct eeh_pe *)data;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 294ce48..520b3d0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1106,14 +1106,21 @@ static inline void kvm_vcpu_set_dy_eligible(struct kvm_vcpu *vcpu, bool val)
 #ifdef CONFIG_KVM_EEH
 typedef int (*kvm_vfio_dev_eeh_map)(struct kvm *kvm, int domain,
 				    int bdn, unsigned long buid, int gbdn);
+typedef int (*kvm_vfio_dev_eeh_unmap)(struct kvm *kvm, int domain, int bdn);
 extern int kvm_vfio_eeh_dev_map(struct kvm *kvm, int domain,
 				int bdn, unsigned long buid, int gbdn);
+extern int kvm_vfio_eeh_dev_unmap(struct kvm *kvm, int domain, int bdn);
 #else
 static inline int kvm_vfio_eeh_dev_map(struct kvm *kvm, int domain,
 				       int bdn, unsigned long buid, int gbdn)
 {
 	return 0;
 }
+
+static inline int kvm_vfio_eeh_dev_unmap(struct kvm *kvm, int domain, int bdn)
+{
+	return 0;
+}
 #endif /* CONFIG_KVM_EEH */
 
 #endif
-- 
1.8.3.2
