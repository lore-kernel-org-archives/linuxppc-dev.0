Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id CA435DE013
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 20:02:33 +1100 (EST)
Received: from localhost (nausicaa2.coritel.it [127.0.0.1])
	by nausicaa2.coritel.it (Postfix) with ESMTP id DC5D0434002
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 09:59:59 +0100 (CET)
Received: from nausicaa2.coritel.it ([127.0.0.1])
	by localhost (nausicaa2.coritel.it [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id XTdcOXXOHIZB for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 09:59:58 +0100 (CET)
Received: from [192.168.2.2] (217-133-82-13.b2b.tiscali.it [217.133.82.13])
	by nausicaa2.coritel.it (Postfix) with ESMTP id 9C3AC434001
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 09:59:58 +0100 (CET)
Message-ID: <47BA9C13.6090400@coritel.it>
Date: Tue, 19 Feb 2008 10:06:27 +0100
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
Subject: MPC8641D PCI-Express error
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm working with the Freescale evaluation board MPC8641DHPCN and the
VIRTEX5 evaluation board ML555 connected with the PCI-Express. When I
try to read some register I have this problem:

Machine check in kernel mode.
Caused by (from SRR1=149030): Transfer error ack signal
Oops: Machine check, sig: 7 [#1]
PREEMPT SMP NR_CPUS=2
Modules linked in: virtex5
LTT NESTING LEVEL : 0
NIP: F108019C LR: F1080198 CTR: 00000001
REGS: c044dd60 TRAP: 0200   Tainted: GF      (2.6.18-mpc8641d_hpcn)
MSR: 00149030 <EE,ME,IR,DR>  CR: 22000222  XER: 00000000
TASK = c20e9990[568] 'insmod' THREAD: c044c000 CPU: 0
GPR00: F1080198 C044DE10 C20E9990 0000002E 80000000 FFFFFFFF 00008000
00002EA3
GPR08: C20E9990 00000000 C04C0220 C044C000 22000222 1001956C 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
GPR24: 3000EAA0 7FD6FDC0 00000000 C045FCC0 F107E594 F10A0000 00000000
C2036000
NIP [F108019C] virtex5_probe+0x130/0x1c4 [virtex5]
LR [F1080198] virtex5_probe+0x12c/0x1c4 [virtex5]
Call Trace:
[C044DE10] [F1080198] virtex5_probe+0x12c/0x1c4 [virtex5] (unreliable)
[C044DE30] [C01D2A58] pci_device_probe+0x84/0xbc
[C044DE50] [C0213754] driver_probe_device+0x60/0x118
[C044DE70] [C0213890] __driver_attach+0x84/0x88
[C044DE90] [C02130F4] bus_for_each_dev+0x58/0x94
[C044DEC0] [C02135D4] driver_attach+0x24/0x34
[C044DED0] [C0212AC8] bus_add_driver+0x88/0x164
[C044DEF0] [C021397C] driver_register+0x70/0xb8
[C044DF00] [C01D284C] __pci_register_driver+0x64/0x98
[C044DF10] [F1080030] init_module+0x30/0x6c [virtex5]
[C044DF20] [C004CBFC] sys_init_module+0xc8/0x25c
[C044DF40] [C0011358] ret_from_syscall+0x0/0x38
--- Exception: c00 at 0xff6de0c
    LR = 0x10000de4
Instruction dump:
40820060 3c60f108 3863cea0 48000311 807f0238 3c800001 48000395 7c7d1b78
3c60f108 3863ced4 480002f5 809d0000 <3c60f108> 3863cf04 480002e5 3c60f108

Have you got any suggestions?

Thanks.

Marco
