Return-Path: <matthiasgrimm@users.sourceforge.net>
Received: from H3MXR02.htp-tel.de (h3mxr02.htp-tel.de [81.14.243.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3661EDDEB7
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jan 2007 02:37:54 +1100 (EST)
Date: Sat, 20 Jan 2007 15:06:14 +0100
From: Matthias Grimm <matthiasgrimm@users.sourceforge.net>
To: linuxppc-dev@ozlabs.org
Subject: kernel 2.6.18: Confusion about Macintosh backlight configuration
Message-Id: <20070120150614.0b62a3ef.matthiasgrimm@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ben@kernel.crashing.org, paulus@samba.org, 407671@bugs.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,
I know your guys are very busy and sometimes a email got lost. Normally
I would let it run but this time debian is going to integrate a kernel
from my point of view with a grave bug and they rejected any change
because they can't see any changes in the upstream project. (see debian
bug #407671)

I added the new SysFS backlight interface to PBButtons and struggled
over a bit of the kernel 2.6.18 (stable) configuration. Beside other we
have two options in Device Driver -> Macintosh Drivers:

CONFIG_PMAC_BACKLIGHT enables
 1. the generic backlight code used for the SysFS interface *and*
 2. the direct backlight manipulating routines for older PowerBooks.
    This means the kernel itself react to the brightness keys and
    change backlight level accordingly. This feature interferes with
    user space daemons like pbbuttonsd.

CONFIG_PMAC_BACKLIGHT enables
 1. PMU_IOC_GET_BACKLIGHT
 2. PMU_IOC_SET_BACKLIGHT
 3. PMU_IOC_GRAB_BACKLIGHT

The help text of CONFIG_PMAC_BACKLIGHT suggests that this option is only
needed if I have an old PowerBook and I could say "No" here if I use a
user space daemon. But if someone say "No" to this option he won't get any
backlight control at all (neither SysFS nor PMU).

To give a user space daemon full control over the backlight device, it has
to disable function #2 of CONFIG_PMAC_BACKLIGHT. Otherwise it would rival
with the kernel for any backlight setting.

This all leads to one single valid configuration:
  CONFIG_PMAC_BACKLIGHT        = YES
  CONFIG_PMAC_BACKLIGHT_LEGACY = YES

But If we have no choice anyway, we don't need configuration options.
Therefore here comes my suggestion:

1a. CONFIG_PMAC_BACKLIGHT
   Use this option for the generic backlight code only or compile it
   always in and get rid of this option.

1b. CONFIG_PMAC_BACKLIGHT_KERNELCTRL
   Use this option for the old Powerbooks or users that don't want to
   use a user space daemon. It should contain all the code that reads
   the brightness keys and set the backlight level in kernel space.
   Furthermore it should contain PMU_IOC_GRAB_BACKLIGHT to disable this
   behaviour during run time.

1c. CONFIG_PMAC_BACKLIGHT_LEGACY
   Should contain only interface parts that would be redundant with the
   new SysFS interface like PMU_IOC_GET_BACKLIGHT and PMU_IOC_SET_BACKLIGHT.

This will allow modern systems to be compiled only with
CONFIG_PMAC_BACKLIGHT and a user space daemon does the rest. I hope my
point could be seen. I would really appreciate if the configuration
could be cleaned up.

Other solutions could be:

2. If the sysfs backlight driver is opened switch kernel backlight keys
   handling off by calling PMU_IOC_GRAB_BACKLIGHT for machines that
   support the sysfs backlight interface.

3. Remove the kernel backlight keys control code from the kernel.

Which solution you prefer is up to you but I would be glad if at least
solution #1 could be realised.

  Best Regards
    Matthias
