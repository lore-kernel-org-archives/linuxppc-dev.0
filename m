Message-ID: <3E59BF74.8C163181@tataelxsi.co.in>
Date: Mon, 24 Feb 2003 12:15:08 +0530
From: "Kamalesh B" <kamal@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem porting 2.4.17 linux to MPC8260ADS
References: <3E5650A4.39677CB0@tataelxsi.co.in> <3E565C04.9020603@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello,

I have done all the memory mapping stuffs according to the board. Please see
my inputs to your answers.

Dan Malek wrote:

> Kamalesh B wrote:
>
> > Iam porting Linux 2.4.17 on MPC8260ADS. I had already working
> > Linux-2.4.1 version on MPC8260ADS board.
>
> There should be very minimal changes required to support the 8260ADS,
> just a few memory mapping initializations.  Everything else is generic
> to all of the other 8260 boards that are supported.

[KAMAL]:
All memory mapping is handled correctly.
SDRAM is mapped to 0xC0000000 from 0x00000000
Flash is mapped to 0xFF800000 from 0xFF800000
Board control/status register is mapped to 0xF0100000 from 0x04500000
IMMR is mapped to 0xF0000000 from 0x04700000

Iam using BATs to do this (BAT0 and BAT1)

> > I had rather taken an tedious process of identifying the problem by
> > glowing LEDs present on the board. I have identify the location of the
> > problem.
>
> Well....think about this for a moment......In order to flash the LEDs
> you need access to the board control register.  Once you initialize
> the MMU for Linux, these mappings are gone and you need to set them
> up again within the Linux memory map.  There are several memory map
> transistions during the start up of Linux.  Very early in the start
> up code it enables the MMU and only maps a small portion of real
> memory.  You won't be able to access LEDs after this point.

[KAMAL]:
After turning on MMU, iam using the LED code to flash leds and it is
working. Memory map of board control status register after turning on MMU is
0xf0100000. Only at this point it won't.

> > I checked the value of cur_cpu_spec[0] pointer. It was zero.
>
> How did you check this?  The processor is running with caches enabled,
> this pointer is initialized during the start up.  If you dumped out
> main memory after the crash, I doubt it was written out of the cache.

[KAMAL]:
Led flashing code looks something like this
--- Code begins ---
lis r20, 0xf010
lis r21, 0
stw r21, 0(r20)
--- Code ends ---

I checked the value of cur_cpu_spec[0] pointer to be zero by putting a
condition for cur_cpu_spec[0] pointer and glow the led if it is true.

> > I also tried commenting this line as this was not there in 2.4.1
> > version. Here control went till this point in "head.S" code
>
> Not a good idea.  There are subtle changes happening all of the time,
> and the difference between 2.4.1 and 2.4.17 is quite a bit.
>
> I suspect your access to the LEDs is crashing due to memory mapping
> changes, and taking you down the wrong path.

[KAMAL]:
Is there any other way of debugging this. I have PowerTAP emulator to use
and PPCBOOT running on the board.

> As I said, there should be very minimal board specific changes
> required.  A header file in arch/ppc/platforms, some updates to the
> bootloader, ensure the IMMR is set to 0xf0000000 before calling the
> kernel and you should have a console prompt.  If you want to access
> other board control registers, they will have to be ioremapped()
> somewhere in the kernel before you use them.

[KAMAL]:
Even i was under the impression that there will be very minimal BSP changes
required until i hit upon this problem.
IMMR is located at 0xf0000000 before calling the kernel.

>         -- Dan

Thanks in advance,
with rgds,
kamal


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
