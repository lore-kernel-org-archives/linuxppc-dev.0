Date: Mon, 4 Aug 2003 16:12:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Florian Schirmer <jolt@tuxbox.org>
Cc: "'Andreas Oberritter'" <obi@saftware.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: new code for an mpc8xx board (dbox2)
Message-ID: <20030804231248.GE20708@ip68-0-152-218.tc.ph.cox.net>
References: <20030804172428.GD20708@ip68-0-152-218.tc.ph.cox.net> <000f01c35ad0$7b8d6fb0$6401a8c0@space.taytron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000f01c35ad0$7b8d6fb0$6401a8c0@space.taytron.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 04, 2003 at 11:36:34PM +0200, Florian Schirmer wrote:
> Hi,
>
> >> I'd also like to know if there is a better way to handle edge
> >> triggered interrupts on 8xx than it is done in
> >> linux-2.4.22-pre6-dbox2-irq.diff. Should CONFIG_DBOX2 be removed in
> >> this patch or maybe replaced by CONFIG_8xx?
> >
> >Which interrupt is being generated that requires this change?
>
> IIRC it is an ugly hack for a broken hardware. The initial problem was that
> there is some hardware we don't have any documentation for. It generates
> interrupts, but we dont know how to properly acknowledge them. This is why
> we "invented" the SA_ONESHOT hack. If there is any other way to work around
> this please let us know...

Well, in that case I'd be inclined to leave it as CONFIG_DBOX2 only,
with a comment describing what hardware this is for.

> >If you use PPCBoot / U-Boot, you do not need to fill out an
> >embed_config routine, and it's OK to let zImage fail.
>
> This will break scripts expecting "make zImage" to return successfully.

Yes, it does.  It's also how all of the other PPCBoot / U-Boot only
platforms work.  Now that I think about this again, would you mind
looking at the source and seeing if the following in embed_config.c
would break anything?
void __attribute__((weak))
embed_config(void)
{
}

(Or so, look at arch/ppc/boot/common/serial_stub.c for the proper usage
of 'weak').

[snip]
> I would like to see the userspace interface merged too
> (http://cvs.tuxbox.org/cgi-bin/viewcvs.cgi/tuxbox/driver/wdt/mpc8xx_wdt.c).
> I propose to drop the kernel watchdog patch and merge in the following
> functions of the userspace interface instead:
>
> mpc8xx_wdt_reset (needs to be exported to modules)
> mpc8xx_wdt_interrupt
> mpc8xx_wdt_handler_install (has to called during kernel init)
>
> mpc8xx_wdt_handler_remove is dead and can be removed.

I need a bit of time to think about this (and a 'new' patch would be
nice as well).  I'll get back to you.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
