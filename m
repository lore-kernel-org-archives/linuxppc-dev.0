Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1ED291A0729
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 17:05:36 +1100 (AEDT)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 1/2] powerpc/powernv: Add interfaces for flash device access
Message-Id: <1427868330.742068.357457598273.1.gpush@pablo>
In-Reply-To: <1427868330.741478.119647151764.0.gpush@pablo>
To: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 01 Apr 2015 14:05:30 +0800
Cc: Cyril Bur <cyrilbur@gmail.com>, Joel Stanley <joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cyril Bur <cyrilbur@gmail.com>

This change adds the OPAL interface definitions to allow Linux to read,
write and erase from system flash devices. We register platform devices
for the flash devices exported by firmware.

We clash with the existing opal_flash_init function, which is really for
the FSP flash update functionality, so we rename that initcall to
opal_flash_update_init().

A future change will add an mtd driver that uses this interface.

Changes from Joel Stanley and Jeremy Kerr.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>

---
 arch/powerpc/include/asm/opal-api.h            |    5 ++++-
 arch/powerpc/include/asm/opal.h                |    9 ++++++++-
 arch/powerpc/platforms/powernv/opal-flash.c    |    2 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |    3 +++
 arch/powerpc/platforms/powernv/opal.c          |   16 +++++++++++++++-
 5 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index e8a6baf..0321a90 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -150,7 +150,10 @@
 #define OPAL_IPMI_SEND				107
 #define OPAL_IPMI_RECV				108
 #define OPAL_I2C_REQUEST			109
-#define OPAL_LAST				109
+#define OPAL_FLASH_READ				110
+#define OPAL_FLASH_WRITE			111
+#define OPAL_FLASH_ERASE			112
+#define OPAL_LAST				112
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index c08de77..7c6d7ea 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -194,6 +194,13 @@ int64_t opal_ipmi_recv(uint64_t interface, struct opal_ipmi_msg *msg,
 int64_t opal_i2c_request(uint64_t async_token, uint32_t bus_id,
 			 struct opal_i2c_request *oreq);
 
+int64_t opal_flash_read(uint64_t id, uint64_t offset, uint64_t buf,
+		uint64_t size, uint64_t token);
+int64_t opal_flash_write(uint64_t id, uint64_t offset, uint64_t buf,
+		uint64_t size, uint64_t token);
+int64_t opal_flash_erase(uint64_t id, uint64_t offset, uint64_t size,
+		uint64_t token);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
@@ -226,7 +233,7 @@ extern int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data);
 struct rtc_time;
 extern unsigned long opal_get_boot_time(void);
 extern void opal_nvram_init(void);
-extern void opal_flash_init(void);
+extern void opal_flash_update_init(void);
 extern void opal_flash_term_callback(void);
 extern int opal_elog_init(void);
 extern void opal_platform_dump_init(void);
diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
index 0ff07ff..4ec6219 100644
--- a/arch/powerpc/platforms/powernv/opal-flash.c
+++ b/arch/powerpc/platforms/powernv/opal-flash.c
@@ -546,7 +546,7 @@ static struct attribute_group image_op_attr_group = {
 	.attrs = image_op_attrs,
 };
 
-void __init opal_flash_init(void)
+void __init opal_flash_update_init(void)
 {
 	int ret;
 
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index b23fe7c..4e74037 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -292,3 +292,6 @@ OPAL_CALL(opal_tpo_read,			OPAL_READ_TPO);
 OPAL_CALL(opal_ipmi_send,			OPAL_IPMI_SEND);
 OPAL_CALL(opal_ipmi_recv,			OPAL_IPMI_RECV);
 OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
+OPAL_CALL(opal_flash_read,			OPAL_FLASH_READ);
+OPAL_CALL(opal_flash_write,			OPAL_FLASH_WRITE);
+OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index d403b2b..e95342b 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -693,6 +693,15 @@ static void __init opal_dump_region_init(void)
 			"rc = %d\n", rc);
 }
 
+static void opal_flash_init(struct device_node *opal_node)
+{
+	struct device_node *np;
+
+	for_each_child_of_node(opal_node, np)
+		if (of_device_is_compatible(np, "ibm,opal-flash"))
+			of_platform_device_create(np, NULL, NULL);
+}
+
 static void opal_ipmi_init(struct device_node *opal_node)
 {
 	struct device_node *np;
@@ -817,7 +826,7 @@ static int __init opal_init(void)
 		/* Setup error log interface */
 		rc = opal_elog_init();
 		/* Setup code update interface */
-		opal_flash_init();
+		opal_flash_update_init();
 		/* Setup platform dump extract interface */
 		opal_platform_dump_init();
 		/* Setup system parameters interface */
@@ -829,6 +838,8 @@ static int __init opal_init(void)
 	/* Initialize OPAL IPMI backend */
 	opal_ipmi_init(opal_node);
 
+	opal_flash_init(opal_node);
+
 	return 0;
 }
 machine_subsys_initcall(powernv, opal_init);
@@ -867,6 +878,9 @@ void opal_shutdown(void)
 EXPORT_SYMBOL_GPL(opal_invalid_call);
 EXPORT_SYMBOL_GPL(opal_ipmi_send);
 EXPORT_SYMBOL_GPL(opal_ipmi_recv);
+EXPORT_SYMBOL_GPL(opal_flash_read);
+EXPORT_SYMBOL_GPL(opal_flash_write);
+EXPORT_SYMBOL_GPL(opal_flash_erase);
 
 /* Convert a region of vmalloc memory to an opal sg list */
 struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
