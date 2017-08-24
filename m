Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdCzj5LsRzDql8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 15:49:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: clg@kaod.org,
	ruscur@russell.cc
Subject: [PATCH] powerpc/xive: Fix the size of the cpumask used in
 xive_find_target_in_mask()
Date: Thu, 24 Aug 2017 15:49:31 +1000
Message-Id: <1503553771-4483-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cédric Le Goater <clg@kaod.org>

When called from xive_irq_startup(), the size of the cpumask can be
larger than nr_cpu_ids. This can result in a WARN_ON such as:

  WARNING: CPU: 10 PID: 1 at ../arch/powerpc/sysdev/xive/common.c:476 xive_find_target_in_mask+0x110/0x2f0
  ...
  NIP [c00000000008a310] xive_find_target_in_mask+0x110/0x2f0
  LR [c00000000008a2e4] xive_find_target_in_mask+0xe4/0x2f0
  Call Trace:
    xive_find_target_in_mask+0x74/0x2f0 (unreliable)
    xive_pick_irq_target.isra.1+0x200/0x230
    xive_irq_startup+0x60/0x180
    irq_startup+0x70/0xd0
    __setup_irq+0x7bc/0x880
    request_threaded_irq+0x14c/0x2c0
    request_event_sources_irqs+0x100/0x180
    __machine_initcall_pseries_init_ras_IRQ+0x104/0x134
    do_one_initcall+0x68/0x1d0
    kernel_init_freeable+0x290/0x374
    kernel_init+0x24/0x170
    ret_from_kernel_thread+0x5c/0x74

This happens because we're being called with our affinity mask set to
irq_default_affinity. That in turn was populated using
cpumask_setall(), which sets NR_CPUs worth of bits, not nr_cpu_ids
worth. Finally cpumask_weight() will return > nr_cpu_ids when passed a
mask which has > nr_cpu_ids bits set.

Fix it by limiting the value returned by cpumask_weight().

Signed-off-by: Cédric Le Goater <clg@kaod.org>
[mpe: Add change log details on actual cause]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/sysdev/xive/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 0db4c45bc561..558df6542b1a 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -447,7 +447,7 @@ static int xive_find_target_in_mask(const struct cpumask *mask,
 	int cpu, first, num, i;
 
 	/* Pick up a starting point CPU in the mask based on  fuzz */
-	num = cpumask_weight(mask);
+	num = min_t(int, cpumask_weight(mask), nr_cpu_ids);
 	first = fuzz % num;
 
 	/* Locate it */
-- 
2.7.4
