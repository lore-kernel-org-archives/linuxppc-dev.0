Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 80E85DDDEE
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 04:36:06 +1000 (EST)
Date: Sun, 27 Apr 2008 20:35:51 +0200 (CEST)
From: Christian Kujau <lists@nerdbynature.de>
To: dwmw2@infradead.org
Subject: filenames with spaces in /sys?
Message-ID: <alpine.DEB.1.10.0804272012000.11017@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I was a bit puzzled today when I came across
/sys/devices/platform/pmu-battery.0/power_supply/PMU battery 0/power
and thought to myself: why are there spaces in "PMU battery 0"? Wouldn't
../pmu-battery.0/power_supply/PMU_battery_0/power be feasible too? I find 
it rather annoying to special case the spaces whenever to look for 
something in /sys, when I'm so used not to when doing the same 
find/grep/xargs stuff in /usr/src/linux.

There are ~2000 directories in my /sys but only a handful contain spaces:

# find /sys/ -type d -regex '.*\ .*' | sort -u
/sys/bus/mdio_bus/drivers/Broadcom BCM5411
/sys/bus/mdio_bus/drivers/Broadcom BCM5421
/sys/bus/mdio_bus/drivers/Broadcom BCM5461
/sys/bus/mdio_bus/drivers/Broadcom BCM5464
/sys/bus/mdio_bus/drivers/Broadcom BCM5481
/sys/bus/mdio_bus/drivers/Broadcom BCM5482
/sys/bus/mdio_bus/drivers/Generic PHY
/sys/devices/platform/pmu-battery.0/power_supply/PMU battery 0
/sys/devices/platform/pmu-battery.0/power_supply/PMU battery 0/power

Hm, OTOH /proc also does contain some elements with spaces in it (e.g. 
/proc/irq/47/GPIO1 ADB)...so, in short: would patches be accepted to
turn ' ' into '_' again (if they don't break too much userspace stuff)?

Thanks,
Christian.
-- 
BOFH excuse #373:

Suspicious pointer corrupted virtual machine
