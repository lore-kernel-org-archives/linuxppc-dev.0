Return-Path: <jengelh@inai.de>
Received: from seven.medozas.de (seven.medozas.de [IPv6:2a01:4f8:161:ffa::1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F172E2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2012 01:24:55 +1000 (EST)
Date: Thu, 16 Aug 2012 17:24:49 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: therm_pm72 units, interface
In-Reply-To: <1345066551.11751.1.camel@pasglop>
Message-ID: <alpine.LNX.2.01.1208161718210.8111@frira.zrqbmnf.qr>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066551.11751.1.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Wednesday 2012-08-15 23:35, Benjamin Herrenschmidt wrote:
>> XServe G5 of mine started powering off more or less 
>> randomly
>
>BTW. There's a new windfarm driver for these in recent kernels...
>
>Appart from that, the trip points are coming from a calibration EEPROM,
>you may want to tweak the driver to warn a bit earlier or that sort of
>things ? (Or just to print more things out ?)

If you have more things to print/offer via sysfs, I'm all for it.

The XsG5 really has (by looking into the casing): 1 PCI Fan,
6 center fans, 1 PSU intake and 1 PSU outblow fan (this last one
seems rather slow-turning, but maybe that's normal).
It is not quite clear which is which in the sysfs display.

What I did figure out: at the PROM, fans run at what seems
to be full speed (some 8000-9000 rpm?). Once Linux and therm_pm72
are loaded, the fans settle down towards 4000 rpm, and if the machine
has warmed up, that is then when it powers off. (The kernel is indeed
3.4. I now need to figure out how to place a new kernel on it without
it powering off inbetween.)

>> $ cd /sys/devices/temperature; grep '' *;
>> backside_fan_pwm:32
>> backside_temperature:54.000
>> cpu0_current:34.423
>> cpu0_exhaust_fan_rpm:5340
>> cpu0_intake_fan_rpm:5340
>> cpu0_temperature:72.889
>> cpu0_voltage:1.252
>> cpu1_current:34.179
>> cpu1_exhaust_fan_rpm:4584
>> cpu1_intake_fan_rpm:4584
>> cpu1_temperature:68.526
>> cpu1_voltage:1.259
>> dimms_temperature:53.000
>> grep: driver: Er en filkatalog
>> modalias:platform:temperature
>> grep: power: Er en filkatalog
>> slots_fan_pwm:20
>> slots_temperature:38.500
>> grep: subsystem: Er en filkatalog
>> uevent:DRIVER=temperature
>> uevent:OF_NAME=fan
>> uevent:OF_FULLNAME=/u3@0,f8000000/i2c@f8001000/fan@15e
>> uevent:OF_TYPE=fcu
>> uevent:OF_COMPATIBLE_0=fcu
>> uevent:OF_COMPATIBLE_N=1
>> uevent:MODALIAS=of:NfanTfcuCfcu
