Date: Fri, 4 Aug 2000 10:55:36 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org,
        Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: rtc again...
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000803182949.650C-100000@ofey.earthlink.net>
Message-ID: <Pine.HPX.4.10.10008041038130.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Aug 2000, Takashi Oe wrote:

> On Thu, 3 Aug 2000, Gabriel Paubert wrote:
>
> > ===== arch/ppc/kernel/pmac_time.c 1.2 vs 1.5 =====
> > --- 1.2/arch/ppc/kernel/pmac_time.c	Mon Jun 19 19:59:36 2000
> > +++ 1.5/arch/ppc/kernel/pmac_time.c	Mon Jul 31 11:28:27 2000
> [...]
> >  int pmac_set_rtc_time(unsigned long nowtime)
> >  {
> > -	return 0;
> > +#ifdef CONFIG_ADB
> > +	struct adb_request req;
> > +#endif
> > +	nowtime += RTC_OFFSET - sys_tz.tz_minuteswest * 60;
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This needs to be changed to
>
> +	nowtime += RTC_OFFSET - sys_tz.tz_minuteswest * 60 + (sys_tz.tz_dsttime? 3600: 0);

That's not my code, I took it from linux-2.4.0-test5, and I just added the
CONFIG_ADB tests so that it links with a PreP config.

I want people to check my patch, with or without NTP and to stress the
machines. All clock drifts should have vanished, which was the
single most important goal of this patch. Anyway I have very strong
opinions about running non UTC clocks and I won't repeat myslef here.

The other important points are:
- gettimeofday is faster (no divide, a single mulhwu which can't overflow
by definition),

- 601 support (also faster than in my previous patch but could be wrong on
SMP 601. There is a solution however).

What I need to know from people with an SMP machine:

- are the timebases synchronized ? Or is there a way to synchronize them ?

There are solutions for non synchronized timebases, but they are
more complex so I wrote the simple solution first.


	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
