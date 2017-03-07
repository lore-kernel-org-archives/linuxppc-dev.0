Return-Path: <srs0=4cvr=2q=google.com=keescook@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vd7fB4w2PzDqLW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 07:33:38 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vd7fB4R5qz8tDp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 07:33:38 +1100 (AEDT)
Received: from mail-io0-x22b.google.com (mail-io0-x22b.google.com
 [IPv6:2607:f8b0:4001:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vd7fB1X9fz9sNL
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Mar 2017 07:33:38 +1100 (AEDT)
Received: by mail-io0-x22b.google.com with SMTP id l7so13889227ioe.3
 for <linuxppc-dev@ozlabs.org>; Tue, 07 Mar 2017 12:33:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6EF2976F-D000-47E9-851F-D13190492303@linux.vnet.ibm.com>
References: <6EF2976F-D000-47E9-851F-D13190492303@linux.vnet.ibm.com>
From: Kees Cook <keescook@google.com>
Date: Tue, 7 Mar 2017 12:33:35 -0800
Message-ID: <CAGXu5jLaR8=MLNuGfvEQZPsFkvg1CDLDBdvAKLFu3xDcShK41g@mail.gmail.com>
Subject: Re: [next 20170227] CPU remove DLPAR operation WARN @
 lib/refcount.c:128
To: Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc: Linux-Next <linux-next@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is likely a legitimate bug: something took the kref object
negative. (Which was noticed due to the recent migration of kref from
atomic_t to refcount_t which will refuse to perform dangerous
refcounting actions.)

If I had to guess, I think it's dlpar_cpu_exists(), which is calling
of_node_put() on the child. I don't think that should be happening,
but I'm not actually familiar with this code. :)

-Kees

On Mon, Feb 27, 2017 at 1:35 AM, Sachin Sant <sachinp@linux.vnet.ibm.com> w=
rote:
> With Feb 27 next tree I am seeing inconsistent results on a CPU remove
> DLPAR operation on a POWER8 LPAR.
>
> After the cpu remove operation the SMT capability of the LPAR is disabled=
.
>
> # uname -r
> 4.10.0-next-20170227
> # ppc64_cpu --smt
> SMT=3D8
> # lscpu
> Architecture:          ppc64le
> Byte Order:            Little Endian
> CPU(s):                16
> On-line CPU(s) list:   0-15
> Thread(s) per core:    8
> Core(s) per socket:    1
> Socket(s):             2
> NUMA node(s):          4
> Model:                 2.1 (pvr 004b 0201)
> Model name:            POWER8 (architected), altivec supported
> L1d cache:             64K
> L1i cache:             32K
> L2 cache:              512K
> L3 cache:              8192K
> NUMA node0 CPU(s):
> NUMA node1 CPU(s):     0-7
> NUMA node3 CPU(s):
> NUMA node4 CPU(s):     8-15
>
> After a DLPAR operation (CPU remove : 2 to 1) all the cpu seems to be
> removed. at the end of it I also see a warning @lib/refcount.c:128
> SMT capability is show as disabled. It should have remained at 8.
>
> # ppc64_cpu =E2=80=94smt
> Machine is not SMT capable
> lscpu o/p shows 8  online cpus, with threads per core as 8.
>
> [root@alp12 ~]# lscpu
> Architecture:          ppc64le
> Byte Order:            Little Endian
> CPU(s):                8
> On-line CPU(s) list:   8-15
> Thread(s) per core:    8
> Core(s) per socket:    1
> Socket(s):             1
> NUMA node(s):          4
> Model:                 2.1 (pvr 004b 0201)
> Model name:            POWER8 (architected), altivec supported
> L1d cache:             64K
> L1i cache:             32K
> NUMA node0 CPU(s):
> NUMA node1 CPU(s):
> NUMA node3 CPU(s):
> NUMA node4 CPU(s):     8-15
> [root@alp12 ~]
>
> [  196.910677] cpu 8 (hwid 8) Ready to die...
> [  197.120324] cpu 9 (hwid 9) Ready to die...
> [  197.290265] cpu 10 (hwid 10) Ready to die...
> [  197.490234] cpu 11 (hwid 11) Ready to die...
> [  197.630110] cpu 12 (hwid 12) Ready to die...
> [  197.790094] cpu 13 (hwid 13) Ready to die...
> [  197.980016] cpu 14 (hwid 14) Ready to die...
> [  198.098137] cpu 15 (hwid 15) Ready to die...
> [  198.210074] pseries-hotplug-cpu: Failed to release drc (10000008) for =
CPU PowerPC,POWER8, rc: -17
> [  199.050648] cpu 0 (hwid 0) Ready to die...
> [  199.220530] cpu 1 (hwid 1) Ready to die...
> [  199.370459] cpu 2 (hwid 2) Ready to die...
> [  199.600322] cpu 3 (hwid 3) Ready to die...
> [  199.770259] cpu 4 (hwid 4) Ready to die...
> [  199.960189] cpu 5 (hwid 5) Ready to die...
> [  200.140145] cpu 6 (hwid 6) Ready to die...
> [  200.258067] cpu 7 (hwid 7) Ready to die...
> [  200.360320] refcount_t: underflow; use-after-free.
> [  200.360371] ------------[ cut here ]------------
> [  200.360385] WARNING: CPU: 10 PID: 7194 at lib/refcount.c:128 refcount_=
sub_and_test+0xb8/0xf0
> [  200.360398] Modules linked in: iptable_mangle ipt_MASQUERADE nf_nat_ma=
squerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ip=
v4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp rpadlpar_i=
o rpaphp tun bridge stp llc kvm iptable_filter vmx_crypto pseries_rng rng_c=
ore binfmt_misc nfsd ip_tables x_tables autofs4
> [  200.360472] CPU: 10 PID: 7194 Comm: drmgr Tainted: G        W       4.=
10.0-next-20170227 #3
> [  200.360478] task: c0000008b7222b00 task.stack: c0000008b72dc000
> [  200.360483] NIP: c000000001b6b4b8 LR: c000000001b6b4b4 CTR: c000000001=
cefb50
> [  200.360488] REGS: c0000008b72df860 TRAP: 0700   Tainted: G        W   =
     (4.10.0-next-20170227)
> [  200.360494] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>
> [  200.360506]   CR: 22000422  XER: 00000007
> [  200.360511] CFAR: c000000001faf738 SOFTE: 1
> [  200.360511] GPR00: c000000001b6b4b4 c0000008b72dfae0 c00000000266c300 =
0000000000000026
> [  200.360511] GPR04: c00000050fd8adb0 c00000050fda1660 0000000000419000 =
000000000000ff00
> [  200.360511] GPR08: 0000000000000000 c00000000235143c 000000050da40000 =
00000000000001d7
> [  200.360511] GPR12: 0000000000000000 c00000000ea82800 0000000000000000 =
0000000000000000
> [  200.360511] GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000
> [  200.360511] GPR20: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000
> [  200.360511] GPR24: 0000000000000000 0000000010018430 c0000005dd05f520 =
c0000008b72dfe00
> [  200.360511] GPR28: 0000000000000000 0000000000000016 0000000000000000 =
c0000008b71ffa18
> [  200.360570] NIP [c000000001b6b4b8] refcount_sub_and_test+0xb8/0xf0
> [  200.360575] LR [c000000001b6b4b4] refcount_sub_and_test+0xb4/0xf0
> [  200.360578] Call Trace:
> [  200.360582] [c0000008b72dfae0] [c000000001b6b4b4] refcount_sub_and_tes=
t+0xb4/0xf0 (unreliable)
> [  200.360588] [c0000008b72dfb40] [c000000001b4b0dc] kobject_put+0x3c/0xa=
0
> [  200.360595] [c0000008b72dfbb0] [c000000001e53bf4] of_node_put+0x24/0x4=
0
> [  200.360602] [c0000008b72dfbd0] [c00000000165b4f4] dlpar_cpu_release+0x=
74/0xf0
> [  200.360608] [c0000008b72dfc20] [c0000000015e0e28] arch_cpu_release+0x3=
8/0x70
> [  200.360615] [c0000008b72dfc40] [c000000001c49eb0] cpu_release_store+0x=
40/0x70
> [  200.360622] [c0000008b72dfc70] [c000000001c3d994] dev_attr_store+0x34/=
0x60
> [  200.360629] [c0000008b72dfc90] [c00000000191bc44] sysfs_kf_write+0x64/=
0xa0
> [  200.360634] [c0000008b72dfcb0] [c00000000191aa80] kernfs_fop_write+0x1=
70/0x250
> [  200.360641] [c0000008b72dfd00] [c00000000187c330] __vfs_write+0x40/0x1=
c0
> [  200.360645] [c0000008b72dfd90] [c00000000187dc48] vfs_write+0xc8/0x240
> [  200.360650] [c0000008b72dfde0] [c00000000187f8b0] SyS_write+0x60/0x110
> [  200.360656] [c0000008b72dfe30] [c0000000015cb8e0] system_call+0x38/0xf=
c
> [  200.360660] Instruction dump:
> [  200.360663] 7d495378 419e0044 2f89ffff 7d434850 7f0a4840 79460020 41de=
001c 4099ffbc
> [  200.360675] 3c62ffb6 38636af8 48444249 60000000 <0fe00000> 38210060 38=
600000 e8010010
> [  200.360686] ---[ end trace 937482186422ac36 ]---
>
> I have attached the dmesg log.
>
> Thanks
> -Sachin
>
>
>



--=20
Kees Cook
Pixel Security
