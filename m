Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B7D3C2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2012 06:52:09 +1000 (EST)
Message-ID: <1345150317.11751.38.camel@pasglop>
Subject: Re: therm_pm72 units, interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jan Engelhardt <jengelh@inai.de>
Date: Fri, 17 Aug 2012 06:51:57 +1000
In-Reply-To: <alpine.LNX.2.01.1208161718210.8111@frira.zrqbmnf.qr>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066551.11751.1.camel@pasglop>
 <alpine.LNX.2.01.1208161718210.8111@frira.zrqbmnf.qr>
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


> If you have more things to print/offer via sysfs, I'm all for it.
> 
> The XsG5 really has (by looking into the casing): 1 PCI Fan,
> 6 center fans, 1 PSU intake and 1 PSU outblow fan (this last one
> seems rather slow-turning, but maybe that's normal).
> It is not quite clear which is which in the sysfs display.

The cpu intake & exhaust are the same, they are handled by groups of 3
ie, cpu0_* is the 3 fans on CPU 0, cpu1_* is the 3 fans on CPU 1.

Backside fan is supposed to blow on the U3 chip, I don't remember where
it's located, and slots fan is the PCI one afaik. The PSU's own fan
isn't under our direct control

> What I did figure out: at the PROM, fans run at what seems
> to be full speed (some 8000-9000 rpm?). Once Linux and therm_pm72
> are loaded, the fans settle down towards 4000 rpm, and if the machine
> has warmed up, that is then when it powers off. (The kernel is indeed
> 3.4. I now need to figure out how to place a new kernel on it without
> it powering off inbetween.)

You can try netbooting... OF netboot is limited to 4M sized zImages
which can be a bit tough nowadays, but modern yaboot can netboot larger
files. Another option is USB sticks.

> >> $ cd /sys/devices/temperature; grep '' *;
> >> backside_fan_pwm:32
> >> backside_temperature:54.000
> >> cpu0_current:34.423
> >> cpu0_exhaust_fan_rpm:5340
> >> cpu0_intake_fan_rpm:5340
> >> cpu0_temperature:72.889
> >> cpu0_voltage:1.252
> >> cpu1_current:34.179
> >> cpu1_exhaust_fan_rpm:4584
> >> cpu1_intake_fan_rpm:4584
> >> cpu1_temperature:68.526
> >> cpu1_voltage:1.259
> >> dimms_temperature:53.000
> >> grep: driver: Er en filkatalog
> >> modalias:platform:temperature
> >> grep: power: Er en filkatalog
> >> slots_fan_pwm:20
> >> slots_temperature:38.500
> >> grep: subsystem: Er en filkatalog
> >> uevent:DRIVER=temperature
> >> uevent:OF_NAME=fan
> >> uevent:OF_FULLNAME=/u3@0,f8000000/i2c@f8001000/fan@15e
> >> uevent:OF_TYPE=fcu
> >> uevent:OF_COMPATIBLE_0=fcu
> >> uevent:OF_COMPATIBLE_N=1
> >> uevent:MODALIAS=of:NfanTfcuCfcu

Cheers,
Ben.
