Message-ID: <3A9F225D.7040807@bigpond.com>
Date: Fri, 02 Mar 2001 15:32:29 +1100
From: Brendan J Simon <brendan.simon@bigpond.com>
Reply-To: brendan.simon@bigpond.com
MIME-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: mpc8260 bus frequency calculations
References: <3A9EFA26.8030805@bigpond.com> <20010301202024.A7876@lx.c-side.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I agree that most systems have some error, but about 1 second every
minute is not good :(
This error can be substantially reduced by more accurately specifying
the clock frequency.  We have a custom board with a 66.6666MHz
oscillator module on it.  There is no way to specify this accurately
with the current interpretation of the board_info structure.  The best
one can do is specify 66,000,000 or 67,000,000 Hz :(

I would like to see the board_info structure members be interpreted as
Hz rather than MHz.  I think this must have been the case earlier
because I saw some code that was commented out which looked something
like "/*** / 1000000 ***/".  ie. the Hz value was being divided by
1000000 to display MHz.  Now someone (Dan ?) changed the interpretation
of the board_info structure for a reason, and I'm wondering if I will
break anything if I change the meaning to Hz.  I'm sure there would be
some easy work arounds by just dividing by 1000000 where necessary.

Brendan.



Brendan.

Neil Russell wrote:

> If bi_busfreq is set to 66.0 and the crystal is 66.6666, then the system
> clock should appear to go too fast.  Sounds like what you have is the other
> way around.  I've seen plenty of crystals that are running at 66.0 MHz.
> Do you have one of these?
>
> The system time is set once at boot up from the RTC.  If the system
> gains/looses time by some fraction of a percent, then this may well
> be just error in the crystal.  Most systems I've seen have some error.
> The program "adjtimex" exists to correct this.
>
>
> Neil.
>
>
> On Fri, Mar 02, 2001 at 12:40:54PM +1100, Brendan J Simon wrote:
>
>> I've come accross a problem where our custom embedded 8260 board is
>> losing time.  I've tracked it down to the bi_busfreq value being set to
>> 66 instead of the true value of
>> 66.6666666666666666666666666666666666666.  One solution is to have the
>> board_info fields in units of Hz instead of MHz.  I could then set the
>> bi_busfreq value to 66666667 for much better accuracy.
>>
>> Another solution might be to regularly read the real time clock.  Does
>> linux do this normally or does it just read the RTC once at boot up and
>> then just rely on it's internal timers for the system time.  I can't see
>> how this can be very accurate.
>>
>> Thanks,
>> Brendan Simon.
>>
>>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
