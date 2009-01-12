Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6499FDE15C
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 09:51:34 +1100 (EST)
Date: Tue, 13 Jan 2009 01:51:50 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1515542773.20090113015150@emcraft.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re[2]: mal_probe crash
In-Reply-To: <1231796192.22571.30.camel@pasglop>
References: <20090107154434.0c9437ef@lappy.seanm.ca>
	<1231368610.2142.27.camel@pasglop>
	<200901091549.56943.matthias.fuchs@esd-electronics.com>
	<200901091602.05730.matthias.fuchs@esd-electronics.com>
	<Pine.LNX.4.64.0901091620240.13230@vixen.sonytel.be>
	<1231536613.2142.74.camel@pasglop> <aday6xknnp2.fsf@cisco.com>
	<Pine.LNX.4.64.0901121421140.13607@vixen.sonytel.be>
	<1231796192.22571.30.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Roland Dreier <rdreier@cisco.com>, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday, January 13, 2009 you wrote:

> On Mon, 2009-01-12 at 14:37 +0100, Geert Uytterhoeven wrote:
>> On Fri, 9 Jan 2009, Roland Dreier wrote:
>> >  > Can you double check that the e1000 isn't copying the PCI resources=
 into
>> >  > a unsigned long before ioremap'ing the result, thus cropping the top
>> >  > bits ?
>> >=20
>> > as far as I can see, e1000 is using pci_ioremap_bar(), which should do
>> > the right thing as long as resource_size_t is the right type (which it
>> > looks like it is on PowerPC 44x).
>>=20
>> Indeed, the full 36-bit address is passed to __ioremap() via pci_ioremap=
_bar(),
>> as evidenced from the additional debug output below (see [1]).
>>=20
>> As I don't have any other 3.3V PCI Ethernet cards, I plugged in a 3.3V P=
CI USB
>> 2.0 card in the second PCI slot, and got a similar crash (see [2]).
>>=20
>> Are the PCI slots on the Sequoia known broken under recent Linux kernels=
? I've
>> never used them before...

> Hrm, something is indeed wrong, hard to say what tho. My canyonlands
> works fine (460EPx) and I can try a Taishan one of these days (440GX
> iirc). What is in sequoia ? I think it's a GX no ?

 Sequoia is equipped with 440EPx.

 I observe the 'mal_probe' crash on the Katmai board too (based on=20
440SPe):

PPC 4xx OCP EMAC driver, version 3.54
Unable to handle kernel paging request for data at address 0x0000003c
Faulting instruction address: 0xc01becb8
Oops: Kernel access of bad area, sig: 11 [#1]
PowerPC 44x Platform
Modules linked in:
NIP: c01becb8 LR: c0232200 CTR: c0014d68
REGS: cfe47d30 TRAP: 0300   Not tainted  (2.6.29-rc1-00014-g58a813f-dirty)
MSR: 00029000 <EE,ME,CE>  CR: 42144084  XER: 20000000
DEAR: 0000003c, ESR: 00000000
TASK =3D cfe00000[1] 'swapper' THREAD: cfe40000
GPR00: c08ce244 cfe47de0 cfe00000 00000000 c08ce22c c0158864 00000020 00029=
000=20
GPR08: 000000d0 c08ce254 000000d0 00000744 82144082 89003000 7ffe4300 00000=
000=20
GPR16: 7ffd901c 7ffde640 00000000 00000000 00000000 00000000 00000000 00000=
00d=20
GPR24: c0751e80 c0415e0c dfec1e00 c0751e64 c04161c8 00000000 dff46a00 c08ce=
200=20
NIP [c01becb8] netif_napi_add+0x1c/0x58
LR [c0232200] mal_probe+0x1cc/0x668
Call Trace:
[cfe47de0] [c0232194] mal_probe+0x160/0x668 (unreliable)
[cfe47e10] [c01abe38] of_platform_device_probe+0x5c/0x36c
[cfe47e30] [c0152c24] driver_probe_device+0xb8/0x1e8
[cfe47e50] [c0152df8] __driver_attach+0xa4/0xa8
[cfe47e70] [c0151fa8] bus_for_each_dev+0x5c/0x98
[cfe47ea0] [c0152a2c] driver_attach+0x24/0x34
[cfe47eb0] [c0152788] bus_add_driver+0x1d8/0x258
[cfe47ee0] [c0153008] driver_register+0x5c/0x158
[cfe47f00] [c01abd00] of_register_driver+0x54/0x70
[cfe47f10] [c031a160] mal_init+0x20/0x30
[cfe47f20] [c031a2c8] emac_init+0x158/0x1b4
[cfe47f60] [c0001170] do_one_initcall+0x34/0x1a0
[cfe47fd0] [c0300168] kernel_init+0x88/0xf4
[cfe47ff0] [c000d8c4] kernel_thread+0x4c/0x68
Instruction dump:
7fe3fb78 7c0803a6 bb210014 38210030 4e800020 38000000 90040024 90040020=20
90a40010 90c4000c 90840000 38040018 <8123003c> 3963003c 91240018 90840004=
=20
---[ end trace 22428c4f73106ff5 ]---


 This is with Linus's tree, head ae0..e10bb.

 The work-around from Matthias Fuchs (Jan 09, 2009) helps though.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
