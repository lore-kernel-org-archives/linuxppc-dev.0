Return-Path: <sean.maclennan@pikatech.com>
Received: from fusion.kanatek.com (fusion.kanatek.com [207.107.229.150])
	by ozlabs.org (Postfix) with ESMTP id 7242ADDEF0
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 04:23:11 +1100 (EST)
Message-ID: <478CF9E3.5050103@pikatech.com>
Date: Tue, 15 Jan 2008 13:22:27 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] MTD for Taco
References: <477F12D1.2070109@pikatech.com> <200801150615.19910.sr@denx.de>
	<478C5309.7040805@pikatech.com> <200801150739.39095.sr@denx.de>
In-Reply-To: <200801150739.39095.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@ottawa.kanatek.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> Bummer! Was worth a try though. I still don't see why this should fail on your 
> platform. What error/exception do you get upon 32bit access btw?
>   
Ask and Ye Shall RX! Here is a complete trace of the crash including the 
NAND debug outputs.

Cheers,
   Sean

NDFC NAND Driver initialized. Chip-Rev: 0x00000109
NAND device: Manufacturer ID: 0xec, Chip ID: 0x76 (Samsung NAND 64MiB 3,3V 8-bi)
Scanning device for bad blocks
Data machine check in kernel mode.
Oops: Machine check, sig: 7 [#1]
Warp
Modules linked in:
NIP: 00000000 LR: c01559b8 CTR: c0159f64
REGS: c02c2f50 TRAP: 0202   Not tainted  (2.6.24-rc6-pika)
MSR: 00000000 <>  CR: 42000024  XER: 2000005f
TASK = cf81bba0[1] 'swapper' THREAD: cf81e000
GPR00: 70000000 cf81fd30 cf81bba0 c02daac4 cf9a5280 0000000c 00000240 00000000 
GPR08: 122deea8 d1064000 000f4240 c02e0000 121f0cf6 00000000 0ffabe00 c02b0d14 
GPR16: 0040044c 0000001f cf9a5080 00000000 00000000 00000010 00000002 00000000 
GPR24: 00000010 00000000 00000001 c02daac4 cf81fda8 00000000 c02daac4 c0159f64 
NIP [00000000] _start+0x40000000/0x30
LR [c01559b8] nand_read_oob_std+0x54/0x6c
Call Trace:
[cf81fd30] [c01559a0] nand_read_oob_std+0x3c/0x6c (unreliable)
[cf81fd50] [c0155fb4] nand_read_oob+0x204/0x334
[cf81fda0] [c01589c8] create_bbt+0x210/0x2f0
[cf81fe00] [c0159abc] nand_scan_bbt+0x464/0x4c4
[cf81fe50] [c0157a1c] nand_scan_tail+0x4b0/0x4f4
[cf81fe70] [c015a214] ndfc_chip_probe+0x168/0x1d4
[cf81fe90] [c012e014] platform_drv_probe+0x20/0x30
[cf81fea0] [c012bee8] driver_probe_device+0xb8/0x1cc
[cf81fec0] [c012c1d4] __driver_attach+0xcc/0xf8
[cf81fee0] [c012af8c] bus_for_each_dev+0x54/0x90
[cf81ff10] [c012bc14] driver_attach+0x24/0x34
[cf81ff20] [c012b64c] bus_add_driver+0x98/0x1b8
[cf81ff40] [c012c65c] driver_register+0x58/0xa0
[cf81ff50] [c012e190] platform_driver_register+0x98/0xa8
[cf81ff60] [c028c014] ndfc_nand_init+0x38/0x50
[cf81ff70] [c027486c] kernel_init+0xa4/0x290
[cf81fff0] [c000c320] kernel_thread+0x48/0x64
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
---[ end trace 99adfcc136bb75fe ]---
