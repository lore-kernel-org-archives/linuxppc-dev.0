Return-Path: <R1AAHA@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 05121B6FC3
 for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2012 11:13:42 +1000 (EST)
Received: from mail8-db3 (localhost [127.0.0.1])	by mail8-db3-R.bigfish.com
 (Postfix) with ESMTP id 0FDF7204FC	for <linuxppc-dev@ozlabs.org>; Fri, 18 May
 2012 01:13:29 +0000 (UTC)
Received: from DB3EHSMHS011.bigfish.com (unknown [10.3.81.227])	by
 mail8-db3.bigfish.com (Postfix) with ESMTP id B59621C0049	for
 <linuxppc-dev@ozlabs.org>; Fri, 18 May 2012 01:13:26 +0000 (UTC)
Received: from x9.am.freescale.net (x9.am.freescale.net [10.82.120.9])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with SMTP id q4I1DWb5019882	for
 <linuxppc-dev@ozlabs.org>; Thu, 17 May 2012 18:13:32 -0700
Date: Thu, 17 May 2012 20:11:45 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: fix irq distribution
Message-ID: <20120517201145.323398fa0f58f32c0bfe707f@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

setting CONFIG_IRQ_ALL_CPUS distributes IRQs to CPUs only when
the number of online CPUs equals NR_CPUS.  See commit
280ff97494e0fef4124bee5c52e39b23a18dd283 "sparc64: fix and
optimize irq distribution" for more details.

Using the online mask fixes IRQ-to-CPU distribution on systems
that boot with less than NR_CPUS.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/kernel/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 2a599ce..c05fd53 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -891,7 +891,7 @@ int irq_choose_cpu(const struct cpumask *mask)
 {
 	int cpuid;
 
-	if (cpumask_equal(mask, cpu_all_mask)) {
+	if (cpumask_equal(mask, cpu_online_mask)) {
 		static int irq_rover;
 		static DEFINE_RAW_SPINLOCK(irq_rover_lock);
 		unsigned long flags;
-- 
1.7.10.2
