Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id B52DFB7125
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2010 12:07:16 +1100 (EST)
Date: Wed, 20 Oct 2010 21:00:32 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: NFS boot problems
Message-ID: <20101020210032.19925617@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anybody else seeing this with 2.6.36?

[  431.260895] Unable to handle kernel paging request for data at address 0x24002082
[  431.268407] Faulting instruction address: 0xc000f6c0
[  431.273321] Oops: Kernel access of bad area, sig: 11 [#1]
[  431.278670] Warp
[  431.280494] last sysfs file:
[  431.283447] Modules linked in:
[  431.286486] NIP: c000f6c0 LR: c02d2338 CTR: 00000000
[  431.291436] REGS: cf831ea0 TRAP: 0300   Not tainted  (2.6.36-pika+)
[  431.297680] MSR: 00029000 <EE,ME,CE>  CR: 24084048  XER: 00000000
[  431.303758] DEAR: 24002082, ESR: 00000000
[  431.307753] TASK = cf82c000[1] 'swapper' THREAD: cf830000
[  431.312958] GPR00: 00000000 cf831f50 cf82c000 24002082 363a2f74 24002081 cf81f128 00000120
[  431.321291] GPR08: 00029000 c03e0000 cf8001a0 c03e1f30 15e6a17f 00000000 0ffa9700 007fff97
[  431.329624] GPR16: 00400450 00800000 007fff00 0ffa9d3c 00000000 ffffffff c0000020 00000001
[  431.337957] GPR24: 00000000 c03f0000 00000000 c03bcd8c c03e2390 c03e1ef4 c03e1ee8 c03e2390
[  431.346487] NIP [c000f6c0] strcmp+0x8/0x24
[  431.350558] LR [c02d2338] svc_reg_xprt_class+0x50/0xd0
[  431.355665] Call Trace:
[  431.358115] [cf831f50] [c00ecbd8] proc_create_data+0x6c/0xcc (unreliable)
[  431.364883] [cf831f70] [c02c6ce8] svc_init_xprt_sock+0x24/0x34
[  431.370702] [cf831f80] [c03bce20] init_sunrpc+0x94/0xb0
[  431.375899] [cf831f90] [c00015d8] do_one_initcall+0x15c/0x1a0
[  431.381635] [cf831fd0] [c03a0874] kernel_init+0xd8/0x178
[  431.386921] [cf831ff0] [c000c31c] kernel_thread+0x50/0x6c
[  431.392296] Instruction dump:
[  431.395248] 3884ffff 8c050001 2c000000 4082fff8 38a5ffff 8c040001 2c000000 9c050001
[  431.402973] 4082fff4 4e800020 38a3ffff 3884ffff <8c650001> 2c830000 8c040001 7c601851
[  431.411405] ---[ end trace 5e5d343531be722e ]---

It looks like both xcl->xcl_name and cl->xcl_name are bogus addresses.

Cheers,
   Sean
