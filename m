Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 46BFC1A0EF6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Aug 2015 21:13:32 +1000 (AEST)
Message-Id: <20150823104135.297693098@telegraphics.com.au>
Date: Sun, 23 Aug 2015 20:41:52 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [RFC v6 23/25] m68k/mac: Use macros for RTC accesses not magic numbers
References: <20150823104129.517600532@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

---

This is intended to improve code style and not affect code behaviour.
I've tested this on a Quadra 650.

I don't know the meanings of the 4 undocumented write protect register
bits 0x55, so I decided against defining 4 macros for those bits.

---
 arch/m68k/mac/misc.c |   59 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 18 deletions(-)

Index: linux/arch/m68k/mac/misc.c
===================================================================
--- linux.orig/arch/m68k/mac/misc.c	2015-08-23 20:41:22.000000000 +1000
+++ linux/arch/m68k/mac/misc.c	2015-08-23 20:41:23.000000000 +1000
@@ -242,6 +242,21 @@ static void via_rtc_send(__u8 data)
 }
 
 /*
+ * These values can be found in Inside Macintosh vol. III ch. 2
+ * which has a description of the RTC chip in the original Mac.
+ */
+
+#define RTC_FLG_READ            BIT(7)
+#define RTC_FLG_WRITE_PROTECT   BIT(7)
+#define RTC_CMD_READ(r)         (RTC_FLG_READ | (r << 2))
+#define RTC_CMD_WRITE(r)        (r << 2)
+#define RTC_REG_SECONDS_0       0
+#define RTC_REG_SECONDS_1       1
+#define RTC_REG_SECONDS_2       2
+#define RTC_REG_SECONDS_3       3
+#define RTC_REG_WRITE_PROTECT   13
+
+/*
  * Execute a VIA PRAM/RTC command. For read commands
  * data should point to a one-byte buffer for the
  * resulting data. For write commands it should point
@@ -250,13 +265,17 @@ static void via_rtc_send(__u8 data)
  * This function disables all interrupts while running.
  */
 
-static void via_pram_command(int command, __u8 *data)
+static void via_rtc_command(int command, __u8 *data)
 {
 	unsigned long flags;
 	int	is_read;
 
 	local_irq_save(flags);
 
+	/* The least significant bits must be 0b01 according to Inside Mac */
+
+	command = (command & ~3) | 1;
+
 	/* Enable the RTC and make sure the strobe line is high */
 
 	via1[vBufB] = (via1[vBufB] | VIA1B_vRTCClk) & ~VIA1B_vRTCEnb;
@@ -264,10 +283,10 @@ static void via_pram_command(int command
 	if (command & 0xFF00) {		/* extended (two-byte) command */
 		via_rtc_send((command & 0xFF00) >> 8);
 		via_rtc_send(command & 0xFF);
-		is_read = command & 0x8000;
+		is_read = command & (RTC_FLG_READ << 8);
 	} else {			/* one-byte command */
 		via_rtc_send(command);
-		is_read = command & 0x80;
+		is_read = command & RTC_FLG_READ;
 	}
 	if (is_read) {
 		*data = via_rtc_recv();
@@ -306,10 +325,10 @@ static long via_read_time(void)
 	} result, last_result;
 	int count = 1;
 
-	via_pram_command(0x81, &last_result.cdata[3]);
-	via_pram_command(0x85, &last_result.cdata[2]);
-	via_pram_command(0x89, &last_result.cdata[1]);
-	via_pram_command(0x8D, &last_result.cdata[0]);
+	via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_0), &last_result.cdata[3]);
+	via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_1), &last_result.cdata[2]);
+	via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_2), &last_result.cdata[1]);
+	via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_3), &last_result.cdata[0]);
 
 	/*
 	 * The NetBSD guys say to loop until you get the same reading
@@ -317,10 +336,14 @@ static long via_read_time(void)
 	 */
 
 	while (1) {
-		via_pram_command(0x81, &result.cdata[3]);
-		via_pram_command(0x85, &result.cdata[2]);
-		via_pram_command(0x89, &result.cdata[1]);
-		via_pram_command(0x8D, &result.cdata[0]);
+		via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_0),
+		                &result.cdata[3]);
+		via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_1),
+		                &result.cdata[2]);
+		via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_2),
+		                &result.cdata[1]);
+		via_rtc_command(RTC_CMD_READ(RTC_REG_SECONDS_3),
+		                &result.cdata[0]);
 
 		if (result.idata == last_result.idata)
 			return result.idata - RTC_OFFSET;
@@ -356,18 +379,18 @@ static void via_write_time(long time)
 	/* Clear the write protect bit */
 
 	temp = 0x55;
-	via_pram_command(0x35, &temp);
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_WRITE_PROTECT), &temp);
 
 	data.idata = time + RTC_OFFSET;
-	via_pram_command(0x01, &data.cdata[3]);
-	via_pram_command(0x05, &data.cdata[2]);
-	via_pram_command(0x09, &data.cdata[1]);
-	via_pram_command(0x0D, &data.cdata[0]);
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_SECONDS_0), &data.cdata[3]);
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_SECONDS_1), &data.cdata[2]);
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_SECONDS_2), &data.cdata[1]);
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_SECONDS_3), &data.cdata[0]);
 
 	/* Set the write protect bit */
 
-	temp = 0xD5;
-	via_pram_command(0x35, &temp);
+	temp = 0x55 | RTC_FLG_WRITE_PROTECT;
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_WRITE_PROTECT), &temp);
 }
 
 static void via_shutdown(void)
