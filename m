Date: Sat, 12 Aug 2000 20:46:11 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again... 
In-Reply-To: <14740.61112.962127.150660@argo.linuxcare.com.au>
Message-ID: <Pine.HPX.4.10.10008121339410.27028-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 12 Aug 2000, Paul Mackerras wrote:

> Gabriel Paubert writes:
>
> > > Certainly on my 7600 with a 2-cpu powersurge board, with the code that
> > > is currently in the devel kernel to use the tb register, you don't get
> > > the same time on both cpus.
> >
> > Yes, we need a way to check that the timebase are in sync and to sync
> > them if they are not. That's basically the same problem in any case.
> > The problem is to do it in a way that works on all machines...
>
> Until we get SMP working on the 2-cpu G4 machines (hopefully I will be
> getting one soon), the old powersurge board is the only supported SMP
> powermac.  I found with mine that when you start the second CPU, it
> stops the decrementers (and I expect timebases as well) on both CPUs
> until you send an interrupt from the primary to the secondary cpu.

I've just tested on my machines since it was not clear to me that the TBEN
pin would stop the decrementer or not: it does. It is the only way I know
to stop the timebase (besides stopping the clock that is).

There may still be issues with the ordering of time_init and starting the
second processor. We'll see...

> So on this platform at least, we can get the decrementers and
> timebases synchronized.

The only important registers are the timebases. First my patch got rid of
the gross `while (get_dec() == dval);' loop, which did not work properly
in any case. Depending on cache misses and external influences between
this loop and the setting of the decrementer, I got effective jiffy
frequency varying by 20ppm or so (that's about 200ns per 10 ms).

This had very nasty consequences even on my stratum 1 NTP server (just
compiling a kernel would make the clock drift by several milliseconds
before the PLL would react) on SMP this would have meant that the timer
interrupts would have been drifting away randomly from each other.

The solution I implemented is simple: use the time base as a reference and
generate a decrementer interrupt every n ticks of the timebase, even if
the 601 makes things more complex (the code in the patch I sent is
still wrong for 601, an improved one is coming soon).

> I merged in your patch and tried it on my 7600/powersurge machine.  It
> seems to work just fine.

So are the timebases in sync ? I was preparing a patch which should work
even with unsynced timebases, but then gettimeofday can only have jiffy
resolution. Beware that my next patch might break it, however, but it's
the fun of writing code that you can't test yourself :-)

> > I have still found bugs in my code (but it seems to be slowly converging).
> > I'm also considering switching to BitKeeper tree, and sending these
> > patches in smaller and more digestible chunks:
>
> I'm going to try to update the linuxppc_2_3 bitkeeper tree to -test6,
> since Cort is busy moving at the moment.  In the meantime I will
> update the rsync tree at linuxcare.com.au::linux-pmac-devel with your
> patch shortly.

I tried once to download your tree, but bandwidth to autralia is too small
from here.

> The get/set rtc stuff on powermac still needs work.  IMHO the way it
> should work on powermacs is this:
>
> - at boot, read the RTC and the xpram and apply the correction from
>   the xpram

Yes for PMAC. Apply the correction later (or never) for other machines.
BTW, man setttimeofday is very interesting about dst:

       The field tz_dsttime contains a symbolic constant  (values
       are  given below) that indicates in which part of the year
       Daylight Saving Time is in force. (Note: its value is con-
       stant  throughout the year - it does not indicate that DST
       is in force, it just selects an algorithm.)  The  daylight
       saving time algorithms defined are as follows :

        DST_NONE     /* not on dst */
        DST_USA      /* USA style dst */
        DST_AUST     /* Australian style dst */
        DST_WET      /* Western European dst */
        DST_MET      /* Middle European dst */
        DST_EET      /* Eastern European dst */
        DST_CAN      /* Canada */
        DST_GB       /* Great Britain and Eire */
        DST_RUM      /* Rumania */
        DST_TUR      /* Turkey */
        DST_AUSTALT  /* Australian style with shift in 1986 */

       Of  course it turned out that the period in which Daylight
       Saving Time is in force cannot be given by a simple  algo-
       rithm,  one per country; indeed, this period is determined
       by unpredictable political decisions. So  this  method  of
       representing  time  zones has been abandoned. Under Linux,
       in a call to settimeofday the tz_dsttime field  should  be
       zero.

So you might have to find another way to pass the dst field.

> - /dev/rtc reads and writes the RTC value directly (no timezone
>   correction)

Right, note that there is a problem in get_rtc_time for some machines, if
we want this function to be used for the /dev/rtc driver, it should not
wait for the second boundary to return, or you can force one second busy
wait loop in the kernel by reading /dev/rtc which opens the doors to
interesting attacks ;-)

The right place to put this waiting loop is in time_init, supposing that
pmac_read_rtc through cuda or pmu does not wait for a second boundary.

I'm currently working on this, but I don't plan to update the code
for all machines: only PreP, CHRP and PMAC. This should provide enough
examples to apply to the other machines (which won't compile anyway due to
deliberate global variable name changes). The maintainers of other
machines can contact me if they need any help...

> > - if the RTC is updated from other places in the kernel, read the
>   timezone recorded in xpram and apply that correction before writing
>   it to the RTC.

Ok, fine for pmac. For other platforms I shall need a way to round to the
closest half hour before writing the clock when the NTP PLL is closed
(which is basically the only kernel part which updates the clock).
This will not yet be in the next patch set.

	Regards,
	Gabriel




** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
