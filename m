Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA8C52C0375
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 01:17:51 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 1 Mar 2013 09:17:49 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 2C98DC90023
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 09:17:46 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r21EHjgr66977854
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:17:45 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r21EHjd2008773
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 11:17:45 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/22] powerpc/eeh: Differentiate EEH event
Date: Fri,  1 Mar 2013 22:17:08 +0800
Message-Id: <1362147440-14096-11-git-send-email-shangw@linux.vnet.ibm.com>
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

The EEH event is usually produced because of 0xFF's returned from
PCI config or I/O registers. PowerNV platform also can produce EEH
event through interrupts. The patch differentiates the EEH events
produced for different cases in order to process them differently
in future.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h             |    4 ++--
 arch/powerpc/include/asm/eeh_event.h       |    6 +++++-
 arch/powerpc/kernel/rtas_pci.c             |    3 ++-
 arch/powerpc/platforms/pseries/eeh.c       |    7 ++++---
 arch/powerpc/platforms/pseries/eeh_event.c |    4 +++-
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 09ea298..05b70dc 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -205,7 +205,7 @@ int __init eeh_ops_register(struct eeh_ops *ops);
 int __exit eeh_ops_unregister(const char *name);
 unsigned long eeh_check_failure(const volatile void __iomem *token,
 				unsigned long val);
-int eeh_dev_check_failure(struct eeh_dev *edev);
+int eeh_dev_check_failure(struct eeh_dev *edev, int flag);
 void __init eeh_addr_cache_build(void);
 void eeh_add_device_tree_early(struct device_node *);
 void eeh_add_device_tree_late(struct pci_bus *);
@@ -246,7 +246,7 @@ static inline unsigned long eeh_check_failure(const volatile void __iomem *token
 	return val;
 }
 
-#define eeh_dev_check_failure(x) (0)
+#define eeh_dev_check_failure(x, f) (0)
 
 static inline void eeh_addr_cache_build(void) { }
 
diff --git a/arch/powerpc/include/asm/eeh_event.h b/arch/powerpc/include/asm/eeh_event.h
index de67d83..7e00f23 100644
--- a/arch/powerpc/include/asm/eeh_event.h
+++ b/arch/powerpc/include/asm/eeh_event.h
@@ -26,12 +26,16 @@
  * to this struct is passed as the data pointer in a notify
  * callback.
  */
+#define EEH_EVENT_NORMAL	(1 << 0)
+#define EEH_EVENT_INT		(1 << 1)
+
 struct eeh_event {
+	int			flag;	/* Event flag		*/
 	struct list_head	list;	/* to form event queue	*/
 	struct eeh_pe		*pe;	/* EEH PE		*/
 };
 
-int eeh_send_failure_event(struct eeh_pe *pe);
+int eeh_send_failure_event(struct eeh_pe *pe, int flag);
 void eeh_handle_event(struct eeh_pe *pe);
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 71cb20d..81c1abb 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -39,6 +39,7 @@
 #include <asm/mpic.h>
 #include <asm/ppc-pci.h>
 #include <asm/eeh.h>
+#include <asm/eeh_event.h>
 
 /* RTAS tokens */
 static int read_pci_config;
@@ -81,7 +82,7 @@ int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (returnval == EEH_IO_ERROR_VALUE(size) &&
-	    eeh_dev_check_failure(of_node_to_eeh_dev(pdn->node)))
+	    eeh_dev_check_failure(of_node_to_eeh_dev(pdn->node), EEH_EVENT_NORMAL))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	return PCIBIOS_SUCCESSFUL;
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index c65e14c..5c486e9 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -272,6 +272,7 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
 /**
  * eeh_dev_check_failure - Check if all 1's data is due to EEH slot freeze
  * @edev: eeh device
+ * @flag: EEH event flag
  *
  * Check for an EEH failure for the given device node.  Call this
  * routine if the result of a read was all 0xff's and you want to
@@ -283,7 +284,7 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
  *
  * It is safe to call this routine in an interrupt context.
  */
-int eeh_dev_check_failure(struct eeh_dev *edev)
+int eeh_dev_check_failure(struct eeh_dev *edev, int flag)
 {
 	int ret;
 	unsigned long flags;
@@ -376,7 +377,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
 	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
 
-	eeh_send_failure_event(pe);
+	eeh_send_failure_event(pe, flag);
 
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
@@ -417,7 +418,7 @@ unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned lon
 		return val;
 	}
 
-	eeh_dev_check_failure(edev);
+	eeh_dev_check_failure(edev, EEH_EVENT_NORMAL);
 
 	pci_dev_put(eeh_dev_to_pci_dev(edev));
 	return val;
diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
index 185bedd..1f86b80 100644
--- a/arch/powerpc/platforms/pseries/eeh_event.c
+++ b/arch/powerpc/platforms/pseries/eeh_event.c
@@ -114,12 +114,13 @@ static void eeh_thread_launcher(struct work_struct *dummy)
 /**
  * eeh_send_failure_event - Generate a PCI error event
  * @pe: EEH PE
+ * @flag: EEH event flag
  *
  * This routine can be called within an interrupt context;
  * the actual event will be delivered in a normal context
  * (from a workqueue).
  */
-int eeh_send_failure_event(struct eeh_pe *pe)
+int eeh_send_failure_event(struct eeh_pe *pe, int flag)
 {
 	unsigned long flags;
 	struct eeh_event *event;
@@ -129,6 +130,7 @@ int eeh_send_failure_event(struct eeh_pe *pe)
 		pr_err("EEH: out of memory, event not handled\n");
 		return -ENOMEM;
 	}
+	event->flag = flag;
 	event->pe = pe;
 
 	/* We may or may not be called in an interrupt context */
-- 
1.7.5.4
