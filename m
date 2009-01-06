Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4963CDD3.1070504@am.sony.com>
Date: Tue, 6 Jan 2009 13:32:03 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 2/6] powerpc/ps3: Add modalias support to the ps3vram driver
References: <4963CA52.9030902@am.sony.com>
In-Reply-To: <4963CA52.9030902@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: David Woodhouse <David.Woodhouse@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Jim Paris <jim@jtan.com>, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Vivien Chappelier <vivien.chappelier@free.fr>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Update ps3vram driver to use the new ps3 three id modalias support.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/include/asm/ps3.h |    1 +
 drivers/mtd/devices/ps3vram.c  |    1 +
 2 files changed, 2 insertions(+)

--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -333,6 +333,7 @@ enum ps3_match_sub_id {
 #define PS3_MODULE_ALIAS_STOR_FLASH	"ps3:8:0"
 #define PS3_MODULE_ALIAS_SOUND		"ps3:9:0"
 #define PS3_MODULE_ALIAS_GPU_FB		"ps3:10:1"
+#define PS3_MODULE_ALIAS_GPU_RAMDISK	"ps3:10:2"
 #define PS3_MODULE_ALIAS_LPM		"ps3:11:0"
 
 enum ps3_system_bus_device_type {
--- a/drivers/mtd/devices/ps3vram.c
+++ b/drivers/mtd/devices/ps3vram.c
@@ -774,3 +774,4 @@ module_exit(ps3vram_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jim Paris <jim@jtan.com>");
 MODULE_DESCRIPTION("MTD driver for PS3 video RAM");
+MODULE_ALIAS(PS3_MODULE_ALIAS_GPU_RAMDISK);
