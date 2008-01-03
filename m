Return-Path: <mikenuss@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 697CFDDECD
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 01:46:57 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so10128025wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jan 2008 06:46:56 -0800 (PST)
Message-ID: <a340dd0e0801030646x4609c669sed653f812d7865e4@mail.gmail.com>
Date: Thu, 3 Jan 2008 09:46:56 -0500
From: "Mike Nuss" <mikenuss@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: Book-E watchdog driver questions
In-Reply-To: <a340dd0e0709251118n108799adxb60af2afa6ac9a96@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46F93E54.5050203@gmail.com>
	<2A9ADFCB-2725-4156-BE66-4E55A4987E2D@kernel.crashing.org>
	<a340dd0e0709251118n108799adxb60af2afa6ac9a96@mail.gmail.com>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sep 25, 2007 1:18 PM, Mike Nuss <mikenuss@gmail.com> wrote:
> > > Is there a reason that booke_wdt.c does not specify a MODULE_LICENSE?
> > >> From the copyright notice at the top it appears to be GPL. As
> > >> written,
> > > it taints the kernel.
> >
> > Odd, no reason.  I'll submit a patch for that.
> >
> > > Also, if I test out the driver by killing my process that's doing the
> > > pinging, I get a kernel panic:
> >
> > Its been a while since i've tried this.  I'll try it out and see what
> > happens.

The kernel panic was caused because TCR: WIE was set. This bit should
not be set, because it causes the timer to generate an interrupt that
the kernel does not handle.

>
> I also found that GETBOOTSTATUS returns 0 after the reboot. Looking at
> the source code I found the comment "XXX: something is clearing TSR" -
> I take that to mean that the register is being cleared by something
> before the module tries to read it? In my case U-Boot may be clearing
> that - I can take a look.

It turns out that the status bits in TSR are undefined at poweron
reset. Boards require external logic to detect POR - this is described
in AMCC's app note for the WDT. Because of this, U-Boot clears TSR
early on in the standard 4xx firmware (in start.S). To use TSR to
detect a watchdog reset, U-Boot must be modified to check that logic
and only clear the bits at POR. Those bits will be preserved until the
kernel driver looks at them, or until the system is powered off. So
the driver is correct here, but the comment should be updated to
explain why the GETBOOTSTATUS value may not be meaningful - it
requires additional hardware and firmware support.

I can submit a patch for these issues if you like.

Mike
