Date: Thu, 17 Oct 2002 17:36:17 +0100 (BST)
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: leeyang <leeyang@ycig.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 860 rtc problem
In-Reply-To: <20021017162357.GL695@opus.bloom.county>
Message-ID: <Pine.LNX.4.44.0210171728470.2469-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 17 Oct 2002, Tom Rini wrote:

>
> On Thu, Oct 17, 2002 at 05:18:21PM +0100, Alex Zeffertt wrote:
> > On Thu, 17 Oct 2002, Tom Rini wrote:
> >
> > > On Thu, Oct 17, 2002 at 05:02:23PM +0100, Alex Zeffertt wrote:
> > > > On Thu, 17 Oct 2002, leeyang wrote:
> > > >
> > > > Hi,
> > > >
> > > > I've written a rtc driver for the mpc860.  See attached files.
> > > >
> > > > HOWTO BUILD
> > > >
> > > > 1.	Edit KERNEL_DIR in Makefile
> > > > 2.	make   (builds rtc.o and rtc)
> > >
> > > This appears to be a binary file.  And the easiest way to do this is to
> > > make ppc_md.set_rtc_time / ppc_md.get_rtc_time point to functions which
> > > do what their name implies.  Then enable CONFIG_PPC_RTC
> >
> > You're right.  This is actually what the module I have sent you does!
> > The reason I wrote the module was merely to provide a way for userland
> > programs to set the RTC.
>
> Er, okay.  But why not just modify
> m8xx_setup.c::m8xx_get_rtc_time/m8xx_set_rtc_time to allow for the
> get/set routines there to be overriden ? Doing that would be nice and
> clean, and also allow the 'new' genrtc driver in 2.5 to just work as
> well.
>

I don't understand.  Why do you need to modify these functions?  They
already work!  All I have done is to create a character driver that calls
them (via their pointers ppc_md.set_rtc_time, and ppc_md.get_rtc_time).

The driver registers itself on the standard rtc major and minor numbers
and supports the standard RTC_RD_TIME/RTC_SET_TIME ioctls.

What is genrtc?  (I'm not using 2.5 yet.)

Alex


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
