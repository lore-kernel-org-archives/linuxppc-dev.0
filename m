Return-Path: <microdevel@googlemail.com>
Received: from mail-qc0-x22c.google.com (mail-qc0-x22c.google.com
 [IPv6:2607:f8b0:400d:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE92C1A0257
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 00:29:09 +1000 (EST)
Received: by mail-qc0-f172.google.com with SMTP id i8so2918461qcq.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 07:29:06 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 12 Aug 2014 16:29:05 +0200
Message-ID: <CAOB9jCKmpuSSAea_DVHPNEYXOuLL3xUJ=JrMrxVO=uhrajY1Fg@mail.gmail.com>
Subject: MPC8641D SMP "Processor 1 is stuck"
From: Chris Enrique <microdevel@googlemail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001a11c16ec26933d005006f7e8e
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11c16ec26933d005006f7e8e
Content-Type: text/plain; charset=UTF-8

Hello,

i am currently working on a GE PPC9A board which has a MPC8641D processor.

My work on this board is currently based on the yocto project (where i also
put this issue on the mailinglist) but the issue affects mainly the
kernel's SMP feature so i want to share this issue here as well and see if
anybody can help:

i created a BSP for this board and yocto generates a fully working 3.14
kernel and rootfs as well as devicetree.

the only thing which is causing problems is SMP. i included the following
kernel options:

CONFIG_SMP=y
CONFIG_SCHED_SMT=y
CONFIG_NR_CPUS=64

Unfortunately, only one CPU is brought up during boot:

...
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Sorting __ex_table...
Memory: 2066916K/2097152K available (4312K kernel code, 188K rwdata, 952K
rodata, 200K init, 131K bss, 30236K reserved, 1310716K highmem)
Kernel virtual memory layout:
  * 0xffbdf000..0xfffff000  : fixmap
  * 0xff400000..0xff800000  : highmem PTEs
  * 0xff3dd000..0xff400000  : early ioremap
  * 0xf1000000..0xff3dd000  : vmalloc & ioremap
Preemptible hierarchical RCU implementation.
    Dump stacks of tasks blocking RCU-preempt GP.
    RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS:512 nr_irqs:512 16
mpic: Setting up MPIC " MPIC     " version 1.2 at fef40000, max 2 CPUs
mpic: ISU size: 256, shift: 8, mask: ff
mpic: Initializing for 256 sources
clocksource: timebase mult[7800001] shift[24] registered
Console: colour dummy device 80x25
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
mpic: requesting IPIs...
ProcePID hash table entries: 4096 (order: 12, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2044396k/2097152k available (4464k kernel code, 51632k reserved,
148k data, 145k bss, 196k init)
Kernel virtual memory layout:
  * 0xfffe0000..0xfffff000  : fixmap
  * 0xff800000..0xffc00000  : highmem PTEs
  * 0xff3db000..0xff800000  : early ioremap
  * 0xf1000000..0xff3db000  : vmalloc & ioremap
NR_IRQS:512
mpic: Setting up MPIC " MPIC     " version 1.2 at fef40000, max 2 CPUs
mpic: ISU size: 256, shift: 8, mask: ff
mpic: Initializing for 256 sources
clocksource: timebase mult[1e00000] shift[22] registered
Console: colour dummy device 80x25
Mount-cache hash table entries: 512
smp_prepare_cpus
mpic: requesting IPIs ...
smp: kicking cpu 1
Processor 1 is stuck.
Brought up 1 CPUs
NET: Registered protocol family 16
...

GE had also released a kernel for this board (2009 2.6 kernel), SMP seems
to fail there as well:

...
Kernel virtual memory layout:
  * 0xfffe0000..0xfffff000  : fixmap
  * 0xff800000..0xffc00000  : highmem PTEs
  * 0xff3db000..0xff800000  : early ioremap
  * 0xf1000000..0xff3db000  : vmalloc & ioremap
NR_IRQS:512
mpic: Setting up MPIC " MPIC     " version 1.2 at fef40000, max 2 CPUs
mpic: ISU size: 256, shift: 8, mask: ff
mpic: Initializing for 256 sources
clocksource: timebase mult[1e00000] shift[22] registered
Console: colour dummy device 80x25
Mount-cache hash table entries: 512
smp_prepare_cpus
mpic: requesting IPIs ...
smp: kicking cpu 1
Processor 1 is stuck.
Brought up 1 CPUs
...

Does anybody have an idea what might cause this problem?

Kind regards,
Chris

--001a11c16ec26933d005006f7e8e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Hello,<br><br>i am currently=
 working on a GE PPC9A board which has a MPC8641D processor.<br><br></div><=
div>My work on this board is currently based on the yocto project (where i =
also put this issue on the mailinglist) but the issue affects mainly the ke=
rnel&#39;s SMP feature so i want to share this issue here as well and see i=
f anybody can help:<br>
</div><div><br></div>i created a BSP for this board and yocto generates a f=
ully working 3.14 kernel and rootfs as well as devicetree.<br>
<br>the only thing which is causing problems is SMP. i included the followi=
ng kernel options:<br><br>CONFIG_SMP=3Dy<br>CONFIG_SCHED_SMT=3Dy<br>CONFIG_=
NR_CPUS=3D64<br><br></div>Unfortunately, only one CPU is brought up during =
boot:<br>

<br>...<br>PID hash table entries: 4096 (order: 2, 16384 bytes)<br>Dentry c=
ache hash table entries: 131072 (order: 7, 524288 bytes)<br>Inode-cache has=
h table entries: 65536 (order: 6, 262144 bytes)<br>Sorting __ex_table...<br=
>

Memory: 2066916K/2097152K available (4312K kernel code, 188K rwdata,=20
952K rodata, 200K init, 131K bss, 30236K reserved, 1310716K highmem)<br>Ker=
nel virtual memory layout:<br>=C2=A0 * 0xffbdf000..0xfffff000=C2=A0 : fixma=
p<br>=C2=A0 * 0xff400000..0xff800000=C2=A0 : highmem PTEs<br>
=C2=A0 * 0xff3dd000..0xff400000=C2=A0 : early ioremap<br>=C2=A0 * 0xf100000=
0..0xff3dd000=C2=A0 : vmalloc &amp; ioremap<br>Preemptible hierarchical RCU=
 implementation.<br>=C2=A0=C2=A0=C2=A0 Dump stacks of tasks blocking RCU-pr=
eempt GP.<br>=C2=A0=C2=A0=C2=A0 RCU restricting CPUs from NR_CPUS=3D64 to n=
r_cpu_ids=3D2.<br>

RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D2<br>NR_IRQS=
:512 nr_irqs:512 16<br>mpic: Setting up MPIC &quot; MPIC=C2=A0=C2=A0=C2=A0=
=C2=A0 &quot; version 1.2 at fef40000, max 2 CPUs<br>mpic: ISU size: 256, s=
hift: 8, mask: ff<br>

mpic: Initializing for 256 sources<br>clocksource: timebase mult[7800001] s=
hift[24] registered<br>Console: colour dummy device 80x25<br>pid_max: defau=
lt: 32768 minimum: 301<br>Mount-cache hash table entries: 2048 (order: 1, 8=
192 bytes)<br>

Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)<br>mpic: r=
equesting IPIs...<br>ProcePID hash table entries: 4096 (order: 12, 16384 by=
tes)<br>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)<br=
>

Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)<br>Memory: 2=
044396k/2097152k available (4464k kernel code, 51632k reserved, 148k data, =
145k bss, 196k init)<br>Kernel virtual memory layout:<br>=C2=A0 * 0xfffe000=
0..0xfffff000=C2=A0 : fixmap<br>

