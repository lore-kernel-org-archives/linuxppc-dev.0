Date: Thu, 17 Oct 2002 17:41:46 +0100 (BST)
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Marius Groeger <mag@sysgo.de>
Cc: Tom Rini <trini@kernel.crashing.org>, leeyang <leeyang@ycig.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 860 rtc problem
In-Reply-To: <Pine.LNX.4.40.0210171832270.15987-100000@mag.devdep.sysgo.de>
Message-ID: <Pine.LNX.4.44.0210171738180.2469-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 17 Oct 2002, Marius Groeger wrote:

>
> On Thu, 17 Oct 2002, Tom Rini wrote:
>
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
> Probably a little late, but: see also drivers/macintosh/rtc.c which is
> a perfectly generic rtc driver at a perfectly non-generic location.
> Don't mix this up with drivers/char/rtc.c, which is the other way
> round. Shudder.

Actually, that's where I got the kernel part of the code I just sent.  :-)
The userland bit I wrote myself.

I've just remembered.  To get this driver to work you have to change a
line in m8xx_setup.c from:

unsigned long __init m8xx_get_rtc_time(void)

to:

unsigned long m8xx_get_rtc_time(void)

Alex


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
