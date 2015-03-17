Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 041511A0BC5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 12:44:29 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9D00914009B
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:44:28 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Mar 2015 11:44:28 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 724B42CE8052
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:44:25 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2H1iHFU48103640
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:44:25 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2H1hp2g014401
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 12:43:52 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/7] powerpc/pci: Trace more information from pci_dn
Date: Tue, 17 Mar 2015 12:37:20 +1100
Message-Id: <1426556244-30066-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1426556244-30066-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1426556244-30066-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Originally, EEH probes on device_node or pci_dev and populates the
corresponding eeh_dev. In the subsequent patches, EEH will probes
on pci_dn and populates the corresponding eeh_dev. So we have to
cache some information in pci_dn, either from device_node or SRIOV
PF's enablement platform hook, to populate the eeh_dev properly.

The motivation to probe pci_dn, instead of device node or pci_dev,
to populate eeh_dev is SRIOV VFs are dynamically created and we
don't have the corresponding device nodes for them.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h |  3 +++
 arch/powerpc/kernel/pci_dn.c          | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 513f8f2..2ab6c4a 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -160,6 +160,9 @@ struct pci_dn {
 
 	int	busno;			/* pci bus number */
 	int	devfn;			/* pci device and function number */
+	int	vendor_id;		/* Vendor ID */
+	int	device_id;		/* Device ID */
+	int	class_code;		/* Device class code */
 
 	struct  pci_dn *parent;
 	struct  pci_controller *phb;	/* for pci devices */
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index f3a1a81..c990275 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -281,6 +281,15 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 		pdn->devfn = (addr >> 8) & 0xff;
 	}
 
+	/* vendor/device IDs and class code */
+	regs = of_get_property(dn, "vendor-id", NULL);
+	pdn->vendor_id = regs ? of_read_number(regs, 1) : 0;
+	regs = of_get_property(dn, "device-id", NULL);
+	pdn->device_id = regs ? of_read_number(regs, 1) : 0;
+	regs = of_get_property(dn, "class-code", NULL);
+	pdn->class_code = regs ? of_read_number(regs, 1) : 0;
+
+	/* Extended config space */
 	pdn->pci_ext_config_space = (type && of_read_number(type, 1) == 1);
 
 	/* Attach to parent node */
@@ -370,6 +379,7 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 	pdn = dn->data;
 	if (pdn) {
 		pdn->devfn = pdn->busno = -1;
+		pdn->vendor_id = pdn->device_id = pdn->class_code = 0;
 		pdn->phb = phb;
 		phb->firmware_data = pdn;
 	}
-- 
1.8.3.2
