Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93176DDF45
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 17:39:59 +1100 (EST)
Subject: Re: Xserve G5 doesn't reboot or restart properly with SMU compiled in
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Massimiliano Vegni <m.vegni@it-systems.it>
In-Reply-To: <45B6BC79.5060904@it-systems.it>
References: <45B6BC79.5060904@it-systems.it>
Content-Type: text/plain
Date: Wed, 24 Jan 2007 17:39:46 +1100
Message-Id: <1169620786.18754.72.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-24 at 02:55 +0100, Massimiliano Vegni wrote:
> Hi,
> 
> We are experiencing a problem with Apple Xserve G5 (2.3G/Dual Proc.).
> After successfully booting the linux  kernel ( tried 2.6.18, 2.6.19 or
> 2.6.20-rc5 )  the machine  fails to boot again.
> It goes thru normal led flashing and fan spinning sequence, like the
> first  time it booted,  but stops before  actually reading from the boot
> disk.  It refuses to enter OF and the only way to make it boot again is
> to reset internal PMU via a PMU reset button located inside  the chassis.
> We found experimentally that disabling the SMU (leaving PMU on) in the
> kernel configuration leads to clean reboot with no problems.... but no
> /dev/rtc of course and this is a BIG problem!
> Enabling I2C driver for Dallas RTC or the new RTC Class driver for RTC
> also locks up the machine on reboot, so I think it's i2c related.
> We also tried with different models of Xserve (2.0Ghz/DP) with same
> results....
> 
> Any help would be appreciated.

Hrm... that is strange... Are you absolutely sure that is related to the
SMU ? There is no SMU in that machine and thus I wouldn't expect the SMU
driver to instanciate at all nor do anything in fact.

The RTC flass driver stuff is bogus, don't use that. It's know to cause
that sort of problems.

I'll give a go at the Xserve I have here see if I can reproduce the
problem.

Also send me your .config

Ben.
