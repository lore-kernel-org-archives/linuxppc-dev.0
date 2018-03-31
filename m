Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0Vz2jLXzF1pP
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:00:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH] powerpc/mpic: Check if cpu_possible() in mpic_physmask()
Date: Sun,  1 Apr 2018 01:00:24 +1100
Message-Id: <20180331140024.1610-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In mpic_physmask() we loop over all CPUs up to 32, then get the hard
SMP processor id of that CPU.

Currently that's possibly walking off the end of the paca array, but
in a future patch we will change the paca array to be an array of
pointers, and in that case we will get a NULL for missing CPUs and
oops. eg:

  Unable to handle kernel paging request for data at address 0x88888888888888b8
  Faulting instruction address: 0xc00000000004e380
  Oops: Kernel access of bad area, sig: 11 [#1]
  ...
  NIP .mpic_set_affinity+0x60/0x1a0
  LR  .irq_do_set_affinity+0x48/0x100

Fix it by checking the CPU is possible, this also fixes the code if
there are gaps in the CPU numbering which probably never happens on
mpic systems but who knows.

Debugged-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/sysdev/mpic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 73067805300a..1d4e0ef658d3 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -626,7 +626,7 @@ static inline u32 mpic_physmask(u32 cpumask)
 	int i;
 	u32 mask = 0;
 
-	for (i = 0; i < min(32, NR_CPUS); ++i, cpumask >>= 1)
+	for (i = 0; i < min(32, NR_CPUS) && cpu_possible(i); ++i, cpumask >>= 1)
 		mask |= (cpumask & 1) << get_hard_smp_processor_id(i);
 	return mask;
 }
-- 
2.14.1
