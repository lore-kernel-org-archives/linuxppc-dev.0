Return-Path: <carl.ljungmark@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 5A02167E47
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 18:39:04 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id C7C7DFB86C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 10:39:01 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id B1C1DFB86C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 10:39:01 +0200 (CEST)
Received: from clj.sysgo.com (clj.sysgo.com [172.24.1.170])
	by donald.sysgo.com (Postfix) with ESMTP id 6012D16FE09
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 11:18:01 +0200 (CEST)
Date: Tue, 02 Aug 2005 10:44:00 +0200
To: linuxppc-embedded@ozlabs.org
From: "Carl Ljungmark" <carl.ljungmark@sysgo.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
Message-ID: <op.suvg7mug0c7u6q@clj.sysgo.com>
Subject: MPC8245+2.6.12=oops
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello everyone!
Trying to boot linux 2.6.12 on an MPC8245 board from MEN (a12) with MenMo=
n =20
firmware. Nothing is printed to the console (ttyS0), but the __log_buf =20
contains this:

<4>entering platform_init.
<4>MENMON parameter string: MPAR brd=3DA012a brdrev=3D01.04.00 brdmod=3D0=
0 =20
sernbr=3D74 cbr=3D38400 cons=3DCOM1 mem0=3D262144 cpu=3DMPC8245 cpuclk=3D=
250memclk=3D100 =20
vmeirqenb=3DFEclun=3D02dlun=3D00 mm=3Dsmm =20
MMST=3D_00+_12+_1B+_1C+_0C+_17+_1A+_1D+_1E-SPD+RTC+LM75+WDOG+CHKS+ALL+.
<4>Command line now console=3DttyS0,38400.
<4>Using memory size from MENMON 0x10000000.
<3>Non-recoverable exception at PC=3Dc0007af0 MSR=3Db930.
<4>Oops: nonrecoverable exception,sig: 9 [#1].
<4>NIP: C0007AF0 LR:C000E474 SP: C00F7F70 REGS: c00f7ec0 TRAP: 0600 Not =20
tainted.
<4>MSR: 0000b930 EE: 1 PR: 0 FP:1 ME: 1 IR/DR:11.
<4>DAR: C0138000, DSISR: 00017C00.
<4>TASK =3D c00dda10[0] 'swapper' THREAD: c00f6000.
<4>Last syscall: 0 .
<6>GPR00: 00000080 C00F7F70 C00DDA10 C0138000 0000000000001000 00000001 =20
00000001 .
<6>GPR08: 0000000200000000 00000001 00000000 00000000 00000000 00008081 =20
2A090A86 .
<6>GPR16: 10588403 1E21D063 21218986 50022502 3C0185B8 011368CA00FFF010 =20
00FFF024 .
<6>GPR24: 00000000 01F8FA68 40000000 C00DC000000005A9 FD000000 FD000000 =20
C0138000 .
<4>NIP [c0007af0] clear_pages+0x10/0x1c.
<4>LR [c000e474] pte_alloc_one_kernel+0x60/0x78.
<4>Call trace:.
<4> [c003e948] pte_alloc_kernel+0x54/0x84.
<4> [c000e5e4] map_page+0x3c/0xdc.
<4> [c00ff61c] io_block_mapping+0x78/0xdc.
<4> [c00fe560] men824xali_map_io+0x20/0x44.
<4> [c00fec38] MMU_init+0x194/0x204.
<4> [c00032a4]start_here+0x48/0x80.
0>Kernelpanic - not syncing: Attempted to kill the idletask!.
<4> ......

adding 'nobats' to the command line changes the boot output slightly (I =20
then get two oops).

In order to get the whole output I had to turn off caching, maybe this ha=
s =20
influenced the boot process.. with dcache on, the __log_buf is practicall=
y =20
empty.

Has anyone managed to boot 6.12 on this board successfully?

Thanks in advance,
Carl.
