Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 75920DE08D
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 13:43:56 +1100 (EST)
Message-ID: <45B81891.1010309@am.sony.com>
Date: Wed, 24 Jan 2007 18:40:17 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 10/14] ps3: get firmware version
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Output the PS3 firmware version to dmesg and /proc/cpuinfo.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/platforms/ps3/setup.c |   30 +++++++++++++++++++++++++++++-
 include/asm-powerpc/ps3.h          |    9 +++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/setup.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/setup.c
@@ -32,6 +32,7 @@
 #include <asm/udbg.h>
 #include <asm/prom.h>
 #include <asm/lv1call.h>
+#include <asm/ps3.h>
 
 #include "platform.h"
 
@@ -41,9 +42,29 @@
 #define DBG(fmt...) do{if(0)printk(fmt);}while(0)
 #endif
 
+int ps3_get_firmware_version(struct ps3_firmware_version *v)
+{
+	int result = lv1_get_version_info(&v->raw);
+
+	if(result) {
+		memset(v, 0, sizeof(struct ps3_firmware_version));
+		return -1;
+	}
+
+	v->rev = v->raw & 0xffff;
+	v->minor = (v->raw >> 16) & 0xffff;
+	v->major = (v->raw >> 32) & 0xffff;
+
+	return result;
+}
+EXPORT_SYMBOL_GPL(ps3_get_firmware_version);
+
 static void ps3_show_cpuinfo(struct seq_file *m)
 {
-	seq_printf(m, "machine\t\t: %s\n", ppc_md.name);
+	struct ps3_firmware_version v;
+
+	ps3_get_firmware_version(&v);
+	seq_printf(m, "firmware\t: %u.%u.%u\n", v.major, v.minor, v.rev);
 }
 
 static void ps3_power_save(void)
@@ -74,8 +95,14 @@ static void ps3_panic(char *str)
 
 static void __init ps3_setup_arch(void)
 {
+	struct ps3_firmware_version v;
+
 	DBG(" -> %s:%d\n", __func__, __LINE__);
 
+	ps3_get_firmware_version(&v);
+	printk(KERN_INFO "PS3 firmware version %u.%u.%u\n", v.major, v.minor,
+		v.rev);
+
 	ps3_spu_set_platform();
 	ps3_map_htab();
 
@@ -89,6 +116,7 @@ static void __init ps3_setup_arch(void)
 
 	ppc_md.power_save = ps3_power_save;
 
+
 	DBG(" <- %s:%d\n", __func__, __LINE__);
 }
 
--- ps3-linux-dev.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-dev/include/asm-powerpc/ps3.h
@@ -27,6 +27,15 @@
 #include <linux/device.h>
 #include <scsi/scsi.h>
 
+struct ps3_firmware_version {
+	u64 raw;
+	unsigned int major;
+	unsigned int minor;
+	unsigned int rev;
+};
+
+int ps3_get_firmware_version(struct ps3_firmware_version *v);
+
 /**
  * struct ps3_device_id - HV bus device identifier from the system repository
  * @bus_id: HV bus id, {1..} (zero invalid)
