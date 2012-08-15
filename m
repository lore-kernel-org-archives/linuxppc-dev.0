Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4EC292C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 07:37:04 +1000 (EST)
Message-ID: <1345066616.11751.2.camel@pasglop>
Subject: Re: therm_pm72 units, interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jan Engelhardt <jengelh@inai.de>
Date: Thu, 16 Aug 2012 07:36:56 +1000
In-Reply-To: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BTW... On a somewhat related note ... if you happen to have a spare
Xserve G5 PSU I'm interested :-) Mine died (well I -think- it's the
PSU ... it just won't power up) which means I can't test on these things
anymore (the new Windfarm RackMac driver is totally untested for
example).

Cheers,
Ben.

On Wed, 2012-08-15 at 19:53 +0200, Jan Engelhardt wrote:
> About a week ago, an XServe G5 of mine started powering off more or less 
> randomly (after 1 hour, chances were good it for it to occur). A 
> problematic UPS has already been cut from the loop, and today I cleaned 
> the machine inside out with pressurized air. So far it runs, for now at 
> least, with a load >= 2.0, but I am keeping an eye on whether this is a 
> thermal issue.
> 
> To that end, I wanted to obtain some statistics. Despite 
> sensors-detect(8) loads lm87.ko for me, running sensors(1) shows no 
> sensors. Oddly enough, I found a "kfand" process running that seems to 
> stem from therm_pm72.ko, which brings me to the sysfs files.
> 
> Is there a reason sensors(1) is not supported for Rackmac3,1?
> 
> Certain sysfs files have a value with an unknown unit.
> "current" is likely in Ampere, temperature must be in Celsius
> (because there's no way the server room is 54°F=12°C cold).
> 
> Is there a way to obtain the trip points for the hardware?
> 
> $ cd /sys/devices/temperature; grep '' *;
> backside_fan_pwm:32
> backside_temperature:54.000
> cpu0_current:34.423
> cpu0_exhaust_fan_rpm:5340
> cpu0_intake_fan_rpm:5340
> cpu0_temperature:72.889
> cpu0_voltage:1.252
> cpu1_current:34.179
> cpu1_exhaust_fan_rpm:4584
> cpu1_intake_fan_rpm:4584
> cpu1_temperature:68.526
> cpu1_voltage:1.259
> dimms_temperature:53.000
> grep: driver: Er en filkatalog
> modalias:platform:temperature
> grep: power: Er en filkatalog
> slots_fan_pwm:20
> slots_temperature:38.500
> grep: subsystem: Er en filkatalog
> uevent:DRIVER=temperature
> uevent:OF_NAME=fan
> uevent:OF_FULLNAME=/u3@0,f8000000/i2c@f8001000/fan@15e
> uevent:OF_TYPE=fcu
> uevent:OF_COMPATIBLE_0=fcu
> uevent:OF_COMPATIBLE_N=1
> uevent:MODALIAS=of:NfanTfcuCfcu
