Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 15 May 2003 20:04:28 +0200
To: Dan Malek <dan@embeddededge.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: set_rtc_time() cleanup / normalization
Message-ID: <20030515180427.GB20958@iram.es>
References: <20030512211733.B489EC6092@atlas.denx.de> <16065.31312.163813.582334@argo.ozlabs.ibm.com> <20030514154310.GC9430@iram.es> <3EC26EAD.8080200@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3EC26EAD.8080200@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 14, 2003 at 12:28:29PM -0400, Dan Malek wrote:
>
> Gabriel Paubert wrote:
>
> >Ask on the ntp lists first, I bet you'll upset a lot of people
> >if you suggest it.
>
> I'll bet no one is using it on a system that has an unpredictable
> latency, interrupt generating, i2c RTC, either. :-)

Never take bets with NTP :-) It is one of the most portable (and actually
ported) protocols and set of programs in existence.

> The solution is to do like other architectures and allow (as Tom
> suggested) a selectable rtc update function.  Although I may use
> a particular RTC driver, I may not want the update function that
> comes along with it.  All we need is an indirect function pointer
> to the get/set functions that is initialized by the board set
> up functions.  By default they should be null functions, if you
> want something else, put a pointer there.

And to go against the existing documentation of hwclock(8) so that
the behaviour depends on the architecture, the exact RTC chip model,
the phase of the moon:

"The Linux kernel has a mode wherein it copies the System Time to the
Hardware Clock every 11 minutes.  This is a good mode to use when you are
using  something  sophisticated  like  ntp to keep your System Time
synchronized. (ntp is a way to keep your System Time synchronized either
to a time server somewhere on the network or to a radio clock hooked up
to  your system.   See  RFC 1305)."

I personally believe that explicitly implementing something which goes
against the existing documentation is one of the worst things that
can happen, espcecially since (after a few years of experience with
the linux hackers) I don't expect anybody to send patches to update
the documentation to reflect this fact. So we are heading towards
justified user complaints (it ain't working as documented).

> The fact is the current rtc update functions are not suitable for
> embedded boards that have to meet latency guarantees.  They simply
> add overhead, often in a bad way, even if implemented correctly.

There are clean solutions to this. I'm ready to code them if you don't
believe me (but I'll need the docs or at least the references for the
most esoteric chips). I'm away for 3 weeks starting next week (including
some holidays and I won't have net access most of the time), but I shall
try to prepare something on my laptop while off-line.

> Installing any kind of real-time enhancement (like RTLinux or RTAI)
> will cause a failure of the rtc update model because the update thread of
> control can be easily preempted.

Doesn't matter if the clock is as slow as it I imagine for i2c. You
obviously can't expect an absolute precision of the clock much better
than its access time. Most (all) RTC clocks run off a 32768Hz clock
(abouy 31us cycle time) and often the first divider stages can't even be
reset, so the ultimate precision you can expect is of the order of a few
hundred microseconds (I don't remember the exact figures, need to
check the docs).

And even for the RTlinux, I am thinking of solutions. Don't tell me
that you can't prevent preemption for about the time of a single bus
access.

> The solution is easy, you can find examples in other architectures,
> and we don't have to argue about it.

Deliberately implementing something which departs from the existing
documentation or makes the subtle details of behaviour dependant
on the architecture or RTC chip you have? I'd rather avoid that
at all costs.

	Regards,
	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
