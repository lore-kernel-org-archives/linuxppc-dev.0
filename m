Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 895531A0CA4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:17:01 +1000 (AEST)
Message-Id: <20150531010138.060000411@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:55 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-api@vger.kernel.org
Subject: [RFC 23/24] m68k/mac: Fix PRAM accessors
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---

Tested on a PowerBook 520 and Quadra 650.

---
 arch/m68k/mac/misc.c     |   35 +++++++++++++++++++++++++++++------
 include/uapi/linux/pmu.h |    2 ++
 2 files changed, 31 insertions(+), 6 deletions(-)

Index: linux/arch/m68k/mac/misc.c
===================================================================
--- linux.orig/arch/m68k/mac/misc.c	2015-05-31 11:01:26.000000000 +1000
+++ linux/arch/m68k/mac/misc.c	2015-05-31 11:01:28.000000000 +1000
@@ -124,19 +124,22 @@ static void pmu_write_time(long data)
 static unsigned char pmu_pram_read_byte(int offset)
 {
 	struct adb_request req;
-	if (pmu_request(&req, NULL, 3, PMU_READ_NVRAM,
-			(offset >> 8) & 0xFF, offset & 0xFF) < 0)
+
+	if (pmu_request(&req, NULL, 3, PMU_READ_XPRAM,
+	                offset & 0xFF, 1) < 0)
 		return 0;
 	while (!req.complete)
 		pmu_poll();
-	return req.reply[3];
+
+	return req.reply[1];
 }
 
 static void pmu_pram_write_byte(unsigned char data, int offset)
 {
 	struct adb_request req;
-	if (pmu_request(&req, NULL, 4, PMU_WRITE_NVRAM,
-			(offset >> 8) & 0xFF, offset & 0xFF, data) < 0)
+
+	if (pmu_request(&req, NULL, 4, PMU_WRITE_XPRAM,
+	                offset & 0xFF, 1, data) < 0)
 		return;
 	while (!req.complete)
 		pmu_poll();
@@ -295,11 +298,31 @@ static void via_pram_command(int command
 #if IS_ENABLED(CONFIG_NVRAM)
 static unsigned char via_pram_read_byte(int offset)
 {
-	return 0;
+	unsigned char temp;
+	int addr = ((offset & 0xE0) << 3) | ((offset & 0x1F) << 2);
+
+	/* Use RTC command 0x38 for XPRAM access, as per MESS source code */
+	via_pram_command(addr | 0x3800 | 0x8001, &temp);
+
+	return temp;
 }
 
 static void via_pram_write_byte(unsigned char data, int offset)
 {
+	unsigned char temp;
+	int addr = ((offset & 0xE0) << 3) | ((offset & 0x1F) << 2);
+
+	/* Clear the write protect bit */
+	temp = 0x55;
+	via_pram_command(0x34 | 0x01, &temp);
+
+	/* Write the byte to XPRAM */
+	temp = data;
+	via_pram_command(0x3800 | 0x0001 | addr, &temp);
+
+	/* Set the write protect bit */
+	temp = 0xD5;
+	via_pram_command(0x34 | 0x01, &temp);
 }
 #endif /* CONFIG_NVRAM */
 
Index: linux/include/uapi/linux/pmu.h
===================================================================
--- linux.orig/include/uapi/linux/pmu.h	2015-05-31 11:00:59.000000000 +1000
+++ linux/include/uapi/linux/pmu.h	2015-05-31 11:01:28.000000000 +1000
@@ -18,7 +18,9 @@
 #define PMU_POWER_CTRL		0x11	/* control power of some devices */
 #define PMU_ADB_CMD		0x20	/* send ADB packet */
 #define PMU_ADB_POLL_OFF	0x21	/* disable ADB auto-poll */
+#define PMU_WRITE_XPRAM		0x32	/* write eXtended Parameter RAM */
 #define PMU_WRITE_NVRAM		0x33	/* write non-volatile RAM */
+#define PMU_READ_XPRAM		0x3a	/* read eXtended Parameter RAM */
 #define PMU_READ_NVRAM		0x3b	/* read non-volatile RAM */
 #define PMU_SET_RTC		0x30	/* set real-time clock */
 #define PMU_READ_RTC		0x38	/* read real-time clock */
