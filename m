Date: Wed, 10 Jan 2001 10:30:57 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Jari Nguyen Trung Thanh <jari.nguyen@serialsystem.com.sg>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using realtime clock?
In-Reply-To: <3A5BE233.AD8C3560@serialsystem.com.sg>
Message-ID: <Pine.HPX.4.10.10101101025560.1811-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 10 Jan 2001, Jari Nguyen Trung Thanh wrote:

>
> Hello,
>
> I'm a junior, pls help me...
> I'm using Hardhat 2.2.14, and I ported it in a custom board
> successfully.
> This board has its own realtime clock, pls tell me where I can modify in
> the kernel
> so that all of the time function in linux can use my realtime
> clock...such as
> date function...or filesystem....

You don't want to use the real time clock for this. Getting the time is a
very frequent opeartion and you don't want to do I/O on every
gettimeofday. even if your RTC is (hopefully) in UTC, it  probably does
not keep time in the right format for the kernel (it is much more likely
to use a split format with year, month, day, hour, minutes and seconds in
different registers). Many do not provide subseconds fields and run off a
32768kHz watch cystal which provides only 30 microseconds or so
resolution.

In one word, the RTC is good to save time across reboots and in some cases
to measure the CPU timebase rate by measuring the number timebase ticks
between two second boundaries.


	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
