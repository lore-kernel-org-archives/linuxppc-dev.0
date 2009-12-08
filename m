Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id BF5F9B7BBF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2009 13:16:42 +1100 (EST)
Date: Tue, 8 Dec 2009 05:16:38 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Peter Tyser <ptyser@xes-inc.com>
Subject: Re: [PATCH] powerpc: mpc8xxx_gpio: Add ability to mask off unused
	GPIO pins
Message-ID: <20091208021638.GA16115@oksana.dev.rtsoft.ru>
References: <1259955820-28565-1-git-send-email-ptyser@xes-inc.com>
	<20091205175614.GA10057@oksana.dev.rtsoft.ru>
	<1260041552.8643.33.camel@ptyser-laptop>
	<20091205205149.GA26030@oksana.dev.rtsoft.ru>
	<1260202998.23828.13344.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1260202998.23828.13344.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 07, 2009 at 10:23:18AM -0600, Peter Tyser wrote:
[...]
> > Yes, badly designed hardware deserves ugly hacks in the platform
> > code. ;-) So for this problem, just request these gpios in the
> > platform code.
> 
> I'd wager lots of boards have GPIO pins that a user shouldn't play
> around with once Linux boots up.  Like GPIO pins used to program an
> FPGA,

What if I do want to program/upgrade an FPGA, say from the userspace?

[...]
> In any case, my high-level thought process is:
> 1. Currently, the "ngpio" value is wrong for some processors and should
> be fixed.
> 2. Adding a new "fsl,gpio-mask" gpio solves #1, and has the benefit of
> allowing the device tree to easily reserve GPIO pins which should not be
> used in Linux.

OK, if you're so eager to fix this... I'd suggest to not put this
stuff into device tree. We have compatible property that describes
the device.

So, in the driver, you can just do

if (of_device_is_compatible("fsl,foo-gpiochip"))
	mask = ...;
else if (of_device_is_compatible("fsl,bar-gpiochip"))
	mask = ...;

If you want to solve "dangerous" GPIOs problem, then I'd say

chosen {
	linux,dangerous-gpios = <&pio1 0 0 &pio1 1 0
				 &pio2 4 0 &pio1 5 0>;
};

And then you can have a generic driver that looks for
linux,dangerous-gpios and requests them at boot.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
