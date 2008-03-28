Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1485ADE618
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 03:53:44 +1100 (EST)
Message-ID: <47ED2292.7010500@am.sony.com>
Date: Fri, 28 Mar 2008 09:53:38 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch] PS3: Split device setup for static vs. dynamic devices
References: <47EAEC2B.1000006@am.sony.com>
In-Reply-To: <47EAEC2B.1000006@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Split the device setup code in ps3_register_repository_device() in two
routines:
  1. ps3_setup_static_device(), to handle the setup of static devices in the
     PS3 repository, which can be __init,
  2. ps3_setup_dynamic_device(), to handle the setup of storage devices that
     may appear later in the PS3 repository.

This fixes a few section mismatch warnings.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---

Hi Paul,

Here is another one for 2.6.26 that Geert just sent me.  Please apply.

-Geoff

 arch/powerpc/platforms/ps3/device-init.c |   78 ++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 32 deletions(-)

--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -499,41 +499,14 @@ static int __init ps3_register_graphics_
 }
 
 /**
- * ps3_register_repository_device - Register a device from the repositiory info.
- *
+ * ps3_setup_dynamic_device - Setup a dynamic device from the repository
  */
 
-static int ps3_register_repository_device(
-	const struct ps3_repository_device *repo)
+static int ps3_setup_dynamic_device(const struct ps3_repository_device *repo)
 {
 	int result;
 
 	switch (repo->dev_type) {
-	case PS3_DEV_TYPE_SB_GELIC:
-		result = ps3_setup_gelic_device(repo);
-		if (result) {
-			pr_debug("%s:%d ps3_setup_gelic_device failed\n",
-				__func__, __LINE__);
-		}
-		break;
-	case PS3_DEV_TYPE_SB_USB:
-
-		/* Each USB device has both an EHCI and an OHCI HC */
-
-		result = ps3_setup_ehci_device(repo);
-
-		if (result) {
-			pr_debug("%s:%d ps3_setup_ehci_device failed\n",
-				__func__, __LINE__);
-		}
-
-		result = ps3_setup_ohci_device(repo);
-
-		if (result) {
-			pr_debug("%s:%d ps3_setup_ohci_device failed\n",
-				__func__, __LINE__);
-		}
-		break;
 	case PS3_DEV_TYPE_STOR_DISK:
 		result = ps3_setup_storage_dev(repo, PS3_MATCH_ID_STOR_DISK);
 
@@ -572,6 +545,48 @@ static int ps3_register_repository_devic
 	return result;
 }
 
+/**
+ * ps3_setup_static_device - Setup a static device from the repository
+ */
+
+static int __init ps3_setup_static_device(const struct ps3_repository_device *repo)
+{
+	int result;
+
+	switch (repo->dev_type) {
+	case PS3_DEV_TYPE_SB_GELIC:
+		result = ps3_setup_gelic_device(repo);
+		if (result) {
+			pr_debug("%s:%d ps3_setup_gelic_device failed\n",
+				__func__, __LINE__);
+		}
+		break;
+	case PS3_DEV_TYPE_SB_USB:
+
+		/* Each USB device has both an EHCI and an OHCI HC */
+
+		result = ps3_setup_ehci_device(repo);
+
+		if (result) {
+			pr_debug("%s:%d ps3_setup_ehci_device failed\n",
+				__func__, __LINE__);
+		}
+
+		result = ps3_setup_ohci_device(repo);
+
+		if (result) {
+			pr_debug("%s:%d ps3_setup_ohci_device failed\n",
+				__func__, __LINE__);
+		}
+		break;
+
+	default:
+		return ps3_setup_dynamic_device(repo);
+	}
+
+	return result;
+}
+
 static void ps3_find_and_add_device(u64 bus_id, u64 dev_id)
 {
 	struct ps3_repository_device repo;
@@ -601,7 +616,7 @@ found:
 		pr_debug("%s:%u: device %lu:%lu found after %u retries\n",
 			 __func__, __LINE__, bus_id, dev_id, retries);
 
-	ps3_register_repository_device(&repo);
+	ps3_setup_dynamic_device(&repo);
 	return;
 }
 
@@ -905,8 +920,7 @@ static int __init ps3_register_devices(v
 
 	ps3_register_graphics_devices();
 
-	ps3_repository_find_devices(PS3_BUS_TYPE_SB,
-		ps3_register_repository_device);
+	ps3_repository_find_devices(PS3_BUS_TYPE_SB, ps3_setup_static_device);
 
 	ps3_register_sound_devices();
 
