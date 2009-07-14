Return-Path: <mmlnx@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6DB0FB707D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jul 2009 04:35:16 +1000 (EST)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9829CDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2009 04:35:14 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n6EIUe0f024969
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 12:30:40 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6EIZA75167858
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 12:35:10 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6EIZ6k3016250
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 12:35:10 -0600
Message-ID: <4A5CCFDF.7000901@us.ibm.com>
Date: Tue, 14 Jul 2009 11:35:11 -0700
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org,
	linasvepstas@gmail.com
Subject: Support for PCI Express reset type in EEH
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Richard Lary <rlary@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By default, EEH does what's known as a "hot reset" during error recovery of a PCI Express device.  We've found a case where the device needs a "fundamental reset" to recover properly.  The current PCI error recovery and EEH frameworks do not support this distinction.

The attached patch (courtesy of Richard Lary) implements a reset type callback that can be used to determine what type of reset a device requires.  It is backwards compatible with all other drivers that implement PCI error recovery callbacks.  Only drivers that require a fundamental reset need to be changed.  So far we're only aware of one driver that has the requirement (qla2xxx).  The patch touches mostly EEH and pseries code, but does require a couple of minor additions to the overall PCI error recovery framework.

Signed-off-by: Mike Mason <mmlnx@us.ibm.com>

