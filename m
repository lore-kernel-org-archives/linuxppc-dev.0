Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id BBCB6B7D10
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 11:46:43 +1100 (EST)
Date: Mon, 8 Mar 2010 19:46:41 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [patch] powerpc: pika_wdt ident cannot be const
Message-ID: <20100308194641.2883b6ba@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The watchdog_info struct cannot be a const since we dynamically fill
in the firmware version.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
index 435ec2a..2d22e99 100644
--- a/drivers/watchdog/pika_wdt.c
+++ b/drivers/watchdog/pika_wdt.c
@@ -52,7 +52,7 @@ static struct {
 	struct timer_list timer;	/* The timer that pings the watchdog */
 } pikawdt_private;
 
-static const struct watchdog_info ident = {
+static struct watchdog_info ident = {
 	.identity	= DRV_NAME,
 	.options	= WDIOF_CARDRESET |
 			  WDIOF_SETTIMEOUT |
