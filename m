Return-Path: <vincent.yang.fujitsu@gmail.com>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EDE771A004A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 16:23:56 +1000 (EST)
Received: by mail-pd0-f169.google.com with SMTP id g10so2621851pdj.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 23:23:55 -0700 (PDT)
From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
To: chris@printf.net,
	linux-mmc@vger.kernel.org
Subject: [RFC PATCH v2 5/6] mmc: core: hold SD Clock before CMD11 during
 Signal Voltage Switch Procedure
Date: Thu, 26 Jun 2014 14:23:31 +0800
Message-Id: <1403763812-5495-6-git-send-email-Vincent.Yang@tw.fujitsu.com>
In-Reply-To: <1403763812-5495-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1403763812-5495-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Cc: devicetree@vger.kernel.org, andy.green@linaro.org, patches@linaro.org,
 anton@enomsg.org, Vincent.Yang@tw.fujitsu.com, jaswinder.singh@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is to fix an issue found on mb86s7x platforms.

[symptom]
There are some UHS-1 SD memory cards sometimes cannot be detected correctly,
e.g., Transcend 600x SDXC 64GB UHS-1 memory card.
During Signal Voltage Switch Procedure, failure to switch is indicated
by the card holding DAT[3:0] low.

[analysis]
According to SD Host Controller Simplified Specification Version 3.00
chapter 3.6.1, the Signal Voltage Switch Procedure should be:
(1) Check S18A; (2) Issue CMD11; (3) Check CMD 11 response;
(4) Stop providing SD clock; (5) Check DAT[3:0] should be 0000b;
(6) Set 1.8V Signal Enable; (7) Wait 5ms; (8) Check 1.8V Signal Enable;
(9) Provide SD Clock; (10) Wait 1ms; (11) Check DAT[3:0] should be 1111b;
(12) error handling

With CONFIG_MMC_CLKGATE=y, sometimes there is one more gating/un-gating
SD clock between (2) and (3). In this case, some UHS-1 SD cards will hold
DAT[3:0] 0000b at (11) and thus fails Signal Voltage Switch Procedure.

[solution]
By mmc_host_clk_hold() before CMD11, the additional gating/un-gating
SD clock between (2) and (3) can be prevented and thus no failure at (11).
It has been verified with many UHS-1 SD cards on mb86s7x platforms and
works correctly.

Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
---
 drivers/mmc/core/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7dc0c85..764af63 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1428,6 +1428,8 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
 		pr_warning("%s: cannot verify signal voltage switch\n",
 				mmc_hostname(host));
 
+	mmc_host_clk_hold(host);
+
 	cmd.opcode = SD_SWITCH_VOLTAGE;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
@@ -1438,8 +1440,6 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
 
 	if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
 		return -EIO;
-
-	mmc_host_clk_hold(host);
 	/*
 	 * The card should drive cmd and dat[0:3] low immediately
 	 * after the response of cmd11, but wait 1 ms to be sure
-- 
1.9.0
