Message-Id: <4.3.2.7.2.20000804015504.00c65c40@mail.munich.netsurf.de>
Date: Fri, 04 Aug 2000 01:58:13 +0200
To: Takashi Oe <toe@unlserve.unl.edu>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: rtc again...
Cc: Gabriel Paubert <paubert@iram.es>, Benjamin Herrenschmidt <bh40@calva.net>,
        Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org,
        Iain Sandoe <iain@sandoe.co.uk>
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000803182949.650C-100000@ofey.earthl
 ink.net>
References: <Pine.HPX.4.10.10008031133480.9070-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 01:33 04.08.00, Takashi Oe wrote:

>On Thu, 3 Aug 2000, Gabriel Paubert wrote:
>
> > ===== arch/ppc/kernel/pmac_time.c 1.2 vs 1.5 =====
> > --- 1.2/arch/ppc/kernel/pmac_time.c   Mon Jun 19 19:59:36 2000
> > +++ 1.5/arch/ppc/kernel/pmac_time.c   Mon Jul 31 11:28:27 2000
>[...]
> >  int pmac_set_rtc_time(unsigned long nowtime)
> >  {
> > -     return 0;
> > +#ifdef CONFIG_ADB
> > +     struct adb_request req;
> > +#endif
> > +     nowtime += RTC_OFFSET - sys_tz.tz_minuteswest * 60;
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>This needs to be changed to
>
>+       nowtime += RTC_OFFSET - sys_tz.tz_minuteswest * 60 +
>(sys_tz.tz_dsttime? 3600: 0);

No, don't handle DST in the kernel!! hwclock handles this in userland, see
the hwclock source for details.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
