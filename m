Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1D4B7DDDEA
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 19:33:07 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 2552B227BA0
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 09:35:22 +0100 (CET)
Received: from localhost (unknown [192.168.1.157])
	by mail.m-online.net (Postfix) with ESMTP id 0184590259
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 09:33:04 +0100 (CET)
Received: from localhost ([192.168.3.149])
	by localhost (scanner1.m-online.net [192.168.1.157]) (amavisd-new,
	port 10024) with ESMTP id lgLuUXDhZlWL for <linuxppc-dev@ozlabs.org>;
	Tue, 22 Jan 2008 09:33:04 +0100 (CET)
Received: from ibook.aepfle.de (DSL01.83.171.173.38.ip-pool.NEFkom.net
	[83.171.173.38]) by mail.mnet-online.de (Postfix) with ESMTP
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 09:33:04 +0100 (CET)
Date: Tue, 22 Jan 2008 09:33:28 +0100
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] create modalias file in sysfs for bus vio
Message-ID: <20080122083328.GA11928@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Create /sys/bus/vio/devices/*/modalias file to allow autoloading
of modules. modalias files are already present for many other bus types.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 arch/powerpc/kernel/vio.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -296,9 +296,24 @@ static ssize_t devspec_show(struct devic
 	return sprintf(buf, "%s\n", of_node ? of_node->full_name : "none");
 }
 
+static ssize_t modalias_show (struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct device_node *of_node = dev->archdata.of_node;
+	const char *compat;
+	int i = 0;
+
+	if (of_node) {
+		compat = of_get_property(of_node, "compatible", &i);
+		i = sprintf (buf, "vio:T%sS%s\n", of_node->type, compat ? compat : "");
+	}
+	return i;
+}
+
 static struct device_attribute vio_dev_attrs[] = {
 	__ATTR_RO(name),
 	__ATTR_RO(devspec),
+	__ATTR_RO(modalias),
 	__ATTR_NULL
 };
 
