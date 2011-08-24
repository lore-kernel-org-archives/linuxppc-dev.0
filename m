Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 6C054B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Aug 2011 07:14:06 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Alex Williamson <alex.williamson@redhat.com>
To: Joerg Roedel <joerg.roedel@amd.com>
Date: Wed, 24 Aug 2011 15:13:49 -0600
In-Reply-To: <20110824091035.GD2079@amd.com>
References: <1314118861.2859.51.camel@bling.home>
	<CA79326A.FB97%aafabbri@cisco.com> <20110824091035.GD2079@amd.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314220434.2859.203.camel@bling.home>
Mime-Version: 1.0
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
	Aaron Fabbri <aafabbri@cisco.com>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"benve@cisco.com" <benve@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joerg,

Is this roughly what you're thinking of for the iommu_group component?
Adding a dev_to_group iommu ops callback let's us consolidate the sysfs
support in the iommu base.  Would AMD-Vi do something similar (or
exactly the same) for group #s?  Thanks,

Alex

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

diff --git a/drivers/base/iommu.c b/drivers/base/iommu.c
index 6e6b6a1..6b54c1a 100644
--- a/drivers/base/iommu.c
+++ b/drivers/base/iommu.c
@@ -17,20 +17,56 @@
  */
 
 #include <linux/bug.h>
+#include <linux/device.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/iommu.h>
+#include <linux/pci.h>
 
 static struct iommu_ops *iommu_ops;
 
+static ssize_t show_iommu_group(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lx", iommu_dev_to_group(dev));
+}
+static DEVICE_ATTR(iommu_group, S_IRUGO, show_iommu_group, NULL);
+
+static int add_iommu_group(struct device *dev, void *unused)
+{
+	if (iommu_dev_to_group(dev) >= 0)
+		return device_create_file(dev, &dev_attr_iommu_group);
+
+	return 0;
+}
+
+static int device_notifier(struct notifier_block *nb,
+			   unsigned long action, void *data)
+{
+	struct device *dev = data;
+
+	if (action == BUS_NOTIFY_ADD_DEVICE)
+		return add_iommu_group(dev, NULL);
+
+	return 0;
+}
+
+static struct notifier_block device_nb = {
+	.notifier_call = device_notifier,
+};
+
 void register_iommu(struct iommu_ops *ops)
 {
 	if (iommu_ops)
 		BUG();
 
 	iommu_ops = ops;
+
+	/* FIXME - non-PCI, really want for_each_bus() */
+	bus_register_notifier(&pci_bus_type, &device_nb);
+	bus_for_each_dev(&pci_bus_type, NULL, NULL, add_iommu_group);
 }
 
 bool iommu_found(void)
@@ -94,6 +130,14 @@ int iommu_domain_has_cap(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_domain_has_cap);
 
+long iommu_dev_to_group(struct device *dev)
+{
+	if (iommu_ops->dev_to_group)
+		return iommu_ops->dev_to_group(dev);
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(iommu_dev_to_group);
+
 int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	      phys_addr_t paddr, int gfp_order, int prot)
 {
diff --git a/drivers/pci/intel-iommu.c b/drivers/pci/intel-iommu.c
index f02c34d..477259c 100644
--- a/drivers/pci/intel-iommu.c
+++ b/drivers/pci/intel-iommu.c
@@ -404,6 +404,7 @@ static int dmar_map_gfx = 1;
 static int dmar_forcedac;
 static int intel_iommu_strict;
 static int intel_iommu_superpage = 1;
+static int intel_iommu_no_mf_groups;
 
 #define DUMMY_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-1))
 static DEFINE_SPINLOCK(device_domain_lock);
@@ -438,6 +439,10 @@ static int __init intel_iommu_setup(char *str)
 			printk(KERN_INFO
 				"Intel-IOMMU: disable supported super page\n");
 			intel_iommu_superpage = 0;
+		} else if (!strncmp(str, "no_mf_groups", 12)) {
+			printk(KERN_INFO
+				"Intel-IOMMU: disable separate groups for multifunction devices\n");
+			intel_iommu_no_mf_groups = 1;
 		}
 
 		str += strcspn(str, ",");
@@ -3902,6 +3907,52 @@ static int intel_iommu_domain_has_cap(struct iommu_domain *domain,
 	return 0;
 }
 
+/* Group numbers are arbitrary.  Device with the same group number
+ * indicate the iommu cannot differentiate between them.  To avoid
+ * tracking used groups we just use the seg|bus|devfn of the lowest
+ * level we're able to differentiate devices */
+static long intel_iommu_dev_to_group(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *bridge;
+	union {
+		struct {
+			u8 devfn;
+			u8 bus;
+			u16 segment;
+		} pci;
+		u32 group;
+	} id;
+
+	if (iommu_no_mapping(dev))
+		return -ENODEV;
+
+	id.pci.segment = pci_domain_nr(pdev->bus);
+	id.pci.bus = pdev->bus->number;
+	id.pci.devfn = pdev->devfn;
+
+	if (!device_to_iommu(id.pci.segment, id.pci.bus, id.pci.devfn))
+		return -ENODEV;
+
+	bridge = pci_find_upstream_pcie_bridge(pdev);
+	if (bridge) {
+		if (pci_is_pcie(bridge)) {
+			id.pci.bus = bridge->subordinate->number;
+			id.pci.devfn = 0;
+		} else {
+			id.pci.bus = bridge->bus->number;
+			id.pci.devfn = bridge->devfn;
+		}
+	}
+
+	/* Virtual functions always get their own group */
+	if (!pdev->is_virtfn && intel_iommu_no_mf_groups)
+		id.pci.devfn = PCI_DEVFN(PCI_SLOT(id.pci.devfn), 0);
+
+	/* FIXME - seg # >= 0x8000 on 32b */
+	return id.group;
+}
+
 static struct iommu_ops intel_iommu_ops = {
 	.domain_init	= intel_iommu_domain_init,
 	.domain_destroy = intel_iommu_domain_destroy,
@@ -3911,6 +3962,7 @@ static struct iommu_ops intel_iommu_ops = {
 	.unmap		= intel_iommu_unmap,
 	.iova_to_phys	= intel_iommu_iova_to_phys,
 	.domain_has_cap = intel_iommu_domain_has_cap,
+	.dev_to_group	= intel_iommu_dev_to_group,
 };
 
 static void __devinit quirk_iommu_rwbf(struct pci_dev *dev)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0a2ba40..90c1a86 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -45,6 +45,7 @@ struct iommu_ops {
 				    unsigned long iova);
 	int (*domain_has_cap)(struct iommu_domain *domain,
 			      unsigned long cap);
+	long (*dev_to_group)(struct device *dev);
 };
 
 #ifdef CONFIG_IOMMU_API
@@ -65,6 +66,7 @@ extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain,
 				      unsigned long iova);
 extern int iommu_domain_has_cap(struct iommu_domain *domain,
 				unsigned long cap);
+extern long iommu_dev_to_group(struct device *dev);
 
 #else /* CONFIG_IOMMU_API */
 
@@ -121,6 +123,10 @@ static inline int domain_has_cap(struct iommu_domain *domain,
 	return 0;
 }
 
+static inline long iommu_dev_to_group(struct device *dev);
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_IOMMU_API */
 
 #endif /* __LINUX_IOMMU_H */
