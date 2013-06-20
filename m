Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 217192C009D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 20:13:41 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 06:13:39 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 7A64638C8045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 06:13:36 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5KADbdH300728
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 06:13:37 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5KADamg019217
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 06:13:37 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] powerpc/eeh: Debugfs for error injection
Date: Thu, 20 Jun 2013 18:13:26 +0800
Message-Id: <1371723206-26190-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371723206-26190-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371723206-26190-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch creates debugfs entries (powerpc/PCIxxxx/err_injct) for
injecting EEH errors for testing purpose.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   31 +++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 2b7689e..84f3036 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/bootmem.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -64,6 +65,29 @@ static struct notifier_block ioda_eeh_nb = {
 	.priority	= 0
 };
 
+#ifdef CONFIG_DEBUG_FS
+static int ioda_eeh_dbgfs_set(void *data, u64 val)
+{
+	struct pci_controller *hose = data;
+	struct pnv_phb *phb = hose->private_data;
+
+	out_be64(phb->regs + 0xD10, val);
+	return 0;
+}
+
+static int ioda_eeh_dbgfs_get(void *data, u64 *val)
+{
+	struct pci_controller *hose = data;
+	struct pnv_phb *phb = hose->private_data;
+
+	*val = in_be64(phb->regs + 0xD10);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(ioda_eeh_dbgfs_ops, ioda_eeh_dbgfs_get,
+			ioda_eeh_dbgfs_set, "0x%llx\n");
+#endif /* CONFIG_DEBUG_FS */
+
 /**
  * ioda_eeh_post_init - Chip dependent post initialization
  * @hose: PCI controller
@@ -101,6 +125,13 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 			}
 		}
 
+#ifdef CONFIG_DEBUG_FS
+		if (phb->dbgfs)
+			debugfs_create_file("err_injct", 0600,
+					    phb->dbgfs, hose,
+					    &ioda_eeh_dbgfs_ops);
+#endif
+
 		phb->eeh_enabled = 1;
 	}
 
-- 
1.7.5.4
