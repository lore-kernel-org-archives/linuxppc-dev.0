Return-Path: <curieux.khetan@gmail.com>
Received: from mail-we0-x22d.google.com (mail-we0-x22d.google.com
 [IPv6:2a00:1450:400c:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 33DC52C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Dec 2013 16:09:42 +1100 (EST)
Received: by mail-we0-f173.google.com with SMTP id u57so6932988wes.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 21:09:36 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 26 Dec 2013 10:39:36 +0530
Message-ID: <CAERE9PrGaOJS3YTBv61=JCEGyPxGnqr_8j=eKrnn7Y9vi8dMug@mail.gmail.com>
Subject: MPC8641 based custom board kernel Bug
From: Ashish Khetan <curieux.khetan@gmail.com>
To: kernelnewbies@kernelnewbies.org, linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=047d7bd6bb0ed882ca04ee68fbee
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7bd6bb0ed882ca04ee68fbee
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I was trying to port Linux-3.12 for MPC8641 based custom designed board for
evaluation purpose. I have been facing a kernel bug at mpic initialization.
Is somebody have faced this kind of bugs or can give me any pointer for
further steps how to solve kernel bugs will be really helpful. here is the
snapshot for the bug that may be helpful to address the bug.
Using MPC86xx HPCN machine description
Total memory = 512MB; using 1024kB for hash table (at cff00000)
Linux version 3.12.0 (ashish@ashish-VirtualBox) (gcc version 4.7.2 (GCC) )
#2 We
d Dec 25 16:04:36 IST 2013
Found initrd at 0xde975000:0xdfec428a
bootconsole [udbg0] enabled
setup_arch: bootmem
mpc86xx_hpcn_setup_arch()
MPC86xx HPCN board from Freescale Semiconductor
arch: exit
Zone ranges:
  DMA      [mem 0x00000000-0x1fffffff]
  Normal   empty
  HighMem  empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x00000000-0x1fffffff]
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=/dev/ram0 rw rootfs console=ttyS0,115200
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Sorting __ex_table...
Memory: 424980K/524288K available (4172K kernel code, 208K rwdata, 1304K
rodata,
 196K init, 149K bss, 99308K reserved, 0K highmem)
Kernel virtual memory layout:
  * 0xfffcf000..0xfffff000  : fixmap
  * 0xff800000..0xffc00000  : highmem PTEs
  * 0xff7fe000..0xff800000  : early ioremap
  * 0xe1000000..0xff7fe000  : vmalloc & ioremap
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:512 nr_irqs:512 16
------------[ cut here ]------------
kernel BUG at arch/powerpc/platforms/86xx/pic.c:42!
Oops: Exception in kernel mode, sig: 5 [#1]
MPC86xx HPCN
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.12.0 #2
task: c05903e0 ti: c05b4000 task.ti: c05b4000
NIP: c0567438 LR: c0567430 CTR: c0567400
REGS: c05b5ee0 TRAP: 0700   Not tainted  (3.12.0)
MSR: 00021032 <ME,IR,DR,RI>  CR: 24000042  XER: 20000000

GPR00: c0567430 c05b5f90 c05903e0 00000000 c04e4ff8 c051e588 0000008f
00000002
GPR08: c042789c 00000001 0000006f 00000000 22000048 bebffffd 11a7b4e5
200c8000
GPR16: ffbeffff ffffffff 00000000 00000024 00000000 1fec56f8 1fec59a7
00000000
GPR24: 00000000 1fff97e8 40000000 1ffcc6a0 c0bff080 c05c2490 c05c2628
c0585b60
NIP [c0567438] mpc86xx_init_irq+0x38/0x108
LR [c0567430] mpc86xx_init_irq+0x30/0x108
Call Trace:
[c05b5f90] [c0567430] mpc86xx_init_irq+0x30/0x108 (unreliable)
[c05b5fb0] [c0562784] init_IRQ+0x24/0x38
[c05b5fc0] [c055fde4] start_kernel+0x1bc/0x2ec
[c05b5ff0] [00003444] 0x3444
Instruction dump:
3d00c04f 38800000 38a01002 38c00000 38e00100 39088f8c 38600000 90010024
bfa10014 4bffec35 7c690034 5529d97e <0f090000> 3fa0c04f 4bfff391 38600000
---[ end trace 31fd0ba7d8756001 ]---

Kernel panic - not syncing: Attempted to kill the idle task!
Rebooting in 180 seconds..


Thanks & Regards
Ashish Khetan

--047d7bd6bb0ed882ca04ee68fbee
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br></div>I was trying to port Linux-3.1=
2 for MPC8641 based custom designed board for evaluation purpose. I have be=
en facing a kernel bug at mpic initialization. Is somebody have faced this =
kind of bugs or can give me any pointer for further steps how to solve kern=
el bugs will be really helpful. here is the snapshot for the bug that may b=
e helpful to address the bug.<br>
Using MPC86xx HPCN machine description<br>Total memory =3D 512MB; using 102=
4kB for hash table (at cff00000)<br>Linux version 3.12.0 (ashish@ashish-Vir=
tualBox) (gcc version 4.7.2 (GCC) ) #2 We<br>d Dec 25 16:04:36 IST 2013<br>
Found initrd at 0xde975000:0xdfec428a<br>bootconsole [udbg0] enabled<br>set=
up_arch: bootmem<br>mpc86xx_hpcn_setup_arch()<br>MPC86xx HPCN board from Fr=
eescale Semiconductor<br>arch: exit<br>Zone ranges:<br>=A0 DMA=A0=A0=A0=A0=
=A0 [mem 0x00000000-0x1fffffff]<br>
=A0 Normal=A0=A0 empty<br>=A0 HighMem=A0 empty<br>Movable zone start for ea=
ch node<br>Early memory node ranges<br>=A0 node=A0=A0 0: [mem 0x00000000-0x=
1fffffff]<br>Built 1 zonelists in Zone order, mobility grouping on.=A0 Tota=
l pages: 130048<br>
Kernel command line: root=3D/dev/ram0 rw rootfs console=3DttyS0,115200<br>P=
ID hash table entries: 2048 (order: 1, 8192 bytes)<br>Dentry cache hash tab=
le entries: 65536 (order: 6, 262144 bytes)<br>Inode-cache hash table entrie=
s: 32768 (order: 5, 131072 bytes)<br>
Sorting __ex_table...<br>Memory: 424980K/524288K available (4172K kernel co=
de, 208K rwdata, 1304K rodata,<br>=A0196K init, 149K bss, 99308K reserved, =
0K highmem)<br>Kernel virtual memory layout:<br>=A0 * 0xfffcf000..0xfffff00=
0=A0 : fixmap<br>
=A0 * 0xff800000..0xffc00000=A0 : highmem PTEs<br>=A0 * 0xff7fe000..0xff800=
000=A0 : early ioremap<br>=A0 * 0xe1000000..0xff7fe000=A0 : vmalloc &amp; i=
oremap<br>SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=
=3D1<br>NR_IRQS:512 nr_irqs:512 16<br>
------------[ cut here ]------------<br>kernel BUG at arch/powerpc/platform=
s/86xx/pic.c:42!<br>Oops: Exception in kernel mode, sig: 5 [#1]<br>MPC86xx =
HPCN<br>Modules linked in:<br>CPU: 0 PID: 0 Comm: swapper Not tainted 3.12.=
0 #2<br>
task: c05903e0 ti: c05b4000 task.ti: c05b4000<br>NIP: c0567438 LR: c0567430=
 CTR: c0567400<br>REGS: c05b5ee0 TRAP: 0700=A0=A0 Not tainted=A0 (3.12.0)<b=
r>MSR: 00021032 &lt;ME,IR,DR,RI&gt;=A0 CR: 24000042=A0 XER: 20000000<br><br=
>GPR00: c0567430 c05b5f90 c05903e0 00000000 c04e4ff8 c051e588 0000008f 0000=
0002<br>
GPR08: c042789c 00000001 0000006f 00000000 22000048 bebffffd 11a7b4e5 200c8=
000<br>GPR16: ffbeffff ffffffff 00000000 00000024 00000000 1fec56f8 1fec59a=
7 00000000<br>GPR24: 00000000 1fff97e8 40000000 1ffcc6a0 c0bff080 c05c2490 =
c05c2628 c0585b60<br>
NIP [c0567438] mpc86xx_init_irq+0x38/0x108<br>LR [c0567430] mpc86xx_init_ir=
q+0x30/0x108<br>Call Trace:<br>[c05b5f90] [c0567430] mpc86xx_init_irq+0x30/=
0x108 (unreliable)<br>[c05b5fb0] [c0562784] init_IRQ+0x24/0x38<br>[c05b5fc0=
] [c055fde4] start_kernel+0x1bc/0x2ec<br>
[c05b5ff0] [00003444] 0x3444<br>Instruction dump:<br>3d00c04f 38800000 38a0=
1002 38c00000 38e00100 39088f8c 38600000 90010024<br>bfa10014 4bffec35 7c69=
0034 5529d97e &lt;0f090000&gt; 3fa0c04f 4bfff391 38600000<br>---[ end trace=
 31fd0ba7d8756001 ]---<br>
<br>Kernel panic - not syncing: Attempted to kill the idle task!<br>Rebooti=
ng in 180 seconds..<br><br><br></div>Thanks &amp; Regards<br></div>Ashish K=
hetan<br></div>

--047d7bd6bb0ed882ca04ee68fbee--
