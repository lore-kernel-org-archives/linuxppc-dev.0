Message-ID: <3BF15F55.AABB383C@mvista.com>
Date: Tue, 13 Nov 2001 09:58:45 -0800
From: Jun Sun <jsun@mvista.com>
MIME-Version: 1.0
To: Richard Zidlicky <rz@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
References: <Pine.GSO.4.21.0111122055010.10720-100000@mullein.sonytel.be> <3BF0371F.8040575B@linux-m68k.org> <20011113144240.B669@linux-m68k.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Richard Zidlicky wrote:

> Btw the interrupt need not to be hardware, for the Q40 I test
> a rtc register once per jiffie and generate a "soft interrupt".
> It could be done generic at least for m68k.
>

I have written an experiemntal ptimer driver to do just this and potential
more.  Such a device is useful for real-time programming (e.g., when you try
to implement a periodic user task).

See http://linux.junsun.net/realtime-linux/preemption-test

The driver is architecture independent (i.e., linux-common code)

Due to the different programming needs behind periodic timers (or user-level
timer) and RTC operations, my vote for future work is to leave them as two
separate drivers.  To me, RTC is really just to read/write RTC clock.

Jun

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
