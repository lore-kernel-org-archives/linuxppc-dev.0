Date: Thu, 9 May 2002 18:16:27 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jean-Denis Boyer <jdboyer@mediatrix.com>,
	<linuxppc-embedded@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Bogomips and loops_per_jiffy
In-Reply-To: <20020509100846.G16602@altus.drgw.net>
Message-ID: <Pine.LNX.4.33.0205091804250.936-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 9 May 2002, Troy Benjegerdes wrote:

> >
> > > >	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0)
> > > >{
> > > >
> > > >Now that next_dec is unsigned, this condition is always false.
> >
> > Yes I wrote this in the most possible compact way.  But I don't understand
> > (yet) how this can cause problems. You have a security margin of about 2
> > billion timbase ticks.
>
> The problem occurs when calibrating the delay loop, and the timebase is
> very large.

The fact that the TB is large or not should be irrelevanet, after all
the TB wraps around every 2 to 5 minutes or so on most processors. Do the
math, it's rather simple modulo 2^32 arithmetic. If I lost decrementer
interrupts every time the TB wraps around, I would see strange things
under top for example.

Now if you do a set_tb after the time_init at some point, you have to
update the timekeeping variables (jiffy_stamp or whatever) in sync.
Otherwise you are going to have problems.

Note that there is a very simple possible patch: truncate the new value
you load into the decrementer to tb_ticks_per_jiffy. And for debugging,
keep the last few values of the timebase at the decrementer interrupt
around and print them when you have to truncate. I'm afraid that this is a
symptom of lost timekeeping after reading the RTC and that you simply
cure the symptom.


>
> http://lists.linuxppc.org/linuxppc-embedded/200205/msg00040.html
>
> We could probably just avoid all this and do 'set_tb(0,0)' in time_init
> (since we go and try to sync the timebase on SMP systems anyway)

Better set the TB to a large value to force the problem and see if you can
reproduce it.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
