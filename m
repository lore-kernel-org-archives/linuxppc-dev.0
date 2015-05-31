Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id E1DFD1A0CA6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:16:59 +1000 (AEST)
Message-Id: <20150531010137.819515570@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:54 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [RFC 22/24] m68k/mac: Adopt nvram module
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement arch_nvram_ops and adjust calling conventions of mac_pram_*
functions to match the ops struct methods. Rename via_pram_readbyte and
via_pram_writebyte to avoid confusion and follow the existing
nvram_*_read_byte and nvram_*_write_byte naming convention.

Enable CONFIG_HAVE_ARCH_NVRAM_OPS on Macs.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---

The arch_nvram_ops struct can only be defined once, of course, so the
Mac and Atari ops structs are mutually exclusive. The final patch will
allow the two implementations to co-exist in a multi-platform kernel binary.

---
 arch/m68k/Kconfig    |    2 
 arch/m68k/mac/misc.c |  120 +++++++++++++++++++++++++++++++--------------------
 2 files changed, 76 insertions(+), 46 deletions(-)

Index: linux/arch/m68k/Kconfig
===================================================================
--- linux.orig/arch/m68k/Kconfig	2015-05-31 11:01:11.000000000 +1000
+++ linux/arch/m68k/Kconfig	2015-05-31 11:01:26.000000000 +1000
@@ -72,7 +72,7 @@ config PGTABLE_LEVELS
 	default 3
 
 config HAVE_ARCH_NVRAM_OPS
-	def_bool ATARI
+	def_bool (ATARI && !MAC) || (MAC && !ATARI)
 
 source "init/Kconfig"
 
Index: linux/arch/m68k/mac/misc.c
===================================================================
--- linux.orig/arch/m68k/mac/misc.c	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/m68k/mac/misc.c	2015-05-31 11:01:26.000000000 +1000
@@ -11,6 +11,7 @@
 #include <linux/time.h>
 #include <linux/rtc.h>
 #include <linux/mm.h>
+#include <linux/nvram.h>
 
 #include <linux/adb.h>
 #include <linux/cuda.h>
@@ -61,7 +62,8 @@ static void cuda_write_time(long data)
 		cuda_poll();
 }
 
