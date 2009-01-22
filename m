Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 0E756DDF0D
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 13:15:31 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LPp6M-0006QL-Mo
	for linuxppc-dev@ozlabs.org; Wed, 21 Jan 2009 18:15:26 -0800
Message-ID: <21593750.post@talk.nabble.com>
Date: Wed, 21 Jan 2009 18:15:26 -0800 (PST)
From: Daniel Ng99 <daniel_ng11@lycos.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
In-Reply-To: <20090120163155.GA8978@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>
	<496F318D.6010302@denx.de>
	<8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
	<496F4760.1010007@denx.de>
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
	<8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>
	<4970CBA9.60809@freescale.com>
	<8cad0aa0901200256n6122d17eh90f56e9cb8cae775@mail.gmail.com>
	<20090120163155.GA8978@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I am using my own 8272-based board (it is similar to the 8272 ADS) with Lin=
ux
2.6.27 and u-boot-2009-Jan-rc1.


Scott Wood-2 wrote:
>=20
> On Tue, Jan 20, 2009 at 11:56:58AM +0100, Jean-Michel Hautbois wrote:
> That looks like something is failing when the real (as opposed to early
> debug) serial driver starts.  Try commenting out the call to cpm_setbrg
> in drivers/serial/cpm_uart/cpm_uart_cpm2.h; if that makes a difference,
> there's something wrong with the brg node in the device tree.
>=20

This works- I can see the rest of the debug messages and it gets to booting
the rootfs.

So the brg node looks like this-

      brg@119f0 {
        compatible =3D "fsl,mpc8272-brg",
                     "fsl,cpm2-brg";
        reg =3D <0x119f0 0x10 0x115f0 0x10>;
        clock-frequency =3D <0>;

But aren't the BRG registers 32 bits, so shouldn't we use?:

       reg =3D <0x119f0 0x20 0x115f0 0x20>;

-either way, changing these values doesn't seem to make a difference in my
board's behaviour. Why?

Regarding the following line in the serial@11a00 node:

fsl,cpm-brg =3D <1>;

-If I change the above number to anything other than 1 (even nonsense like
'99') then it also seems to work. Why? Does this mean the clock for BRG1 is
set incorrectly? Where do I set this?

Adding 'clock-frequency =3D <0>;' to the brg node doesn't seem to make a
difference to my board's behaviour.

What is actually happening here? Is it freezing up in the switch over from
the early boot console driver to the proper linux console driver? Which of
these drivers is cpm_uart_cpm2.h for? Why does it still work when we commen=
t
out the call to 'set_brg()'?

Here's the relevant part of the 'working' boot sequence. Notice there are
still some funny characters when the CPM serial driver kicks in (near the
bottom). Should this be of concern?-

time_init: decrementer frequency =3D 16.500000 MHz
time_init: processor frequency   =3D 330.000000 MHz
clocksource: timebase mult[f26c9b2] shift[22] registered
clockevent: decrementer mult[439] shift[16] cpu[0]
Console: colour dummy device 80x25
cpm_uart_init_port()
OF: ** translation for device /soc@f0000000/cpm@119c0/serial@11a00 **
OF: bus is default (na=3D1, ns=3D1) on /soc@f0000000/cpm@119c0
OF: translating address: 00011a00
OF: parent bus is default (na=3D1, ns=3D1) on /soc@f0000000
OF: no ranges, 1:1 translation
OF: parent translation for: 00000000
OF: with offset: 11a00
OF: one level translation: 00011a00
OF: parent bus is default (na=3D1, ns=3D1) on /
OF: walking ranges...
OF: default map, cp=3D0, s=3D53000, da=3D11a00
OF: parent translation for: f0000000
OF: with offset: 11a00
OF: one level translation: f0011a00
OF: reached root node
OF: ** translation for device /soc@f0000000/cpm@119c0/serial@11a00 **
OF: bus is default (na=3D1, ns=3D1) on /soc@f0000000/cpm@119c0
OF: translating address: 00008000
OF: parent bus is default (na=3D1, ns=3D1) on /soc@f0000000
OF: no ranges, 1:1 translation
OF: parent translation for: 00000000
OF: with offset: 8000
OF: one level translation: 00008000
OF: parent bus is default (na=3D1, ns=3D1) on /
OF: walking ranges...
OF: default map, cp=3D0, s=3D53000, da=3D8000
OF: parent translation for: f0000000
OF: with offset: 8000
OF: one level translation: f0008000
OF: reached root node
of_irq_map_one: dev=3D/soc@f0000000/cpm@119c0/serial@11a00, index=3D0
 intsize=3D2 intlen=3D2
of_irq_map_raw:
par=3D/soc@f0000000/interrupt-controller@10c00,intspec=3D[0x00000028 0x
00000008...],ointsize=3D2
of_irq_map_raw: ipar=3D/soc@f0000000/interrupt-controller@10c00, size=3D2
 -> addrsize=3D1
 -> got it !
irq: irq_create_mapping(0xc02d1320, 0x28)
irq: -> using host @c02d1320
irq: -> obtained virq 40
cpm2_pic_host_map(40, 0x28)
of_get_gpio exited with status -2
of_get_gpio exited with status -2
of_get_gpio exited with status -2
of_get_gpio exited with status -2
of_get_gpio exited with status -2
of_get_gpio exited with status -2
cpm_uart_request_port()
CPM uart[=C3=BEDentry cache hash table entries: 4096 (order: 2, 16384 bytes=
)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 29840k/32768k available (2372k kernel code, 2928k reserved, 100k
data, 126k
 bss, 116k init)
SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
Calibrating delay loop... 32.89 BogoMIPS (lpj=3D65792)
Mount-cache hash table entries: 512

Cheers,
Daniel









=20



--=20
View this message in context: http://www.nabble.com/-MPC8272ADS-Cannot-star=
t-my-Linux-Kernel-tp21476017p21593750.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
