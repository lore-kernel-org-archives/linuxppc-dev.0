Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418YDK5gcwzF0f7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 00:21:05 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5IEK1CZ002199
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 10:21:02 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jpe1hh7kf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 10:21:02 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 18 Jun 2018 10:21:01 -0400
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/numa: Handle unitialized timer reset
Date: Mon, 18 Jun 2018 09:20:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <2c2ac709-acc5-67a6-6f40-889de7ca672e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the code in 'numa.c' may be reused when updating kernel
state after an LPAR migration event.  One such common function
is 'reset_topology_timer' which was being invoked by the
'.notifier_call' function within the NUMA module by
'of_property_notify'.  If this occurs after a previous call to
'stop_topology_update' or on a system without VPHN enabled, the
code runs into an unitialized timer structure and crashes.  This
patch adds a safety check along this path toward the problem code.

Note: This crash was observed on every LPM in the 4.17-rc7 kernel
of a system with dedicated CPUs enabled.  An example crash log
without the patch is as follows.

  [ 2571.437467] ibmvscsi 30000081: Re-enabling adapter!
[ 2571.673850] ------------[ cut here ]------------
[ 2571.673863] kernel BUG at kernel/time/timer.c:958!
[ 2571.673875] Oops: Exception in kernel mode, sig: 5 [#1]
[ 2571.673877] LE SMP NR_CPUS=2048 NUMA pSeries
[ 2571.673886] Modules linked in: nfsv3 nfs_acl nfs tcp_diag udp_diag inet_diag lockd unix_diag af_packet_diag netlink_diag grace fscache sunrpc xts vmx_crypto pseries_rng sg binfmt_misc ip_tables xfs libcrc32c sd_mod ibmvscsi ibmveth scsi_transport_srp dm_mirror dm_region_hash dm_log dm_mod
[ 2571.673969] CPU: 11 PID: 3067 Comm: drmgr Not tainted 4.17.0+ #179
[ 2571.673972] NIP:  c000000000198a2c LR: c000000000075990 CTR: 0000000000000000
[ 2571.673975] REGS: c0000003f9407560 TRAP: 0700   Not tainted  (4.17.0+)
[ 2571.673977] MSR:  800000010282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 44482824  XER: 00000000
[ 2571.673990] CFAR: c00000000007598c SOFTE: 0 
[ 2571.673990] GPR00: c000000000075990 c0000003f94077e0 c00000000113a900 c0000000012e5968 
[ 2571.673990] GPR04: 000000010003776b c0000003ffa05180 0000000000000020 c0000003f9407850 
[ 2571.673990] GPR08: 0000000000000000 0000000000000001 ffffffffffffffff 0000000000000220 
[ 2571.673990] GPR12: c000000000076560 c00000001ec90200 0000000040000000 0000000000000018 
[ 2571.673990] GPR16: 0000000000000000 000000000000000d c0000003e9ea5015 0000000000000010 
[ 2571.673990] GPR20: 000000000000000b 0000000000000050 c0000003e9ea4068 0000000000000001 
[ 2571.673990] GPR24: 000000000000001c c0000003ffff3ab0 0000000000000000 c0000003f9407990 
[ 2571.673990] GPR28: 0000000000000005 c0000003ffff3ab0 000000010003776b c0000000012e5968 
[ 2571.674042] NIP [c000000000198a2c] mod_timer+0x4c/0x400
[ 2571.674051] LR [c000000000075990] reset_topology_timer+0x40/0x60
[ 2571.674053] Call Trace:
[ 2571.674056] [c0000003f94077e0] [c0000003f9407830] 0xc0000003f9407830 (unreliable)
[ 2571.674060] [c0000003f9407860] [c000000000075990] reset_topology_timer+0x40/0x60
[ 2571.674063] [c0000003f9407880] [c000000000076660] dt_update_callback+0x100/0x120
[ 2571.674072] [c0000003f94078d0] [c00000000012ada0] notifier_call_chain+0x90/0x100
[ 2571.674077] [c0000003f9407920] [c00000000012b270] __blocking_notifier_call_chain+0x60/0x90
[ 2571.674092] [c0000003f9407970] [c0000000007b9a60] of_property_notify+0x90/0xd0
[ 2571.674096] [c0000003f94079d0] [c0000000007b4644] of_update_property+0x104/0x150
[ 2571.674103] [c0000003f9407a30] [c0000000000c0ddc] update_dt_property+0xdc/0x1f0
[ 2571.674106] [c0000003f9407a90] [c0000000000c11c0] pseries_devicetree_update+0x2d0/0x510
[ 2571.674110] [c0000003f9407bc0] [c0000000000c147c] post_mobility_fixup+0x7c/0xf0
[ 2571.674113] [c0000003f9407c30] [c0000000000c1594] migration_store+0xa4/0xc0
[ 2571.674123] [c0000003f9407c70] [c000000000989940] kobj_attr_store+0x30/0x60
[ 2571.674133] [c0000003f9407c90] [c00000000040b294] sysfs_kf_write+0x64/0xa0
[ 2571.674136] [c0000003f9407cb0] [c00000000040a02c] kernfs_fop_write+0x16c/0x240
[ 2571.674146] [c0000003f9407d00] [c00000000034eeb0] __vfs_write+0x40/0x200
[ 2571.674149] [c0000003f9407d90] [c00000000034f288] vfs_write+0xc8/0x240
[ 2571.674152] [c0000003f9407de0] [c00000000034f5bc] ksys_write+0x5c/0x100
[ 2571.674158] [c0000003f9407e30] [c00000000000b284] system_call+0x58/0x6c
[ 2571.674161] Instruction dump:
[ 2571.674163] fb01ffc0 7c7f1b78 fb21ffc8 fb41ffd0 fb61ffd8 fb81ffe0 fba1ffe8 f8010010 
[ 2571.674168] f821ff81 e9230018 7d290074 7929d182 <0b090000> e9230008 2fa90000 419e0278 
[ 2571.674176] ---[ end trace 0c7939657d5522df ]---

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 57a5029..8802e7d 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1457,7 +1457,8 @@ static void topology_timer_fn(struct timer_list *unused)
 
 static void reset_topology_timer(void)
 {
-	mod_timer(&topology_timer, jiffies + topology_timer_secs * HZ);
+	if (vphn_enabled)
+		mod_timer(&topology_timer, jiffies + topology_timer_secs * HZ);
 }
 
 #ifdef CONFIG_SMP
