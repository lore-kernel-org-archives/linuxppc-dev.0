Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CB6F3684C5
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2005 06:07:45 +1000 (EST)
Date: Mon, 10 Oct 2005 22:07:39 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Message-ID: <20051010200739.GA14317@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] Add modalias to macio sysfs attributes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Provide a "compatible" entry in /sys/bus/macio/devices/*/
This can be used to load drivers via the modules.alias file.

Author: <schab@suse.de>
Signed-off-by: Olaf Hering <olh@suse.de>

--- linux-2.6.13-rc7/drivers/macintosh/macio_sysfs.c.~1~	2005-08-26 16:32:13.000000000 +0200
+++ linux-2.6.13-rc7/drivers/macintosh/macio_sysfs.c	2005-08-27 11:58:47.000000000 +0200
@@ -39,6 +39,31 @@ compatible_show (struct device *dev, str
 	return length;
 }
 
+static ssize_t modalias_show (struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct of_device *of;
+	char *compat;
+	int cplen;
+	int length;
+
+	of = &to_macio_device (dev)->ofdev;
+	compat = (char *) get_property (of->node, "compatible", &cplen);
+	if (!compat) compat = "", cplen = 1;
+	length = sprintf (buf, "of:N%sT%s", of->node->name, of->node->type);
+	buf += length;
+	while (cplen > 0) {
+		int l;
+		length += sprintf (buf, "C%s", compat);
+		buf += length;
+		l = strlen (compat) + 1;
+		compat += l;
+		cplen -= l;
+	}
+
+	return length;
+}
+
 macio_config_of_attr (name, "%s\n");
 macio_config_of_attr (type, "%s\n");
 
@@ -46,5 +71,6 @@ struct device_attribute macio_dev_attrs[
 	__ATTR_RO(name),
 	__ATTR_RO(type),
 	__ATTR_RO(compatible),
+	__ATTR_RO(modalias),
 	__ATTR_NULL
 };
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
