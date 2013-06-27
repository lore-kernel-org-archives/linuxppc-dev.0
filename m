Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6F6022C04D9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 15:48:00 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 27 Jun 2013 01:47:57 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A2A2B6E803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 01:47:21 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5R5ktx0324574
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 01:46:55 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5R5ktaD026189
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:55 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/8] powerpc/eeh: Avoid build warnings
Date: Thu, 27 Jun 2013 13:46:47 +0800
Message-Id: <1372312009-13710-7-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch is for avoiding following build warnings:

   The function .pnv_pci_ioda_fixup() references
   the function __init .eeh_init().
   This is often because .pnv_pci_ioda_fixup lacks a __init

   The function .pnv_pci_ioda_fixup() references
   the function __init .eeh_addr_cache_build().
   This is often because .pnv_pci_ioda_fixup lacks a __init

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h  |    4 ++--
 arch/powerpc/kernel/eeh.c       |    2 +-
 arch/powerpc/kernel/eeh_cache.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index dd65e31..09a8743 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -202,13 +202,13 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
 
 void *eeh_dev_init(struct device_node *dn, void *data);
 void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
-int __init eeh_init(void);
+int eeh_init(void);
 int __init eeh_ops_register(struct eeh_ops *ops);
 int __exit eeh_ops_unregister(const char *name);
 unsigned long eeh_check_failure(const volatile void __iomem *token,
 				unsigned long val);
 int eeh_dev_check_failure(struct eeh_dev *edev);
-void __init eeh_addr_cache_build(void);
+void eeh_addr_cache_build(void);
 void eeh_add_device_tree_early(struct device_node *);
 void eeh_add_device_tree_late(struct pci_bus *);
 void eeh_add_sysfs_files(struct pci_bus *);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index f7f2775..14475f6 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -751,7 +751,7 @@ int __exit eeh_ops_unregister(const char *name)
  * Even if force-off is set, the EEH hardware is still enabled, so that
  * newer systems can boot.
  */
-int __init eeh_init(void)
+int eeh_init(void)
 {
 	struct pci_controller *hose, *tmp;
 	struct device_node *phb;
diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index 858ebea..ea9a94c 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -285,7 +285,7 @@ void eeh_addr_cache_rmv_dev(struct pci_dev *dev)
  * Must be run late in boot process, after the pci controllers
  * have been scanned for devices (after all device resources are known).
  */
-void __init eeh_addr_cache_build(void)
+void eeh_addr_cache_build(void)
 {
 	struct device_node *dn;
 	struct eeh_dev *edev;
-- 
1.7.5.4
