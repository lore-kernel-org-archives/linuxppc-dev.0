Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4DDC8DDE02
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 23:04:57 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Powerbook hard shutdown after boot if it's hot
Date: Sat, 16 Jun 2007 15:04:41 +0200
References: <200706141739.12754.mb@bu3sch.de>
	<1181955074.26853.105.camel@localhost.localdomain>
In-Reply-To: <1181955074.26853.105.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200706161504.41168.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 16 June 2007 02:51:13 Benjamin Herrenschmidt wrote:
> On Thu, 2007-06-14 at 17:39 +0200, Michael Buesch wrote:
> > Hi,
> > 
> > I have a strange problem that my Powerbook shuts down hard
> > right after boot, if the machine is hot.
> > For example, if I compile a kernel and then want to reboot
> > into it, it will shutdown the machine right after userspace
> > is booted. Cooling down the machine will fix the issue.
> > I first thought this might be a problem with the adt746x
> > chip driver (thermostat). But this turns out to not be
> > the case. I disabled the module (put return 0; early into
> > the module_init function), but the problem still exists.
> > I'm not sure how to debug this, as I don't see what's
> > going on. I tried to boot with init=/bin/bash. It will
> > boot into the shell but shutdown hard after 1 or 2 seconds.
> > It seems like there is some timer hitting in right after
> > userspace is up and running (some workqueue?). Strange is
> > that it _only_ shuts down the machine when it's hot
> > and it _only_ does this right after boot. If it survived
> > the first few seconds after boot, it's rock-stable and
> > it won't show any problems when getting hot (will drive
> > the fans correctly, etc etc...)
> > 
> > Any idea how to debug this?
> 
> Not really, that's weird.. maybe trying to print the values in the adt
> sensor to see how hot it is vs. the various thresholds set by the

The thresholds are the same as when the machine is cold:
81 80 87

I also tried to spinup the fans at full speed on boot (by setting
the fan_speed variable in the adt driver to 255), but it kills
the machine before the fans have the ability to spin up.

I also tried to move the 2000ms sleep in the adt monitor task down
to the bottom of the task function, so it immediately runs the task
once on boot. But that didn't help either.

I think this powerdown is not really related to the adt chip/driver.
I think it's more likely some PMU issue and the PMU forces the machine
down. How's the PMU involved into temperatures? Does it get
the temperature values from the adt chip?

> firmware ? Maybe the PMU is trying to send us a "high temp" alert via a
> PMU message we don't know how to parse and expcts us to reply in a given
> amount of time (for example by slowing the CPU down).

Where in the kernel code are the PMU messages handled?

-- 
Greetings Michael.
