Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id E4981DDE01
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 13:24:37 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so205188anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 18:24:36 -0800 (PST)
Date: Sat, 23 Feb 2008 20:23:57 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: sfr@canb.auug.org.au, davem@davemloft.net, benh@kernel.crashing.org
Subject: [PATCH][OF] Add of_device_is_available function
Message-ID: <20080223202357.20a12b84@zod.rchland.ibm.com>
In-Reply-To: <20080223185904.757c2884@zod.rchland.ibm.com>
References: <20080223155823.2c85d829@zod.rchland.ibm.com>
	<20080223185904.757c2884@zod.rchland.ibm.com>
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

On Sat, 23 Feb 2008 18:59:04 -0600
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Sat, 23 Feb 2008 15:58:23 -0600
> Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> 
> > IEEE 1275 defined a standard "status" property to indicate the operational
> > status of a device.  The property has four possible values: okay, disabled,
> > fail, fail-xxx.  The absence of this property means the operational status
> > of the device is unknown or okay.
> > 
> > This adds a function called of_device_is_disabled that checks to see if a
> > node has the status property set to "disabled".  This can be quite useful
> > for devices that may be present but disabled due to pin sharing, etc.
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> Talking with Ben H a bit, he suggested to reverse this API.  Basically,
> create an of_device_is_available that returns 1 if the status property
> is completely missing, or if it's set to "okay" or "ok".  The latter is
> to cope with some broken firmwares.

And since I seem to be talking to myself and have nothing better to do
on a Saturday evening, here's the code.

josh


IEEE 1275 defined a standard "status" property to indicate the operational
status of a device.  The property has four possible values: okay, disabled,
fail, fail-xxx.  The absence of this property means the operational status
of the device is unknown or okay.

This adds a function called of_device_is_available that checks the state
of the status property of a device.  If the property is absent or set to
either "okay" or "ok", it returns 1.  Otherwise it returns 0.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 drivers/of/base.c  |   23 +++++++++++++++++++++++
 include/linux/of.h |    1 +
 2 files changed, 24 insertions(+)

--- linux-2.6.orig/drivers/of/base.c
+++ linux-2.6/drivers/of/base.c
@@ -117,6 +117,29 @@ int of_device_is_compatible(const struct
 EXPORT_SYMBOL(of_device_is_compatible);
 
 /**
+ *  of_device_is_available - check if a device is available for use
+ *
+ *  @device: Node to check for availability
+ *
+ *  Returns 1 if the status property is absent or set to "okay" or "ok",
+ *  0 otherwise
+ */
+int of_device_is_available(const struct device_node *device)
+{
+	const char *status;
+
+	status = of_get_property(device, "status", NULL);
+	if (status == NULL)
+		return 1;
+
+	if (!strcmp(status, "okay") || !strcmp(status, "ok"))
+		return 1;
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
