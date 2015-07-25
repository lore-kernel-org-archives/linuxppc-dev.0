Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 02A8D1A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 17:56:52 +1000 (AEST)
Message-Id: <20150725074605.143283098@telegraphics.com.au>
Date: Sat, 25 Jul 2015 17:46:22 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [RFC v5 23/26] m68k/mac: Adopt naming and calling conventions for
 PRAM routines
References: <20150725074559.543547894@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adopt the existing *_read_byte and *_write_byte naming convention.
Rename via_pram_readbyte and via_pram_writebyte to avoid confusion.
Adjust calling conventions of mac_pram_* functions to match the
arch_nvram_ops struct methods.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---

Changes since v1:
- Don't introduce the arch_nvram_ops struct in this patch, even if it 
would form a logical progression. Since the struct would get replaced
later on, some might see it as churn.

Changes since v2:
- Rename via_pram_send() and via_pram_recv() as
via_rtc_send() and via_rtc_recv() resp.

---
 arch/m68k/mac/misc.c |   91 +++++++++++++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

Index: linux/arch/m68k/mac/misc.c
===================================================================
--- linux.orig/arch/m68k/mac/misc.c	2015-07-25 17:42:33.000000000 +1000
+++ linux/arch/m68k/mac/misc.c	2015-07-25 17:45:53.000000000 +1000
@@ -61,7 +61,7 @@ static void cuda_write_time(long data)
 		cuda_poll();
 }
 
