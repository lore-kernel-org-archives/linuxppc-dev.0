Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 73CB8B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 11:58:52 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 22 Mar 2012 00:56:23 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2M0qnwn3211468
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 11:52:49 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2M0wm07002019
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 11:58:48 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Subject: [PATCH 1/3] powerpc/eeh: remove eeh device from OF node
Date: Wed, 21 Mar 2012 15:30:27 +0800
Message-Id: <1332315029-29688-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: sfr@canb.auug.org.au, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Originally, the PCI sensitive OF node is tracing the eeh device
through struct device_node::edev. However, it was regarded as
bad idea.

The patch removes struct device_node::edev and uses PCI_DN to
trace the corresponding eeh device according to BenH's comments.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h    |    8 ++++++++
 arch/powerpc/platforms/pseries/eeh_dev.c |    2 +-
 include/linux/of.h                       |   10 ----------
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 5d48765..21f99ae 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -155,6 +155,7 @@ struct pci_dn {
 
 	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 #ifdef CONFIG_EEH
+	struct eeh_dev *edev;		/* eeh device */
 	int	class_code;		/* pci device class */
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
@@ -185,6 +186,13 @@ static inline int pci_device_from_OF_node(struct device_node *np,
 	return 0;
 }
 
+#if defined(CONFIG_EEH)
+static inline struct eeh_dev *of_node_to_eeh_dev(struct device_node *dn)
+{
+	return PCI_DN(dn)->edev;
+}
+#endif
+
 /** Find the bus corresponding to the indicated device node */
 extern struct pci_bus *pcibios_find_pci_bus(struct device_node *dn);
 
diff --git a/arch/powerpc/platforms/pseries/eeh_dev.c b/arch/powerpc/platforms/pseries/eeh_dev.c
index f3aed7d..c4507d0 100644
--- a/arch/powerpc/platforms/pseries/eeh_dev.c
+++ b/arch/powerpc/platforms/pseries/eeh_dev.c
@@ -62,7 +62,7 @@ void * __devinit eeh_dev_init(struct device_node *dn, void *data)
 	}
 
 	/* Associate EEH device with OF node */
-	dn->edev  = edev;
+	PCI_DN(dn)->edev = edev;
 	edev->dn  = dn;
 	edev->phb = phb;
 
diff --git a/include/linux/of.h b/include/linux/of.h
index bdb1c07..92cf6ad 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -58,9 +58,6 @@ struct device_node {
 	struct	kref kref;
 	unsigned long _flags;
 	void	*data;
-#if defined(CONFIG_EEH)
-	struct eeh_dev *edev;
-#endif
 #if defined(CONFIG_SPARC)
 	char	*path_component_name;
 	unsigned int unique_id;
@@ -75,13 +72,6 @@ struct of_phandle_args {
 	uint32_t args[MAX_PHANDLE_ARGS];
 };
 
-#if defined(CONFIG_EEH)
-static inline struct eeh_dev *of_node_to_eeh_dev(struct device_node *dn)
-{
-	return dn->edev;
-}
-#endif
-
 #if defined(CONFIG_SPARC) || !defined(CONFIG_OF)
 /* Dummy ref counting routines - to be implemented later */
 static inline struct device_node *of_node_get(struct device_node *node)
-- 
1.7.5.4
