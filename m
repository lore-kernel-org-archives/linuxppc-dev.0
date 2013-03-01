Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 44E642C02A1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 01:17:37 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 1 Mar 2013 09:17:35 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6B7D838C801B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 09:17:33 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r21EHXpx29688056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:17:33 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r21EHW0a007662
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 11:17:33 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/22] powerpc/eeh: Make eeh_init public
Date: Fri,  1 Mar 2013 22:17:04 +0800
Message-Id: <1362147440-14096-7-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For EEH on PowerNV platform, we will do EEH probe based on the
real PCI devices. The PCI devices are available after PCI probe.
So we have to call eeh_init() explicitly on PowerNV platform
after PCI probe.

The patch also enables eeh_init() to do EEH probe for PowerNV
platform.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h       |    6 ++++++
 arch/powerpc/platforms/pseries/eeh.c |   23 +++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 557d82a..1ff2aa9 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -199,6 +199,7 @@ void eeh_pci_dev_traverse(struct pci_bus *bus,
 		eeh_pci_traverse_func fn, void *flag);
 void *eeh_dev_init(struct device_node *dn, void *data);
 void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
+int __init eeh_init(void);
 int __init eeh_ops_register(struct eeh_ops *ops);
 int __exit eeh_ops_unregister(const char *name);
 unsigned long eeh_check_failure(const volatile void __iomem *token,
@@ -227,6 +228,11 @@ void eeh_remove_bus_device(struct pci_dev *, int);
 
 #else /* !CONFIG_EEH */
 
+static inline int eeh_init(void)
+{
+	return 0;
+}
+
 static inline void *eeh_dev_init(struct device_node *dn, void *data)
 {
 	return NULL;
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 6b73d6c..abe26f8 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -674,11 +674,21 @@ int __exit eeh_ops_unregister(const char *name)
  * Even if force-off is set, the EEH hardware is still enabled, so that
  * newer systems can boot.
  */
-static int __init eeh_init(void)
+int __init eeh_init(void)
 {
 	struct pci_controller *hose, *tmp;
 	struct device_node *phb;
-	int ret;
+	static int cnt = 0;
+	int ret = 0;
+
+	/*
+	 * We have to delay the initialization on PowerNV after
+	 * the PCI hierarchy tree has been built because the PEs
+	 * are figured out based on PCI devices instead of device
+	 * tree nodes
+	 */
+	if (machine_is(powernv) && cnt++ <= 0)
+		return ret;
 
 	/* call platform initialization function */
 	if (!eeh_ops) {
@@ -700,6 +710,15 @@ static int __init eeh_init(void)
 			phb = hose->dn;
 			traverse_pci_devices(phb, eeh_ops->of_probe, NULL);
 		}
+	} else if (eeh_probe_mode_dev()) {
+		list_for_each_entry_safe(hose, tmp,
+			&hose_list, list_node) {
+			eeh_pci_dev_traverse(hose->bus, eeh_ops->dev_probe, NULL);
+		}
+	} else {
+		pr_warning("%s: Invalid probe mode %d\n",
+			__func__, eeh_probe_mode);
+		return -EINVAL;
 	}
 
 	if (eeh_subsystem_enabled)
-- 
1.7.5.4
