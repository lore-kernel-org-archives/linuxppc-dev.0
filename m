Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE004.bigfish.com (ch1ehsobe004.messaging.microsoft.com
	[216.32.181.184]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 972E2B6F8E
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2011 05:49:01 +1000 (EST)
Received: from mail47-ch1 (localhost.localdomain [127.0.0.1])	by
	mail47-ch1-R.bigfish.com (Postfix) with ESMTP id 92A1A1B28172	for
	<linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 19:48:58 +0000 (UTC)
Received: from CH1EHSMHS031.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.252])	by mail47-ch1.bigfish.com (Postfix) with ESMTP id
	748B9A4004F
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 19:48:58 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: clamp the P1022DS DIU pixel clock to allowed
	values
Date: Thu, 23 Jun 2011 14:48:54 -0500
Message-ID: <1308858535-17396-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To ensure that the DIU pixel clock will not be set to an invalid value,
clamp the PXCLK divider to the allowed range (2-255).  This also acts as
a limiter for the pixel clock.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/85xx/p1022_ds.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index e083e1f..266b3aa 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -195,8 +195,13 @@ void p1022ds_set_pixel_clock(unsigned int pixclock)
 	do_div(temp, pixclock);
 	freq = temp;
 
-	/* pixclk is the ratio of the platform clock to the pixel clock */
+	/*
+	 * 'pxclk' is the ratio of the platform clock to the pixel clock.
+	 * This number is programmed into the CLKDVDR register, and the valid
+	 * range of values is 2-255.
+	 */
 	pxclk = DIV_ROUND_CLOSEST(fsl_get_sys_freq(), freq);
+	pxclk = clamp_t(u32, pxclk, 2, 255);
 
 	/* Disable the pixel clock, and set it to non-inverted and no delay */
 	clrbits32(&guts->clkdvdr,
-- 
1.7.3.4
