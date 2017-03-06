Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcTfR6y87zDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 06:01:35 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v26Iwpsd139208
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 14:01:29 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 291dcgrebh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 14:01:29 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 7 Mar 2017 00:31:26 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8F9CC125805C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 00:31:39 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v26J1OPF12713994
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 00:31:24 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v26J1Nmx001364
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 00:31:23 +0530
Subject: [next-20170306] Memory off-on resulted in Oops on Power 6 system
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
Cc: "aneesh.kumar" <aneesh.kumar@linux.vnet.ibm.com>, mpe <mpe@ellerman.id>
Date: Tue, 07 Mar 2017 00:31:22 +0530
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1488826882.3961.8.camel@abdul-ThinkPad-T450>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

Today’s next resulted in kernel Oops while running memory-off-on test from kernel selftest.

Kernel Version : 4.11.0-rc1-next-20170306
Machine type : Power6 PowerVM LPAR

[stdout] make[1]: Entering directory
`/var/tmp/avocado_kkNtjt/1-kernel_kselftest.py_kselftest.test/src/linux-4.8.6/tools/testing/selftests/memory-hotplug'
[stdout] ./mem-on-off-test.sh -r 2 || echo "selftests: memory-hotplug
[FAIL]"
[stdout] Test scope: 2% hotplug memory
[stdout] 	 online all hotplug memory in offline state
[stdout] 	 offline 2% hotplug memory in online state
[stdout] 	 online all hotplug memory in offline state
[stdout] online-offline 89
ehea: memory is going offline
ehea: LPAR memory changed - re-initializing driver
ehea: re-initializing driver complete
Offlined Pages 1024
[stdout] online-offline 92
ehea: memory is going offline
ehea: LPAR memory changed - re-initializing driver
ehea: WARNING: sq not flushed completely
ehea: WARNING: sq not flushed completely
ehea: re-initializing driver complete
ehea: memory offlining canceled
ehea: memory is going online
ehea: LPAR memory changed - re-initializing driver
ehea: WARNING: sq not flushed completely
ehea: re-initializing driver complete
Unable to handle kernel paging request for data at address 0x00000008
Faulting instruction address: 0xc000000000205138
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=1024 
NUMA 
pSeries
Modules linked in: xt_CHECKSUM bnep bluetooth nf_conntrack_netbios_ns
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6
nf_defrag_ipv6 cfg80211 ipt_REJECT nf_reject_ipv4 nf_conntrack_ipv4
nf_defrag_ipv4 xt_conntrack nf_conntrack rfkill libcrc32c ebtable_nat
ebtable_broute bridge stp llc ebtable_filter ebtables ip6table_mangle
ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_mangle
iptable_security iptable_raw iptable_filter ip_tables nfsd auth_rpcgss
nfs_acl lockd ses osst enclosure st scsi_transport_sas ehea
uio_pdrv_genirq uio sunrpc grace ipv6 crc_ccitt autofs4 ext4 mbcache
jbd2 sr_mod cdrom sd_mod dm_mirror dm_region_hash dm_log dm_mod
CPU: 8 PID: 8993 Comm: mem-on-off-test Not tainted 4.11.0-rc1-next-20170306-autotest #2
task: c0000000fd47d200 task.stack: c0000000fca18000
NIP: c000000000205138 LR: c0000000002870ec CTR: c00000000082b110
REGS: c0000000fca1b3b0 TRAP: 0300   Not tainted  (4.11.0-rc1-next-20170306-autotest)
MSR: 800000000200b032 <SF,VEC,EE,FP,ME,IR,DR,RI>
  CR: 24222882  XER: 00000007
CFAR: c000000000008920 DAR: 0000000000000008 DSISR: 40000000 SOFTE: 0 
GPR00: c000000000286ec0 c0000000fca1b630 c000000001025400 c0000001c3623800 
GPR04: 0000000000000000 0000000000000002 0000000000000007 0000000000000100 
GPR08: c000000001065400 0000000000000000 0000000000000008 c0000000011b0f00 
GPR12: 0000000024222882 c00000000edc1800 fffffffffffffff5 00000000000000fe 
GPR16: 0000000000017400 0000000000000173 0000000000000400 0000000100002358 
GPR20: c000000001063b00 0000000000000000 6db6db6db6db6db7 c0000001c3ff6500 
GPR24: 0000000000000001 0000000000000008 0000000000000001 0000000000000001 
GPR28: c0000000011b0f00 c0000001c3ff6920 c0000001c3ff6500 c0000001c3620000 
NIP [c000000000205138] .get_pfnblock_flags_mask+0x38/0x70
LR [c0000000002870ec] .unset_migratetype_isolate+0x28c/0x300
Call Trace:
[c0000000fca1b630] [c000000000286ec0] .unset_migratetype_isolate+0x60/0x300 (unreliable)
[c0000000fca1b6e0] [c000000000287608] .undo_isolate_page_range+0x148/0x180
[c0000000fca1b790] [c000000000289448] .__offline_pages.constprop.19+0x268/0xad0
[c0000000fca1b8f0] [c000000000547ae8] .memory_subsys_offline+0x58/0xe0
[c0000000fca1b970] [c000000000525478] .device_offline+0xe8/0x130
[c0000000fca1ba00] [c00000000054793c] .store_mem_state+0x15c/0x180
[c0000000fca1ba90] [c000000000520910] .dev_attr_store+0x30/0x60
[c0000000fca1bb00] [c000000000335be0] .sysfs_kf_write+0x60/0xa0
[c0000000fca1bb70] [c0000000003349c4] .kernfs_fop_write+0x184/0x260
[c0000000fca1bc10] [c00000000028d37c] .__vfs_write+0x3c/0x1a0
[c0000000fca1bcf0] [c00000000028eca0] .vfs_write+0xc0/0x230
[c0000000fca1bd90] [c000000000290878] .SyS_write+0x58/0x100
[c0000000fca1be30] [c00000000000b758] system_call+0x38/0xfc
Instruction dump:
3928bb00 794a1f24 7d29502a 788ac202 2fa90000 419e000c 794a2428 7d295214 
3d020004 78840620 81487564 7c845436 <e9490008> 5484103a 7c8807b4 548406ba 
---[ end trace 911354ae3120f308 ]---


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
