Message-ID: <015801c27646$ffc2cce0$fc00a8c0@ycigrnd.ycig.com>
From: "leeyang" <leeyang@ycig.com>
To: "Tom Rini" <trini@kernel.crashing.org>,
	"Alex Zeffertt" <ajz@cambridgebroadband.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20021017162357.GL695@opus.bloom.county> <Pine.LNX.4.44.0210171728470.2469-100000@localhost.localdomain> <20021017170513.GN695@opus.bloom.county>
Subject: Re: 860 rtc problem
Date: Fri, 18 Oct 2002 09:38:01 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am sure that I have defined the CONFIG_PPC_RTC in the kernel
(General setup--->Support for /dev/rtc).

In order to track whether m8xx_get_rtc_time/m8xx_set_rtc_time
been called in hwclock I and 2 printk in them as following:

/* The RTC on the MPC8xx is an internal register.
 * We want to protect this during power down, so we need to unlock,
 * modify, and re-lock.
 */
static int
m8xx_set_rtc_time(unsigned long time)
{
 printk("enter set rtc\n");
 ((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_rtck = KAPWR_KEY;
 ((volatile immap_t *)IMAP_ADDR)->im_sit.sit_rtc = time;
 ((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_rtck = ~KAPWR_KEY;
 return(0);
}

static unsigned long
m8xx_get_rtc_time(void)
{
 /* Get time from the RTC. */
 printk("enter get rtc\n");
 return((unsigned long)(((immap_t *)IMAP_ADDR)->im_sit.sit_rtc));
}

and when booting the kernel and when using hwclock --show
many "enter get rtc" pop up (about 1000),
so I am sure get function is called.

but when call hwclock -s --date 'Oct 18 2002',it hangs serveral
seconds and return no "enter set rtc' msg.

bash-2.04# hwclock -s --date 'Oct 18 9:00 2002' --debug
hwclock 2.4c/util-linux-2.11f
Using /dev/rtc interface to clock.
Last drift adjustment done at 0 seconds after 1969
Last calibration done at 0 seconds after 1969
Hardware clock is on unknown time
Assuming hardware clock is kept in local time.
Waiting for clock tick...
/dev/rtc does not have interrupt functions. Waiting in loop for time from
/dev/r
tc to change
Timed out waiting for time change.
...got clock tick

So I am not sure the set function works or not?


----- Original Message -----
From: "Tom Rini" <trini@kernel.crashing.org>
To: "Alex Zeffertt" <ajz@cambridgebroadband.com>
Cc: "leeyang" <leeyang@ycig.com>; <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, October 18, 2002 1:05 AM
Subject: Re: 860 rtc problem


> On Thu, Oct 17, 2002 at 05:36:17PM +0100, Alex Zeffertt wrote:
> > On Thu, 17 Oct 2002, Tom Rini wrote:
> >
> > >
> > > On Thu, Oct 17, 2002 at 05:18:21PM +0100, Alex Zeffertt wrote:
> > > > On Thu, 17 Oct 2002, Tom Rini wrote:
> > > >
> > > > > On Thu, Oct 17, 2002 at 05:02:23PM +0100, Alex Zeffertt wrote:
> > > > > > On Thu, 17 Oct 2002, leeyang wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > I've written a rtc driver for the mpc860.  See attached files.
> > > > > >
> > > > > > HOWTO BUILD
> > > > > >
> > > > > > 1. Edit KERNEL_DIR in Makefile
> > > > > > 2. make   (builds rtc.o and rtc)
> > > > >
> > > > > This appears to be a binary file.  And the easiest way to do this
is to
> > > > > make ppc_md.set_rtc_time / ppc_md.get_rtc_time point to functions
which
> > > > > do what their name implies.  Then enable CONFIG_PPC_RTC
> > > >
> > > > You're right.  This is actually what the module I have sent you
does!
> > > > The reason I wrote the module was merely to provide a way for
userland
> > > > programs to set the RTC.
> > >
> > > Er, okay.  But why not just modify
> > > m8xx_setup.c::m8xx_get_rtc_time/m8xx_set_rtc_time to allow for the
> > > get/set routines there to be overriden ? Doing that would be nice and
> > > clean, and also allow the 'new' genrtc driver in 2.5 to just work as
> > > well.
> >
> > I don't understand.  Why do you need to modify these functions?  They
> > already work!  All I have done is to create a character driver that
calls
> > them (via their pointers ppc_md.set_rtc_time, and ppc_md.get_rtc_time).
> >
> > The driver registers itself on the standard rtc major and minor numbers
> > and supports the standard RTC_RD_TIME/RTC_SET_TIME ioctls.
>
> I don't understand what you did at all then (and you sent a binary file,
> not rtc.c so I can't really see).  drivers/macintosh/rtc.c is already a
> 'generic' RTC driver for PPC, which already works on 8xx (and has,
> officially since maybe 2.4.18 or 2.4.19, and much longer in the PPC
> community trees).  So why did you have to write anything, if you used
> the m8xx_set_rtc_time / m8xx_get_rtc_time functions in m8xx_setup.c ?
>
> > What is genrtc?  (I'm not using 2.5 yet.)
>
> It's a generic RTC driver, which lets arch specific (which can then be
> board-specific) files determine how to exactly access the RTC hw, since
> most things like date checking, some ioctls (except for the hw-specific
> parts) are all generic.
>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
