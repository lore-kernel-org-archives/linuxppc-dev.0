Date: Sat, 5 Aug 2000 09:44:50 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000805112531.1840@192.168.1.10>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000805092052.649D-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 5 Aug 2000, Benjamin Herrenschmidt wrote:

> >
> >As Geert has pointed out, hwclock can give UTC or local time to /dev/rtc,
> >why don't we just let userland deal with this local time issue.  What I
> >mean is for pmac_set_rtc_time(), let's change:
>
> That would give us back what we had at the beginning. This way, userland
> is solely responsible for this setup, which means it will be wrong on 50%
> of user machines (but that's user fault isn't it ?) and which means the
> kernel will boot with a wrong time, at least until the userland init
> script takes over.

Hmm, nothing has been changed with pmac_get_rtc_time().  So, if it is
broken now, it was broken before....  Seriously, pmac_get_rtc_time() is
the one responsible for giving you the correct time at boot time, isn't
it?

Does xtime need to be in UTC?  If so, is it feasible to let
ppc_md.time_init() give an offset in seconds from UTC to the time given by
RTC?

  void __init time_init(void)
  {
	unsigned long flags;
+ 	int offset = 0;
  	if (ppc_md.time_init != NULL)
  	{
  		offset = ppc_md.time_init();
  	}
	...
  	write_lock_irqsave(&xtime_lock, flags);
- 	xtime.tv_sec = ppc_md.get_rtc_time();
+ 	xtime.tv_sec = ppc_md.get_rtc_time() + offset;
  	write_unlock_irqrestore(&xtime_lock, flags);
	...

Oh, and change time_sleep_notify() in pmac_time.c accordingly.

> I don't see why it's such a mess to simply read the default values from
> xpram so we are consistent with MacOS. But everything in Linux is a mess
> anyway...

Maybe because pmac's RTC is in local time for one?


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
