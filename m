Date: Thu, 17 Oct 2002 10:05:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: leeyang <leeyang@ycig.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 rtc problem
Message-ID: <20021017170513.GN695@opus.bloom.county>
References: <20021017162357.GL695@opus.bloom.county> <Pine.LNX.4.44.0210171728470.2469-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0210171728470.2469-100000@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 17, 2002 at 05:36:17PM +0100, Alex Zeffertt wrote:
> On Thu, 17 Oct 2002, Tom Rini wrote:
>
> >
> > On Thu, Oct 17, 2002 at 05:18:21PM +0100, Alex Zeffertt wrote:
> > > On Thu, 17 Oct 2002, Tom Rini wrote:
> > >
> > > > On Thu, Oct 17, 2002 at 05:02:23PM +0100, Alex Zeffertt wrote:
> > > > > On Thu, 17 Oct 2002, leeyang wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I've written a rtc driver for the mpc860.  See attached files.
> > > > >
> > > > > HOWTO BUILD
> > > > >
> > > > > 1.	Edit KERNEL_DIR in Makefile
> > > > > 2.	make   (builds rtc.o and rtc)
> > > >
> > > > This appears to be a binary file.  And the easiest way to do this is to
> > > > make ppc_md.set_rtc_time / ppc_md.get_rtc_time point to functions which
> > > > do what their name implies.  Then enable CONFIG_PPC_RTC
> > >
> > > You're right.  This is actually what the module I have sent you does!
> > > The reason I wrote the module was merely to provide a way for userland
> > > programs to set the RTC.
> >
> > Er, okay.  But why not just modify
> > m8xx_setup.c::m8xx_get_rtc_time/m8xx_set_rtc_time to allow for the
> > get/set routines there to be overriden ? Doing that would be nice and
> > clean, and also allow the 'new' genrtc driver in 2.5 to just work as
> > well.
>
> I don't understand.  Why do you need to modify these functions?  They
> already work!  All I have done is to create a character driver that calls
> them (via their pointers ppc_md.set_rtc_time, and ppc_md.get_rtc_time).
>
> The driver registers itself on the standard rtc major and minor numbers
> and supports the standard RTC_RD_TIME/RTC_SET_TIME ioctls.

I don't understand what you did at all then (and you sent a binary file,
not rtc.c so I can't really see).  drivers/macintosh/rtc.c is already a
'generic' RTC driver for PPC, which already works on 8xx (and has,
officially since maybe 2.4.18 or 2.4.19, and much longer in the PPC
community trees).  So why did you have to write anything, if you used
the m8xx_set_rtc_time / m8xx_get_rtc_time functions in m8xx_setup.c ?

> What is genrtc?  (I'm not using 2.5 yet.)

It's a generic RTC driver, which lets arch specific (which can then be
board-specific) files determine how to exactly access the RTC hw, since
most things like date checking, some ioctls (except for the hw-specific
parts) are all generic.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
