Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A1E9DDF45
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 17:37:03 +1000 (EST)
Date: Fri, 11 Jul 2008 09:36:50 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Subject: Re: [RFC] (almost) booting allyesconfig -- please  don't poke
	super-io  without request_region
Message-ID: <20080711093650.4b98e3b7@hyperion.delvare>
In-Reply-To: <48770B5E.7000308@hhs.nl>
References: <for-27-patch1-0@bga.com> <48768018.2070704@hhs.nl>
	<acca8e14e769b2feadee19f1f7448438@bga.com>
	<20080711085246.1ead773b@hyperion.delvare>
	<48770B5E.7000308@hhs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Samuel Ortiz <samuel@sortiz.org>,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	lm-sensors@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 11 Jul 2008 09:27:26 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Hi Hans, hi Milton,
> > 
> 
> <snip>
> 
> >> One could make a superio driver, and create sub-devices for the IR, 
> >> I2C, floppy, parallel, etc
> >> nodes.
> > 
> > There have been proposals to do this, and this would indeed be a very
> > good idea, but unfortunately nobody took the time to implement this
> > properly, push it upstream and volunteer to maintain it. The problem is
> > that you don't need just a "driver", but a new subsystem, that needs to
> > be designed and maintained.
> 
> Well, I believe there have been some lightweight superio locking coordinator 
> patches been floating around on the lm_sensors list, and I have reviewed them 
> and then a new version was done with my issues fixed.
> 
> I kinda liked the proposed solution there, it was quite simple, moved all the 
> generic superio stuff into generic superio code, and added locking for super io 
> access from multiple drivers, what ever happened to those patches?

As far as I know, nothing, and this is the problem. Somebody needs to
step up and call him/herself the maintainer of the new code, and push
it upstream and convert all the drivers (hwmon, watchdog, parallel
port...) to make use of it. And I am not the one to do this, I am busy
enough as is with i2c and hwmon.

> If were to start using those, we could actually do a request region and then 
> never release it, as things should be.

Yes, if we have a superio access coordinator, it can request the region
and not release it. But as long as we don't have that, I agree with
Milton that the individual drivers should temporarily request the
Super-I/O region before accessing it.

-- 
Jean Delvare
