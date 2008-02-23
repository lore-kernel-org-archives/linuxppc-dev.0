Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 261FCDE04C
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 09:00:03 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1NLwuvB017226
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 16:58:56 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1NLwuuX313672
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 16:58:56 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1NLwtWv010031
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 16:58:56 -0500
Date: Sat, 23 Feb 2008 15:58:23 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: sfr@canb.auug.org.au, davem@davemloft.net
Subject: [PATCH 1/2][OF] Add of_device_is_disabled function
Message-ID: <20080223155823.2c85d829@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

IEEE 1275 defined a standard "status" property to indicate the operational
status of a device.  The property has four possible values: okay, disabled,
fail, fail-xxx.  The absence of this property means the operational status
of the device is unknown or okay.

This adds a function called of_device_is_disabled that checks to see if a
node has the status property set to "disabled".  This can be quite useful
for devices that may be present but disabled due to pin sharing, etc.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 drivers/of/base.c  |   18 ++++++++++++++++++
 include/linux/of.h |    1 +
 2 files changed, 19 insertions(+)

--- linux-2.6.orig/drivers/of/base.c
+++ linux-2.6/drivers/of/base.c
@@ -117,6 +117,24 @@ int of_device_is_compatible(const struct
 EXPORT_SYMBOL(of_device_is_compatible);
 
 /**
+ *  of_device_is_disabled - Check if a device's status is disabled
+ *  @device: device node to check
+ *
+ *  Returns true or false depending on the value of the staus property
+ */
+int of_device_is_disabled(const struct device_node *device)
+{
+	const char *status;
+
+	status = of_get_property(device, "status", NULL);
+	if (status == NULL)
+		return 0;
+
+	return !(strcmp(status, "disabled"));
+}
+EXPORT_SYMBOL(of_device_is_disabled);
+
+/**
  *	of_get_parent - Get a node's parent if any
  *	@node:	Node to get parent
  *
--- linux-2.6.orig/include/linux/of.h
+++ linux-2.6/include/linux/of.h
@@ -62,6 +62,7 @@ extern struct property *of_find_property
 					 int *lenp);
 extern int of_device_is_compatible(const struct device_node *device,
 				   const char *);
+extern int of_device_is_disabled(const struct device_node *device);
 extern const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp);
