From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 14 May 2003 17:50:36 +0200
To: Eugene Surovegin <ebs@ebshome.net>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: set_rtc_time() cleanup / normalization
Message-ID: <20030514155036.GD9430@iram.es>
References: <20030512211733.B489EC6092@atlas.denx.de> <20030512211733.B489EC6092@atlas.denx.de> <5.1.0.14.2.20030513161846.03805338@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20030513161846.03805338@mail.ebshome.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, May 13, 2003 at 04:33:50PM -0700, Eugene Surovegin wrote:
>
> At 04:05 PM 5/13/2003, Paul Mackerras wrote:
>
> >Wolfgang Denk writes:
> >
> >> I would like to find out if there is some consensus about the use  of
> >> set_rtc_time() in the timer interrupt handler.
> >
> >The consensus so far seems to be that we shouldn't call set_rtc_time
> >in the timer interrupt handler.  Is anyone willing to speak up with a
> >reason why we should keep it?
>
> Because there are systems which rely on this behavior?
> For example, all our embedded systems use this feature.
>
> Wolfgang said that "... many embedded systems run in a configuration
> where they use a high precision RTC chip...".
>
> All embedded systems I saw used cheap RTC parts with poor accuracy.
>
> I think we mix two different issues here:
>
> 1) call set_rtc_time() from timer interrupt every 11 min if clock is
> synched (e.g. by NTP)
>    I don't see any problems with this.
>
> 2) set_rtc_time() implementation for concrete RTC device *maybe* slow or
> just cannot
>    be called from the interrupt context.
>    Why just don't fix actual RTC code in each case ?
>    It may be useful to provide some *generic* facility for such cases.

Absolutely agreed. I believe that this is set_rtc_time and get_rtc_time
that should be fixed. I have BTW a small bugfix to submit.

I believe that in the end we shall have two read functions:
- one __init__ for boot time which should fill two global variables:
a second value and the value of the timebase at the second transition.
There performance is irrelevant.
- one to read it on the fly while the kernel is running,

I would not mind if the hctosys and systohc functions were accesible
through adjtimex BTW. This would make the rtc driver unnecessary for
most cases and on my machines it does not work properly in any cases
since they are nonstandard PreP, the interrupt pin of the RTC is
not wired at all.

	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
