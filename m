Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9ED04DDEB6
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 04:55:38 +1000 (EST)
Message-ID: <466EEB84.8000706@am.sony.com>
Date: Tue, 12 Jun 2007 11:52:52 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 13/30] PS3: System-bus modinfo attribute
References: <20070612181825.730300780@am.sony.com>>
In-Reply-To: <20070612181825.730300780@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: David Woodhouse <dwmw2@infradead.org>

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
@@ -452,6 +452,20 @@ static int ps3_system_bus_uevent(struct 
 	return 0;
 }
 
+static ssize_t modalias_show(struct device *_dev, struct device_attribute *a,
+	char *buf)
+{
+	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
+	int len = snprintf(buf, PAGE_SIZE, "ps3:%d\n", dev->match_id);
+
+	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
+}
+
+static struct device_attribute ps3_system_bus_dev_attrs[] = {
+	__ATTR_RO(modalias),
+	__ATTR_NULL,
+};
+
 struct bus_type ps3_system_bus_type = {
 	.name = "ps3_system_bus",
 	.match = ps3_system_bus_match,
@@ -459,6 +473,7 @@ struct bus_type ps3_system_bus_type = {
 	.probe = ps3_system_bus_probe,
 	.remove = ps3_system_bus_remove,
 	.shutdown = ps3_system_bus_shutdown,
+	.dev_attrs = ps3_system_bus_dev_attrs,
 };
 
 static int __init ps3_system_bus_init(void)

-- 
