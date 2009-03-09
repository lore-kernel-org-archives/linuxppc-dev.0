Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 85113DDF9B
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 00:26:27 +1100 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
	Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 2/7] parisc: rtc: platform_driver_probe() fixups
Date: Mon,  9 Mar 2009 14:26:18 +0100
Message-Id: <1236605183-22718-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1236605183-22718-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: linux-m68k@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dann frazier <dannf@hp.com>, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>,
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

When using platform_driver_probe(), it's not needed to setup a .probe
function, and .remove should be marked __exit_p(), not __devexit_p().

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: dann frazier <dannf@hp.com>
---
 drivers/rtc/rtc-parisc.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-parisc.c b/drivers/rtc/rtc-parisc.c
index 620b949..f4e871c 100644
--- a/drivers/rtc/rtc-parisc.c
+++ b/drivers/rtc/rtc-parisc.c
@@ -62,8 +62,7 @@ static struct platform_driver parisc_rtc_driver = {
 		.name = "rtc-parisc",
 		.owner = THIS_MODULE,
 	},
-	.probe = parisc_rtc_probe,
-	.remove = __devexit_p(parisc_rtc_remove),
+	.remove = __exit_p(parisc_rtc_remove),
 };
 
 static int __init parisc_rtc_init(void)
-- 
1.6.0.4
