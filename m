Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x22c.google.com (mail-pb0-x22c.google.com
 [IPv6:2607:f8b0:400e:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6F9E22C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 21:27:04 +1100 (EST)
Received: by mail-pb0-f44.google.com with SMTP id rq2so1589370pbb.17
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 02:26:57 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/ppc32: fix the bug in the init of non-base exception
 stack for UP
Date: Wed, 29 Jan 2014 18:24:54 +0800
Message-Id: <1390991094-16094-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We would allocate one specific exception stack for each kind of
non-base exceptions for every CPU. For ppc32 the CPU hard ID is
used as the subscript to get the specific exception stack for
one CPU. But for an UP kernel, there is only one element in the
each kind of exception stack array. We would get stuck if the
CPU hard ID is not equal to '0'. So in this case we should use the
subscript '0' no matter what the CPU hard ID is.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/irq.c      | 5 +++++
 arch/powerpc/kernel/setup_32.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 9729b23bfb0a..1d0848bba049 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -559,8 +559,13 @@ void exc_lvl_ctx_init(void)
 #ifdef CONFIG_PPC64
 		cpu_nr = i;
 #else
+#ifdef CONFIG_SMP
 		cpu_nr = get_hard_smp_processor_id(i);
+#else
+		cpu_nr = 0;
 #endif
+#endif
+
 		memset((void *)critirq_ctx[cpu_nr], 0, THREAD_SIZE);
 		tp = critirq_ctx[cpu_nr];
 		tp->cpu = cpu_nr;
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 2b0da27eaee4..04cc4fcca78b 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -247,7 +247,12 @@ static void __init exc_lvl_early_init(void)
 	/* interrupt stacks must be in lowmem, we get that for free on ppc32
 	 * as the memblock is limited to lowmem by MEMBLOCK_REAL_LIMIT */
 	for_each_possible_cpu(i) {
+#ifdef CONFIG_SMP
 		hw_cpu = get_hard_smp_processor_id(i);
+#else
+		hw_cpu = 0;
+#endif
+
 		critirq_ctx[hw_cpu] = (struct thread_info *)
 			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
 #ifdef CONFIG_BOOKE
-- 
1.8.5.3
