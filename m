Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZHsV0TXwzF25k
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 18:34:53 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id z9so6204059pfe.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 01:34:53 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: anton@ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, benh@kernel.crashing.org,
 alistair@popple.id.au, arbab@linux.vnet.ibm.com,
 Balbir Singh <bsingharora@gmail.com>, Michael Neuling <mikey@neuling.org>
Subject: [PATCH] Revert "powerpc/powernv: Increase memory block size to 1GB on
 radix"
Date: Mon, 30 Apr 2018 18:34:32 +1000
Message-Id: <20180430083432.21546-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit 53ecde0b9126ff140abe3aefd7f0ec64d6fa36b0.

The commit above changed the memblock size to 1GiB, which did some
nice things like create fewer TLB entries for mapping memory at
the time of hotplug. The downside is that it changes the granularity
at which memory can be hot-plugged and hot-unplugged. The implication
is that if we had less than a 1GiB to hot-plug/hot-unplug that
would not be possible.

The reason we had this fix was to resolve an issue where we did not
split mappings on hot-unplug, leaving a TLB entry that spanned the
region that was unplugged. This is now fixed by 4dd5f8a99e79 which
splits the page table, removing the MMU mappings for the hot-unplugged
region correctly.

This trade-offs performance as we increase the number of TLB's to
map 1GiB of memory, mapped in via hot-plug, but gives us the ability
to handle smaller memory sizes.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/platforms/powernv/setup.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index ef8c9ce53a61..fa63d3fff14c 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -356,15 +356,7 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
 static unsigned long pnv_memory_block_size(void)
 {
-	/*
-	 * We map the kernel linear region with 1GB large pages on radix. For
-	 * memory hot unplug to work our memory block size must be at least
-	 * this size.
-	 */
-	if (radix_enabled())
-		return 1UL * 1024 * 1024 * 1024;
-	else
-		return 256UL * 1024 * 1024;
+	return 256UL * 1024 * 1024;
 }
 #endif
 
-- 
2.13.6
