Return-Path: <j.w.r.degoede@hhs.nl>
Received: from smtp1.versatel.nl (smtp1.versatel.nl [62.58.50.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 083CFDE020
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 17:20:19 +1000 (EST)
Message-ID: <48770B5E.7000308@hhs.nl>
Date: Fri, 11 Jul 2008 09:27:26 +0200
From: Hans de Goede <j.w.r.degoede@hhs.nl>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC] (almost) booting allyesconfig -- please don't poke super-io
	without request_region
References: <for-27-patch1-0@bga.com>	<48768018.2070704@hhs.nl>	<acca8e14e769b2feadee19f1f7448438@bga.com>
	<20080711085246.1ead773b@hyperion.delvare>
In-Reply-To: <20080711085246.1ead773b@hyperion.delvare>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Jean Delvare wrote:
> Hi Hans, hi Milton,
> 

<snip>

>> One could make a superio driver, and create sub-devices for the IR, 
>> I2C, floppy, parallel, etc
>> nodes.
> 
> There have been proposals to do this, and this would indeed be a very
> good idea, but unfortunately nobody took the time to implement this
> properly, push it upstream and volunteer to maintain it. The problem is
> that you don't need just a "driver", but a new subsystem, that needs to
> be designed and maintained.
> 

Well, I believe there have been some lightweight superio locking coordinator 
patches been floating around on the lm_sensors list, and I have reviewed them 
and then a new version was done with my issues fixed.

I kinda liked the proposed solution there, it was quite simple, moved all the 
generic superio stuff into generic superio code, and added locking for super io 
access from multiple drivers, what ever happened to those patches?

If were to start using those, we could actually do a request region and then 
never release it, as things should be.

Regards,

Hans
