Return-Path: <jengelh@inai.de>
Received: from seven.medozas.de (seven.medozas.de [IPv6:2a01:4f8:161:ffa::1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3466E2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 03:59:17 +1000 (EST)
Date: Wed, 15 Aug 2012 19:53:22 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: therm_pm72 units, interface
Message-ID: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


About a week ago, an XServe G5 of mine started powering off more or less 
randomly (after 1 hour, chances were good it for it to occur). A 
problematic UPS has already been cut from the loop, and today I cleaned 
the machine inside out with pressurized air. So far it runs, for now at 
least, with a load >= 2.0, but I am keeping an eye on whether this is a 
thermal issue.

To that end, I wanted to obtain some statistics. Despite 
sensors-detect(8) loads lm87.ko for me, running sensors(1) shows no 
sensors. Oddly enough, I found a "kfand" process running that seems to 
stem from therm_pm72.ko, which brings me to the sysfs files.

Is there a reason sensors(1) is not supported for Rackmac3,1?

Certain sysfs files have a value with an unknown unit.
"current" is likely in Ampere, temperature must be in Celsius
(because there's no way the server room is 54°F=12°C cold).

Is there a way to obtain the trip points for the hardware?

$ cd /sys/devices/temperature; grep '' *;
backside_fan_pwm:32
backside_temperature:54.000
cpu0_current:34.423
cpu0_exhaust_fan_rpm:5340
cpu0_intake_fan_rpm:5340
cpu0_temperature:72.889
cpu0_voltage:1.252
cpu1_current:34.179
cpu1_exhaust_fan_rpm:4584
cpu1_intake_fan_rpm:4584
cpu1_temperature:68.526
cpu1_voltage:1.259
dimms_temperature:53.000
grep: driver: Er en filkatalog
modalias:platform:temperature
grep: power: Er en filkatalog
slots_fan_pwm:20
slots_temperature:38.500
grep: subsystem: Er en filkatalog
uevent:DRIVER=temperature
uevent:OF_NAME=fan
uevent:OF_FULLNAME=/u3@0,f8000000/i2c@f8001000/fan@15e
uevent:OF_TYPE=fcu
uevent:OF_COMPATIBLE_0=fcu
uevent:OF_COMPATIBLE_N=1
uevent:MODALIAS=of:NfanTfcuCfcu
