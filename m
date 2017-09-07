Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnpLt1HLhzDrSs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 15:05:58 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 bharata@linux.vnet.ibm.com, arbab@linux.vnet.ibm.com, npiggin@gmail.com,
 mikey@neuling.org, cyrilbur@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Increase memory block size to 1GB on radix
Date: Thu,  7 Sep 2017 15:05:51 +1000
Message-Id: <20170907050551.4632-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

Memory hot unplug on PowerNV radix hosts is broken. Our memory block
size is 256MB but since we map the linear region with very large pages,
each pte we tear down maps 1GB.

A hot unplug of one 256MB memory block results in 768MB of memory
getting unintentionally unmapped. At this point we are likely to oops.

Fix this by increasing our memory block size to 1GB on PowerNV radix
hosts.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/powernv/setup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 897aa1400eb8..bbb73aa0eb8f 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -272,7 +272,15 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
 static unsigned long pnv_memory_block_size(void)
 {
-	return 256UL * 1024 * 1024;
+	/*
+	 * We map the kernel linear region with 1GB large pages on radix. For
+	 * memory hot unplug to work our memory block size must be at least
+	 * this size.
+	 */
+	if (radix_enabled())
+		return 1UL * 1024 * 1024 * 1024;
+	else
+		return 256UL * 1024 * 1024;
 }
 #endif
 
-- 
2.11.0
