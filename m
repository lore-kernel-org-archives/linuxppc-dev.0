Message-ID: <3A14FE6A.A8BEA01F@opersys.com>
From: Karim Yaghmour <karym@opersys.com>
MIME-Version: 1.0
To: minyard@acm.org
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Make CPU usage and virtual itimers accurate
References: <m2d7fve255.fsf@c469597-a.grlnd1.tx.home.com>
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Nov 2000 04:41:31 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Corey,

I've taken a look at your patch and it seems interesting indeed. There
are 2 ways to the problem you solve, exact accounting and statistical
accounting. The later is flawed as used currently in the kernel, but
it can be done otherwise. The following paper discusses a way to
randomize sampling which gives a higher precision to the results:
Steve McCanne and Chris Torek.
  A Randomized Sampling Clock for CPU Utilization Estimation and Code Profiling.
  In  USENIX Conference Proceedings, San Diego, CA, USENIX.
  January, 1993.
  <ftp://ftp.ee.lbl.gov/papers/statclk-usenix93.ps.Z>.

The problem with exact accounting is that the overhead incurred is
proportional to the number of system calls, interrupts and traps. With
the statistical approach, the overhead is fixed.

That said, I had raised this issue on the kernel development mailing
list a while ago because the Linux Trace Toolkit I've written would be
an excellent basis for implementing exact accounting since all the necessary
hooks are already inserted. That said, my suggestion received a mild
reception on the part of some who didn't think this was the way
to go. Nonetheless, I believe that exact accounting should be an
option, as you've implemented it.

If you are interested, I'd really like to integrate your exact accounting
code into LTT. All the hooks you need are already there for the i386 and
the PowerPC. Therefore, you wouldn't need to deal with the architectural
details, all you'd need would be to manage the time-accounting variables.

You can find LTT at: http://www.opersys.com/LTT

Besides the accounting issues, if you're trying to understand the exact behavior
of your system, it should be fairly useful.

Tell me what you think about my suggestion.

Best regards

Karim

Corey Minyard wrote:
>
> I have patches written to improve the accuracy of CPU measurement
> (getrusage()) and virtual itimers.  This lets the amount of CPU used
> by a process be measured fairly accurately.  The patches are on my web
> page: http://members.home.com/minyard
>
> This is if anyone is interested.  I don't know if anyone has any
> interest in putting these into the main kernel.  The patches are only
> turned on if the configuration option is set on, so it shouldn't
> affect anything otherwise.
>
> Patches are against 2.4.0-test10 and 2.2.16.  I have not tested the
> 2.2.16 patch yet.
>
> Some text from the web page:
>
> The current method of measure CPU usage of a process in Linux is crude
> at best.  For most applications, that is fine, but for some it is
> critical to know how much CPU you have used.  Also, using setitimer's
> viritual timers have a rather crude measurement mechanism, if the
> timer tick hits when the task is running then an entire tick is added
> to the processes time.  It's actually possible to use no CPU and still
> time out.  CPU measurement is done the same way.
>
> The following patch fixes all that.  They add a kernel configuration
> parameter that allows high-resolution (microsecond) timing of task CPU
> usage.  There are a few caveats:
>
>  * It only works on PowerPC right now.  If someone wants to do an
>    Intel port (or another platform port), feel free to send me the
>    patches.
>
>  * It costs extra time in interrupts, exceptions, and system calls.
>    There is no real way around this, to accurately count system time
>    verses user time you have to know when the kernel is running verses
>    the user process.  (If you don't enable the configuration option,
>    there is no affect from the patch)
>
>  * There is some wierd interaction with gettimeofday.  If I have a
>    loop calling gettimeofday, the system doesn't seem to keep time
>    properly.  I haven't figured this out yet.  It may not be this
>    patch, either.  As long as you don't use gettimeofday a few
>    thousand times a second, though, you should be ok.
>
>  * The patches are new and, of course, experimental.  They may crash
>    your system and destroy all your data.
>
>  * I have not tested the 2.2.16 patch at all, I have just gotten it to
>    compile.
>
> Corey
>

--
===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
