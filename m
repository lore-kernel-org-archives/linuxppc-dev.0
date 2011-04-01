Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7601BB6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Apr 2011 15:47:23 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p314lIIm006160
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2011 23:47:19 -0500
Subject: [PATCH] powerpc: Set nr_cpu_ids early and use it to free PACAs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Apr 2011 15:47:16 +1100
Message-ID: <1301633237.2549.0.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ryan Grimm <grimm@us.ibm.com>

Without this, "holes" in the CPU numbering can cause us to
free too many PACAs

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/paca.c         |    2 +-
 arch/powerpc/kernel/setup-common.c |    3 +++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index f4adf89..10f0aad 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -203,7 +203,7 @@ void __init free_unused_pacas(void)
 {
 	int new_size;
 
-	new_size = PAGE_ALIGN(sizeof(struct paca_struct) * num_possible_cpus());
+	new_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpu_ids);
 
 	if (new_size >= paca_size)
 		return;
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 9d4882a..21f30cb 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -509,6 +509,9 @@ void __init smp_setup_cpu_maps(void)
 	 */
 	cpu_init_thread_core_maps(nthreads);
 
+	/* Now that possible cpus are set, set nr_cpu_ids for later use */
+	nr_cpu_ids = find_last_bit(cpumask_bits(cpu_possible_mask),NR_CPUS) + 1;
+
 	free_unused_pacas();
 }
 #endif /* CONFIG_SMP */
