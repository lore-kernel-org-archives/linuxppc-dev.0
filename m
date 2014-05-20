Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E34B01A085D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:30:24 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 20 May 2014 18:30:23 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C7E1B357804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:30:20 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4K88tRK22610114
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:08:55 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4K8UKYC022823
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:30:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 2/4] powerpc/eeh: Flags for passed device and PE
Date: Tue, 20 May 2014 18:30:10 +1000
Message-Id: <1400574612-19411-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, agraf@suse.de, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces new flags for EEH device and PE to indicate
that the device or PE has been passed through to guest. In turn,
we will deliver EEH errors to guest for further handling, which
will be done in subsequent patches.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 7782056..34a2d83 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -72,6 +72,7 @@ struct device_node;
 #define EEH_PE_RESET		(1 << 2)	/* PE reset in progress	*/
 
 #define EEH_PE_KEEP		(1 << 8)	/* Keep PE on hotplug	*/
+#define EEH_PE_PASSTHROUGH	(1 << 9)	/* PE owned by guest	*/
 
 struct eeh_pe {
 	int type;			/* PE type: PHB/Bus/Device	*/
@@ -93,6 +94,21 @@ struct eeh_pe {
 #define eeh_pe_for_each_dev(pe, edev, tmp) \
 		list_for_each_entry_safe(edev, tmp, &pe->edevs, list)
 
+static inline bool eeh_pe_passed(struct eeh_pe *pe)
+{
+	return pe ? !!(pe->state & EEH_PE_PASSTHROUGH) : false;
+}
+
+static inline void eeh_pe_set_passed(struct eeh_pe *pe, bool passed)
+{
+	if (pe) {
+		if (passed)
+			pe->state |= EEH_PE_PASSTHROUGH;
+		else
+			pe->state &= ~EEH_PE_PASSTHROUGH;
+	}
+}
+
 /*
  * The struct is used to trace EEH state for the associated
  * PCI device node or PCI device. In future, it might
@@ -110,6 +126,7 @@ struct eeh_pe {
 #define EEH_DEV_SYSFS		(1 << 9)	/* Sysfs created	*/
 #define EEH_DEV_REMOVED		(1 << 10)	/* Removed permanently	*/
 #define EEH_DEV_FRESET		(1 << 11)	/* Fundamental reset	*/
+#define EEH_DEV_PASSTHROUGH	(1 << 12)	/* Owned by guest	*/
 
 struct eeh_dev {
 	int mode;			/* EEH mode			*/
@@ -138,6 +155,21 @@ static inline struct pci_dev *eeh_dev_to_pci_dev(struct eeh_dev *edev)
 	return edev ? edev->pdev : NULL;
 }
 
+static inline bool eeh_dev_passed(struct eeh_dev *dev)
+{
+	return dev ? !!(dev->mode & EEH_DEV_PASSTHROUGH) : false;
+}
+
+static inline void eeh_dev_set_passed(struct eeh_dev *dev, bool passed)
+{
+	if (dev) {
+		if (passed)
+			dev->mode |= EEH_DEV_PASSTHROUGH;
+		else
+			dev->mode &= ~EEH_DEV_PASSTHROUGH;
+	}
+}
+
 /* Return values from eeh_ops::next_error */
 enum {
 	EEH_NEXT_ERR_NONE = 0,
-- 
1.8.3.2
