Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from VA3EHSOBE006.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id EB8A4DDE00
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 13:43:42 +1100 (EST)
Message-ID: <498CF52E.4040903@am.sony.com>
Date: Fri, 6 Feb 2009 18:42:54 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch] powerpc/ps3: Use hard coded values for LV1 device type
References: <498C6C49.1010200@in.ibm.com>
In-Reply-To: <498C6C49.1010200@in.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the PS3 platform code to use hard coded numbers for its
LV1 device types.

The PS3 platform code was incorrectly using some scsi block
constants for the device type returned from the LV1 hypervisor.

Fixes build errors like these when CONFIG_BLOCK=n:

  In file included from include/scsi/scsi.h:12,
                   from arch/powerpc/platforms/ps3/platform.h:25,
                   from arch/powerpc/platforms/ps3/setup.c:36:
  include/scsi/scsi_cmnd.h:27:25: warning: "BLK_MAX_CDB" is not defined
  include/scsi/scsi_cmnd.h:28:3: error: #error MAX_COMMAND_SIZE can not be bigger than BLK_MAX_CDB

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
Ben,

Please send upstream for 2.6.29.

-Geoff

 arch/powerpc/platforms/ps3/platform.h |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -22,8 +22,6 @@
 #define _PS3_PLATFORM_H
 
 #include <linux/rtc.h>
-#include <scsi/scsi.h>
-
 #include <asm/ps3.h>
 
 /* htab */
@@ -83,12 +81,12 @@ enum ps3_bus_type {
 };
 
 enum ps3_dev_type {
-	PS3_DEV_TYPE_STOR_DISK = TYPE_DISK,	/* 0 */
+	PS3_DEV_TYPE_STOR_DISK = 0, /* TYPE_DISK */
 	PS3_DEV_TYPE_SB_GELIC = 3,
 	PS3_DEV_TYPE_SB_USB = 4,
-	PS3_DEV_TYPE_STOR_ROM = TYPE_ROM,	/* 5 */
+	PS3_DEV_TYPE_STOR_ROM = 5, /* TYPE_ROM */
 	PS3_DEV_TYPE_SB_GPIO = 6,
-	PS3_DEV_TYPE_STOR_FLASH = TYPE_RBC,	/* 14 */
+	PS3_DEV_TYPE_STOR_FLASH = 14, /* TYPE_RBC */
 };
 
 int ps3_repository_read_bus_str(unsigned int bus_index, const char *bus_str,