-static __u8 cuda_read_pram(int offset)
+#if IS_ENABLED(CONFIG_NVRAM)
+static unsigned char cuda_pram_read_byte(int offset)
 {
 	struct adb_request req;
 	if (cuda_request(&req, NULL, 4, CUDA_PACKET, CUDA_GET_PRAM,
@@ -72,7 +74,7 @@ static __u8 cuda_read_pram(int offset)
 	return req.reply[3];
 }
 
-static void cuda_write_pram(int offset, __u8 data)
+static void cuda_pram_write_byte(unsigned char data, int offset)
 {
 	struct adb_request req;
 	if (cuda_request(&req, NULL, 5, CUDA_PACKET, CUDA_SET_PRAM,
@@ -81,11 +83,13 @@ static void cuda_write_pram(int offset,
 	while (!req.complete)
 		cuda_poll();
 }
+#endif /* CONFIG_NVRAM */
+
 #else
 #define cuda_read_time() 0
 #define cuda_write_time(n)
-#define cuda_read_pram NULL
-#define cuda_write_pram NULL
+#define cuda_pram_read_byte NULL
+#define cuda_pram_write_byte NULL
 #endif
 
 #ifdef CONFIG_ADB_PMU68K
@@ -116,7 +120,8 @@ static void pmu_write_time(long data)
 		pmu_poll();
 }
 
-static __u8 pmu_read_pram(int offset)
+#if IS_ENABLED(CONFIG_NVRAM)
+static unsigned char pmu_pram_read_byte(int offset)
 {
 	struct adb_request req;
 	if (pmu_request(&req, NULL, 3, PMU_READ_NVRAM,
@@ -127,7 +132,7 @@ static __u8 pmu_read_pram(int offset)
 	return req.reply[3];
 }
 
-static void pmu_write_pram(int offset, __u8 data)
+static void pmu_pram_write_byte(unsigned char data, int offset)
 {
 	struct adb_request req;
 	if (pmu_request(&req, NULL, 4, PMU_WRITE_NVRAM,
@@ -136,11 +141,13 @@ static void pmu_write_pram(int offset, _
 	while (!req.complete)
 		pmu_poll();
 }
+#endif /* CONFIG_NVRAM */
+
 #else
 #define pmu_read_time() 0
 #define pmu_write_time(n)
-#define pmu_read_pram NULL
-#define pmu_write_pram NULL
+#define pmu_pram_read_byte NULL
+#define pmu_pram_write_byte NULL
 #endif
 
 #if 0 /* def CONFIG_ADB_MACIISI */
@@ -169,7 +176,8 @@ static void maciisi_write_time(long data
 			(data >> 8) & 0xFF, data & 0xFF);
 }
 
-static __u8 maciisi_read_pram(int offset)
+#if IS_ENABLED(CONFIG_NVRAM)
+static unsigned char maciisi_pram_read_byte(int offset)
 {
 	struct adb_request req;
 	if (maciisi_request(&req, NULL, 4, CUDA_PACKET, CUDA_GET_PRAM,
@@ -178,17 +186,19 @@ static __u8 maciisi_read_pram(int offset
 	return req.reply[3];
 }
 
-static void maciisi_write_pram(int offset, __u8 data)
+static void maciisi_pram_write_byte(unsigned char data, int offset)
 {
 	struct adb_request req;
 	maciisi_request(&req, NULL, 5, CUDA_PACKET, CUDA_SET_PRAM,
 			(offset >> 8) & 0xFF, offset & 0xFF, data);
 }
+#endif /* CONFIG_NVRAM */
+
 #else
 #define maciisi_read_time() 0
 #define maciisi_write_time(n)
-#define maciisi_read_pram NULL
-#define maciisi_write_pram NULL
+#define maciisi_pram_read_byte NULL
+#define maciisi_pram_write_byte NULL
 #endif
 
 /*
@@ -198,7 +208,7 @@ static void maciisi_write_pram(int offse
  * the RTC should be enabled.
  */
 
-static __u8 via_pram_readbyte(void)
+static __u8 via_pram_recv(void)
 {
 	int	i,reg;
 	__u8	data;
@@ -225,7 +235,7 @@ static __u8 via_pram_readbyte(void)
 	return data;
 }
 
-static void via_pram_writebyte(__u8 data)
+static void via_pram_send(__u8 data)
 {
 	int	i,reg,bit;
 
@@ -262,17 +272,17 @@ static void via_pram_command(int command
 	via1[vBufB] = (via1[vBufB] | VIA1B_vRTCClk) & ~VIA1B_vRTCEnb;
 
 	if (command & 0xFF00) {		/* extended (two-byte) command */
-		via_pram_writebyte((command & 0xFF00) >> 8);
-		via_pram_writebyte(command & 0xFF);
+		via_pram_send((command & 0xFF00) >> 8);
+		via_pram_send(command & 0xFF);
 		is_read = command & 0x8000;
 	} else {			/* one-byte command */
-		via_pram_writebyte(command);
+		via_pram_send(command);
 		is_read = command & 0x80;
 	}
 	if (is_read) {
-		*data = via_pram_readbyte();
+		*data = via_pram_recv();
 	} else {
-		via_pram_writebyte(*data);
+		via_pram_send(*data);
 	}
 
 	/* All done, disable the RTC */
@@ -282,14 +292,16 @@ static void via_pram_command(int command
 	local_irq_restore(flags);
 }
 
-static __u8 via_read_pram(int offset)
+#if IS_ENABLED(CONFIG_NVRAM)
+static unsigned char via_pram_read_byte(int offset)
 {
 	return 0;
 }
 
-static void via_write_pram(int offset, __u8 data)
+static void via_pram_write_byte(unsigned char data, int offset)
 {
 }
+#endif /* CONFIG_NVRAM */
 
 /*
  * Return the current time in seconds since January 1, 1904.
@@ -453,52 +465,70 @@ void pmu_shutdown(void)
  *-------------------------------------------------------------------
  */
 
-void mac_pram_read(int offset, __u8 *buffer, int len)
+#if IS_ENABLED(CONFIG_NVRAM)
+static unsigned char mac_pram_read_byte(int addr)
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
+static void mac_pram_write_byte(unsigned char val, int addr)
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
 
+static ssize_t mac_pram_get_size(void)
+{
+	if (!MACH_IS_MAC)
+		return -ENODEV;
+	return 256;
+}
+
+const struct nvram_ops arch_nvram_ops = {
+	.read_byte      = mac_pram_read_byte,
+	.write_byte     = mac_pram_write_byte,
+	.get_size       = mac_pram_get_size,
+};
+EXPORT_SYMBOL(arch_nvram_ops);
+#endif /* CONFIG_NVRAM */
+
+
 void mac_poweroff(void)
 {
 	/*
