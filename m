Date: Fri, 16 Jan 2004 12:27:56 +0100
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: benh@kernel.crashing.org
Subject: [PATCH] therm_* drivers need i2c-keywest
Message-Id: <20040116122756.034fc736.colin@colino.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__16_Jan_2004_12_27_56_+0100_=.zBZKxZMN/VyjI8"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

--Multipart_Fri__16_Jan_2004_12_27_56_+0100_=.zBZKxZMN/VyjI8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

This patch lets the different pmac thermostat drivers try to load i2c-keywest if necessary and possible.

HTH,
--
Colin

--Multipart_Fri__16_Jan_2004_12_27_56_+0100_=.zBZKxZMN/VyjI8
Content-Type: text/plain;
 name="therm_load_i2c.diff"
Content-Disposition: attachment;
 filename="therm_load_i2c.diff"
Content-Transfer-Encoding: 7bit

Index: drivers/macintosh/therm_adt7467.c
===================================================================
RCS file: /home/cvsroot/linuxppc/drivers/macintosh/therm_adt7467.c,v
retrieving revision 1.1
diff -u -u -r1.1 therm_adt7467.c
--- drivers/macintosh/therm_adt7467.c	11 Jan 2004 20:21:54 -0000	1.1
+++ drivers/macintosh/therm_adt7467.c	16 Jan 2004 11:23:58 -0000
@@ -27,6 +27,7 @@
 #include <asm/system.h>
 #include <asm/sections.h>
 #include <asm/of_device.h>
+#include <linux/kmod.h>

 #undef DEBUG

@@ -392,6 +393,7 @@
 {
 	struct device_node* np;
 	u32 *prop;
+	int res = 0;

 	/* Currently, we only deal with the iBook G4, we will support
 	 * all "2003" powerbooks later on
@@ -424,6 +426,10 @@
 	device_create_file(&of_dev->dev, &dev_attr_gpu_limit);
 	device_create_file(&of_dev->dev, &dev_attr_fan_speed);

+#ifdef CONFIG_KMOD
+	if ((res = request_module("i2c-keywest")) != 0)
+		return res;
+#endif
 	return i2c_add_driver(&thermostat_driver);
 }

Index: drivers/macintosh/therm_pm72.c
===================================================================
RCS file: /home/cvsroot/linuxppc/drivers/macintosh/therm_pm72.c,v
retrieving revision 1.1.1.1
diff -u -u -r1.1.1.1 therm_pm72.c
--- drivers/macintosh/therm_pm72.c	8 Jan 2004 11:25:19 -0000	1.1.1.1
+++ drivers/macintosh/therm_pm72.c	16 Jan 2004 11:23:32 -0000
@@ -91,6 +91,7 @@
 #include <asm/system.h>
 #include <asm/sections.h>
 #include <asm/of_device.h>
+#include <linux/kmod.h>

 #include "therm_pm72.h"

@@ -1165,6 +1166,11 @@

 	state = state_detached;

+#ifdef CONFIG_KMOD
+	rc = request_module("i2c-keywest");
+	if (rc != 0)
+		return ret;
+#endif
 	rc = i2c_add_driver(&therm_pm72_driver);
 	if (rc < 0)
 		return rc;
Index: drivers/macintosh/therm_windtunnel.c
===================================================================
RCS file: /home/cvsroot/linuxppc/drivers/macintosh/therm_windtunnel.c,v
retrieving revision 1.1
diff -u -u -r1.1 therm_windtunnel.c
--- drivers/macintosh/therm_windtunnel.c	11 Jan 2004 20:21:55 -0000	1.1
+++ drivers/macintosh/therm_windtunnel.c	16 Jan 2004 11:24:18 -0000
@@ -44,6 +44,7 @@
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/sections.h>
+#include <linux/kmod.h>

 MODULE_AUTHOR("Samuel Rydh <samuel@ibrium.se>");
 MODULE_DESCRIPTION("Apple G4 (windtunnel) fan driver");
@@ -380,6 +381,10 @@
 		printk(KERN_ERR "g4fan: unsupported machine type\n");
 		return -ENODEV;
 	}
+#ifdef CONFIG_KMOD
+	if( (ret=request_module("i2c-keywest")) )
+		return ret;
+#endif
 	if( (ret=i2c_add_driver(&g4fan_driver)) )
 		return ret;


--Multipart_Fri__16_Jan_2004_12_27_56_+0100_=.zBZKxZMN/VyjI8--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
