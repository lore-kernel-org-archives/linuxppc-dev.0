From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 14 May 2003 17:57:11 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Eugene Surovegin <ebs@ebshome.net>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: set_rtc_time() cleanup / normalization
Message-ID: <20030514155711.GE9430@iram.es>
References: <20030512211733.B489EC6092@atlas.denx.de> <20030512211733.B489EC6092@atlas.denx.de> <5.1.0.14.2.20030513161846.03805338@mail.ebshome.net> <1052901153.664.15.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1052901153.664.15.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 14, 2003 at 10:32:33AM +0200, Benjamin Herrenschmidt wrote:
>
> >
> > 2) set_rtc_time() implementation for concrete RTC device *maybe* slow or
> > just cannot
> >     be called from the interrupt context.
> >     Why just don't fix actual RTC code in each case ?
> >     It may be useful to provide some *generic* facility for such cases.
>
> It may just not be fixable cleanly. If you RTC is on a bus which requires
> some semaphoring for access (i2c does on pmac, though so far, the RTC isn't
> on i2c on these, I admit), or which is just so slow that you really do NOT
> want to block the machine in an interrupt that long ?
>
> Actually, the later is the most nasty. Also, since set_rtc_time() is used for
> both interrupt call and non-interrupt call, it cannot make assumptions about
> beeing able to schedule or not, thus causing the same latency problem when
> called via /dev/rtc, possibly a good DOS attack tool, but more simply, it
> just suck that way...

Well, on all these aspects, I am strongly on Eugene's side. I believe
the implementation has to be refined, but that the functionality cannot
be removed.

It seems that we are only two, ok. In any case, it will stay that way
in my source trees. I have reasonably fast RTC (15 microseconds to write
them) so it's never a big issue of course.

I also suspect that people strongly object to a CONFIG option.

	Gabriel.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
