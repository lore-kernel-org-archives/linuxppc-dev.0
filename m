Return-Path: <sachinp@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWwqL52L4zDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 20:08:30 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vWwqL118Dz9s8X
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2017 20:08:29 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1R96FK3147303
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2017 04:08:27 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28u6y65s7w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2017 04:08:27 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Mon, 27 Feb 2017 14:38:24 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id F1AC2E005B
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2017 14:40:04 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1R98LF99437222
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2017 14:38:21 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1R98KW7014344
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2017 14:38:21 +0530
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: [next 20170227] Memory hot plug results in kernel BUG at
 mm/memory_hotplug.c:2180!
Date: Mon, 27 Feb 2017 14:38:20 +0530
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org
Message-Id: <8A79BDFE-3D69-4C86-8D60-B74692C7D089@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Trying to add memory via DLPAR operation on a POWER 8 LPAR running
today=E2=80=99s next results in a crash.

This problem was introduced in today=E2=80=99s next. Possible cause is =
following commit:
dc18d706a4367 : memory-hotplug: use dev_online for memhp_auto_online

[   42.377988] rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
[root@alp12 ~]# [  115.179128] pseries-hotplug-mem: Attempting to =
hot-add 60 LMB(s)
[  115.194879] Unable to resize hash page table to target order 24: -19
[  115.195267] Built 2 zonelists in Node order, mobility grouping on.  =
Total pages: 240639
[  115.195271] Policy zone: DMA
[  115.196128] Built 2 zonelists in Node order, mobility grouping on.  =
Total pages: 244735
[  115.196131] Policy zone: DMA
[  115.196209] removing memory fails, because memory =
[0x00000003c0000000-0x00000003cfffffff] is onlined
[  115.196219] ------------[ cut here ]------------
[  115.196221] kernel BUG at mm/memory_hotplug.c:2180!
[  115.196225] Oops: Exception in kernel mode, sig: 5 [#1]
[  115.196227] SMP NR_CPUS=3D2048=20
[  115.196227] NUMA=20
[  115.196229] pSeries
[  115.196232] Modules linked in: rpadlpar_io rpaphp iptable_mangle =
ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat =
nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT =
nf_reject_ipv4 xt_tcpudp tun bridge stp llc kvm iptable_filter =
vmx_crypto pseries_rng rng_core binfmt_misc nfsd ip_tables x_tables =
autofs4
[  115.196254] CPU: 0 PID: 67 Comm: kworker/u33:2 Tainted: G        W    =
   4.10.0-next-20170227 #1
[  115.196260] Workqueue: pseries hotplug workque pseries_hp_work_fn
[  115.196263] task: c0000003b903c200 task.stack: c0000003b90fc000
[  115.196266] NIP: c0000000018789d0 LR: c000000001878958 CTR: =
c000000001cefb50
[  115.196269] REGS: c0000003b90ff7a0 TRAP: 0700   Tainted: G        W   =
     (4.10.0-next-20170227)
[  115.196272] MSR: 800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>
[  115.196277]   CR: 42002022  XER: 00000009
[  115.196281] CFAR: c00000000187895c SOFTE: 1=20
[  115.196281] GPR00: c000000001878958 c0000003b90ffa20 c00000000266c300 =
0000000000000001=20
[  115.196281] GPR04: c0000003ab85ec80 0000000000000068 0000000000000002 =
0000000000000003=20
[  115.196281] GPR08: 0000000000000003 0000000000000003 0000000000000003 =
00000000000001a3=20
[  115.196281] GPR12: 0000000000002200 c00000000ea80000 c0000000016b4848 =
c0000003b9c30000=20
[  115.196281] GPR16: 0000000000000000 0000000000000010 c0000003bfff1a10 =
c0000003bfff1ae0=20
[  115.196281] GPR20: c0000003b82b3b44 0000000000000004 0000000000000002 =
0000000000000010=20
[  115.196281] GPR24: 0000000000000004 0000000000000002 0000000000000000 =
0000000000000001=20
[  115.196281] GPR28: 0000000000000001 0000000000000000 0000000010000000 =
00000003c0000000=20
[  115.196317] NIP [c0000000018789d0] remove_memory+0xe0/0xf0
[  115.196320] LR [c000000001878958] remove_memory+0x68/0xf0
[  115.196322] Call Trace:
[  115.196324] [c0000003b90ffa20] [c000000001878958] =
remove_memory+0x68/0xf0 (unreliable)
[  115.196329] [c0000003b90ffa60] [c00000000165d294] =
dlpar_add_lmb+0x394/0x410
[  115.196333] [c0000003b90ffb40] [c00000000165e004] =
dlpar_memory+0x644/0xd80
[  115.196336] [c0000003b90ffbf0] [c000000001656968] =
handle_dlpar_errorlog+0xe8/0x150
[  115.196340] [c0000003b90ffc60] [c000000001656a04] =
pseries_hp_work_fn+0x34/0x90
[  115.196345] [c0000003b90ffc90] [c0000000016aca44] =
process_one_work+0x174/0x490
[  115.196349] [c0000003b90ffd20] [c0000000016acdf8] =
worker_thread+0x98/0x530
[  115.196352] [c0000003b90ffdc0] [c0000000016b498c] kthread+0x14c/0x190
[  115.196357] [c0000003b90ffe30] [c0000000015cbc60] =
ret_from_kernel_thread+0x5c/0x7c
[  115.196360] Instruction dump:
[  115.196362] 3863d2e8 fb89d2e0 4872c231 60000000 38210040 e8010010 =
eb81ffe0 eba1ffe8=20
[  115.196368] ebc1fff0 ebe1fff8 7c0803a6 4e800020 <0fe00000> 00000000 =
00000000 00000000=20
[  115.196374] ---[ end trace c012fadf5f8c4e40 ]---
[  115.196376]=20

Thanks
-Sachin=
