Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 622E5141CB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Apr 2014 19:33:13 +1000 (EST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 25 Apr 2014 10:33:06 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8E97F1B08061
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Apr 2014 10:33:11 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3P9X5lF30801950
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Apr 2014 09:33:05 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3P9X44R010643
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Apr 2014 03:33:05 -0600
Message-ID: <1398418381.2805.168.camel@ThinkPad-T5421.cn.ibm.com>
Subject: [RFC PATCH] Fix Oops in rtas_stop_self()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 25 Apr 2014 17:33:01 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When trying offline cpus, I noticed following Oops in rtas_stop_self(),
and it seems caused by commit 41dd03a9. The Oops disappears after
reverting this commit.

After reading the code, I guess it might be caused by moving the
rtas_args to stack. Still need some more time to read enter_rtas to
understand why it happens, but the problem seems could be solved by
moving the rtas_args away from stack by adding static before it.

[  247.194623] cpu 28 (hwid 28) Ready to die...
[  247.194641] Unable to handle kernel paging request for data at address 0xecb213c50
[  247.194642] Faulting instruction address: 0x0f34157c
[  247.194645] Oops: Kernel access of bad area, sig: 11 [#1]
[  247.194648] SMP NR_CPUS=1024 NUMA pSeries
[  247.194664] Modules linked in: nf_conntrack_netbios_ns nf_conntrack_broadcast ipt_MASQUERADE ip6table_nat nf_nat_ipv6 ip6table_mangle ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 iptable_nat nf_nat_ipv4 nf_nat iptable_mangle nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ebtable_filter ebtables ip6table_filter ip6_tables ehea ibmvscsi scsi_transport_srp scsi_tgt
[  247.194667] CPU: 28 PID: 0 Comm: swapper/28 Not tainted 3.15.0-rc1+ #10
[  247.194670] CPU: 27 PID: 1171 Comm: drmgr Not tainted 3.15.0-rc1+ #10
[  247.194673] task: c0000007ca2f0ba0 ti: c000000ecb210000 task.ti: c000000ecb210000
[  247.194679] NIP: 000000000f34157c LR: 000000000000a84c CTR: 0000000000000151
[  247.194680] REGS: c000000ecb213780 TRAP: 0300   Not tainted  (3.15.0-rc1+)
[  247.194684] MSR: 8000000000001000 <SF,ME>  CR: 00000000  XER: 00000000
[  247.194707] CFAR: c00000000000a844 DAR: 0000000ecb213c50 DSISR: 40000000 SOFTE: 0 
[  247.194707] GPR00: 8000000000001030 c000000ecb213a00 c0000000014c7880 0000000ecb213c50 
[  247.194707] GPR04: 000000000f340000 0000000ecb213c50 0000000000000000 8000000000001032 
[  247.194707] GPR08: 0000000000001000 c000000ecb213a00 0000000000000000 0000000000000000 
[  247.194707] GPR12: 0000000000000000 c00000000f227e00 c00000000091f5b0 000000000f394e2c 
[  247.194707] GPR16: 000000000000001c 0000000000000001 000000000000001c c0000000013ad5b0 
[  247.194707] GPR20: 0000000000000001 0000000000000000 c0000000013bfb89 c000000000d57688 
[  247.194707] GPR24: 000000000000001c c000000000d44e2c c000000ecb210000 c0000000013c0f48 
[  247.194707] GPR28: c000000000d44e28 c00000000150ca68 00000000000000e0 c000000ecb210000 
[  247.194710] NIP [000000000f34157c] 0xf34157c
[  247.194712] LR [000000000000a84c] 0xa84c
[  247.194714] Call Trace:
[  247.194716] [c000000ecb213a00] [000000000000001c] 0x1c (unreliable)
[  247.194722] [c000000ecb213be0] [c00000000007ffe0] .pseries_mach_cpu_die+0x150/0x350
[  247.194725] [c000000ecb213cf0] [c0000000000420cc] .cpu_die+0x3c/0x60
[  247.194727] [c000000ecb213d60] [c000000000017e58] .arch_cpu_idle_dead+0x28/0x40
[  247.194732] [c000000ecb213dd0] [c000000000104f40] .cpu_startup_entry+0x570/0x590
[  247.194735] [c000000ecb213ed0] [c000000000041d4c] .start_secondary+0x2dc/0x310
[  247.194738] [c000000ecb213f90] [c00000000000996c] .start_secondary_prolog+0x10/0x14
[  247.194740] Instruction dump:
[  247.194744] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
[  247.194748] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
[  247.194751] ---[ end trace d1d21584135396ba ]---

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 9b8e050..20d6297 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -88,13 +88,14 @@ void set_default_offline_state(int cpu)
 
 static void rtas_stop_self(void)
 {
-	struct rtas_args args = {
-		.token = cpu_to_be32(rtas_stop_self_token),
+	static struct rtas_args args = {
 		.nargs = 0,
 		.nret = 1,
 		.rets = &args.args[0],
 	};
 
+	args.token = cpu_to_be32(rtas_stop_self_token);
+
 	local_irq_disable();
 
 	BUG_ON(rtas_stop_self_token == RTAS_UNKNOWN_SERVICE);
