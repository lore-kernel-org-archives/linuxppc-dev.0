Subject: Re: set_rtc_time() cleanup / normalization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <5.1.0.14.2.20030513161846.03805338@mail.ebshome.net>
References: <20030512211733.B489EC6092@atlas.denx.de>
	 <20030512211733.B489EC6092@atlas.denx.de>
	 <5.1.0.14.2.20030513161846.03805338@mail.ebshome.net>
Content-Type: text/plain
Message-Id: <1052901153.664.15.camel@gaston>
Mime-Version: 1.0
Date: 14 May 2003 10:32:33 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> 2) set_rtc_time() implementation for concrete RTC device *maybe* slow or
> just cannot
>     be called from the interrupt context.
>     Why just don't fix actual RTC code in each case ?
>     It may be useful to provide some *generic* facility for such cases.

It may just not be fixable cleanly. If you RTC is on a bus which requires
some semaphoring for access (i2c does on pmac, though so far, the RTC isn't
on i2c on these, I admit), or which is just so slow that you really do NOT
want to block the machine in an interrupt that long ?

Actually, the later is the most nasty. Also, since set_rtc_time() is used for
both interrupt call and non-interrupt call, it cannot make assumptions about
beeing able to schedule or not, thus causing the same latency problem when
called via /dev/rtc, possibly a good DOS attack tool, but more simply, it
just suck that way...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
