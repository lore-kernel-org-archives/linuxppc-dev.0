Message-ID: <3A9FB34D.AAA2EB2C@snmc.com>
Date: Fri, 02 Mar 2001 08:50:53 -0600
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: brendan.simon@bigpond.com
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: mpc8260 bus frequency calculations
References: <3A9EFA26.8030805@bigpond.com> <20010301202024.A7876@lx.c-side.com> <3A9F225D.7040807@bigpond.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan,

We did exactly as you suggest here in the QSLinux kernel.  We modified
the board_info structure to specify the input clock frequency in Hz
rather than in MHz.  Refer to the code in ftp://qslinux.org.

I don't think Dan changed the code (correct me if I'm wrong).  I began
using the 2.2.5 kernel about 2 years ago, and it was specified in MHz
way back then.  I think the original code was probably written by Cort.

You could easily make the change on whatever kernel you are using
(MonteVista?).  The board descriptor structure is meant to be somewhat
flexible.  You just need to do a grep to find out where else the
variable is used.  You will probably find that it is used in the
ethernet and console serial drivers, and in the initialization of the
internal count-down clock.  The board_info structure is not used down in
the internals of the Linux kernel.  It is "board specific", and so it
only applies to a few board specific device drivers.

Regards,
Daris


--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

Brendan J Simon wrote:
>
> I agree that most systems have some error, but about 1 second every
> minute is not good :(
> This error can be substantially reduced by more accurately specifying
> the clock frequency.  We have a custom board with a 66.6666MHz
> oscillator module on it.  There is no way to specify this accurately
> with the current interpretation of the board_info structure.  The best
> one can do is specify 66,000,000 or 67,000,000 Hz :(
>
> I would like to see the board_info structure members be interpreted as
> Hz rather than MHz.  I think this must have been the case earlier
> because I saw some code that was commented out which looked something
> like "/*** / 1000000 ***/".  ie. the Hz value was being divided by
> 1000000 to display MHz.  Now someone (Dan ?) changed the interpretation
> of the board_info structure for a reason, and I'm wondering if I will
> break anything if I change the meaning to Hz.  I'm sure there would be
> some easy work arounds by just dividing by 1000000 where necessary.
>
> Brendan.
>
> Brendan.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
