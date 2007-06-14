Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 7FE40DDED4
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 02:41:43 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 14 Jun 2007 18:41:36 +0200
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: Powerbook hard shutdown after boot if it's hot
Message-ID: <20070614164136.GB27602@iram.es>
References: <200706141739.12754.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200706141739.12754.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 14, 2007 at 05:39:12PM +0200, Michael Buesch wrote:
> Hi,
> 
> I have a strange problem that my Powerbook shuts down hard
> right after boot, if the machine is hot.
> For example, if I compile a kernel and then want to reboot
> into it, it will shutdown the machine right after userspace
> is booted. Cooling down the machine will fix the issue.
> I first thought this might be a problem with the adt746x
> chip driver (thermostat). But this turns out to not be
> the case. I disabled the module (put return 0; early into
> the module_init function), but the problem still exists.
> I'm not sure how to debug this, as I don't see what's
> going on. I tried to boot with init=/bin/bash. It will
> boot into the shell but shutdown hard after 1 or 2 seconds.
> It seems like there is some timer hitting in right after
> userspace is up and running (some workqueue?). Strange is
> that it _only_ shuts down the machine when it's hot
> and it _only_ does this right after boot. If it survived
> the first few seconds after boot, it's rock-stable and
> it won't show any problems when getting hot (will drive
> the fans correctly, etc etc...)
> 
> Any idea how to debug this?

I believe that the hardware (PMU?) forces a power off
when the fan speed control registers are not accessed
for some time. This delay may depend on the temperature. 

When my PB motherboard failed, the fans were driven at full
speed at power-up and then ran for about a minute before
they were stopped and the machine completely shut-down.

As a stab in the dark, you might try to force the fans at 
full speed in an __init function. This will make the machine 
noisy for some time before the loop starts regulating fan 
speed but might buy you some time.

	Regards,
	Gabriel
