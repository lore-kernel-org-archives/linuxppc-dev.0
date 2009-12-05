Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id B95FAB6F1B
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Dec 2009 07:51:52 +1100 (EST)
Date: Sat, 5 Dec 2009 23:51:49 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Peter Tyser <ptyser@xes-inc.com>
Subject: Re: [PATCH] powerpc: mpc8xxx_gpio: Add ability to mask off unused
	GPIO pins
Message-ID: <20091205205149.GA26030@oksana.dev.rtsoft.ru>
References: <1259955820-28565-1-git-send-email-ptyser@xes-inc.com>
	<20091205175614.GA10057@oksana.dev.rtsoft.ru>
	<1260041552.8643.33.camel@ptyser-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1260041552.8643.33.camel@ptyser-laptop>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 05, 2009 at 01:32:32PM -0600, Peter Tyser wrote:
[...]
> > > Adding a new "fsl,gpio-mask" device tree property allows a dts file to
> > > accurately describe what GPIO pins are available for use on a given
> > > board.
> > 
> > I don't see any real usage for this. If device tree specifies a wrong
> > gpio in the gpios = <> property, then it's a bug in the device tree
> > and should be fixed (or workarounded in the platform code).
> > 
> > If a user fiddles with unknown gpios via sysfs interface, then it's
> > user's problem.
> 
> Its the sysfs case that I'm concerned about.  Primarily because:
> 1. Users scratch their head when they see that the "ngpio" sysfs value
> doesn't match their CPU manual or board vendor's manual, and
> subsequently ask their board vendor's engineers (ie me:) what's up.

I don't think that adding code and device tree entries just for
documentation purposes is a good idea.

> 2. Improperly using GPIO pins could damage hardware for some boards.

Well, your initial patch tried to solve a different problem: to not
let users to request non-existent GPIOs, which is usually safe.

[...]
> #2 could be worked around by exporting GPIO pins in platform code so
> that they are not available via sysfs.

Yes, badly designed hardware deserves ugly hacks in the platform
code. ;-) So for this problem, just request these gpios in the
platform code.

> Would it be any more acceptable to instead add
> a "fsl,num-gpio" property so that "ngpio" actually reported an accurate
> value and non-existent GPIO pins couldn't be used/exported?

I'd think it's actually less acceptable. fsl,gpio-mask is more generic,
since from gpio-mask you can deduce ngpio. But it's still ugly.

What would be OK to do is to describe in the device tree every
device that is using some GPIO, and then let the userspace request
*only* gpios that are described in the device-tree. That way you
can automatically exclude not-existent gpios.
And if some gpios are just headers on the board, you can still
describe them in the device tree via "gpio-header" nodes.

Still, a lot of efforts for no real gain...

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
