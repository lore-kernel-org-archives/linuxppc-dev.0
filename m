Message-Id: <5.1.0.14.2.20030514093849.029e6f98@mail.ebshome.net>
Date: Wed, 14 May 2003 09:41:40 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: set_rtc_time() cleanup / normalization
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1052901153.664.15.camel@gaston>
References: <5.1.0.14.2.20030513161846.03805338@mail.ebshome.net>
 <20030512211733.B489EC6092@atlas.denx.de>
 <20030512211733.B489EC6092@atlas.denx.de>
 <5.1.0.14.2.20030513161846.03805338@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 01:32 AM 5/14/2003, Benjamin Herrenschmidt wrote:

> >
> > 2) set_rtc_time() implementation for concrete RTC device *maybe* slow or
> > just cannot
> >     be called from the interrupt context.
> >     Why just don't fix actual RTC code in each case ?
> >     It may be useful to provide some *generic* facility for such cases.
>
>It may just not be fixable cleanly. If you RTC is on a bus which requires
>some semaphoring for access (i2c does on pmac, though so far, the RTC isn't
>on i2c on these, I admit), or which is just so slow that you really do NOT
>want to block the machine in an interrupt that long ?

Well, fix was already suggested. Just use some kernel thread to actually
update RTC.

>Actually, the later is the most nasty. Also, since set_rtc_time() is used for
>both interrupt call and non-interrupt call, it cannot make assumptions about
>beeing able to schedule or not, thus causing the same latency problem when
>called via /dev/rtc, possibly a good DOS attack tool, but more simply, it
>just suck that way...

Well, maybe we need to functions, one that can be called from interrupt
context,
the other - usual one. Or we can test in_interrupt() in set_rtc_time and
act accordingly (although solution with two functions seems more clean).

Eugene.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
