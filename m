Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5B631679A6
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2006 08:33:49 +1100 (EST)
Date: Mon, 27 Feb 2006 13:33:19 -0800
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: copying /sys causes fans to spin up
Message-ID: <20060227213319.GC4685@pb15.lixom.net>
References: <20060227160911.GA17569@suse.de>
	<1141075795.4809.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1141075795.4809.15.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 28, 2006 at 08:29:55AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2006-02-27 at 17:09 +0100, Olaf Hering wrote:
> > Ben, 
> > 
> > 
> > some tool copies /sys, and while doing it, the fans start to spin up on
> > my G5. Any idea how to fix it, other than not reading from /sys? Have to
> > find the exact file.
> 
> Interesting... it's causing the i2c bus to go nuts... It would be useful
> to find out what file indeed...

For me it's /sys/devices/system/windfarm.0/hd-temp

It also seems that the windfarm module misdetects my system. From dmesg:

PowerMac G5 Thermal control driver 1.2b2
Detected fan controls:
  0: PWM fan, id 1, location: BACKSIDE,SYS CTRLR FAN
  1: RPM fan, id 2, location: DRIVE BAY
  2: PWM fan, id 2, location: SLOT,PCI FAN
  3: RPM fan, id 3, location: CPU A INTAKE
  4: RPM fan, id 4, location: CPU A EXHAUST
  5: RPM fan, id 5, location: CPU B INTAKE
  6: RPM fan, id 6, location: CPU B EXHAUST
  7: RPM fan, id 1, location: CPU A PUMP
  8: RPM fan, id 0, location: CPU B PUMP
....
PowerMac i2c bus pmu 2 registered
PowerMac i2c bus pmu 1 registered
PowerMac i2c bus mac-io 0 registered
PowerMac i2c bus u3 1 registered
Liquid cooling pumps detected, using new algorithm !
windfarm: failed to attach ds1775 hd-temp to i2c

And it for sure is not a liquid cooled model, the 2.0's never were.
(PM7,3)

I think this is a 2.6.16-rc2 with the cpufreq patches, but I seems to
have lost the source tree to verify for sure.


-Olof
