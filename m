Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AAAC1B71C5
 for <linuxppc-dev@ozlabs.org>; Sat, 24 Dec 2011 03:54:23 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=us-ascii
Subject: p1020 unstable with 3.2
Date: Fri, 23 Dec 2011 17:54:14 +0100
Message-Id: <0048E411-D82D-4EA4-B9BA-EF233AC6ED34@suse.de>
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0 (Apple Message framework v1084)
Cc: Scott Wood <scottwood@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi guys,

While trying to test my latest patch queue for ppc kvm, I realized that =
even though the device trees got updated, the p1020 box still is =
unstable. The trace below is the one I've seen the most. It only occurs =
during network I/O which happens a lot on that box, since I'm running it =
using NFS root.

As for configuration, I use kumar's "merge" branch from today and the =
p1020rdb.dts device tree provided in that tree.

The last known good configuration I'm aware of is 3.0.

Any ideas what's going wrong here?

Alex

---

Unable to handle kernel paging request for data at address 0x00000004
Faulting instruction address: 0xc00eb38c
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=3D2 P1020 RDB
Modules linked in:
NIP: c00eb38c LR: c00eb278 CTR: c0340e48
REGS: effedc70 TRAP: 0300   Not tainted  =
(3.2.0-rc3-00013-gaca3173-dirty)
MSR: 00021000 <ME,CE>  CR: 28842422  XER: 00000000
DEAR: 00000004, ESR: 00800000
TASK =3D ef4bd900[4816] 'cc1' THREAD: ee4c4000 CPU: 0
GPR00: 00004080 effedd20 ef4bd900 ef001180 c15e5700 ffffffff c03e7448 =
00100021=20
GPR08: 00100020 00010001 00000000 00000000 28842442 10a3e610 00210d00 =
00200200=20
GPR16: 00100100 00000001 c06d6748 ef002670 00000000 c03e7448 ffffffff =
00000020=20
GPR24: effec000 ffffffec 00029000 ef001188 00000000 ef002600 c18079e0 =
ef001180=20
NIP [c00eb38c] __slab_alloc+0x3d4/0x4f8
LR [c00eb278] __slab_alloc+0x2c0/0x4f8
Call Trace:
[effedd20] [c06d6b78] hashrnd+0x0/0x4 (unreliable)
[effeddc0] [c00eb680] __kmalloc_track_caller+0x1d0/0x200
[effedde0] [c03e6064] __alloc_skb+0x74/0x150
[effede00] [c03e7448] __netdev_alloc_skb+0x28/0x60
[effede10] [c03408f0] gfar_new_skb+0x50/0x7c
[effede20] [c0340acc] gfar_clean_rx_ring+0x1b0/0x52c
[effede90] [c03412d0] gfar_poll+0x488/0x624
[effedf60] [c03f062c] net_rx_action+0x140/0x1e8
[effedfa0] [c0061aa0] __do_softirq+0x124/0x210
[effedff0] [c000e0fc] call_do_softirq+0x14/0x24
[ee4c5c40] [c000564c] do_softirq+0xb4/0xe0
[ee4c5c60] [c006170c] irq_exit+0x94/0xb4
[ee4c5c70] [c000591c] do_IRQ+0xb0/0x1ac
[ee4c5ca0] [c000fc5c] ret_from_except+0x0/0x18
--- Exception: 501 at do_lookup+0x118/0x3cc
    LR =3D do_lookup+0xec/0x3cc
[ee4c5db0] [c00ff898] link_path_walk+0x308/0xc78
[ee4c5e30] [c0103cb0] path_openat+0xc8/0x3ec
[ee4c5e90] [c01040f4] do_filp_open+0x44/0xb0
[ee4c5f10] [c00efcf8] do_sys_open+0x198/0x24c
[ee4c5f40] [c000f604] ret_from_syscall+0x0/0x3c
--- Exception: c01 at 0xfdb6658
    LR =3D 0xfe50be8
Instruction dump:
8004000c 7f880000 409effa8 91240008 9164000c 7c0004ac 80040000 2f8a0000=20=

81240018 81640014 5400003c 90040000 <912b0004> 91690000 92040014 =
91e40018=20
Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 180 seconds..=
