Message-ID: <001501c357e6$2f641a90$212d4cdc@smkim>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "Richard Danter" <richard.danter@windriver.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <3F2949D3.8020106@windriver.com>
Subject: Re: 750/107 CHRP question
Date: Fri, 1 Aug 2003 13:34:24 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Some serial port driver doesn't ioremap and directly use the physical address for accessing device.
This doesn't causes any problem when the base address is above 0x80000000.

There are two solutions for this
Solution 1. Change the serial port base address above 0x80000000, such as 0xff000000.

Solution 2. Ioremap to get the base address of the serial port and use the address.
ie. base = ioremap(0x7c000000,0x1000);

I think the solution 2 is more appropriate because changing hardware requires a lot of money.

Regards,
Sangmoon Kim

----- Original Message -----
From: "Richard Danter" <richard.danter@windriver.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, August 01, 2003 1:54 AM
Subject: 750/107 CHRP question


>
> Hi All,
>
> Sorry if this is a bit of a newbie question....
>
> I am trying to port a 2.4.x kernel to a PPC750 board with a 107
> controller. The board has a serial port connected to one of the ROM
> select lines (at 0x7C000000) and I would like to use this as my console
> port.
>
> So far I can boot the board and see (via the serial port) the kernel
> load addresses etc, and the kernel gets decompressed and starts to run.
> This is all fine as the MMU is off at this point. However, when the
> serial_console_setup() code starts trying to configure the serial port
> again, I get a kernel panic as I am accessing an invalid mem space (MMU
> now on!).
>
> How do I map this correctly???
>
> My build is based on the sandpoint but with all the init stuff for
> devices, such as the RTC, removed. So I have the "standard" mapping in
> the MMU_init code.
>
> Many thanks
> Rich
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
