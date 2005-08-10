Return-Path: <mmporter@cox.net>
Received: from fed1rmmtai10.cox.net (fed1rmmtai10.cox.net [68.230.241.49])
	by ozlabs.org (Postfix) with ESMTP id 9EAD468053
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2005 03:26:25 +1000 (EST)
Received: from liberty.homelinux.org ([70.190.160.125]) by fed1rmmtao11.cox.net
	(InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP id
	<20050810163736.PXST12158.fed1rmmtao11.cox.net@liberty.homelinux.org>
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2005 12:37:36 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id JAA22824
	for linuxppc-dev@ozlabs.org; Wed, 10 Aug 2005 09:37:35 -0700
Date: Wed, 10 Aug 2005 09:37:35 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050810093735.B22586@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] Use todc on Mot PReP platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This restores behavior from 2.4 where PReP platforms identified
as Motorola would calibrate the decrementer using the RTC. On
real Motorola PReP hardware this isn't needed. However, in order
to boot a stock 2.6 PReP kernel on qemu (which emulates a Motorola
PReP system) it is necessary to allow it to calibrate the decrementer
using an emulated RTC.  If the decrementer rate is read from
residual data then timing is screwed since a qemu PReP system typically
runs much faster than the original hardware.

If anybody has objections to this as the default, let me know. It
still works (as did 2.4) on a couple of my Mot PReP boxes and doesn't
affect the IBM PReP paths. My goal with this is to be able to run
a stock 2.6 defconfig PReP build on qemu.

-Matt

diff --git a/arch/ppc/platforms/prep_setup.c b/arch/ppc/platforms/prep_setup.c
--- a/arch/ppc/platforms/prep_setup.c
+++ b/arch/ppc/platforms/prep_setup.c
@@ -940,8 +940,7 @@ prep_calibrate_decr(void)
 			tb_to_us = mulhwu_scale_factor(freq/divisor, 1000000);
 			tb_ticks_per_jiffy = freq / HZ / divisor;
 		}
-	}
-	else
+	} else
 		todc_calibrate_decr();
 }
 
@@ -1155,16 +1154,17 @@ prep_init(unsigned long r3, unsigned lon
 
 	ppc_md.time_init      = todc_time_init;
 	if (_prep_type == _PREP_IBM) {
+		ppc_md.calibrate_decr = prep_calibrate_decr;
 		ppc_md.rtc_read_val = todc_mc146818_read_val;
 		ppc_md.rtc_write_val = todc_mc146818_write_val;
 		TODC_INIT(TODC_TYPE_MC146818, RTC_PORT(0), NULL, RTC_PORT(1),
 				8);
 	} else {
+		ppc_md.calibrate_decr = todc_calibrate_decr;
 		TODC_INIT(TODC_TYPE_MK48T59, PREP_NVRAM_AS0, PREP_NVRAM_AS1,
 				PREP_NVRAM_DATA, 8);
 	}
 
-	ppc_md.calibrate_decr = prep_calibrate_decr;
 	ppc_md.set_rtc_time   = todc_set_rtc_time;
 	ppc_md.get_rtc_time   = todc_get_rtc_time;
 
