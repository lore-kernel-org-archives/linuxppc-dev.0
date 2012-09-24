Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A7462C0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 13:56:15 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 24 Sep 2012 09:26:11 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8O3u6mh65536100
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 09:26:06 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8O9Pf69017926
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 14:55:42 +0530
Message-ID: <1348458962.2475.8.camel@ThinkPad-T420>
Subject: [RFC PATCH powerpc] Fix a lazy irq related WARING in
 arch_local_irq_restore()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 24 Sep 2012 11:56:02 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch tries to fix a WARNING in irq.c(below), when doing cpu offline/online. 

The reason is that if the preferred offline state is CPU_STATE_INACTIVE, when
cpu offline, pseries_mach_cpu_die() calls extended_cede_processor() to cede
the processor. After the hv call returns, the MSR_EE is enabled, while
the irq_happened in paca should already be set as PACA_IRQ_HARD_DIS.

Then when the cpu is put online again, the warning is reported when
start_secondary() tries to enable irq. [ Sometimes, we don't see this warning,
that's because when we come to local_irq_enable(), there might already have been
some interrupts occurred, e.g. PACA_IRQ_DEC is already set. ]

The patch tries to clear MSR_EE by calling __hard_irq_disable() after cede
returns, and before calling start_secondary_resume(). 
 
[   56.618846] WARNING: at arch/powerpc/kernel/irq.c:240
[   56.618851] Modules linked in: rcutorture ipv6 dm_mod ext3 jbd mbcache sg sd_mod crc_t10dif ibmvscsic scsi_transport_srp scsi_tgt ibmveth
[   56.618883] NIP: c00000000000ff94 LR: c00000000067a5e0 CTR: 0000000000000001
[   56.618889] REGS: c0000001fef6bbe0 TRAP: 0700   Not tainted  (3.6.0-rc1-autokern1)
[   56.618894] MSR: 8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 42000082  XER: 20000000
[   56.618913] SOFTE: 1
[   56.618916] CFAR: c00000000067a5dc
[   56.618920] TASK = c0000001feed79a0[0] 'swapper/5' THREAD: c0000001fef68000 CPU: 5
GPR00: 0000000000000001 c0000001fef6be60 c000000000f9ca08 0000000000000001 
GPR04: 0000000000000001 0000000000000008 0000000000000001 0000000000000000 
GPR08: 0000000000000000 c0000001feed79a0 0008a80000000000 0000000000000000 
GPR12: 0000000022000082 c00000000f330f00 c0000001fef6bf90 000000000f394b4c 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR24: c000000000fe8f80 0000000000000008 0000000000000028 0000000000000000 
GPR28: 0000000000000000 0000000000000020 c000000000f1ab40 0000000000000001 
[   56.619014] NIP [c00000000000ff94] .arch_local_irq_restore+0x34/0xa0
[   56.619020] LR [c00000000067a5e0] .start_secondary+0x368/0x37c
[   56.619025] Call Trace:
[   56.619030] [c0000001fef6be60] [c000000001ba0500] 0xc000000001ba0500 (unreliable)
[   56.619038] [c0000001fef6bed0] [c00000000067a5e0] .start_secondary+0x368/0x37c
[   56.619046] [c0000001fef6bf90] [c000000000009380] .start_secondary_resume+0x10/0x14
[   56.619052] Instruction dump:
[   56.619056] f8010010 f821ff91 986d022a 2fa30000 419e0054 880d022b 78000621 41820048 
[   56.619071] 2f800001 40de0064 7c0000a6 78008fe2 <0b000000> 2fa00000 40de0050 38000000 
[   56.619088] ---[ end trace 0199c0d783d7f9ba ]---

Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 64c97d8..8de539a 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -137,6 +137,8 @@ static void pseries_mach_cpu_die(void)
 		if (get_preferred_offline_state(cpu) == CPU_STATE_ONLINE) {
 			unregister_slb_shadow(hwcpu);
 
+			__hard_irq_disable();
+
 			/*
 			 * Call to start_secondary_resume() will not return.
 			 * Kernel stack will be reset and start_secondary()
-- 
1.7.1
