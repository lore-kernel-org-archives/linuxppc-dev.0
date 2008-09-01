Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0402BDE1A7
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 19:24:00 +1000 (EST)
Subject: Re: Trace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
In-Reply-To: <319b0ac50809010216jac3ae30r9260699abde6535@mail.gmail.com>
References: <319b0ac50809010216jac3ae30r9260699abde6535@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 01 Sep 2008 19:23:53 +1000
Message-Id: <1220261033.13010.48.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-09-01 at 11:16 +0200, Sébastien Chrétien wrote:
> Hello,
> 
> I am triying to write a tty_driver under ppc. And I get a kernel
> panic.
> Can somebody explain me how finding the source of the error with a
> kernel panic trace : 
> thanks

What kind of device are you writing a tty driver for ?

I don't see anything much relevant in your backtrace, you went through a
crap pointer in init_dev, could be anything at this stage...

Can you post your driver to the list ?

Ben.

> Unable to handle kernel paging request for data at address 0x575555f9
> Faulting instruction address: 0xc0110ddc
> Oops: Kernel access of bad area, sig: 11 [#1]
> Modules linked in:
> NIP: c0110ddc LR: c011118c CTR: 00000000
> REGS: cf01bcb0 TRAP: 0300   Not tainted  (2.6.26)
> MSR: 00009032 <EE,ME,IR,DR>  CR: 44002022  XER: 20000000
> DAR: 575555f9, DSISR: 40000000
> TASK = cf01c000[1] 'swapper' THREAD: cf01a000
> GPR00: 0000000c cf01bd60 cf01c000 cf04c300 ffffffff cf01bdbc 00000000
> c01d0000 
> GPR08: 00001249 fffffffc 00000000 cf000420 84002022 00000000 10000b00
> 007fff00 
> GPR16: 0fffa1d0 00000000 00000004 cf01bdbc 007ffec0 00000000 00000000
> 00800000 
> GPR24: 00000000 c01b7650 00000002 c01d0000 ffffffff ce4a6700 cf04c300
> 57555541 
> NIP [c0110ddc] init_dev+0x2bc/0x584
> LR [c011118c] tty_open+0xe8/0x3e0
> Call Trace:
> [cf01bd60] [cf01bd78] 0xcf01bd78 (unreliable)
> [cf01bdb0] [c011118c] tty_open+0xe8/0x3e0
> [cf01bde0] [c00742c8] chrdev_open+0x114/0x1b0
> [cf01be10] [c006fb5c] __dentry_open+0x190/0x2e8
> [cf01be40] [c006fdac] nameidata_to_filp+0x38/0x70
> [cf01be60] [c007bc60] do_filp_open+0x200/0x7d0
> [cf01bf10] [c00700b4] do_sys_open+0x74/0x114
> [cf01bf40] [c0003c94] init_post+0x34/0x258
> [cf01bf60] [c019ca64] kernel_init+0x258/0x270
> [cf01bff0] [c0011b3c] kernel_thread+0x44/0x60
> Instruction dump:
> 7d808120 4e800020 7c832378 4bfa9ea9 7c7f1b79 418201f0 a81e0062
> 2f800001 
> 409efd98 83ff00d0 2c1f0000 4182fd90 <801f00b8> 70090080 408201b0
> 801e0060 
> ---[ end trace b7795a387aeb7786 ]---
> Kernel panic - not syncing: Attempted to kill init!
> allocation failed: out of vmalloc space - use vmalloc=<size> to
> increase size.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
