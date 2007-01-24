Return-Path: <m.vegni@it-systems.it>
Received: from mail.it-systems.it (net203-143-073.mclink.it [213.203.143.73])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80942DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 13:55:30 +1100 (EST)
Received: from [85.18.14.0] (helo=[23.237.68.34])
	by mail.it-systems.it with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.63)
	(envelope-from <m.vegni@it-systems.it>) id 1H9XLu-0007Xg-Vm
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 02:55:15 +0100
Message-ID: <45B6BC79.5060904@it-systems.it>
Date: Wed, 24 Jan 2007 02:55:05 +0100
From: Massimiliano Vegni <m.vegni@it-systems.it>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Xserve G5 doesn't reboot or restart properly with SMU compiled in
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

We are experiencing a problem with Apple Xserve G5 (2.3G/Dual Proc.).
After successfully booting the linux  kernel ( tried 2.6.18, 2.6.19 or
2.6.20-rc5 )  the machine  fails to boot again.
It goes thru normal led flashing and fan spinning sequence, like the
first  time it booted,  but stops before  actually reading from the boot
disk.  It refuses to enter OF and the only way to make it boot again is
to reset internal PMU via a PMU reset button located inside  the chassis.
We found experimentally that disabling the SMU (leaving PMU on) in the
kernel configuration leads to clean reboot with no problems.... but no
/dev/rtc of course and this is a BIG problem!
Enabling I2C driver for Dallas RTC or the new RTC Class driver for RTC
also locks up the machine on reboot, so I think it's i2c related.
We also tried with different models of Xserve (2.0Ghz/DP) with same
results....

Any help would be appreciated.

Massimiliano (Max) Vegni
IT SYSTEMS srl - Rome - Italy
