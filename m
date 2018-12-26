Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8D0C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 05:07:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92ACC2171F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 05:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92ACC2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Pgvq3jQlzDqMy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 16:07:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43Pgmy5gr1zDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 16:01:54 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 2009129513; Tue, 25 Dec 2018 19:43:56 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joshua Thompson <funaho@jurai.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Message-Id: <535828e73145446d4f1b9916f12c853c7026ce93.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 10/25] m68k/mac: Adopt naming and calling conventions for
 PRAM routines
Date: Wed, 26 Dec 2018 11:37:59 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Adopt the existing *_read_byte and *_write_byte naming convention.
Rename via_pram_readbyte and via_pram_writebyte to avoid confusion.
Adjust calling conventions of mac_pram_* functions to match the
arch_nvram_ops struct methods.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
---
Changed since v7:
 - Removed some gratuitous function pointers.
---
 arch/m68k/mac/misc.c | 61 +++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index ebb3b6d169ea..9f6849deecea 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -37,7 +37,7 @@
 static void (*rom_reset)(void);
 
 #ifdef CONFIG_ADB_CUDA
-static __u8 cuda_read_pram(int offset)
+static unsigned char cuda_pram_read_byte(int offset)
 {
 	struct adb_request req;
 
@@ -49,7 +49,7 @@ static __u8 cuda_read_pram(int offset)
 	return req.reply[3];
 }
 
-static void cuda_write_pram(int offset, __u8 data)
+static void cuda_pram_write_byte(unsigned char data, int offset)
 {
 	struct adb_request req;
 
@@ -62,7 +62,7 @@ static void cuda_write_pram(int offset, __u8 data)
 #endif /* CONFIG_ADB_CUDA */
 
 #ifdef CONFIG_ADB_PMU
-static __u8 pmu_read_pram(int offset)
+static unsigned char pmu_pram_read_byte(int offset)
 {
 	struct adb_request req;
 
@@ -74,7 +74,7 @@ static __u8 pmu_read_pram(int offset)
 	return req.reply[3];
 }
 
-static void pmu_write_pram(int offset, __u8 data)
+static void pmu_pram_write_byte(unsigned char data, int offset)
 {
 	struct adb_request req;
 
@@ -93,7 +93,7 @@ static void pmu_write_pram(int offset, __u8 data)
  * the RTC should be enabled.
  */
 
-static __u8 via_pram_readbyte(void)
+static __u8 via_rtc_recv(void)
 {
 	int i, reg;
 	__u8 data;
@@ -120,7 +120,7 @@ static __u8 via_pram_readbyte(void)
 	return data;
 }
 
-static void via_pram_writebyte(__u8 data)
+static void via_rtc_send(__u8 data)
 {
 	int i, reg, bit;
 
@@ -157,17 +157,17 @@ static void via_pram_command(int command, __u8 *data)
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
@@ -177,12 +177,12 @@ static void via_pram_command(int command, __u8 *data)
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
 
@@ -326,63 +326,48 @@ static void cuda_shutdown(void)
  *-------------------------------------------------------------------
  */
 
-void mac_pram_read(int offset, __u8 *buffer, int len)
+unsigned char mac_pram_read_byte(int addr)
 {
-	__u8 (*func)(int);
-	int i;
-
 	switch (macintosh_config->adb_type) {
 	case MAC_ADB_IOP:
 	case MAC_ADB_II:
 	case MAC_ADB_PB1:
-		func = via_read_pram;
-		break;
+		return via_pram_read_byte(addr);
 #ifdef CONFIG_ADB_CUDA
 	case MAC_ADB_EGRET:
 	case MAC_ADB_CUDA:
-		func = cuda_read_pram;
-		break;
+		return cuda_pram_read_byte(addr);
 #endif
 #ifdef CONFIG_ADB_PMU
 	case MAC_ADB_PB2:
-		func = pmu_read_pram;
-		break;
+		return pmu_pram_read_byte(addr);
 #endif
 	default:
-		return;
-	}
-	for (i = 0 ; i < len ; i++) {
-		buffer[i] = (*func)(offset++);
+		return 0xFF;
 	}
 }
 
-void mac_pram_write(int offset, __u8 *buffer, int len)
+void mac_pram_write_byte(unsigned char val, int addr)
 {
-	void (*func)(int, __u8);
-	int i;
-
 	switch (macintosh_config->adb_type) {
 	case MAC_ADB_IOP:
 	case MAC_ADB_II:
 	case MAC_ADB_PB1:
-		func = via_write_pram;
+		via_pram_write_byte(val, addr);
 		break;
 #ifdef CONFIG_ADB_CUDA
 	case MAC_ADB_EGRET:
 	case MAC_ADB_CUDA:
-		func = cuda_write_pram;
+		cuda_pram_write_byte(val, addr);
 		break;
 #endif
 #ifdef CONFIG_ADB_PMU
 	case MAC_ADB_PB2:
-		func = pmu_write_pram;
+		pmu_pram_write_byte(val, addr);
 		break;
 #endif
 	default:
-		return;
-	}
-	for (i = 0 ; i < len ; i++) {
-		(*func)(offset++, buffer[i]);
+		break;
 	}
 }
 
-- 
2.19.2

