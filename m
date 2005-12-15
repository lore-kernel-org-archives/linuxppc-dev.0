Return-Path: <Kristian-M@kristian-m.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id CD2A968802
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 15:33:18 +1100 (EST)
From: Kristian Mueller <Kristian-M@Kristian-M.de>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20051215041430.GB7468@pb15.lixom.net>
References: <1134618322.4972.10.camel@pismo>
	<20051215041430.GB7468@pb15.lixom.net>
Content-Type: multipart/mixed; boundary="=-kXABQvHWWro8A/RPSkss"
Date: Thu, 15 Dec 2005 12:31:55 +0800
Message-Id: <1134621116.4972.19.camel@pismo>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] via-mpu: compile without Power Management support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-kXABQvHWWro8A/RPSkss
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Please move the sleep_in_progress variable outside of #ifdef where it's
> defined instead, it will default to 0 and never trigger, but things will
> still build.
Okay good point, done.

Fix compilation of via-mpu.c without Power Management support.


Regards,
Kristian

--=-kXABQvHWWro8A/RPSkss
Content-Disposition: attachment; filename=pmu-without-pm-revised.patch
Content-Type: text/x-patch; name=pmu-without-pm-revised.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

--- linux/drivers/macintosh/via-pmu.c.orig	2005-12-15 11:28:28.000000000 +0800
+++ linux/drivers/macintosh/via-pmu.c	2005-12-15 12:20:43.000000000 +0800
@@ -157,8 +157,8 @@ static int pmu_version;
 static int drop_interrupts;
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
 static int option_lid_wakeup = 1;
-static int sleep_in_progress;
 #endif /* CONFIG_PM && CONFIG_PPC32 */
+static int sleep_in_progress;
 static unsigned long async_req_locks;
 static unsigned int pmu_irq_stats[11];
 

--=-kXABQvHWWro8A/RPSkss--
