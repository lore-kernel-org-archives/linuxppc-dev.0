Date: Thu, 3 Aug 2000 13:45:24 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000803111422.1301@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10008031331030.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Aug 2000, Benjamin Herrenschmidt wrote:

> Most "sane" RTCs are in UTC. On PReP and CHRP, this is not a problem,
> they use, I think, legacy RTC hardware and so you just need to set it up
> correctly in UTC.

Once upon a time, there was also NT for PowerPC, anyway using anything
else than UTC in this world is simply madness (it gives ambiguous dates
close to DST transition and is a mess in a connected world).

I'm now fighting problems with possible ambiguous timestamps around leap
seconds (only 1 every 18 months or so but they may be a killer in my
case), and trying to build a clean interface to get non ambiguous
timestamps at 23:59:60 when it happens. (See what the kernel does in this
case in kernel/timer.c about leap second processing, it simply sets the
clock back one second and sets the TIME_OOP flag but there are additional
problems if you want to get a non ambiguous timestamp in an interrupt
between the timer interrupt and the following bottom-half).

RTC in CHRP and PreP are varied and far between. I'm still waiting for the
new Motorola MVME boards in which they have increased the NVRAM size and
the RTC is at the end, another set of quirks in perspective.

> On Macs, it's slightly different. MacOS expects the RTC to be in local
> time and stores the timezone and DSL state in PRAM. I recently added
> fixup code in pmac_time.c for reading that value and correctly setting
> the kernel timezone at boot from it. Paul improved on my code by adding
> the ability to save modified timezone back to PRAM. I think there's still
> an issue with DST. There's a field for storing it in the kernel tz
> structure, but I'm not sure it's fully defined or used. I beleive this
> could be easily fixed by looking at what hwclock does, and eventually
> fixing it.

Do you have to change the clock every spring and autumn in MacOS ? Or is
it automatic ?

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
