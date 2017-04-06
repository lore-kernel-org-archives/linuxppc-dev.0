Return-Path: <srs0=wlyf=3o=linux.vnet.ibm.com=tyreld@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzZSm6QPlzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 06:44:24 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzZSm5gQJz8svT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 06:44:24 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzZSm13Jnz9s80
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 06:44:23 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v36Kd0n0064457
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2017 16:44:13 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29nph2hs4b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Apr 2017 16:44:12 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 6 Apr 2017 14:44:11 -0600
Subject: Re: WARN @lib/refcount.c:128 during hot unplug of I/O adapter.
To: Sachin Sant <sachinp@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
References: <E5B3D5CE-EB6A-4470-B7E9-4F6F7B029809@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "nfont >> Nathan Fontenot" <nfont@linux.vnet.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 6 Apr 2017 13:44:07 -0700
MIME-Version: 1.0
In-Reply-To: <E5B3D5CE-EB6A-4470-B7E9-4F6F7B029809@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <a7a782f2-3783-fd96-eda9-1c7634b2a2e5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/06/2017 03:27 AM, Sachin Sant wrote:
> On a POWER8 LPAR running 4.11.0-rc5, a hot unplug operation on
> any I/O adapter results in the following warning
> 
> This problem has been in the code for some time now. I had first seen this in
> -next tree.
> 
> [  269.589441] rpadlpar_io: slot PHB 72 removed
> [  270.589997] refcount_t: underflow; use-after-free.
> [  270.590019] ------------[ cut here ]------------
> [  270.590025] WARNING: CPU: 5 PID: 3335 at lib/refcount.c:128 refcount_sub_and_test+0xf4/0x110
> [  270.590028] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 tun bridge stp llc rpadlpar_io rpaphp kvm_pr kvm ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter dccp_diag dccp tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag ghash_generic xts gf128mul vmx_crypto tpm_ibmvtpm tpm sg pseries_rng nfsd auth_rpcgss nfs_acl lockd grace sunrpc binfmt_misc ip_tables xfs libcrc32c sr_mod sd_mod cdrom ibmvscsi ibmveth scsi_transport_srp dm_mirror dm_region_hash dm_log dm_mod
> [  270.590076] CPU: 5 PID: 3335 Comm: drmgr Not tainted 4.11.0-rc5 #3
> [  270.590079] task: c0000005d8df8600 task.stack: c0000000fb3a8000
> [  270.590081] NIP: c000000001aa3ca4 LR: c000000001aa3ca0 CTR: 00000000006338e4
> [  270.590084] REGS: c0000000fb3ab8a0 TRAP: 0700   Not tainted  (4.11.0-rc5)
> [  270.590087] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>
> [  270.590090]   CR: 22002422  XER: 00000007
> [  270.590093] CFAR: c000000001edaabc SOFTE: 1 
> [  270.590093] GPR00: c000000001aa3ca0 c0000000fb3abb20 c0000000025ea900 0000000000000026 
> [  270.590093] GPR04: c00000077fc4ada0 c00000077fc617b8 00000000000f0c33 0000000000000000 
> [  270.590093] GPR08: 0000000000000000 c00000000227146c 000000077d9e0000 0000000000003ff0 
> [  270.590093] GPR12: 0000000000002200 c00000000e802d00 0000000000000000 0000000000000000 
> [  270.590093] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [  270.590093] GPR20: 0000000000000000 000000001001b5a8 0000000010018338 0000000010016650 
> [  270.590093] GPR24: 000000001001b278 c000000776e0fdcc 0000000010016650 0000000000000000 
> [  270.590093] GPR28: c00000077ffea910 c0000000fbf79180 c000000776e0fdc0 c0000000fbf791d8 
> [  270.590126] NIP [c000000001aa3ca4] refcount_sub_and_test+0xf4/0x110
> [  270.590129] LR [c000000001aa3ca0] refcount_sub_and_test+0xf0/0x110
> [  270.590132] Call Trace:
> [  270.590134] [c0000000fb3abb20] [c000000001aa3ca0] refcount_sub_and_test+0xf0/0x110 (unreliable)
> [  270.590139] [c0000000fb3abb80] [c000000001a8221c] kobject_put+0x3c/0xa0
> [  270.590143] [c0000000fb3abbf0] [c000000001d22d34] of_node_put+0x24/0x40
> [  270.590147] [c0000000fb3abc10] [c00000000165c874] ofdt_write+0x204/0x6b0
> [  270.590151] [c0000000fb3abcd0] [c00000000197a220] proc_reg_write+0x80/0xd0
> [  270.590155] [c0000000fb3abd00] [c0000000018de680] __vfs_write+0x40/0x1c0
> [  270.590158] [c0000000fb3abd90] [c0000000018dffd8] vfs_write+0xc8/0x240
> [  270.590162] [c0000000fb3abde0] [c0000000018e1c40] SyS_write+0x60/0x110
> [  270.590165] [c0000000fb3abe30] [c0000000015cb184] system_call+0x38/0xe0
> [  270.590168] Instruction dump:
> [  270.590170] 7863d182 4e800020 7c0802a6 39200001 3d42fff8 3c62ffb1 386371a8 992a0171 
> [  270.590175] f8010010 f821ffa1 48436de1 60000000 <0fe00000> 38210060 38600000 e8010010 
> [  270.590180] ---[ end trace 08c7a2f3c8bead33 ]—
> 
> Have attached the dmesg log from the system. Let me know if any additional
> information is required to help debug this problem.

I remember you mentioning this when the issue was brought up for CPUs. I
assume the case is the same here where the issue is only seen with
adapters that were hot-added after boot (ie. hot-remove of adapter
present at boot doesn't trip the warning)?

-Tyrel

> 
> Thanks
> -Sachin
> 
> 