-static __u8 cuda_read_pram(int offset)
+static unsigned char cuda_pram_read_byte(int offset)
 {
 	struct adb_request req;
 	if (cuda_request(&req, NULL, 4, CUDA_PACKET, CUDA_GET_PRAM,
@@ -72,7 +72,7 @@ static __u8 cuda_read_pram(int offset)
 	return req.reply[3];
 }
 
-static void cuda_write_pram(int offset, __u8 data)
+static void cuda_pram_write_byte(unsigned char data, int offset)
 {
 	struct adb_request req;
 	if (cuda_request(&req, NULL, 5, CUDA_PACKET, CUDA_SET_PRAM,
@@ -84,8 +84,8 @@ static void cuda_write_pram(int offset,
 #else
 #define cuda_read_time() 0
 #define cuda_write_time(n)
-#define cuda_read_pram NULL
-#define cuda_write_pram NULL
+#define cuda_pram_read_byte NULL
+#define cuda_pram_write_byte NULL
 #endif
 
 #ifdef CONFIG_ADB_PMU68K
@@ -116,7 +116,7 @@ static void pmu_write_time(long data)
 		pmu_poll();
 }
 
-static __u8 pmu_read_pram(int offset)
+static unsigned char pmu_pram_read_byte(int offset)
 {
 	struct adb_request req;
 	if (pmu_request(&req, NULL, 3, PMU_READ_NVRAM,
@@ -127,7 +127,7 @@ static __u8 pmu_read_pram(int offset)
 	return req.reply[3];
 }
 
-static void pmu_write_pram(int offset, __u8 data)
+static void pmu_pram_write_byte(unsigned char data, int offset)
 {
 	struct adb_request req;
 	if (pmu_request(&req, NULL, 4, PMU_WRITE_NVRAM,
@@ -139,8 +139,8 @@ static void pmu_write_pram(int offset, _
 #else
 #define pmu_read_time() 0
 #define pmu_write_time(n)
-#define pmu_read_pram NULL
-#define pmu_write_pram NULL
+#define pmu_pram_read_byte NULL
+#define pmu_pram_write_byte NULL
 #endif
 
 #if 0 /* def CONFIG_ADB_MACIISI */
@@ -169,7 +169,7 @@ static void maciisi_write_time(long data
 			(data >> 8) & 0xFF, data & 0xFF);
 }
 
-static __u8 maciisi_read_pram(int offset)
+static unsigned char maciisi_pram_read_byte(int offset)
 {
 	struct adb_request req;
 	if (maciisi_request(&req, NULL, 4, CUDA_PACKET, CUDA_GET_PRAM,
@@ -178,7 +178,7 @@ static __u8 maciisi_read_pram(int offset
 	return req.reply[3];
 }
 
-static void maciisi_write_pram(int offset, __u8 data)
+static void maciisi_pram_write_byte(unsigned char data, int offset)
 {
 	struct adb_request req;
 	maciisi_request(&req, NULL, 5, CUDA_PACKET, CUDA_SET_PRAM,
@@ -187,8 +187,8 @@ static void maciisi_write_pram(int offse
 #else
 #define maciisi_read_time() 0
 #define maciisi_write_time(n)
-#define maciisi_read_pram NULL
-#define maciisi_write_pram NULL
+#define maciisi_pram_read_byte NULL
+#define maciisi_pram_write_byte NULL
 #endif
 
 /*
@@ -198,7 +198,7 @@ static void maciisi_write_pram(int offse
  * the RTC should be enabled.
  */
 
-static __u8 via_pram_readbyte(void)
+static __u8 via_rtc_recv(void)
 {
 	int	i,reg;
 	__u8	data;
@@ -225,7 +225,7 @@ static __u8 via_pram_readbyte(void)
 	return data;
 }
 
-static void via_pram_writebyte(__u8 data)
+static void via_rtc_send(__u8 data)
 {
 	int	i,reg,bit;
 
@@ -262,17 +262,17 @@ static void via_pram_command(int command
 	via1[vBufB] = (via1[vBufB] | VIA1B_vRTCClk) & ~VIA1B_vRTCEnb;
 
 	if (command & 0xFF00) {		/* extended (two-byte) command */
-		via_pram_writebyte((command & 0xFF00) >> 8);
-		via_pram_writebyte(command & 0xFF);
+		via_rtc_send((command & 0xFF00) >> 8);
+		via_rtc_send(command & 0xFF);
 		is_read = command & 0x8000;
 	} else {			/* one-byte command */
-		via_pram_writebyte(command);
+		via_rtc_send(command);
 		is_read = command & 0x80;
 	}
 	if (is_read) {
-		*data = via_pram_readbyte();
+		*data = via_rtc_recv();
 	} else {
-		via_pram_writebyte(*data);
+		via_rtc_send(*data);
 	}
 
 	/* All done, disable the RTC */
@@ -282,12 +282,12 @@ static void via_pram_command(int command
 	local_irq_restore(flags);
 }
 
-static __u8 via_read_pram(int offset)
+static unsigned char via_pram_read_byte(int offset)
 {
 	return 0;
 }
 
-static void via_write_pram(int offset, __u8 data)
+static void via_pram_write_byte(unsigned char data, int offset)
 {
 }
 
@@ -453,50 +453,51 @@ void pmu_shutdown(void)
  *-------------------------------------------------------------------
  */
 
-void mac_pram_read(int offset, __u8 *buffer, int len)
+unsigned char mac_pram_read_byte(int addr)
 {
-	__u8 (*func)(int);
-	int i;
+	unsigned char (*func)(int);
 
 	switch(macintosh_config->adb_type) {
 	case MAC_ADB_IISI:
-		func = maciisi_read_pram; break;
+		func = maciisi_pram_read_byte;
+		break;
 	case MAC_ADB_PB1:
 	case MAC_ADB_PB2:
-		func = pmu_read_pram; break;
+		func = pmu_pram_read_byte;
+		break;
 	case MAC_ADB_CUDA:
-		func = cuda_read_pram; break;
+		func = cuda_pram_read_byte;
+		break;
 	default:
-		func = via_read_pram;
-	}
-	if (!func)
-		return;
-	for (i = 0 ; i < len ; i++) {
-		buffer[i] = (*func)(offset++);
+		func = via_pram_read_byte;
 	}
+
+	if (func)
+		return (*func)(addr);
+	return 0xff;
 }
 
-void mac_pram_write(int offset, __u8 *buffer, int len)
+void mac_pram_write_byte(unsigned char val, int addr)
 {
-	void (*func)(int, __u8);
-	int i;
+	void (*func)(unsigned char, int);
 
 	switch(macintosh_config->adb_type) {
 	case MAC_ADB_IISI:
-		func = maciisi_write_pram; break;
+		func = maciisi_pram_write_byte;
+		break;
 	case MAC_ADB_PB1:
 	case MAC_ADB_PB2:
-		func = pmu_write_pram; break;
+		func = pmu_pram_write_byte;
+		break;
 	case MAC_ADB_CUDA:
-		func = cuda_write_pram; break;
+		func = cuda_pram_write_byte;
+		break;
 	default:
-		func = via_write_pram;
-	}
-	if (!func)
-		return;
-	for (i = 0 ; i < len ; i++) {
-		(*func)(offset++, buffer[i]);
+		func = via_pram_write_byte;
 	}
+
+	if (func)
+		(*func)(val, addr);
 }
 
 void mac_poweroff(void)
