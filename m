Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EA9DEB7278
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 18:32:53 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4899DDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 18:32:53 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n5J8WmwR025114
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 03:32:49 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Fix issue found by lockdep trace in
	smp_85xx_kick_cpu
Date: Fri, 19 Jun 2009 03:32:48 -0500
Message-Id: <1245400368-4344-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

lockdep trace found the following:

------------[ cut here ]------------
Badness at c007baf0 [verbose debug info unavailable]
NIP: c007baf0 LR: c007bad8 CTR: 00000000
REGS: ef855e00 TRAP: 0700   Tainted: G        W
(2.6.30-06736-g12a31df-dirty)
MSR: 00021000 <ME,CE>  CR: 24044022  XER: 20000000
TASK = ef858000[1] 'swapper' THREAD: ef854000 CPU: 0
GPR00: 00000000 ef855eb0 ef858000 00000001 000000d0 f1000000 ffbc8000 ffffffff
GPR08: 000000d0 c0760000 c0710000 00000007 2fffffff 1004a388 7ffd9400 00000000
GPR16: 00000000 7ffcd100 7ffcd100 7ffcd100 c059cd78 c075c498 c057da7c ffffffff
GPR24: ffbc8000 f1000000 00000001 c00bf8b0 c07595d4 000000d0 00021000 000000d0
NIP [c007baf0] lockdep_trace_alloc+0xc0/0xf0
LR [c007bad8] lockdep_trace_alloc+0xa8/0xf0
Call Trace:
[ef855eb0] [c007ba60] lockdep_trace_alloc+0x30/0xf0 (unreliable)
[ef855ec0] [c00cb3ac] kmem_cache_alloc+0x2c/0xf0
[ef855ee0] [c00bf8b0] __get_vm_area_node+0x80/0x1c0
[ef855f10] [c0017580] __ioremap_caller+0x1d0/0x1e0
[ef855f40] [c057da7c] smp_85xx_kick_cpu+0x64/0x124
[ef855f60] [c0599180] __cpu_up+0xd0/0x1a4
[ef855f80] [c05997c4] cpu_up+0x14c/0x1e0
[ef855fc0] [c05732a0] kernel_init+0x100/0x1c4
[ef855ff0] [c0011524] kernel_thread+0x4c/0x68
Instruction dump:
8009c174 2f800000 409e0048 73c08000 40820040 4818980d 2f830000 419effa0
3d20c076 8009c388 2f800000 409eff90 <0fe00000> 4bffff88 60000000 60000000

We were calling ioremap after we local_irq_restore(flags).  A simple
reorder fixes the problem.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/smp.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index cc0b0db..62c592e 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -52,20 +52,19 @@ smp_85xx_kick_cpu(int nr)
 
 	pr_debug("smp_85xx_kick_cpu: kick CPU #%d\n", nr);
 
-	local_irq_save(flags);
-
 	np = of_get_cpu_node(nr, NULL);
 	cpu_rel_addr = of_get_property(np, "cpu-release-addr", NULL);
 
 	if (cpu_rel_addr == NULL) {
 		printk(KERN_ERR "No cpu-release-addr for cpu %d\n", nr);
-		local_irq_restore(flags);
 		return;
 	}
 
 	/* Map the spin table */
 	bptr_vaddr = ioremap(*cpu_rel_addr, SIZE_BOOT_ENTRY);
 
+	local_irq_save(flags);
+
 	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, nr);
 	out_be32(bptr_vaddr + BOOT_ENTRY_ADDR_LOWER, __pa(__early_start));
 
@@ -73,10 +72,10 @@ smp_85xx_kick_cpu(int nr)
 	while ((__secondary_hold_acknowledge != nr) && (++n < 1000))
 		mdelay(1);
 
-	iounmap(bptr_vaddr);
-
 	local_irq_restore(flags);
 
+	iounmap(bptr_vaddr);
+
 	pr_debug("waited %d msecs for CPU #%d.\n", n, nr);
 }
 
-- 
1.6.0.6
