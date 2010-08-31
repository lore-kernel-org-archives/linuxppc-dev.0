Return-Path: <msm@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144]) by ozlabs.org (Postfix) with ESMTP id 004D7B715D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 09:18:08 +1000 (EST)
Received: from mail61-db3 (localhost.localdomain [127.0.0.1])	by
	mail61-db3-R.bigfish.com (Postfix) with ESMTP id E415417C02A9	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2010 23:18:00 +0000 (UTC)
Received: from DB3EHSMHS009.bigfish.com (unknown [10.3.81.244])	by
	mail61-db3.bigfish.com (Postfix) with ESMTP id B39FA112004B	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2010 23:18:00 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7VNHlGx004488	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 16:17:58 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/mm: Assume first cpu is boot_cpuid not 0
Date: Tue, 31 Aug 2010 18:24:44 -0500
Message-ID: <1283297085-3455-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/mm/mmu_context_nohash.c assumes the boot cpu
will always have smp_processor_id() == 0. This patch fixes
that assumption

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/mm/mmu_context_nohash.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 1f2d9ff..cf98c1e 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -334,7 +334,7 @@ static int __cpuinit mmu_context_cpu_notify(struct notifier_block *self,
 	/* We don't touch CPU 0 map, it's allocated at aboot and kept
 	 * around forever
 	 */
-	if (cpu == 0)
+	if (cpu == boot_cpuid)
 		return NOTIFY_OK;
 
 	switch (action) {
@@ -412,9 +412,11 @@ void __init mmu_context_init(void)
 	 */
 	context_map = alloc_bootmem(CTX_MAP_SIZE);
 	context_mm = alloc_bootmem(sizeof(void *) * (last_context + 1));
+#ifndef CONFIG_SMP
 	stale_map[0] = alloc_bootmem(CTX_MAP_SIZE);
+#else
+	stale_map[boot_cpuid] = alloc_bootmem(CTX_MAP_SIZE);
 
-#ifdef CONFIG_SMP
 	register_cpu_notifier(&mmu_context_cpu_nb);
 #endif
 
-- 
1.6.6.1
