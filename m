Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 912C567EB4
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 12:57:48 +1100 (EST)
Date: Tue, 14 Nov 2006 12:57:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: fix slb.c for combined build
Message-Id: <20061114125738.8c1dad0d.sfr@canb.auug.org.au>
In-Reply-To: <20061113010330.1d821876@pb15>
References: <20061113144918.84647810.sfr@canb.auug.org.au>
	<20061113010330.1d821876@pb15>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, ppc-dev <linuxppc-dev@ozlabs.org>
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
 arch/powerpc/mm/slb.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

This version takes into account Olof's comment.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index d373391..224e960 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -23,6 +23,7 @@
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
 #include <asm/smp.h>
+#include <asm/firmware.h>
 #include <linux/compiler.h>
 
 #ifdef DEBUG
@@ -193,6 +194,7 @@ static inline void patch_slb_encoding(un
 void slb_initialize(void)
 {
 	unsigned long linear_llp, vmalloc_llp, io_llp;
+	unsigned long lflags, vflags;
 	static int slb_encoding_inited;
 	extern unsigned int *slb_miss_kernel_load_linear;
 	extern unsigned int *slb_miss_kernel_load_io;
@@ -225,11 +227,12 @@ void slb_initialize(void)
 #endif
 	}
 
+	get_paca()->stab_rr = SLB_NUM_BOLTED;
+
 	/* On iSeries the bolted entries have already been set up by
 	 * the hypervisor from the lparMap data in head.S */
-#ifndef CONFIG_PPC_ISERIES
- {
-	unsigned long lflags, vflags;
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return;
 
 	lflags = SLB_VSID_KERNEL | linear_llp;
 	vflags = SLB_VSID_KERNEL | vmalloc_llp;
@@ -247,8 +250,4 @@ void slb_initialize(void)
 	 * elsewhere, we'll call _switch() which will bolt in the new
 	 * one. */
 	asm volatile("isync":::"memory");
- }
-#endif /* CONFIG_PPC_ISERIES */
-
-	get_paca()->stab_rr = SLB_NUM_BOLTED;
 }
-- 
1.4.3.3
