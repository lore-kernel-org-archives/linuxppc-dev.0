Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B383B7BF6
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Dec 2009 06:32:35 +1100 (EST)
Subject: Re: [PATCH] powerpc: mpc8xxx_gpio: Add ability to mask off unused
	GPIO pins
From: Peter Tyser <ptyser@xes-inc.com>
To: avorontsov@ru.mvista.com
In-Reply-To: <20091205175614.GA10057@oksana.dev.rtsoft.ru>
References: <1259955820-28565-1-git-send-email-ptyser@xes-inc.com>
	<20091205175614.GA10057@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Sat, 05 Dec 2009 13:32:32 -0600
Message-Id: <1260041552.8643.33.camel@ptyser-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,
Thanks for the feedback.

> On Fri, Dec 04, 2009 at 01:43:40PM -0600, Peter Tyser wrote:
> > This change resolves 2 issues:
> > - Different chips have a different number of GPIO pins per controller.
> >   For example, the MPC8347 has 32, the P2020 16, and the mpc8572 8.
> >   Previously, the mpc8xxx_gpio driver assumed every chip had 32 GPIO
> >   pins which resulted in some processors reporting an incorrect 'ngpio'
> >   field in /sys.  Additionally, users could export and "use" 32 GPIO
> >   pins, although in reality only a subset of the 32 pins had any real
> >   functionality.
> > 
> > - Some boards don't utilize all available GPIO pins.  Previously,
> >   unused GPIO pins could still be exported and "used", even though the
> >   pins had no real functionality.  This is somewhat confusing to a user
> >   and also allow a user to do something "bad", like change an unused
> >   floating output into a floating input.
> 
> There are hundreds of other ways to screw things up.
> 
> Think of /dev/mem, you still able to change the registers.
> Before changing any GPIO (whether it is a normal or reserved GPIO),
> user has to consult with schematics/docs.

Agreed.  This is an attempt to make it just a little bit harder to
accidentally screw things up and to make the "ngpio" sysfs value
actually contain an accurate value.

> > Adding a new "fsl,gpio-mask" device tree property allows a dts file to
> > accurately describe what GPIO pins are available for use on a given
> > board.
> 
> I don't see any real usage for this. If device tree specifies a wrong
> gpio in the gpios = <> property, then it's a bug in the device tree
> and should be fixed (or workarounded in the platform code).
> 
> If a user fiddles with unknown gpios via sysfs interface, then it's
> user's problem.

Its the sysfs case that I'm concerned about.  Primarily because:
1. Users scratch their head when they see that the "ngpio" sysfs value
doesn't match their CPU manual or board vendor's manual, and
subsequently ask their board vendor's engineers (ie me:) what's up.

2. Improperly using GPIO pins could damage hardware for some boards.
For example, some of our boards have a voltage regulator controlled via
GPIO pins so that a CPU's core voltage can be changed based on its
frequency, etc.  A user could damage their CPU if they aren't careful
with those GPIO pins.  For pins like that, it'd be nice to not even let
users play with them.

#2 could be worked around by exporting GPIO pins in platform code so
that they are not available via sysfs.  And I agree that if a user is
playing with GPIO pins, they had better know what they are doing, so #1
above is my main issue.  Would it be any more acceptable to instead add
a "fsl,num-gpio" property so that "ngpio" actually reported an accurate
value and non-existent GPIO pins couldn't be used/exported?

With the patch as is, if "fsl,gpio-mask" is not given, the driver
defaults to enabling all 32 gpio pins.  Would it be any better if I
respun the patch to only add the "fsl,gpio-mask" property for the
mpc8572, p2020, and mpc8379 boards which have less than 32 gpio pins and
document the dts property as optional?

Thanks,
Peter
