Date: Tue, 8 Aug 2000 19:08:25 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Gabriel Paubert <paubert@iram.es>,
        benjamin herrenschmidt <bh40@calva.net>,
        martin costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <200008081431.PAA08490@hyperion.valhalla.net>
Message-ID: <Pine.LNX.4.10.10008081855220.13215-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >> (a) Fix up time in the kernel to emulate UTC
> >> (b) Fix up time in the kernel to emulates Local Time
> >
> > Please also think about people who really run their RTC in UTC, who don't run
> > MacOS anymore, or who simply don't have a PowerMac.
>
> It was never my intention to suggest otherwise - as (I'm sure) I'm on record
> as saying - I've used all of 'em and have no particular favourites or axe to
> grind :-)
>
> I *would* like a working solution for those of us whose machines include
> pmac and still need MacOS for some jobs.

So what about setting the kernel internal time to local time including all
fixups at least on Powermacs (using the data passed by OF or read from
NVRAM) and to UTC (or more precisely, whatever the RTC is set to) on all
those where we cannot determine UTC and DST offsets from OF or NVRAM?
Next, agree on either returning local time or UTC, at any rate a time
without accounting for GMT and DST offset, via /dev/rtc so user space
tools won't notice a difference ? I'd vote for UTC format for /dev/rtc.

We do assume the user set up the clock properly (as in: actually bothered
to set the clock to UTC and define GMT and DST offset as apparently done
by the MacOS Date&Time control panel), and set hwclock to interpret the
time as UTC. Or the user set up the clock in local time (no DST offset)
and set hwclock to interpret the time as local time.

This way

- early log stamps and later ones agree on all those machines that let the
kernel figure out GMT and DST offset, and are off by at most the DST
offset if the clock is set to local time,

- we don't need any special case handling in hwclock.

Impossible?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
