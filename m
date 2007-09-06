Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 6 Sep 2007 18:14:57 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2.6.23] PS3: Ignore storage devices that are still being probed
Message-ID: <Pine.LNX.4.62.0709061813090.22591@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1057582484-1189095297=:22591"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1057582484-1189095297=:22591
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

PS3: A storage device may show up in the repository before the hypervisor has
finished probing:
  - If its type is not yet known, it shows up as PS3_DEV_TYPE_STOR_DUMMY,
  - If its regions are being probed, it shows up as having zero regions.
If any of these happen, consider the device not yet present.  The storage
probe thread will retry later.

This fixes the timing-dependent problem where a kernel booted from FLASH ROM
sometimes cannot find the hard disk.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/platforms/ps3/platform.h   |    1 +
 arch/powerpc/platforms/ps3/repository.c |   29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -83,6 +83,7 @@ enum ps3_dev_type {
 	PS3_DEV_TYPE_STOR_ROM = TYPE_ROM,	/* 5 */
 	PS3_DEV_TYPE_SB_GPIO = 6,
 	PS3_DEV_TYPE_STOR_FLASH = TYPE_RBC,	/* 14 */
+	PS3_DEV_TYPE_STOR_DUMMY = 32,
 	PS3_DEV_TYPE_NOACCESS = 255,
 };
 
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -349,6 +349,35 @@ int ps3_repository_find_device(struct ps
 		return result;
 	}
 
+	if (tmp.bus_type == PS3_BUS_TYPE_STORAGE) {
+		/*
+		 * A storage device may show up in the repository before the
+		 * hypervisor has finished probing its type and regions
+		 */
+		unsigned int num_regions;
+
+		if (tmp.dev_type == PS3_DEV_TYPE_STOR_DUMMY) {
+			pr_debug("%s:%u storage device not ready\n", __func__,
+				 __LINE__);
+			return -ENODEV;
+		}
+
+		result = ps3_repository_read_stor_dev_num_regions(tmp.bus_index,
+								  tmp.dev_index,
+								  &num_regions);
+		if (result) {
+			pr_debug("%s:%d read_stor_dev_num_regions failed\n",
+				 __func__, __LINE__);
+			return result;
+		}
+
+		if (!num_regions) {
+			pr_debug("%s:%u storage device has no regions yet\n",
+				 __func__, __LINE__);
+			return -ENODEV;
+		}
+	}
+
 	result = ps3_repository_read_dev_id(tmp.bus_index, tmp.dev_index,
 		&tmp.dev_id);
 

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-1057582484-1189095297=:22591--
