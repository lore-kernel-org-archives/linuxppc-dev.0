Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA34E67B67
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 09:56:42 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8FNuexw009950
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 19:56:40 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8FNuaJM292068
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 19:56:36 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8FNuaGH023927
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 19:56:36 -0400
Date: Fri, 15 Sep 2006 18:56:35 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/4]: PowerPC: EEH: code comment cleanup
Message-ID: <20060915235635.GS29167@austin.ibm.com>
References: <20060915235025.GQ29167@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060915235025.GQ29167@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Clean up subroutine documentation; mostly formatting
changes, with some new content.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c        |   19 ++++++++++++++-----
 arch/powerpc/platforms/pseries/eeh_driver.c |   27 +++++++++++++++++++++------
 2 files changed, 35 insertions(+), 11 deletions(-)

Index: linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.18-rc7-git1.orig/arch/powerpc/platforms/pseries/eeh.c	2006-09-14 14:07:43.000000000 -0500
+++ linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh.c	2006-09-14 14:44:40.000000000 -0500
@@ -449,7 +449,11 @@ EXPORT_SYMBOL(eeh_check_failure);
 /* ------------------------------------------------------------- */
 /* The code below deals with error recovery */
 
-/** Return negative value if a permanent error, else return
+/**
+ * eeh_slot_availability - returns error status of slot
+ * @pdn pci device node
+ *
+ * Return negative value if a permanent error, else return
  * a number of milliseconds to wait until the PCI slot is
  * ready to be used.
  */
@@ -477,8 +481,10 @@ eeh_slot_availability(struct pci_dn *pdn
 	return -1;
 }
 
-/** rtas_pci_slot_reset raises/lowers the pci #RST line
- *  state: 1/0 to raise/lower the #RST
+/**
+ * rtas_pci_slot_reset - raises/lowers the pci #RST line
+ * @pdn pci device node
+ * @state: 1/0 to raise/lower the #RST
  *
  * Clear the EEH-frozen condition on a slot.  This routine
  * asserts the PCI #RST line if the 'state' argument is '1',
@@ -518,8 +524,9 @@ rtas_pci_slot_reset(struct pci_dn *pdn, 
 	}
 }
 
-/** rtas_set_slot_reset -- assert the pci #RST line for 1/4 second
- *  dn -- device node to be reset.
+/**
+ * rtas_set_slot_reset -- assert the pci #RST line for 1/4 second
+ * @pdn: pci device node to be reset.
  *
  *  Return 0 if success, else a non-zero value.
  */
@@ -582,6 +589,8 @@ rtas_set_slot_reset(struct pci_dn *pdn)
 
 /**
  * __restore_bars - Restore the Base Address Registers
+ * @pdn: pci device node
+ *
  * Loads the PCI configuration space base address registers,
  * the expansion ROM base address, the latency timer, and etc.
  * from the saved values in the device node.
Index: linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.18-rc7-git1.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-09-14 14:34:12.000000000 -0500
+++ linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh_driver.c	2006-09-14 14:47:21.000000000 -0500
@@ -77,8 +77,12 @@ static int irq_in_use(unsigned int irq)
 }
 
 /* ------------------------------------------------------- */
-/** eeh_report_error - report an EEH error to each device,
- *  collect up and merge the device responses.
+/**
+ * eeh_report_error - report pci error to each device driver
+ * 
+ * Report an EEH error to each device driver, collect up and 
+ * merge the device driver responses. Cumulative response 
+ * passed back in "userdata".
  */
 
 static void eeh_report_error(struct pci_dev *dev, void *userdata)
@@ -108,8 +112,8 @@ static void eeh_report_error(struct pci_
 	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 }
 
-/** eeh_report_reset -- tell this device that the pci slot
- *  has been reset.
+/**
+ * eeh_report_reset - tell device that slot has been reset
  */
 
 static void eeh_report_reset(struct pci_dev *dev, void *userdata)
@@ -132,6 +136,10 @@ static void eeh_report_reset(struct pci_
 	driver->err_handler->slot_reset(dev);
 }
 
+/**
+ * eeh_report_resume - tell device to resume normal operations
+ */
+
 static void eeh_report_resume(struct pci_dev *dev, void *userdata)
 {
 	struct pci_driver *driver = dev->driver;
@@ -148,6 +156,13 @@ static void eeh_report_resume(struct pci
 	driver->err_handler->resume(dev);
 }
 
+/**
+ * eeh_report_failure - tell device driver that device is dead.
+ *
+ * This informs the device driver that the device is permanently
+ * dead, and that no further recovery attempts will be made on it.
+ */
+
 static void eeh_report_failure(struct pci_dev *dev, void *userdata)
 {
 	struct pci_driver *driver = dev->driver;
@@ -190,11 +205,11 @@ static void eeh_report_failure(struct pc
 
 /**
  * eeh_reset_device() -- perform actual reset of a pci slot
- * Args: bus: pointer to the pci bus structure corresponding
+ * @bus: pointer to the pci bus structure corresponding
  *            to the isolated slot. A non-null value will
  *            cause all devices under the bus to be removed
  *            and then re-added.
- *     pe_dn: pointer to a "Partionable Endpoint" device node.
+ * @pe_dn: pointer to a "Partionable Endpoint" device node.
  *            This is the top-level structure on which pci
  *            bus resets can be performed.
  */
