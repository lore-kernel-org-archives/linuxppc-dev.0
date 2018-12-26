Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0C4C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 05:04:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A6821741
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 05:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A6821741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43PgqL4drPzDqKf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 16:03:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43Pgmy5kqhzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 16:01:54 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 4F2A029522; Tue, 25 Dec 2018 19:43:56 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joshua Thompson <funaho@jurai.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Message-Id: <9a2226a05c8b1e142ee060a40c30ed803607ae44.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 12/25] m68k/mac: Fix PRAM accessors
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

PMU-based m68k Macs pre-date PowerMac-style NVRAM. Use the appropriate
PMU commands. Also implement the missing XPRAM accessors for VIA-based
Macs.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
---
Changed since v7:
 - Updated PMU response decoding due to via-pmu68k driver replacement.
---
 arch/m68k/mac/misc.c     | 43 ++++++++++++++++++++++++++++++----------
 include/uapi/linux/pmu.h |  2 ++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 475c93e4048c..0009efebb264 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -66,23 +66,22 @@ static unsigned char pmu_pram_read_byte(int offset)
 {
 	struct adb_request req;
 
-	if (pmu_request(&req, NULL, 3, PMU_READ_NVRAM,
-			(offset >> 8) & 0xFF, offset & 0xFF) < 0)
+	if (pmu_request(&req, NULL, 3, PMU_READ_XPRAM,
+	                offset & 0xFF, 1) < 0)
 		return 0;
-	while (!req.complete)
-		pmu_poll();
-	return req.reply[3];
+	pmu_wait_complete(&req);
+
+	return req.reply[0];
 }
 
 static void pmu_pram_write_byte(unsigned char data, int offset)
 {
 	struct adb_request req;
 
-	if (pmu_request(&req, NULL, 4, PMU_WRITE_NVRAM,
-			(offset >> 8) & 0xFF, offset & 0xFF, data) < 0)
+	if (pmu_request(&req, NULL, 4, PMU_WRITE_XPRAM,
+	                offset & 0xFF, 1, data) < 0)
 		return;
-	while (!req.complete)
-		pmu_poll();
+	pmu_wait_complete(&req);
 }
 #endif /* CONFIG_ADB_PMU */
 
@@ -151,6 +150,16 @@ static void via_rtc_send(__u8 data)
 #define RTC_REG_SECONDS_3       3
 #define RTC_REG_WRITE_PROTECT   13
 
+/*
+ * Inside Mac has no information about two-byte RTC commands but
+ * the MAME/MESS source code has the essentials.
+ */
+
+#define RTC_REG_XPRAM           14
+#define RTC_CMD_XPRAM_READ      (RTC_CMD_READ(RTC_REG_XPRAM) << 8)
+#define RTC_CMD_XPRAM_WRITE     (RTC_CMD_WRITE(RTC_REG_XPRAM) << 8)
+#define RTC_CMD_XPRAM_ARG(a)    (((a & 0xE0) << 3) | ((a & 0x1F) << 2))
+
 /*
  * Execute a VIA PRAM/RTC command. For read commands
  * data should point to a one-byte buffer for the
@@ -198,11 +207,25 @@ static void via_rtc_command(int command, __u8 *data)
 
 static unsigned char via_pram_read_byte(int offset)
 {
-	return 0;
+	unsigned char temp;
+
+	via_rtc_command(RTC_CMD_XPRAM_READ | RTC_CMD_XPRAM_ARG(offset), &temp);
+
+	return temp;
 }
 
 static void via_pram_write_byte(unsigned char data, int offset)
 {
+	unsigned char temp;
+
+	temp = 0x55;
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_WRITE_PROTECT), &temp);
+
+	temp = data;
+	via_rtc_command(RTC_CMD_XPRAM_WRITE | RTC_CMD_XPRAM_ARG(offset), &temp);
+
+	temp = 0x55 | RTC_FLG_WRITE_PROTECT;
+	via_rtc_command(RTC_CMD_WRITE(RTC_REG_WRITE_PROTECT), &temp);
 }
 
 /*
diff --git a/include/uapi/linux/pmu.h b/include/uapi/linux/pmu.h
index 97256f90e6df..f2fc1bd80017 100644
--- a/include/uapi/linux/pmu.h
+++ b/include/uapi/linux/pmu.h
@@ -19,7 +19,9 @@
 #define PMU_POWER_CTRL		0x11	/* control power of some devices */
 #define PMU_ADB_CMD		0x20	/* send ADB packet */
 #define PMU_ADB_POLL_OFF	0x21	/* disable ADB auto-poll */
+#define PMU_WRITE_XPRAM		0x32	/* write eXtended Parameter RAM */
 #define PMU_WRITE_NVRAM		0x33	/* write non-volatile RAM */
+#define PMU_READ_XPRAM		0x3a	/* read eXtended Parameter RAM */
 #define PMU_READ_NVRAM		0x3b	/* read non-volatile RAM */
 #define PMU_SET_RTC		0x30	/* set real-time clock */
 #define PMU_READ_RTC		0x38	/* read real-time clock */
-- 
2.19.2

