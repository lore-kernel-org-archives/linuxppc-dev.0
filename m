From: "Florian Schirmer" <jolt@tuxbox.org>
To: "'Tom Rini'" <trini@kernel.crashing.org>,
	"'Andreas Oberritter'" <obi@saftware.de>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: new code for an mpc8xx board (dbox2)
Date: Mon, 4 Aug 2003 23:36:34 +0200
Message-ID: <000f01c35ad0$7b8d6fb0$6401a8c0@space.taytron.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20030804172428.GD20708@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

>> I'd also like to know if there is a better way to handle edge
>> triggered interrupts on 8xx than it is done in
>> linux-2.4.22-pre6-dbox2-irq.diff. Should CONFIG_DBOX2 be removed in
>> this patch or maybe replaced by CONFIG_8xx?
>
>Which interrupt is being generated that requires this change?

IIRC it is an ugly hack for a broken hardware. The initial problem was that
there is some hardware we don't have any documentation for. It generates
interrupts, but we dont know how to properly acknowledge them. This is why
we "invented" the SA_ONESHOT hack. If there is any other way to work around
this please let us know...

>If you use PPCBoot / U-Boot, you do not need to fill out an
>embed_config routine, and it's OK to let zImage fail.

This will break scripts expecting "make zImage" to return successfully.

>> linux-2.4.22-pre6-dbox2-watchdog.diff is needed because the
>> bootloader of this board enables the watchdog. Since it is a generic
>> implementation for handling an 8xx watchdog, I'd add CONFIG_8xx_WATCHDOG
>> for it instead of CONFIG_DBOX2, if no one complains.
>
>Since you have to define PITRTCLK, and there's magic numbers (and I don't
>have time at the moment to dig into the watchdog docs, cursed
>classes..) are you sure this is all generic 8xx code, and that
>those numbers wouldn't be board-specific?

It assumes there is a 32.768kHz crystal present on the board. Fix is simple:

if (RTCSC.38K)
  pitrtclk = 9600;
else
  pitrtclk = 8192;

I would like to see the userspace interface merged too
(http://cvs.tuxbox.org/cgi-bin/viewcvs.cgi/tuxbox/driver/wdt/mpc8xx_wdt.c).
I propose to drop the kernel watchdog patch and merge in the following
functions of the userspace interface instead:

mpc8xx_wdt_reset (needs to be exported to modules)
mpc8xx_wdt_interrupt
mpc8xx_wdt_handler_install (has to called during kernel init)

mpc8xx_wdt_handler_remove is dead and can be removed.

Regards,
   Florian


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
