Return-Path: <daniel.black@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmct33Gm3zDrDg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 16:55:23 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v856sgaX017740
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Sep 2017 02:55:20 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2csmxanhj5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Sep 2017 02:55:20 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <daniel.black@au1.ibm.com>;
 Tue, 5 Sep 2017 16:55:17 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v856tGZX32833656
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Sep 2017 16:55:16 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v856tH5N016483
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Sep 2017 16:55:17 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v856tHDt016469
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Sep 2017 16:55:17 +1000
Received: from hopper.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 7EFA8A012A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 16:55:15 +1000 (AEST)
To: linuxppc-dev@lists.ozlabs.org
From: Daniel Black <daniel.black@au1.ibm.com>
Subject: oops: arch_update_cpu_topology -> lockdep_assert_cpus_held
Date: Tue, 5 Sep 2017 16:55:15 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <13005e1b-a194-1c60-8bdf-754211a21402@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


4.13-rc3 mainline at b1b6f83ac938d176742c85757960dec2cf10e468

Backtrace occurred for every CPU during boot.

its a kvm host machine.


[ 254.131688] new mount options do not match the existing superblock,
will be ignored
[ 255.654622] ------------[ cut here ]------------
[ 255.654658] WARNING: CPU: 1 PID: 14 at kernel/cpu.c:240
lockdep_assert_cpus_held+0x54/0x80
[ 255.654661] Modules linked in: bridge stp llc binfmt_misc kvm_hv kvm
leds_powernv vmx_crypto powernv_rng rng_core led_class powernv_op_panel
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
[ 255.654734] CPU: 1 PID: 14 Comm: cpuhp/1 Tainted: G W 4.13.0 #1
[ 255.654737] task: c000001ff25fa100 task.stack: c000001ff2578000
[ 255.654740] NIP: c0000000000f8624 LR: c0000000000f8618 CTR:
c0000000001763e0
[ 255.654742] REGS: c000001ff257b780 TRAP: 0700 Tainted: G W (4.13.0)
[ 255.654744] MSR: 9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>
[ 255.654764] CR: 24200422 XER: 00000000
[ 255.654766] CFAR: c0000000001783d0 SOFTE: 1
GPR00: c0000000000f8618 c000001ff257ba00 c000000001042100 0000000000000000
GPR04: ffffffffffffffff 0000000000000001 0000000000000000 0000000000000000
GPR08: 0000001ffe490000 0000000000000000 0000000000000000 c000007fee782f50
GPR12: 0000000000000000 c00000000fd80500 c00000000012c878 c000001ff6209180
GPR16: 0000000000000000 0000000000000000 c000000000ef2728 0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000001 0000000000000000
GPR24: 0000000000000000 c000000001087d50 c000000000fe0e7d c0000000001448c0
GPR28: 0000001ffe490000 0000000000000000 0000000000000002 c000000001088050
[ 255.654842] NIP [c0000000000f8624] lockdep_assert_cpus_held+0x54/0x80
[ 255.654845] LR [c0000000000f8618] lockdep_assert_cpus_held+0x48/0x80
[ 255.654847] Call Trace:
[ 255.654851] [c000001ff257ba00] [c0000000000f8618]
lockdep_assert_cpus_held+0x48/0x80 (unreliable)
[ 255.654858] [c000001ff257ba20] [c00000000007a848]
arch_update_cpu_topology+0x18/0x30
[ 255.654864] [c000001ff257ba40] [c00000000016bd0c]
partition_sched_domains+0x8c/0x4e0
[ 255.654870] [c000001ff257baf0] [c00000000020a914]
cpuset_update_active_cpus+0x24/0x60
[ 255.654876] [c000001ff257bb10] [c0000000001449bc]
sched_cpu_deactivate+0xfc/0x1a0
[ 255.654882] [c000001ff257bc20] [c0000000000f5a8c]
cpuhp_invoke_callback+0x19c/0xe00
[ 255.654888] [c000001ff257bcb0] [c0000000000f6868]
cpuhp_down_callbacks+0x78/0xf0
[ 255.654893] [c000001ff257bd00] [c0000000000f6c1c]
cpuhp_thread_fun+0x1fc/0x210
[ 255.654899] [c000001ff257bd50] [c000000000132f4c]
smpboot_thread_fn+0x2fc/0x370
[ 255.654905] [c000001ff257bdc0] [c00000000012ca24] kthread+0x1b4/0x1c0
[ 255.654911] [c000001ff257be30] [c00000000000bcec]
ret_from_kernel_thread+0x5c/0x70
[ 255.654914] Instruction dump:
[ 255.654919] 4e800020 60000000 60420000 7c0802a6 3c62ffeb 3880ffff
38639280 f8010030
[ 255.654934] 4807fd45 60000000 2fa30000 409e0020 <0fe00000> e8010030
38210020 7c0803a6
[ 255.654950] ---[ end trace 06efa323f571f14b ]---
[ 255.894356] ------------[ cut here ]------------
[ 255.894367] WARNING: CPU: 2 PID: 20 at kernel/cpu.c:240
lockdep_assert_cpus_held+0x54/0x80
[ 255.894370] Modules linked in: bridge stp llc binfmt_misc kvm_hv kvm
leds_powernv vmx_crypto powernv_rng rng_core led_class powernv_op_panel
autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en
raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic
crct10dif_common mlx4_core
[ 255.894438] CPU: 2 PID: 20 Comm: cpuhp/2 Tainted: G W 4.13.0 #1
[ 255.894441] task: c000001ff25e8a00 task.stack: c000001ff2700000
[ 255.894444] NIP: c0000000000f8624 LR: c0000000000f8618 CTR:
c000000000146650
[ 255.894447] REGS: c000001ff2703780 TRAP: 0700 Tainted: G W (4.13.0)
[ 255.894448] MSR: 9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>
[ 255.894468] CR: 24200422 XER: 00000000
[ 255.894470] CFAR: c0000000001783d0 SOFTE: 1
GPR00: c0000000000f8618 c000001ff2703a00 c000000001042100 0000000000000000
GPR04: ffffffffffffffff 0000000000000006 c000001fe60ec000 0000000000000001
GPR08: 0000000000000000 0000000000000000 0000000000000000 c000007fe9acf550
GPR12: 0000000000000000 c00000000fd80a00 c00000000012c878 c000001ff6209180
GPR16: 0000000000000000 0000000000000000 c000000000ef2728 0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000001 0000000000000000
GPR24: 0000000000000000 c000000001087d50 c000000000fe0e7d c0000000001448c0
GPR28: 0000001ffe4d0000 0000000000000000 0000000000000004 c000000001088050
[ 255.894543] NIP [c0000000000f8624] lockdep_assert_cpus_held+0x54/0x80
[ 255.894546] LR [c0000000000f8618] lockdep_assert_cpus_held+0x48/0x80
[ 255.894549] Call Trace:
[ 255.894552] [c000001ff2703a00] [c0000000000f8618]
lockdep_assert_cpus_held+0x48/0x80 (unreliable)
[ 255.894560] [c000001ff2703a20] [c00000000007a848]
arch_update_cpu_topology+0x18/0x30
[ 255.894566] [c000001ff2703a40] [c00000000016bd0c]
partition_sched_domains+0x8c/0x4e0
[ 255.894572] [c000001ff2703af0] [c00000000020a914]
cpuset_update_active_cpus+0x24/0x60
[ 255.894577] [c000001ff2703b10] [c0000000001449bc]
sched_cpu_deactivate+0xfc/0x1a0
[ 255.894583] [c000001ff2703c20] [c0000000000f5a8c]
cpuhp_invoke_callback+0x19c/0xe00
[ 255.894588] [c000001ff2703cb0] [c0000000000f6868]
cpuhp_down_callbacks+0x78/0xf0
[ 255.894594] [c000001ff2703d00] [c0000000000f6c1c]
cpuhp_thread_fun+0x1fc/0x210
[ 255.894599] [c000001ff2703d50] [c000000000132f4c]
smpboot_thread_fn+0x2fc/0x370
[ 255.894604] [c000001ff2703dc0] [c00000000012ca24] kthread+0x1b4/0x1c0
[ 255.894610] [c000001ff2703e30] [c00000000000bcec]
ret_from_kernel_thread+0x5c/0x70
[ 255.894614] Instruction dump:
[ 255.894618] 4e800020 60000000 60420000 7c0802a6 3c62ffeb 3880ffff
38639280 f8010030
[ 255.894633] 4807fd45 60000000 2fa30000 409e0020 <0fe00000> e8010030
38210020 7c0803a6
[ 255.894649] ---[ end trace 06efa323f571f14c ]---

ref: https://github.com/linuxppc/linux/issues/106
ref to self:
https://jenkins/job/linux_pipeline/job/upstream%252Fmaster/453/artifact/pseries_le/gcc-7-branch
