Subject: RE: Real time clock seems stuck
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 31 Oct 2002 11:02:05 -0500
Message-ID: <3D296C067098F149B11A8F4FC37C054603EFEA@EXVS1.ops.infiniswitch.com>
From: "Wright, David" <dwright@infiniswitch.com>
To: "Kurt Wall" <kurt.wall@timesys.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Kurt Wall [mailto:kurt.wall@timesys.com]
> Sent: Thursday, October 31, 2002 9:28 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Real time clock seems stuck
>
>
>
> Speaking on condition of anonymity, Dr. Craig Hollabaugh told us:
> >
> > Folks,
> >
> > I'm trying to get a walnut board booted. I'm using
> linuxppc_2_4_devel pulled from denx yesterday. I'm getting
> the "Real time clock seems stuck" message then nothing, no
> messages after that. I found a brief thread about this.
> >
>
> I've seen this on boards that don't have an RTC...

He said he's working on a Walnut, guys, and a Walnut has a DS1743
RTC chip on board, or at least mine does.

The problem here is arising because the kernel is attempting to
probe the RTC continuously, waiting for it to tick over.  You
can't do that to a DS1743; you have to leave it idle for 500 usec
between probes or the indicators won't advance.

This isn't a production-quality patch, but here's the change I
made to arch/ppc/kernel/time.c:time_init() to handle the problem
(my changes tagged with "INFINISWITCH"):

	if (ppc_md.get_rtc_time) {
		int read_delta = 0;	/* INFINISWITCH */

		stamp = get_native_tbl();
		sec = ppc_md.get_rtc_time();
		elapsed = 0;
		do {
			old_stamp = stamp;
			old_sec = sec;
			stamp = get_native_tbl();
			if (__USE_RTC() && stamp < old_stamp) old_stamp -= 1000000000;
			elapsed += stamp - old_stamp;
			read_delta += stamp - old_stamp;  /* INFINISWITCH */

			/* some real-time clocks, like the DS1743, can't be
			 * read repeatedly at very high speed.  Only try to
			 * read the RTC once per jiffy (INFINISWITCH)
			 */
			if (read_delta > tb_ticks_per_jiffy) {
				sec = ppc_md.get_rtc_time();
				read_delta = 0;
			}
		} while ( sec == old_sec && elapsed < 2*HZ*tb_ticks_per_jiffy);



  -- David Wright, Infiniswitch Corp., Westborough, MA

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
