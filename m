Return-Path: <Clive.Jenkins@xerox.com>
Received: from wbmler3.mail.xerox.com (wbmler3.mail.xerox.com [13.13.138.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wbmler3.mail.xerox.com",
	Issuer "wbmler3.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 79A96DDE1B
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 23:58:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Trace
Date: Mon, 1 Sep 2008 14:58:09 +0100
Message-ID: <929D3CED81F34E43887A393170D66FB926B41A@GBRSUN01MS002.eu.xerox.net>
In-Reply-To: <929D3CED81F34E43887A393170D66FB926B40F@GBRSUN01MS002.eu.xerox.net>
References: <319b0ac50809010216jac3ae30r9260699abde6535@mail.gmail.com><929D3CED81F34E43887A393170D66FB926B259@GBRSUN01MS002.eu.xerox.net><319b0ac50809010525w7451ef92m5aaf6fd5f5a8958e@mail.gmail.com>
	<929D3CED81F34E43887A393170D66FB926B40F@GBRSUN01MS002.eu.xerox.net>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>,
	=?iso-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  Why can't tty have value 0x57555541 ?
To answer my own question, because it ends in 1 and is not word-aligned!

-----Original Message-----
From: linuxppc-dev-bounces+clive.jenkins=3Dxerox.com@ozlabs.org =
[mailto:linuxppc-dev-bounces+clive.jenkins=3Dxerox.com@ozlabs.org] On =
Behalf Of Jenkins, Clive
Sent: 01 September 2008 14:54
To: S=E9bastien Chr=E9tien
Cc: linuxppc-dev@ozlabs.org
Subject: RE: Trace

I'm not sure that is a failure. Why can't tty have value 0x57555541 ?

I think the code in tty_io.c initialises driver->ttys and you shouldn't =
need to do anything in your driver.
=20
If you are not already aware, a useful way to explore kernel code is to =
use LXR:
http://lxr.linux.no/linux+v2.6.26/include/linux/tty_driver.h#L212
This may help you understand the tty code.
=20
Good luck!
=20
________________________________

From: S=E9bastien Chr=E9tien =
[mailto:sebastien.chretien.enseirb@gmail.com]=20
Sent: 01 September 2008 13:25
To: Jenkins, Clive
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Trace


I found where is the failure with your advices=20
In init_dev (tty_io.c), init_dev calls "tty =3D driver->ttys[idx]"
after this call, tty value is : tty =3D 0x57555541

Have I to initialize driver->ttys in my driver. If yes, how have I to =
Initialize this ?

The driver tty is used in order to have a console on my serial port.
Thanks for your help



2008/9/1, Jenkins, Clive <Clive.Jenkins@xerox.com>:=20

	The instruction that caused the fault is at this address:
=09
	> NIP [c0110ddc] init_dev+0x2bc/0x584
=09
=09
	The hex value of the instruction is also highlighted between <> here:
=09
	> Instruction dump:
	> 7d808120 4e800020 7c832378 4bfa9ea9 7c7f1b79 418201f0 a81e0062 =
2f800001
	> 409efd98 83ff00d0 2c1f0000 4182fd90 <801f00b8> 70090080 408201b0 =
801e0060
=09
=09
	Disassemble your kernel and look at offset 0x2BC relative to the label =
init_dev
=09
	________________________________
=09
	From: linuxppc-dev-bounces+clive.jenkins=3Dxerox.com@ozlabs.org =
[mailto:linuxppc-dev-bounces+clive.jenkins =
<mailto:linuxppc-dev-bounces%2Bclive.jenkins> =3Dxerox.com@ozlabs.org] =
On Behalf Of S=E9bastien Chr=E9tien
	Sent: 01 September 2008 10:16
	To: linuxppc-dev@ozlabs.org
	Subject: Trace
=09
=09
=09
	Hello,
=09
	I am triying to write a tty_driver under ppc. And I get a kernel panic.
	Can somebody explain me how finding the source of the error with a =
kernel panic trace :
	thanks
=09
	Unable to handle kernel paging request for data at address 0x575555f9
	Faulting instruction address: 0xc0110ddc
	Oops: Kernel access of bad area, sig: 11 [#1]
	Modules linked in:
	NIP: c0110ddc LR: c011118c CTR: 00000000
	REGS: cf01bcb0 TRAP: 0300   Not tainted  (2.6.26)
	MSR: 00009032 <EE,ME,IR,DR>  CR: 44002022  XER: 20000000
	DAR: 575555f9, DSISR: 40000000
	TASK =3D cf01c000[1] 'swapper' THREAD: cf01a000
	GPR00: 0000000c cf01bd60 cf01c000 cf04c300 ffffffff cf01bdbc 00000000 =
c01d0000
	GPR08: 00001249 fffffffc 00000000 cf000420 84002022 00000000 10000b00 =
007fff00
	GPR16: 0fffa1d0 00000000 00000004 cf01bdbc 007ffec0 00000000 00000000 =
00800000
	GPR24: 00000000 c01b7650 00000002 c01d0000 ffffffff ce4a6700 cf04c300 =
57555541
	NIP [c0110ddc] init_dev+0x2bc/0x584
	LR [c011118c] tty_open+0xe8/0x3e0
	Call Trace:
	[cf01bd60] [cf01bd78] 0xcf01bd78 (unreliable)
	[cf01bdb0] [c011118c] tty_open+0xe8/0x3e0
	[cf01bde0] [c00742c8] chrdev_open+0x114/0x1b0
	[cf01be10] [c006fb5c] __dentry_open+0x190/0x2e8
	[cf01be40] [c006fdac] nameidata_to_filp+0x38/0x70
	[cf01be60] [c007bc60] do_filp_open+0x200/0x7d0
	[cf01bf10] [c00700b4] do_sys_open+0x74/0x114
	[cf01bf40] [c0003c94] init_post+0x34/0x258
	[cf01bf60] [c019ca64] kernel_init+0x258/0x270
	[cf01bff0] [c0011b3c] kernel_thread+0x44/0x60
	Instruction dump:
	7d808120 4e800020 7c832378 4bfa9ea9 7c7f1b79 418201f0 a81e0062 2f800001
	409efd98 83ff00d0 2c1f0000 4182fd90 <801f00b8> 70090080 408201b0 =
801e0060
	---[ end trace b7795a387aeb7786 ]---
	Kernel panic - not syncing: Attempted to kill init!
	allocation failed: out of vmalloc space - use vmalloc=3D<size> to =
increase size.
=09
=09


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
