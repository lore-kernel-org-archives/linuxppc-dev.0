Message-ID: <027c01c2dbdc$3fbf1290$e600a8c0@udtech.net>
From: "Shen Rong" <rshen@udtech.com.cn>
To: "Kamalesh B" <kamal@tataelxsi.co.in>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <3E5650A4.39677CB0@tataelxsi.co.in> <3E565C04.9020603@embeddededge.com> <3E59BF74.8C163181@tataelxsi.co.in>
Subject: Re: Problem porting 2.4.17 linux to MPC8260ADS
Date: Mon, 24 Feb 2003 16:10:52 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: "Kamalesh B" <kamal@tataelxsi.co.in>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Monday, February 24, 2003 2:45 PM
Subject: Re: Problem porting 2.4.17 linux to MPC8260ADS


> [KAMAL]:
> All memory mapping is handled correctly.
> SDRAM is mapped to 0xC0000000 from 0x00000000
> Flash is mapped to 0xFF800000 from 0xFF800000
> Board control/status register is mapped to 0xF0100000 from 0x04500000
> IMMR is mapped to 0xF0000000 from 0x04700000
>
> Iam using BATs to do this (BAT0 and BAT1)
How do you map the above, in PPCBoot or Linux?
If in Linux, BAT0 and BAT1 is not enough to map Flash & BCSR & IMMR.
Linux will map the IMMR automatically(in m8260_setup.c), and you'd better to
set the IMMR to be physically at 0xf0000000.

> After turning on MMU, iam using the LED code to flash leds and it is
> working. Memory map of board control status register after turning on MMU
is
> 0xf0100000. Only at this point it won't.
Remember, if you manually map the BCSR in head.S before start_kernel,
you will lost this map after the MMU fully inited(after start_kernel).
That's to say
LED not flashing doesn't mean Linux crashes. In fact, programming the LED
at the original address will likely crash Linux.

>
> > > I checked the value of cur_cpu_spec[0] pointer. It was zero.
If you are sure that the cur_cpu_spec[0] is NULL, then you sould check
the setup.c:early_init().  cur_cpu_spec is set by identify_cpu(). Check to
see what value it sets. early_init() runs with the stack address set by
ppcboot.

> Is there any other way of debugging this. I have PowerTAP emulator to use
> and PPCBOOT running on the board.
It will be good to use a emulator, but I have no experience with PowerTAP.

> > As I said, there should be very minimal board specific changes
> > required.  A header file in arch/ppc/platforms, some updates to the
> > bootloader, ensure the IMMR is set to 0xf0000000 before calling the
> > kernel and you should have a console prompt.  If you want to access
> > other board control registers, they will have to be ioremapped()
> > somewhere in the kernel before you use them.
Remember what dan has said.


Shenrong


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
