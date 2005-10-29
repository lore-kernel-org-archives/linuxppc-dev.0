Return-Path: <akpm@osdl.org>
Message-Id: <200510290046.j9T0kpoa030015@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:20 -0700
Cc: akpm@osdl.org, scwhab@suse.de, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 10/43] Add modalias to macio sysfs attributes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: <scwhab@suse.de>

Provide a "compatible" entry in /sys/bus/macio/devices/*/ This can be used
to load drivers via the modules.alias file.

Signed-off-by: Olaf Hering <olh@suse.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/macintosh/macio_sysfs.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+)

diff -puN drivers/macintosh/macio_sysfs.c~add-modalias-to-macio-sysfs-attributes drivers/macintosh/macio_sysfs.c
--- devel/drivers/macintosh/macio_sysfs.c~add-modalias-to-macio-sysfs-attributes	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/drivers/macintosh/macio_sysfs.c	2005-10-28 17:44:03.000000000 -0700
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
_
