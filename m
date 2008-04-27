Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 30D12DDDF5
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 05:44:49 +1000 (EST)
Date: Sun, 27 Apr 2008 21:44:45 +0200 (CEST)
From: Christian Kujau <lists@nerdbynature.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] Re: filenames with spaces in /sys?
In-Reply-To: <1209322478.25560.84.camel@pmac.infradead.org>
Message-ID: <alpine.DEB.1.10.0804272137570.11017@sheep.housecafe.de>
References: <alpine.DEB.1.10.0804272012000.11017@sheep.housecafe.de>
	<1209322478.25560.84.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 27 Apr 2008, David Woodhouse wrote:
>> Hm, OTOH /proc also does contain some elements with spaces in it (e.g.
>> /proc/irq/47/GPIO1 ADB)...so, in short: would patches be accepted to
>> turn ' ' into '_' again (if they don't break too much userspace stuff)?
>
> I see no reason not to for the battery class, certainly.

Thanks. By changing drivers/power/pmu_battery.c I now have '_' instead of 
' ' (spaces) in /sys:

/sys/devices/platform/pmu-battery.0/power_supply/PMU_battery_0
/sys/class/power_supply/PMU_battery_0

I'm still not sure if some userspace tool out there uses the 
old paths and will break now.

Signed-off-by: Christian Kujau <lists@nerdbynature.de>

--- linux-2.6-git/drivers/power/pmu_battery.c.orig	2008-04-27 20:26:34.000000000 +0200
+++ linux-2.6-git/drivers/power/pmu_battery.c	2008-04-27 20:31:19.000000000 +0200
@@ -159,7 +159,7 @@ static int __init pmu_bat_init(void)
  		if (!pbat)
  			break;

-		sprintf(pbat->name, "PMU battery %d", i);
+		sprintf(pbat->name, "PMU_battery_%d", i);
  		pbat->bat.name = pbat->name;
  		pbat->bat.properties = pmu_bat_props;
  		pbat->bat.num_properties = ARRAY_SIZE(pmu_bat_props);


C.
-- 
BOFH excuse #189:

SCSI's too wide.
