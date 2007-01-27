Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 92A63DE31D
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 14:11:56 +1100 (EST)
Message-ID: <45BAC225.7020209@am.sony.com>
Date: Fri, 26 Jan 2007 19:08:21 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 13/16] ps3: get firmware version
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a new routine ps3_get_firmware_version() and use it to output the firmware
version to dmesg.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

Changed from a struct to a union and got rid of the output to /proc/cpuinfo.
I'll look into arranging something in /proc/device-tree that userspace utils
can query.

 arch/powerpc/platforms/ps3/setup.c |   20 ++++++++++++++++++++
 include/asm-powerpc/ps3.h          |   12 ++++++++++++
 2 files changed, 32 insertions(+)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/setup.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/setup.c
@@ -32,6 +32,7 @@
 #include <asm/udbg.h>
 #include <asm/prom.h>
 #include <asm/lv1call.h>
+#include <asm/ps3.h>
 
 #include "platform.h"
 
@@ -41,6 +42,19 @@
 #define DBG(fmt...) do{if(0)printk(fmt);}while(0)
 #endif
 
+int ps3_get_firmware_version(union ps3_firmware_version *v)
+{
+	int result = lv1_get_version_info(&v->raw);
+
+	if (result) {
+		v->raw = 0;
+		return -1;
+	}
+
+	return result;
+}
+EXPORT_SYMBOL_GPL(ps3_get_firmware_version);
+
 static void ps3_power_save(void)
 {
 	/*
@@ -69,8 +83,14 @@ static void ps3_panic(char *str)
 
 static void __init ps3_setup_arch(void)
 {
+	union ps3_firmware_version v;
+
 	DBG(" -> %s:%d\n", __func__, __LINE__);
 
+	ps3_get_firmware_version(&v);
+	printk(KERN_INFO "PS3 firmware version %u.%u.%u\n", v.major, v.minor,
+		v.rev);
+
 	ps3_spu_set_platform();
 	ps3_map_htab();
 
--- ps3-linux-dev.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-dev/include/asm-powerpc/ps3.h
@@ -27,6 +27,18 @@
 #include <linux/device.h>
 #include <scsi/scsi.h>
 
+union ps3_firmware_version {
+	u64 raw;
+	struct {
+		u16 pad;
+		u16 major;
+		u16 minor;
+		u16 rev;
+	};
+};
+
+int ps3_get_firmware_version(union ps3_firmware_version *v);
+
 /**
  * struct ps3_device_id - HV bus device identifier from the system repository
  * @bus_id: HV bus id, {1..} (zero invalid)
