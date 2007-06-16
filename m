Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5607ADDF5D
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 10:51:23 +1000 (EST)
Subject: Re: Powerbook hard shutdown after boot if it's hot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mb@bu3sch.de>
In-Reply-To: <200706141739.12754.mb@bu3sch.de>
References: <200706141739.12754.mb@bu3sch.de>
Content-Type: text/plain
Date: Sat, 16 Jun 2007 10:51:13 +1000
Message-Id: <1181955074.26853.105.camel@localhost.localdomain>
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

On Thu, 2007-06-14 at 17:39 +0200, Michael Buesch wrote:
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

Not really, that's weird.. maybe trying to print the values in the adt
sensor to see how hot it is vs. the various thresholds set by the
firmware ? Maybe the PMU is trying to send us a "high temp" alert via a
PMU message we don't know how to parse and expcts us to reply in a given
amount of time (for example by slowing the CPU down).

Ben.
