Return-Path: <srs0=hhd3=2y=linux.vnet.ibm.com=sachinp@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjpJg28SBzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 21:49:39 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vjpJg1GHnz8syJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 21:49:39 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vjpJf0vwxz9ryT
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Mar 2017 21:49:37 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2FAjauI061712
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Mar 2017 06:49:34 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 296ng06t90-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Mar 2017 06:49:33 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Wed, 15 Mar 2017 20:49:30 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2FAnKri40108166
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Mar 2017 21:49:28 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2FAmuV8020716
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Mar 2017 21:48:56 +1100
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [FIX PATCH v1] powerpc/pseries: Fix reference count leak during
 CPU unplug
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <c135c292-d88f-d209-bd96-21c8aa7b2c68@linux.vnet.ibm.com>
Date: Wed, 15 Mar 2017 16:18:29 +0530
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 nfont@linux.vnet.ibm.com, Grant Likely <grant.likely@linaro.org>
References: <1489034268-24888-1-git-send-email-bharata@linux.vnet.ibm.com>
 <cd939dd8-c04a-54df-2b4f-e1b90e3c6cc7@linux.vnet.ibm.com>
 <20170313102910.GA21558@in.ibm.com>
 <c135c292-d88f-d209-bd96-21c8aa7b2c68@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Message-Id: <9F7E3EBF-57A6-455B-8C53-3D799B9CCE00@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>> So you suggest that adding of_node_get() to __of_attach_node_sysfs()
>> is the right fix ?
>=20
> If I understand that this only creates for hot-added cpus then no. =
Also
> for this to be the correct fix I would expect to see this recreate for
> all hot-remove operations such as memory and pci devices as well.
>=20

So I can recreate this problem while removing a I/O adapter as well.

Here is a trace against 4.11.0-rc1-next20170310 while performing
a DLPAR remove operation on a I/O adapter.

[  549.815605] rpaphp: Slot [U78C7.001.RCH0042-P1-C1] registered
[  549.815608] rpadlpar_io: slot PHB 64 added
[  575.267302] iommu: Removing device 0040:01:00.0 from group 1
[  575.267401] iommu: Removing device 0040:01:00.1 from group 1
[  575.267842] refcount_t: underflow; use-after-free.
[  575.267855] ------------[ cut here ]------------
[  575.267862] WARNING: CPU: 2 PID: 3837 at lib/refcount.c:128 =
refcount_sub_and_test+0xf4/0x110
[  575.267865] Modules linked in: rpadlpar_io rpaphp dccp_diag dccp =
tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag =
rpcrdma sunrpc ib_isert iscsi_target_mod ib_iser libiscsi =
scsi_transport_iscsi ib_srpt target_core_mod ib_srp ib_ipoib rdma_ucm =
ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm iw_cxgb3 ib_core =
ghash_generic xts gf128mul tpm_ibmvtpm tpm vmx_crypto pseries_rng sg =
binfmt_misc ip_tables xfs libcrc32c sr_mod sd_mod cdrom cxgb3 ibmvscsi =
ibmveth scsi_transport_srp mdio dm_mirror dm_region_hash dm_log dm_mod
[  575.267904] CPU: 2 PID: 3837 Comm: drmgr Not tainted =
4.11.0-rc1-next-20170310 #4
[  575.267907] task: c00000076f041600 task.stack: c00000076f084000
[  575.267910] NIP: c000000001aa69c4 LR: c000000001aa69c0 CTR: =
00000000006338e4
[  575.267913] REGS: c00000076f0878a0 TRAP: 0700   Not tainted  =
(4.11.0-rc1-next-20170310)
[  575.267915] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>
[  575.267920]   CR: 42002422  XER: 00000007
[  575.267923] CFAR: c000000001edb5e0 SOFTE: 1=20
[  575.267923] GPR00: c000000001aa69c0 c00000076f087b20 c000000002605f00 =
0000000000000026=20
[  575.267923] GPR04: 0000000000000000 800000100fe93ec0 0000000000492b9a =
0000000000000000=20
[  575.267923] GPR08: 0000000000000001 0000000000000007 0000000000000006 =
0000000000003ff0=20
[  575.267923] GPR12: 0000000000002200 c00000000e801200 0000000000000000 =
0000000000000000=20
[  575.267923] GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[  575.267923] GPR20: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[  575.267923] GPR24: 0000000000000000 c0000001db50a78c 0000000010016650 =
0000000000000000=20
[  575.267923] GPR28: c0000001dd1a7500 c0000001dd1a7200 c0000001db50a780 =
c0000001dd1a7258=20
[  575.267955] NIP [c000000001aa69c4] refcount_sub_and_test+0xf4/0x110
[  575.267958] LR [c000000001aa69c0] refcount_sub_and_test+0xf0/0x110
[  575.267960] Call Trace:
[  575.267962] [c00000076f087b20] [c000000001aa69c0] =
refcount_sub_and_test+0xf0/0x110 (unreliable)
[  575.267967] [c00000076f087b80] [c000000001a84f1c] =
kobject_put+0x3c/0xa0
[  575.267972] [c00000076f087bf0] [c000000001d239b4] =
of_node_put+0x24/0x40
[  575.267976] [c00000076f087c10] [c00000000165ce74] =
ofdt_write+0x204/0x6b0
[  575.267980] [c00000076f087cd0] [c00000000197bde0] =
proc_reg_write+0x80/0xd0
[  575.267984] [c00000076f087d00] [c0000000018df040] =
__vfs_write+0x40/0x1c0
[  575.267987] [c00000076f087d90] [c0000000018e0998] =
vfs_write+0xc8/0x240
[  575.267991] [c00000076f087de0] [c0000000018e2600] =
SyS_write+0x60/0x110
[  575.267995] [c00000076f087e30] [c0000000015cb184] =
system_call+0x38/0xe0
[  575.267997] Instruction dump:
[  575.267999] 7863d182 4e800020 7c0802a6 39200001 3d42fff8 3c62ffb1 =
386306a0 992afd41=20
[  575.268004] f8010010 f821ffa1 48434be5 60000000 <0fe00000> 38210060 =
38600000 e8010010=20
[  575.268010] ---[ end trace e6c0a4371a0aa4e2 ]=E2=80=94

Thanks
-Sachin=