=C2=A0 * 0xff800000..0xffc00000=C2=A0 : highmem PTEs<br>=C2=A0 * 0xff3db000=
..0xff800000=C2=A0 : early ioremap<br>=C2=A0 * 0xf1000000..0xff3db000=C2=A0=
 : vmalloc &amp; ioremap<br>NR_IRQS:512<br>mpic: Setting up MPIC &quot; MPI=
C=C2=A0=C2=A0=C2=A0=C2=A0 &quot; version 1.2 at fef40000, max 2 CPUs<br>

mpic: ISU size: 256, shift: 8, mask: ff<br>mpic: Initializing for 256 sourc=
es<br>clocksource: timebase mult[1e00000] shift[22] registered<br>Console: =
colour dummy device 80x25<br>Mount-cache hash table entries: 512<br>smp_pre=
pare_cpus<br>

mpic: requesting IPIs ... <br>smp: kicking cpu 1<br>Processor 1 is stuck.<b=
r>Brought up 1 CPUs<br>NET: Registered protocol family 16<br>...<br><br></d=
iv>GE had also released a kernel for this board (2009 2.6 kernel), SMP seem=
s to fail there as well:<br>

<br>...<br>Kernel virtual memory layout:<br>=C2=A0 * 0xfffe0000..0xfffff000=
=C2=A0 : fixmap<br>=C2=A0 * 0xff800000..0xffc00000=C2=A0 : highmem PTEs<br>=
=C2=A0 * 0xff3db000..0xff800000=C2=A0 : early ioremap<br>=C2=A0 * 0xf100000=
0..0xff3db000=C2=A0 : vmalloc &amp; ioremap<br>

NR_IRQS:512<br>mpic: Setting up MPIC &quot; MPIC=C2=A0=C2=A0=C2=A0=C2=A0 &q=
uot; version 1.2 at fef40000, max 2 CPUs<br>mpic: ISU size: 256, shift: 8, =
mask: ff<br>mpic: Initializing for 256 sources<br>clocksource: timebase mul=
t[1e00000] shift[22] registered<br>

Console: colour dummy device 80x25<br>Mount-cache hash table entries: 512<b=
r>smp_prepare_cpus<br>mpic: requesting IPIs ... <br>smp: kicking cpu 1<br>P=
rocessor 1 is stuck.<br>Brought up 1 CPUs<br>...<br><br></div>Does anybody =
have an idea what might cause this problem?<br>

<br></div>Kind regards,<br></div>Chris</div>

--001a11c16ec26933d005006f7e8e--
