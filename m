Message-Id: <4.3.2.20010110072315.00bb5230@falcon.si.com>
Date: Wed, 10 Jan 2001 07:33:58 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Using realtime clock?
In-Reply-To: <Pine.HPX.4.10.10101101025560.1811-100000@gra-ux1.iram.es>
References: <3A5BE233.AD8C3560@serialsystem.com.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The "proper" way to handle a RTC is to read it on power up and set the
system clock based on it.  From then on, the system clock will be
correct and everyone will use the system clock efficiently and accurately.

On the x86 (PC host), the utility is "hwclock" (man hwclock).  Your
best approach is to get the source for that, modify it to read your RTC
hardware (which may be different from the PC RTC hardware, although you
might get lucky and only have to deal with endian issues).  Then add a
call to it in your startup scripts, typically in /etc/rc.d/rc.local.

gvb


At 10:30 AM 1/10/01 +0100, Gabriel Paubert wrote:

>On Wed, 10 Jan 2001, Jari Nguyen Trung Thanh wrote:
>
> >
> > Hello,
> >
> > I'm a junior, pls help me...
> > I'm using Hardhat 2.2.14, and I ported it in a custom board
> > successfully.
> > This board has its own realtime clock, pls tell me where I can
> modify in
> > the kernel
> > so that all of the time function in linux can use my realtime
> > clock...such as
> > date function...or filesystem....
>
>You don't want to use the real time clock for this. Getting the time is a
>very frequent opeartion and you don't want to do I/O on every
>gettimeofday. even if your RTC is (hopefully) in UTC, it  probably does
>not keep time in the right format for the kernel (it is much more likely
>to use a split format with year, month, day, hour, minutes and seconds in
>different registers). Many do not provide subseconds fields and run off a
>32768kHz watch cystal which provides only 30 microseconds or so
>resolution.
>
>In one word, the RTC is good to save time across reboots and in some cases
>to measure the CPU timebase rate by measuring the number timebase ticks
>between two second boundaries.
>
>
>         Regards,
>         Gabriel.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
