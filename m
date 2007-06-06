Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound7-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 838DEDE176
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 13:00:50 +1000 (EST)
Message-ID: <4666235C.10209@am.sony.com>
Date: Tue, 05 Jun 2007 20:00:44 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [patch 11/18] PS3: System-bus modinfo attribute
References: <20070606024407.786638029@am.sony.com>>
In-Reply-To: <20070606024407.786638029@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add modinfo attribute to ps3_system_bus devices.  Also make them all
children of the same ps3_system_bus 'device' so they appear in a
corresponding subdirectory under /sys/devices 

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/system-bus.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -448,6 +448,20 @@ static int ps3_system_bus_uevent(struct 
 	return 0;
 }
 
+static ssize_t modalias_show(struct device *_dev, struct device_attribute *a,
+			     char *buf)
+{
+	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
+        int len = snprintf(buf, PAGE_SIZE, "ps3:%d\n", dev->match_id);
+
+        return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
+}
+
+static struct device_attribute ps3_system_bus_dev_attrs[] = {
+        __ATTR_RO(modalias),
+        __ATTR_NULL,
+};
+
 struct bus_type ps3_system_bus_type = {
 	.name = "ps3_system_bus",
 	.match = ps3_system_bus_match,
@@ -455,6 +469,7 @@ struct bus_type ps3_system_bus_type = {
 	.probe = ps3_system_bus_probe,
 	.remove = ps3_system_bus_remove,
 	.shutdown = ps3_system_bus_shutdown,
+	.dev_attrs = ps3_system_bus_dev_attrs,
 };
 
 static int __init ps3_system_bus_init(void)

-- 
