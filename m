Message-ID: <20010301202024.A7876@lx.c-side.com>
Date: Thu, 1 Mar 2001 20:20:24 -0800
From: Neil Russell <caret@c-side.com>
To: brendan.simon@bigpond.com,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: Dan Malek <dmalek@jlc.net>
Subject: Re: linuxppc-embedded: mpc8260 bus frequency calculations
References: <3A9EFA26.8030805@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A9EFA26.8030805@bigpond.com>; from Brendan J Simon on Fri, Mar 02, 2001 at 12:40:54PM +1100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If bi_busfreq is set to 66.0 and the crystal is 66.6666, then the system
clock should appear to go too fast.  Sounds like what you have is the other
way around.  I've seen plenty of crystals that are running at 66.0 MHz.
Do you have one of these?

The system time is set once at boot up from the RTC.  If the system
gains/looses time by some fraction of a percent, then this may well
be just error in the crystal.  Most systems I've seen have some error.
The program "adjtimex" exists to correct this.


Neil.


On Fri, Mar 02, 2001 at 12:40:54PM +1100, Brendan J Simon wrote:
>
> I've come accross a problem where our custom embedded 8260 board is
> losing time.  I've tracked it down to the bi_busfreq value being set to
> 66 instead of the true value of
> 66.6666666666666666666666666666666666666.  One solution is to have the
> board_info fields in units of Hz instead of MHz.  I could then set the
> bi_busfreq value to 66666667 for much better accuracy.
>
> Another solution might be to regularly read the real time clock.  Does
> linux do this normally or does it just read the RTC once at boot up and
> then just rely on it's internal timers for the system time.  I can't see
> how this can be very accurate.
>
> Thanks,
> Brendan Simon.
>
>

--
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
