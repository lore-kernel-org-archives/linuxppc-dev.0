Date: Fri, 10 May 2002 16:27:04 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: Troy Benjegerdes <hozer@drgw.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-embedded@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
Subject: RE: Bogomips and loops_per_jiffy
In-Reply-To: <F1BED55F35F4D3118C0F00E0295CFF4DFFA00A@mail.mediatrix.com>
Message-ID: <Pine.LNX.4.33.0205101615390.23021-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 10 May 2002, Jean-Denis Boyer wrote:

>
> Grabiel,
>
> > I'm afraid that this is a symptom of lost timekeeping
> > after reading the RTC and that you simply cure the symptom.
>
> My platform uses an 8260 processor, and AFAIK there is no RTC. The function
> __USE_RTC() returns 0.

Yes the RTC is a 601 specific thing which makes everything more complex.

>
> > Better set the TB to a large value to force the problem and
> > see if you can reproduce it.
>
> That's exactly the way I reproduced it!... and why I initially proposed the
> fix set_tb(0,0).
>
> If you add a set_tb(0, 0x90000000) at the beginning of time_init, you will
> fall right into it.
>
> The problem occurs only when the TBL is initially over 0x80000000. Then,
> when compared against jiffy_stamp (unsigned, initially 0), and transformed
> into a signed integer, it returns a negative delta, causing the while loop
> in the time_interrupt to be left, and the decrementer set to a very high
> value.

I don't yet understand this explanation. Jiffy stamp is initialized in
time_init, in the line:

 last_jiffy_stamp(0) = tb_last_stamp = stamp;

and then jiffy_stamp is simply a temporary copy of last_jiffy_stamp in
the interrupt handler.

>
> Yes, pratically, it will never happen at run time. Anyway, the decrementer
> and the time base count at the same rate, so they share the same
> constraints.
>
> At boot time, however, it is platform specific... usually, after a cold
> boot, the TB is reset to 0. But after a warm reset, this is not necessarily
> true. Does the boot load resets the time base? The boot loader can also take
> a long time to get the kernel in place and jump to it, for example after a
> heavy hardware testing (RAM and peripherals), or an inefficient TFTP
> download... Well, any weird reason you can imagine that slows down the boot
> time only by a few minutes. ;-)

I almost only use machines which boot via tftp and take quite a long time
to boot, yet I have never seen this.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
