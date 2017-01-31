Return-Path: <sachinp@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCNb10XgWzDq98
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 22:00:28 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0VAxNou000550
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 06:00:27 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28a6qpt901-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 06:00:26 -0500
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Tue, 31 Jan 2017 16:30:22 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 311433940060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 16:30:20 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0VAxOLs28770312
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 16:29:24 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0VB0Ipc011887
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 16:30:19 +0530
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [tip:sched/core] sched/core: Add debugging code to catch missing
 update_rq_clock() calls
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20170130213435.GM31613@codeblueprint.co.uk>
Date: Tue, 31 Jan 2017 16:30:12 +0530
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 peterz@infradead.org,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 linux-kernel@vger.kernel.org
References: <20160921133813.31976-8-matt@codeblueprint.co.uk>
 <tip-cb42c9a3ebbbb23448c3f9a25417fae6309b1a92@git.kernel.org>
 <87tw8gutp6.fsf@concordia.ellerman.id.au>
 <20170130213435.GM31613@codeblueprint.co.uk>
To: Matt Fleming <matt@codeblueprint.co.uk>,
 Michael Ellerman <mpe@ellerman.id.au>
Message-Id: <33118425-8548-475A-8DED-9A2424C0BCCC@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Trimming the cc list.

>> I assume I should be worried?
>=20
> Thanks for the report. No need to worry, the bug has existed for a
> while, this patch just turns on the warning ;-)
>=20
> The following commit queued up in tip/sched/core should fix your
> issues (assuming you see the same callstack on all your powerpc
> machines):
>=20
>  =
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=3Dsched=
/core&id=3D1b1d62254df0fe42a711eb71948f915918987790

I still see this warning with today=E2=80=99s next running inside =
PowerVM LPAR
on a POWER8 box. The stack trace is different from what Michael had
reported.

Easiest way to recreate this is to Online/offline cpu=E2=80=99s.

[  114.795609] rq->clock_update_flags < RQCF_ACT_SKIP
[  114.795621] ------------[ cut here ]------------
[  114.795632] WARNING: CPU: 2 PID: 27 at kernel/sched/sched.h:804 =
set_next_entity+0xbc8/0xcc0
[  114.795634] Modules linked in: xt_CHECKSUM iptable_mangle =
ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat =
nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT =
nf_reject_ipv4 tun bridge stp llc rpadlpar_io rpaphp kvm_pr kvm =
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter =
dccp_diag dccp tcp_diag udp_diag inet_diag unix_diag af_packet_diag =
netlink_diag rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi =
scsi_transport_iscsi ib_srpt target_core_mod ib_srp ib_ipoib rdma_ucm =
ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm iw_cxgb3 ib_core =
ghash_generic xts gf128mul tpm_ibmvtpm tpm sg vmx_crypto pseries_rng =
nfsd auth_rpcgss nfs_acl lockd grace sunrpc binfmt_misc ip_tables xfs =
libcrc32c sr_mod sd_mod cdrom cxgb3 ibmvscsi ibmveth scsi_transport_srp =
mdio
[  114.795751]  dm_mirror dm_region_hash dm_log dm_mod
[  114.795762] CPU: 2 PID: 27 Comm: migration/2 Not tainted =
4.10.0-rc6-next-20170131 #1
[  114.795765] task: c0000004fa2f8600 task.stack: c0000004fa49c000
[  114.795768] NIP: c000000000114ed8 LR: c000000000114ed4 CTR: =
c0000000004a8cf0
[  114.795771] REGS: c0000004fa49f6a0 TRAP: 0700   Not tainted  =
(4.10.0-rc6-next-20170131)
[  114.795773] MSR: 8000000002823033 <SF,VEC,VSX,FP,ME,IR,DR,RI,LE>
[  114.795787]   CR: 28004022  XER: 00000000
[  114.795789] CFAR: c0000000008ec5c4 SOFTE: 0=20
GPR00: c000000000114ed4 c0000004fa49f920 c00000000100dd00 =
0000000000000026=20
GPR04: 0000000000000000 0000000000000006 6574616470755f6b =
c0000000011cdd00=20
GPR08: 0000000000000000 c000000000c6edb0 000000015ef20000 =
d000000006488538=20
GPR12: 0000000000004400 c00000000e801200 c0000000000ecc38 =
c0000004fe064300=20
GPR16: 0000000000000000 0000000000000001 0000000000000000 =
c000000000f27e08=20
GPR20: c000000000f277c5 0000000000000000 0000000000000004 =
0000000000000000=20
GPR24: c00000015fba49f0 c000000000f27e08 c000000000ef9e80 =
c0000004fa49fb00=20
GPR28: c00000015fba4980 c00000015fba49f0 c0000004f34c1000 =
c00000015fba49f0=20
[  114.795850] NIP [c000000000114ed8] set_next_entity+0xbc8/0xcc0
[  114.795855] LR [c000000000114ed4] set_next_entity+0xbc4/0xcc0
[  114.795857] Call Trace:
[  114.795862] [c0000004fa49f920] [c000000000114ed4] =
set_next_entity+0xbc4/0xcc0 (unreliable)
[  114.795869] [c0000004fa49f9d0] [c000000000119f4c] =
pick_next_task_fair+0xfc/0x6f0
[  114.795874] [c0000004fa49fae0] [c000000000104820] =
sched_cpu_dying+0x3c0/0x450
[  114.795880] [c0000004fa49fb80] [c0000000000c1958] =
cpuhp_invoke_callback+0x148/0x5b0
[  114.795886] [c0000004fa49fbf0] [c0000000000c3340] =
take_cpu_down+0xb0/0x110
[  114.795893] [c0000004fa49fc50] [c0000000001a1e58] =
multi_cpu_stop+0x1a8/0x1e0
[  114.795899] [c0000004fa49fca0] [c0000000001a20c4] =
cpu_stopper_thread+0x104/0x1e0
[  114.795905] [c0000004fa49fd60] [c0000000000f2b90] =
smpboot_thread_fn+0x290/0x2a0
[  114.795911] [c0000004fa49fdc0] [c0000000000ecd7c] kthread+0x14c/0x190
[  114.795919] [c0000004fa49fe30] [c00000000000b4e8] =
ret_from_kernel_thread+0x5c/0x74
[  114.795921] Instruction dump:
[  114.795924] 0fe00000 4bfff884 3d02fff2 89289ac5 2f890000 40fef4ec =
39200001 3c62ffac=20
[  114.795936] 38633698 99289ac5 487d76b5 60000000 <0fe00000> 4bfff4cc =
eb9f0118 e93f0120=20
[  114.795948] ---[ end trace 5c822f32f967fbc5 ]---
[  123.059141] nr_pdflush_threads exported in /proc is scheduled for =
removal

Thanks
-Sachin
