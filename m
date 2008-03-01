Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B44FDDED4
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Mar 2008 01:18:09 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m21EI5dW013235
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 09:18:05 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m21EI5J8088012
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 07:18:05 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m21EI5uA008540
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 07:18:05 -0700
Date: Sat, 1 Mar 2008 08:16:00 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org, sfr@canb.auug.org.au
Subject: [PATCH 1/2 v2] [OF] Add of_device_is_available function
Message-ID: <20080301081600.74598ce4@zod.rchland.ibm.com>
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

IEEE 1275 defined a standard "status" property to indicate the
operational status of a device.  The property has four possible values:
okay, disabled, fail, fail-xxx.  The absence of this property means the
operational status of the device is unknown or okay.

This adds a function called of_device_is_available that checks the state
of the status property of a device.  If the property is absent or set to
either "okay" or "ok", it returns 1.  Otherwise it returns 0.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 drivers/of/base.c  |   26 ++++++++++++++++++++++++++
 include/linux/of.h |    1 +
 2 files changed, 27 insertions(+)

--- linux-2.6.orig/drivers/of/base.c
+++ linux-2.6/drivers/of/base.c
@@ -117,6 +117,32 @@ int of_device_is_compatible(const struct
 EXPORT_SYMBOL(of_device_is_compatible);
 
 /**
+ *  of_device_is_available - check if a device is available for use
+ *
+ *  @device: Node to check for availability
+ *
+ *  Returns 1 if the status property is absent or set to "okay" or
"ok",
+ *  0 otherwise
+ */
+int of_device_is_available(const struct device_node *device)
+{
+	const char *status;
+	int statlen;
+
+	status = of_get_property(device, "status", &statlen);
+	if (status == NULL)
+		return 1;
+
+	if (statlen > 0) {
+		if (!strncmp(status, "okay", 4) || !strncmp(status,
"ok", 2))
+			return 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(of_device_is_available);
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
+extern int of_device_is_available(const struct device_node *device);
 extern const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp);
