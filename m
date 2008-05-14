Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id F03BBDDDFC
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 11:34:44 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: mpc86xx - couple of questions...
Date: Tue, 13 May 2008 18:22:16 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D702315472@corpexc01.corp.networkrobots.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I took the latest tree from linux/kernel/git/galak/powerpc.git
(2.6.26-rc2), and the latest dtc from linux/kernel/git/galak/dtc.git.

After compiling, I am having couple of questions.

1) Doesn't the latest dtc support /memreserve/ on the top before or
after /dts-v1/? This used to work fine for previous compiler and this is
giving an error now.

2) When I compiled and started booting the new kernel, I am getting a
kernel crash (copy pasted below) in hash_page routine when it executes
the assembly instruction "lwarx   r6,0,r8". Can some one throw light at
this?

Kernel command line: root=3D/dev/ram rw console=3DttyS0,115200
mpic: Setting up MPIC " MPIC     " version 1.2 at ff740000, max 2 CPUs
mpic: ISU size: 88, shift: 7, mask: 7f
mpic: Initializing for 88 sources
PID hash table entries: 4096 (order: 12, 16384 bytes)
time_init: decrementer frequency =3D 150.000000 MHz
time_init: processor frequency   =3D 1572.864000 MHz
clocksource: timebase mult[1aaaaab] shift[22] registered
clockevent: decrementer mult[2666] shift[16] cpu[0]
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
High memory: 262144k
Memory: 1028816k/1048576k available (4308k kernel code, 18904k reserved,
108k data, 168k bss, 188k init)
SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-3, MinObjects=3D0, =
CPUs=3D2, Nodes=3D1
Calibrating delay loop... 299.00 BogoMIPS (lpj=3D149504)
Mount-cache hash table entries: 512
mpic: requesting IPIs ...=20
Machine check in kernel mode.
Caused by (from SRR1=3D141000): Transfer error ack signal
Oops: Machine check, sig: 7 [#1]
SMP NR_CPUS=3D2 Bivio's Odessa
Modules linked in:
NIP: 00015860 LR: 000003b0 CTR: 00000000
REGS: ef82bcc0 TRAP: 0200   Not tainted  (2.6.26-rc2)
MSR: 00141000 <ME>  CR: 8202202c  XER: 20000000
TASK =3D ef830000[-1073742352] 'swapper' THREAD: ef82a000 CPU: =
1919248243
GPR00: 00000102 ef82bd70 ef830000 00000005 89dbb8b0 0001189c 82c10068
40000000=20
GPR08: 834106ec 00001032 40000000 2f82bd70 c000e66c 00000061 00000000
00000004=20
GPR16: 00000080 c0000000 0000000e 00007a2c 00100000 00000000 c0430000
c0460000=20
GPR24: c0430000 00000002 ef82be60 c0460000 00000001 ef82a000 c046318c
c0460000=20
NIP [00015860] 0x15860
LR [000003b0] 0x3b0
Call Trace:
[ef82bd70] [00001032] 0x1032 (unreliable)
--- Exception: 466f3c at 0xef82bec0
    LR =3D ret_from_except+0x0/0x14
[ef82be50] [c0011d7c] ret_from_except+0x0/0x14
--- Exception: 901 at __delay+0x30/0x74
    LR =3D __cpu_up+0x144/0x1b4
[ef82bf10] [c0428978] __cpu_up+0xa4/0x1b4 (unreliable)
[ef82bf30] [c04291cc] cpu_up+0x108/0x1c4
[ef82bf70] [c0406204] kernel_init+0xd0/0x310
Instruction dump:
3ca0c043 XXXXXXXX XXXXXXXX XXXXXXXX 5085653a XXXXXXXX XXXXXXXX XXXXXXXX=20
5088b53a XXXXXXXX XXXXXXXX XXXXXXXX 7c653079 XXXXXXXX XXXXXXXX XXXXXXXX=20
---[ end trace 31fd0ba7d8756001 ]---

Thanks
Siva
