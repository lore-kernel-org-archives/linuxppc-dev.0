Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id D418BDDFB2
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 00:26:26 +1100 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
	Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 1/7] parisc: rtc: get_rtc_time() returns unsigned int
Date: Mon,  9 Mar 2009 14:26:17 +0100
Message-Id: <1236605183-22718-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: linux-m68k@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Dann Frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/rtc/rtc-parisc.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-parisc.c b/drivers/rtc/rtc-parisc.c
index b966f56..620b949 100644
--- a/drivers/rtc/rtc-parisc.c
+++ b/drivers/rtc/rtc-parisc.c
@@ -13,9 +13,7 @@
 
 static int parisc_get_time(struct device *dev, struct rtc_time *tm)
 {
-	unsigned long ret;
-
-	ret = get_rtc_time(tm);
+	unsigned int ret = get_rtc_time(tm);
 
 	if (ret & RTC_BATT_BAD)
 		return -EOPNOTSUPP;
-- 
1.6.0.4
