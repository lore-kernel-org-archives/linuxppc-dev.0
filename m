Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A68BB6EEF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2009 03:23:28 +1100 (EST)
Subject: Re: [PATCH] powerpc: mpc8xxx_gpio: Add ability to mask off unused
	GPIO pins
From: Peter Tyser <ptyser@xes-inc.com>
To: avorontsov@ru.mvista.com
In-Reply-To: <20091205205149.GA26030@oksana.dev.rtsoft.ru>
References: <1259955820-28565-1-git-send-email-ptyser@xes-inc.com>
	<20091205175614.GA10057@oksana.dev.rtsoft.ru>
	<1260041552.8643.33.camel@ptyser-laptop>
	<20091205205149.GA26030@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Dec 2009 10:23:18 -0600
Message-ID: <1260202998.23828.13344.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,
I've CC-ed devicetree-discuss.  The original patch is at
http://patchwork.ozlabs.org/patch/40361/ for reference.

On Sat, 2009-12-05 at 23:51 +0300, Anton Vorontsov wrote:
> On Sat, Dec 05, 2009 at 01:32:32PM -0600, Peter Tyser wrote:
> [...]
> > > > Adding a new "fsl,gpio-mask" device tree property allows a dts file to
> > > > accurately describe what GPIO pins are available for use on a given
> > > > board.
> > > 
> > > I don't see any real usage for this. If device tree specifies a wrong
> > > gpio in the gpios = <> property, then it's a bug in the device tree
> > > and should be fixed (or workarounded in the platform code).
> > > 
> > > If a user fiddles with unknown gpios via sysfs interface, then it's
> > > user's problem.
> > 
> > Its the sysfs case that I'm concerned about.  Primarily because:
> > 1. Users scratch their head when they see that the "ngpio" sysfs value
> > doesn't match their CPU manual or board vendor's manual, and
> > subsequently ask their board vendor's engineers (ie me:) what's up.
> 
> I don't think that adding code and device tree entries just for
> documentation purposes is a good idea.

Its not just for documentation purposes.  Right now, the sysfs "ngpio"
value is flat out wrong for some processors, regardless of
documentation.  Granted its not a critical bug, but I'd still consider
it a bug.

> > 2. Improperly using GPIO pins could damage hardware for some boards.
> 
> Well, your initial patch tried to solve a different problem: to not
> let users to request non-existent GPIOs, which is usually safe.

I can update the commit message with this rational if it makes a
difference.

> [...]
> > #2 could be worked around by exporting GPIO pins in platform code so
> > that they are not available via sysfs.
> 
> Yes, badly designed hardware deserves ugly hacks in the platform
> code. ;-) So for this problem, just request these gpios in the
> platform code.

I'd wager lots of boards have GPIO pins that a user shouldn't play
around with once Linux boots up.  Like GPIO pins used to program an
FPGA, or control a PLL, etc.  1 device tree property is nicer than
hacking up lots of platform code...

> > Would it be any more acceptable to instead add
> > a "fsl,num-gpio" property so that "ngpio" actually reported an accurate
> > value and non-existent GPIO pins couldn't be used/exported?
> 
> I'd think it's actually less acceptable. fsl,gpio-mask is more generic,
> since from gpio-mask you can deduce ngpio. But it's still ugly.
> 
> What would be OK to do is to describe in the device tree every
> device that is using some GPIO, and then let the userspace request
> *only* gpios that are described in the device-tree. That way you
> can automatically exclude not-existent gpios.
> And if some gpios are just headers on the board, you can still
> describe them in the device tree via "gpio-header" nodes.
> 
> Still, a lot of efforts for no real gain...

Agreed.  Seems like a clean solution, but is a chunk of work.

In any case, my high-level thought process is:
1. Currently, the "ngpio" value is wrong for some processors and should
be fixed.
2. Adding a new "fsl,gpio-mask" gpio solves #1, and has the benefit of
allowing the device tree to easily reserve GPIO pins which should not be
used in Linux.

I guess I'm not seeing the big downside of a new "fsl,gpio-mask"
property.  Its the device tree's job to describe the hardware.  The
change is pretty minimal (~15 lines), and the property can be made
optional.

Or is there another suggestion on how to resolve #1 above?  I consider
it a bug and would like to fix it.

Best,
Peter
