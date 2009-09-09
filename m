Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8E15EB7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 09:43:33 +1000 (EST)
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id 14D7EDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 09:43:32 +1000 (EST)
Message-ID: <4AA83A05.8010400@am.sony.com>
Date: Wed, 9 Sep 2009 16:28:05 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: powerpc/ps3: Workaround for flash memory I/O error
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A workaround for flash memory I/O errors when the PS3 internal
hard disk has not been formatted for OtherOS use.

This error condition mainly effects 'Live CD' users who have not
formatted the PS3's internal hard disk for OtherOS.

Fixes errors similar to these when using the ps3-flash-util
or ps3-boot-game-os programs:

  ps3flash read failed 0x2050000
  os_area_header_read: read error: os_area_header: Input/output error
  main:627: os_area_read_hp error.
  ERROR: can't change boot flag

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/ps3/ps3stor_lib.c |   65 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 3 deletions(-)

--- a/drivers/ps3/ps3stor_lib.c
+++ b/drivers/ps3/ps3stor_lib.c
@@ -23,6 +23,65 @@
 #include <asm/lv1call.h>
 #include <asm/ps3stor.h>
 
+/*
+ * A workaround for flash memory I/O errors when the internal hard disk
+ * has not been formatted for OtherOS use.  Delay disk close until flash
+ * memory is closed.
+ */
+
+static struct ps3_flash_workaround {
+	int flash_open;
+	int disk_open;
+	struct ps3_system_bus_device *disk_sbd;
+} ps3_flash_workaround;
+
+static int ps3stor_open_hv_device(struct ps3_system_bus_device *sbd)
+{
+	int error = ps3_open_hv_device(sbd);
+
+	if (error)
+		return error;
+
+	if (sbd->match_id == PS3_MATCH_ID_STOR_FLASH)
+		ps3_flash_workaround.flash_open = 1;
+
+	if (sbd->match_id == PS3_MATCH_ID_STOR_DISK)
+		ps3_flash_workaround.disk_open = 1;
+
+	return 0;
+}
+
+static int ps3stor_close_hv_device(struct ps3_system_bus_device *sbd)
+{
+	int error;
+
+	if (sbd->match_id == PS3_MATCH_ID_STOR_DISK
+		&& ps3_flash_workaround.disk_open
+		&& ps3_flash_workaround.flash_open) {
+		ps3_flash_workaround.disk_sbd = sbd;
+		return 0;
+	}
+
+	error = ps3_close_hv_device(sbd);
+
+	if (error)
+		return error;
+
+	if (sbd->match_id == PS3_MATCH_ID_STOR_DISK)
+		ps3_flash_workaround.disk_open = 0;
+
+	if (sbd->match_id == PS3_MATCH_ID_STOR_FLASH) {
+		ps3_flash_workaround.flash_open = 0;
+
+		if (ps3_flash_workaround.disk_sbd) {
+			ps3_close_hv_device(ps3_flash_workaround.disk_sbd);
+			ps3_flash_workaround.disk_open = 0;
+			ps3_flash_workaround.disk_sbd = NULL;
+		}
+	}
+
+	return 0;
+}
 
 static int ps3stor_probe_access(struct ps3_storage_device *dev)
 {
@@ -90,7 +149,7 @@ int ps3stor_setup(struct ps3_storage_dev
 	int error, res, alignment;
 	enum ps3_dma_page_size page_size;
 
-	error = ps3_open_hv_device(&dev->sbd);
+	error = ps3stor_open_hv_device(&dev->sbd);
 	if (error) {
 		dev_err(&dev->sbd.core,
 			"%s:%u: ps3_open_hv_device failed %d\n", __func__,
@@ -166,7 +225,7 @@ fail_free_irq:
 fail_sb_event_receive_port_destroy:
 	ps3_sb_event_receive_port_destroy(&dev->sbd, dev->irq);
 fail_close_device:
-	ps3_close_hv_device(&dev->sbd);
+	ps3stor_close_hv_device(&dev->sbd);
 fail:
 	return error;
 }
@@ -193,7 +252,7 @@ void ps3stor_teardown(struct ps3_storage
 			"%s:%u: destroy event receive port failed %d\n",
 			__func__, __LINE__, error);
 
-	error = ps3_close_hv_device(&dev->sbd);
+	error = ps3stor_close_hv_device(&dev->sbd);
 	if (error)
 		dev_err(&dev->sbd.core,
 			"%s:%u: ps3_close_hv_device failed %d\n", __func__,
