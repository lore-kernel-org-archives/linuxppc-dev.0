Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1B67F2C0097
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Aug 2013 05:08:30 +1000 (EST)
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id 3c6Hvv2Vsrz4KK3N
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Aug 2013 21:08:27 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 3c6Hvt73lFzbbnr
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Aug 2013 21:08:26 +0200 (CEST)
Received: from mail.mnet-online.de ([192.168.8.180])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new,
 port 10024) with ESMTP id RrFv7ayaIBZ6 for <linuxppc-dev@ozlabs.org>;
 Fri,  2 Aug 2013 21:08:25 +0200 (CEST)
Received: from igel.home (ppp-88-217-110-98.dynamic.mnet-online.de
 [88.217.110.98]) by mail.mnet-online.de (Postfix) with ESMTPA
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Aug 2013 21:08:25 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: windfarm_fcu_controls: cpu-pump-0 <HW FAULT>
Date: Fri, 02 Aug 2013 21:08:25 +0200
Message-ID: <87r4eb52s6.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

wf_fcu_fan_get_rpm is returning EFAULT when reading the values for the
cpu pump controls on the PowerMac7,3.  Also, wf_fcu_get_pump_minmax is
unable to get the real limits and falls back to using the defaults.

Here is the output when DEBUG is defined:

wf_fcu: FCU Initialized, RPM fan shift is 3
Looking up FCU controls in device-tree...
 control: rpm0, type: fan-rpm-control
 matching location: CPU B PUMP, reg: 0x00000010
 location match, name: cpu-pump-1
wf_fcu: pump min/max for cpu-pump-1 set to: [1250..3200] RPM
wf_pm72: Liquid cooling pump(s) detected, using new algorithm !
 control: rpm1, type: fan-rpm-control
 matching location: CPU A PUMP, reg: 0x00000012
 location match, name: cpu-pump-0
wf_fcu: pump min/max for cpu-pump-0 set to: [1250..3200] RPM
 control: rpm2, type: fan-rpm-control
 matching location: DRIVE BAY, reg: 0x00000014
 location match, name: drive-bay-fan
wf_fcu: fan min/max for drive-bay-fan set to: [300..7000] RPM
 control: rpm3, type: fan-rpm-control
 matching location: CPU A INTAKE, reg: 0x00000016
 location match, name: cpu-front-fan-0
wf_fcu: fan min/max for cpu-front-fan-0 set to: [300..3200] RPM
 control: rpm4, type: fan-rpm-control
 matching location: CPU A EXHAUST, reg: 0x00000018
 location match, name: cpu-rear-fan-0
wf_fcu: fan min/max for cpu-rear-fan-0 set to: [300..3200] RPM
 control: rpm5, type: fan-rpm-control
 matching location: CPU B INTAKE, reg: 0x0000001a
 location match, name: cpu-front-fan-1
wf_fcu: fan min/max for cpu-front-fan-1 set to: [300..3200] RPM
 control: rpm6, type: fan-rpm-control
 matching location: CPU B EXHAUST, reg: 0x0000001c
 location match, name: cpu-rear-fan-1
wf_fcu: fan min/max for cpu-rear-fan-1 set to: [300..3200] RPM
 control: pwm1, type: fan-pwm-control
 matching location: BACKSIDE, reg: 0x00000032
 location match, name: backside-fan
 control: pwm2, type: fan-pwm-control
 matching location: SLOT, reg: 0x00000034
 location match, name: slots-fan
 control: adc0, type: power-sensor
 control: adc1, type: power-sensor
 control: adc2, type: power-sensor
 control: adc3, type: power-sensor
 control: gpi0, type: gpi-sensor
 control: gpi1, type: gpi-sensor

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
