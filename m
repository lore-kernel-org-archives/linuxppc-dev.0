Date: Fri, 4 Aug 2000 08:40:01 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000804125445.5797@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000804083103.650O-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Aug 2000, Benjamin Herrenschmidt wrote:

> >
> >Oh, "nowtime" is UTC + DST fix up then???  If so, that seems to be broken
> >to me
>
> AFAIK, the timezone offset in nvram includes the DST fixup.

Yes, that's right.

My assumption was "nowtime" given to kernel for pmac_set_rtc_time() is
UTC.  If that's the case, the following code in pmac_set_rtc_time()

     nowtime += RTC_OFFSET - sys_tz.tz_minuteswest * 60;

is incomplete because it does not include DST fix up and the time stored
via CUDA or PMU will be an hour off from localtime which Mac OS uses
during DST is in effect.

Is my assumption correct?

What I was saying is that if "nowtime" given to kernel is neither UTC or
localtime, the interface seems to be broken (to me).


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
