Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1F82567D4E
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 14:49:11 +1100 (EST)
Date: Mon, 13 Nov 2006 14:49:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: fix slb.c for combined build
Message-Id: <20061113144918.84647810.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/slb.c |   39 +++++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 20 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index d373391..06c0055 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -23,6 +23,7 @@
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
 #include <asm/smp.h>
+#include <asm/firmware.h>
 #include <linux/compiler.h>
 
 #ifdef DEBUG
@@ -227,28 +228,26 @@ void slb_initialize(void)
 
 	/* On iSeries the bolted entries have already been set up by
 	 * the hypervisor from the lparMap data in head.S */
-#ifndef CONFIG_PPC_ISERIES
- {
-	unsigned long lflags, vflags;
+	if (!firmware_has_feature(FW_FEATURE_ISERIES)) {
+		unsigned long lflags, vflags;
 
-	lflags = SLB_VSID_KERNEL | linear_llp;
-	vflags = SLB_VSID_KERNEL | vmalloc_llp;
+		lflags = SLB_VSID_KERNEL | linear_llp;
+		vflags = SLB_VSID_KERNEL | vmalloc_llp;
+
+		/* Invalidate the entire SLB (even slot 0) & all the ERATS */
+		asm volatile("isync":::"memory");
+		asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
+		asm volatile("isync; slbia; isync":::"memory");
+		create_shadowed_slbe(PAGE_OFFSET, lflags, 0);
 
-	/* Invalidate the entire SLB (even slot 0) & all the ERATS */
-	asm volatile("isync":::"memory");
-	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
-	asm volatile("isync; slbia; isync":::"memory");
-	create_shadowed_slbe(PAGE_OFFSET, lflags, 0);
-
-	create_shadowed_slbe(VMALLOC_START, vflags, 1);
-
-	/* We don't bolt the stack for the time being - we're in boot,
-	 * so the stack is in the bolted segment.  By the time it goes
-	 * elsewhere, we'll call _switch() which will bolt in the new
-	 * one. */
-	asm volatile("isync":::"memory");
- }
-#endif /* CONFIG_PPC_ISERIES */
+		create_shadowed_slbe(VMALLOC_START, vflags, 1);
+
+		/* We don't bolt the stack for the time being - we're in boot,
+		 * so the stack is in the bolted segment.  By the time it goes
+		 * elsewhere, we'll call _switch() which will bolt in the new
+		 * one. */
+		asm volatile("isync":::"memory");
+	}
 
 	get_paca()->stab_rr = SLB_NUM_BOLTED;
 }
-- 
1.4.3.3
