Return-Path: <david.hagood@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id 31DFDB71E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 00:26:57 +1000 (EST)
Received: by gxk28 with SMTP id 28so2240986gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 07:26:55 -0700 (PDT)
Received: from localhost (Deathwish [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id A3A39C7B8043
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 09:26:51 -0500 (CDT)
Message-ID: <2bef2051c143a8d6e619519b222016f9.squirrel@localhost>
Date: Tue, 28 Sep 2010 09:26:51 -0500
Subject: Parsing a bus fault message?
From: david.hagood@gmail.com
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I finally found my problems accessing the PPC OWBAR registers as an
endpoint (copy/paste brown paper bag bug on my part), but I still get a
bus fault trying to access the device.

The problem is that I don't know if the fault is internal to the PPC (e.g.
I don't have something in the chip set up) or if the fault is happening on
the PCIe side of things.

Are there any good how-tos on interpreting the kernel machine check error
for the PPC, that might help me know where to look for the problem?


Alternatively, can somebody see a hint in the message that I don't know
enough to pick out? At this point, my code is trying to memcpy() from the
PCIe bus (mapped via the outbound ATMU) to local memory, so the fault is
either a) the ATMU is not accessible b) the ATMU is accessible but not
mapped (which I would have thought the ioremap call I made would have
handled) or c) the chip is not able to bus master on the PCI bus.


Machine check in kernel mode.
Caused by (from SRR1=149030): Transfer error ack signal
Oops: Machine check, sig: 7 [#1]
SMP NR_CPUS=2 EP8641A
Modules linked in: Endpoint_driver rionetlink
NIP: c0014e80 LR: f102d434 CTR: 00000200
REGS: ef05fdf0 TRAP: 0200   Not tainted  (2.6.26.2-ep1.10)
MSR: 00149030 <EE,ME,IR,DR>  CR: 24004482  XER: 00000000
TASK = ef05b310[76] 'cat' THREAD: ef05e000 CPU: 0
GPR00: 00000000 ef05fea0 ef05b310 eed06000 f14dfffc 00001000 eed05ffc
80000000
GPR08: 00000000 00000000 00001000 c0014e60 00001000 100a7264 0ffff100
00000001
GPR16: ffffffff 004005b4 007fff00 c0290000 c02f0000 ef05ff20 bfba5978
eed06000
GPR24: eed14ce0 ef02c678 eed61910 00000000 00000000 efb8d4b0 fffffffb
00001000
NIP [c0014e80] memcpy+0x20/0x9c
LR [f102d434] Endpoint_atmu_read+0x4c/0x90 [Endpoint_driver]
Call Trace:
[ef05fea0] [ef05609c] 0xef05609c (unreliable)
[ef05feb0] [c00cf2c0] read+0xd8/0x1c8
[ef05fef0] [c007ff40] vfs_read+0xcc/0x16c
[ef05ff10] [c008074c] sys_read+0x4c/0x90
[ef05ff40] [c0011174] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff697f0
    LR = 0x10007008
Instruction dump:
4200fff0 4e800020 7c032040 418100a0 54a7e8ff 38c3fffc 3884fffc 41820028
70c00003 7ce903a6 40820054 80e40004 <85040008> 90e60004 95060008 4200fff0
---[ end trace e0620da52f69882d ]---