--- a/arch/powerpc/include/asm/ppc-pci.h	2009-06-09 20:05:27.000000000 -0700
+++ b/arch/powerpc/include/asm/ppc-pci.h	2009-07-13 16:12:31.000000000 -0700
@@ -90,7 +90,9 @@ int rtas_pci_enable(struct pci_dn *pdn,
 *
 * Returns a non-zero value if the reset failed.
 */
-int rtas_set_slot_reset (struct pci_dn *);
+#define HOT_RESET		1
+#define FUNDAMENTAL_RESET	3
+int rtas_set_slot_reset (struct pci_dn *, int reset_type);
int eeh_wait_for_slot_status(struct pci_dn *pdn, int max_wait_msecs);

/** 
--- a/arch/powerpc/platforms/pseries/eeh.c	2009-06-09 20:05:27.000000000 -0700
+++ b/arch/powerpc/platforms/pseries/eeh.c	2009-07-13 16:27:27.000000000 -0700
@@ -666,7 +666,7 @@ rtas_pci_enable(struct pci_dn *pdn, int
/**
 * rtas_pci_slot_reset - raises/lowers the pci #RST line
 * @pdn pci device node
- * @state: 1/0 to raise/lower the #RST
+ * @state: 1/3/0 to raise hot-reset/fundamental-reset/lower the #RST
 *
 * Clear the EEH-frozen condition on a slot.  This routine
 * asserts the PCI #RST line if the 'state' argument is '1',
@@ -742,9 +742,9 @@ int pcibios_set_pcie_reset_state(struct
 *  Return 0 if success, else a non-zero value.
 */

-static void __rtas_set_slot_reset(struct pci_dn *pdn)
+static void __rtas_set_slot_reset(struct pci_dn *pdn, int reset_type)
{
-	rtas_pci_slot_reset (pdn, 1);
+	rtas_pci_slot_reset (pdn, reset_type);

	/* The PCI bus requires that the reset be held high for at least
	 * a 100 milliseconds. We wait a bit longer 'just in case'.  */
@@ -766,13 +766,13 @@ static void __rtas_set_slot_reset(struct
	msleep (PCI_BUS_SETTLE_TIME_MSEC);
}

-int rtas_set_slot_reset(struct pci_dn *pdn)
+int rtas_set_slot_reset(struct pci_dn *pdn, int reset_type)
{
	int i, rc;

	/* Take three shots at resetting the bus */
	for (i=0; i<3; i++) {
-		__rtas_set_slot_reset(pdn);
+		__rtas_set_slot_reset(pdn, reset_type);

		rc = eeh_wait_for_slot_status(pdn, PCI_BUS_RESET_WAIT_MSEC);
		if (rc == 0)
--- a/arch/powerpc/platforms/pseries/eeh_driver.c	2009-07-13 14:25:24.000000000 -0700
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c	2009-07-13 16:39:16.000000000 -0700
@@ -115,6 +115,34 @@ static void eeh_enable_irq(struct pci_de

/* ------------------------------------------------------- */
/**
+ * eeh_query_reset_type - query each device driver for reset type
+ *
+ * Query each device driver for special reset type if required
+ * merge the device driver responses. Cumulative response
+ * passed back in "userdata".
+ */
+
+static int eeh_query_reset_type(struct pci_dev *dev, void *userdata)
+{
+	enum pci_ers_result rc, *res = userdata;
+	struct pci_driver *driver = dev->driver;
+
+	if (!driver)
+		return 0;
+
+	if (!driver->err_handler ||
+	    !driver->err_handler->reset_type)
+		return 0;
+
+	rc = driver->err_handler->reset_type (dev);
+
+	/* A driver that needs a special reset trumps all others */
+	if (rc == PCI_ERS_RESULT_FUNDAMENTAL_RESET ) *res = rc;
+
+	return 0;
+}
+
+/**
 * eeh_report_error - report pci error to each device driver
 * 
 * Report an EEH error to each device driver, collect up and 
@@ -282,9 +310,12 @@ static int eeh_report_failure(struct pci
 * @pe_dn: pointer to a "Partionable Endpoint" device node.
 *            This is the top-level structure on which pci
 *            bus resets can be performed.
+ *
+ * reset_type: some devices may require type other than default hot reset.
 */

-static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
+static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus,
+			     int reset_type)
{
	struct device_node *dn;
	int cnt, rc;
@@ -298,7 +329,7 @@ static int eeh_reset_device (struct pci_
	/* Reset the pci controller. (Asserts RST#; resets config space).
	 * Reconfigure bridges and devices. Don't try to bring the system
	 * up if the reset failed for some reason. */
-	rc = rtas_set_slot_reset(pe_dn);
+	rc = rtas_set_slot_reset(pe_dn, reset_type);
	if (rc)
		return rc;

@@ -343,6 +374,7 @@ struct pci_dn * handle_eeh_events (struc
	struct pci_dn *frozen_pdn;
	struct pci_bus *frozen_bus;
	int rc = 0;
+	int reset_type = HOT_RESET;
	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
	const char *location, *pci_str, *drv_str;

@@ -400,10 +432,16 @@ struct pci_dn * handle_eeh_events (struc

	/* Walk the various device drivers attached to this slot through
	 * a reset sequence, giving each an opportunity to do what it needs
-	 * to accomplish the reset.  Each child gets a report of the
-	 * status ... if any child can't handle the reset, then the entire
-	 * slot is dlpar removed and added.
+	 * to accomplish the reset.  Query device driver for special reset
+	 * requiements. Report eeh error to each child with cumulative
+	 * result status... if any child can't handle the reset,
+	 * then the entire slot is dlpar removed and added.
	 */
+	pci_walk_bus(frozen_bus, eeh_query_reset_type, &result);
+	if ( result == PCI_ERS_RESULT_FUNDAMENTAL_RESET )
+		reset_type = FUNDAMENTAL_RESET;
+
+	result = PCI_ERS_RESULT_NONE;
	pci_walk_bus(frozen_bus, eeh_report_error, &result);

	/* Get the current PCI slot state. This can take a long time,
@@ -425,7 +463,8 @@ struct pci_dn * handle_eeh_events (struc
	 * go down willingly, without panicing the system.
	 */
	if (result == PCI_ERS_RESULT_NONE) {
-		rc = eeh_reset_device(frozen_pdn, frozen_bus);
+		rc = eeh_reset_device(frozen_pdn, frozen_bus, reset_type);
+
		if (rc) {
			printk(KERN_WARNING "EEH: Unable to reset, rc=%d\n", rc);
			goto hard_fail;
@@ -466,7 +505,7 @@ struct pci_dn * handle_eeh_events (struc

	/* If any device called out for a reset, then reset the slot */
	if (result == PCI_ERS_RESULT_NEED_RESET) {
-		rc = eeh_reset_device(frozen_pdn, NULL);
+		rc = eeh_reset_device(frozen_pdn, NULL, reset_type);
		if (rc) {
			printk(KERN_WARNING "EEH: Cannot reset, rc=%d\n", rc);
			goto hard_fail;
--- a/include/linux/pci.h	2009-07-13 14:25:37.000000000 -0700
+++ b/include/linux/pci.h	2009-07-13 16:12:31.000000000 -0700
@@ -446,6 +446,9 @@ enum pci_ers_result {

	/* Device driver is fully recovered and operational */
	PCI_ERS_RESULT_RECOVERED = (__force pci_ers_result_t) 5,
+
+	/* Device driver requires fundamental reset to recover */
+	PCI_ERS_RESULT_FUNDAMENTAL_RESET = (__force pci_ers_result_t) 6,
};

/* PCI bus error event callbacks */
@@ -465,6 +468,9 @@ struct pci_error_handlers {

	/* Device driver may resume normal operations */
	void (*resume)(struct pci_dev *dev);
+
+	/* PCI slot requires special reset type for recovery */
+	pci_ers_result_t (*reset_type)(struct pci_dev *dev);
};

/* ---------------------------------------------------------------- */
--- a/arch/powerpc/include/asm/ppc-pci.h	2009-06-09 20:05:27.000000000 -0700
+++ b/arch/powerpc/include/asm/ppc-pci.h	2009-07-13 16:12:31.000000000 -0700
@@ -90,7 +90,9 @@ int rtas_pci_enable(struct pci_dn *pdn,
 *
 * Returns a non-zero value if the reset failed.
 */
-int rtas_set_slot_reset (struct pci_dn *);
+#define HOT_RESET		1
+#define FUNDAMENTAL_RESET	3
+int rtas_set_slot_reset (struct pci_dn *, int reset_type);
int eeh_wait_for_slot_status(struct pci_dn *pdn, int max_wait_msecs);

/** 
--- a/arch/powerpc/platforms/pseries/eeh.c	2009-06-09 20:05:27.000000000 -0700
+++ b/arch/powerpc/platforms/pseries/eeh.c	2009-07-13 16:27:27.000000000 -0700
@@ -666,7 +666,7 @@ rtas_pci_enable(struct pci_dn *pdn, int
/**
 * rtas_pci_slot_reset - raises/lowers the pci #RST line
 * @pdn pci device node
- * @state: 1/0 to raise/lower the #RST
+ * @state: 1/3/0 to raise hot-reset/fundamental-reset/lower the #RST
 *
 * Clear the EEH-frozen condition on a slot.  This routine
 * asserts the PCI #RST line if the 'state' argument is '1',
@@ -742,9 +742,9 @@ int pcibios_set_pcie_reset_state(struct
 *  Return 0 if success, else a non-zero value.
 */

-static void __rtas_set_slot_reset(struct pci_dn *pdn)
+static void __rtas_set_slot_reset(struct pci_dn *pdn, int reset_type)
{
-	rtas_pci_slot_reset (pdn, 1);
+	rtas_pci_slot_reset (pdn, reset_type);

	/* The PCI bus requires that the reset be held high for at least
	 * a 100 milliseconds. We wait a bit longer 'just in case'.  */
@@ -766,13 +766,13 @@ static void __rtas_set_slot_reset(struct
	msleep (PCI_BUS_SETTLE_TIME_MSEC);
}

-int rtas_set_slot_reset(struct pci_dn *pdn)
+int rtas_set_slot_reset(struct pci_dn *pdn, int reset_type)
{
	int i, rc;

	/* Take three shots at resetting the bus */
	for (i=0; i<3; i++) {
-		__rtas_set_slot_reset(pdn);
+		__rtas_set_slot_reset(pdn, reset_type);

		rc = eeh_wait_for_slot_status(pdn, PCI_BUS_RESET_WAIT_MSEC);
		if (rc == 0)
--- a/arch/powerpc/platforms/pseries/eeh_driver.c	2009-07-13 14:25:24.000000000 -0700
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c	2009-07-13 16:39:16.000000000 -0700
@@ -115,6 +115,34 @@ static void eeh_enable_irq(struct pci_de

/* ------------------------------------------------------- */
/**
+ * eeh_query_reset_type - query each device driver for reset type
+ *
+ * Query each device driver for special reset type if required
+ * merge the device driver responses. Cumulative response
+ * passed back in "userdata".
+ */
+
+static int eeh_query_reset_type(struct pci_dev *dev, void *userdata)
+{
+	enum pci_ers_result rc, *res = userdata;
+	struct pci_driver *driver = dev->driver;
+
+	if (!driver)
+		return 0;
+
+	if (!driver->err_handler ||
+	    !driver->err_handler->reset_type)
+		return 0;
+
+	rc = driver->err_handler->reset_type (dev);
+
+	/* A driver that needs a special reset trumps all others */
+	if (rc == PCI_ERS_RESULT_FUNDAMENTAL_RESET ) *res = rc;
+
+	return 0;
+}
+
+/**
 * eeh_report_error - report pci error to each device driver
 * 
 * Report an EEH error to each device driver, collect up and 
@@ -282,9 +310,12 @@ static int eeh_report_failure(struct pci
 * @pe_dn: pointer to a "Partionable Endpoint" device node.
 *            This is the top-level structure on which pci
 *            bus resets can be performed.
+ *
+ * reset_type: some devices may require type other than default hot reset.
 */

-static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
+static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus,
+			     int reset_type)
{
	struct device_node *dn;
	int cnt, rc;
@@ -298,7 +329,7 @@ static int eeh_reset_device (struct pci_
	/* Reset the pci controller. (Asserts RST#; resets config space).
	 * Reconfigure bridges and devices. Don't try to bring the system
	 * up if the reset failed for some reason. */
-	rc = rtas_set_slot_reset(pe_dn);
+	rc = rtas_set_slot_reset(pe_dn, reset_type);
	if (rc)
		return rc;

@@ -343,6 +374,7 @@ struct pci_dn * handle_eeh_events (struc
	struct pci_dn *frozen_pdn;
	struct pci_bus *frozen_bus;
	int rc = 0;
+	int reset_type = HOT_RESET;
	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
	const char *location, *pci_str, *drv_str;

@@ -400,10 +432,16 @@ struct pci_dn * handle_eeh_events (struc

	/* Walk the various device drivers attached to this slot through
	 * a reset sequence, giving each an opportunity to do what it needs
-	 * to accomplish the reset.  Each child gets a report of the
-	 * status ... if any child can't handle the reset, then the entire
-	 * slot is dlpar removed and added.
+	 * to accomplish the reset.  Query device driver for special reset
+	 * requiements. Report eeh error to each child with cumulative
+	 * result status... if any child can't handle the reset,
+	 * then the entire slot is dlpar removed and added.
	 */
+	pci_walk_bus(frozen_bus, eeh_query_reset_type, &result);
+	if ( result == PCI_ERS_RESULT_FUNDAMENTAL_RESET )
+		reset_type = FUNDAMENTAL_RESET;
+
+	result = PCI_ERS_RESULT_NONE;
	pci_walk_bus(frozen_bus, eeh_report_error, &result);

	/* Get the current PCI slot state. This can take a long time,
@@ -425,7 +463,8 @@ struct pci_dn * handle_eeh_events (struc
	 * go down willingly, without panicing the system.
	 */
	if (result == PCI_ERS_RESULT_NONE) {
-		rc = eeh_reset_device(frozen_pdn, frozen_bus);
+		rc = eeh_reset_device(frozen_pdn, frozen_bus, reset_type);
+
		if (rc) {
			printk(KERN_WARNING "EEH: Unable to reset, rc=%d\n", rc);
			goto hard_fail;
@@ -466,7 +505,7 @@ struct pci_dn * handle_eeh_events (struc

	/* If any device called out for a reset, then reset the slot */
	if (result == PCI_ERS_RESULT_NEED_RESET) {
-		rc = eeh_reset_device(frozen_pdn, NULL);
+		rc = eeh_reset_device(frozen_pdn, NULL, reset_type);
		if (rc) {
			printk(KERN_WARNING "EEH: Cannot reset, rc=%d\n", rc);
			goto hard_fail;
--- a/include/linux/pci.h	2009-07-13 14:25:37.000000000 -0700
+++ b/include/linux/pci.h	2009-07-13 16:12:31.000000000 -0700
@@ -446,6 +446,9 @@ enum pci_ers_result {

	/* Device driver is fully recovered and operational */
	PCI_ERS_RESULT_RECOVERED = (__force pci_ers_result_t) 5,
+
+	/* Device driver requires fundamental reset to recover */
+	PCI_ERS_RESULT_FUNDAMENTAL_RESET = (__force pci_ers_result_t) 6,
};

/* PCI bus error event callbacks */
@@ -465,6 +468,9 @@ struct pci_error_handlers {

	/* Device driver may resume normal operations */
	void (*resume)(struct pci_dev *dev);
+
+	/* PCI slot requires special reset type for recovery */
+	pci_ers_result_t (*reset_type)(struct pci_dev *dev);
};

/* ---------------------------------------------------------------- */
