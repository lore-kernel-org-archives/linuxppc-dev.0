Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4B8E8679F4
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Apr 2006 02:45:08 +1000 (EST)
Date: Sun, 2 Apr 2006 02:45:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] powerpc: iSeries needs slb_initialize to be called
Message-Id: <20060402024504.39d58d41.sfr@canb.auug.org.au>
In-Reply-To: <20060402021840.4640dab7.sfr@canb.auug.org.au>
References: <20060402021840.4640dab7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since the powerpc 64k pages patch went in, systems that have SLBs
(like Power4 iSeries) needed to have slb_initialize called to set up
some variables for the SLB miss handler.  This was not being called
on the boot processor on iSeries, so on single cpu iSeries machines,
we would get apparent memory curruption as soon as we entered user mode.

This patch fixes that by calling slb_initialize on the boot cpu if the
processor has an SLB.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/setup_64.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

The previous version was against 2.6.16, this one is against the current
powerpc tree.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

032013b4b9e7617e88ad1da8d8515bfd9f8ab012
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 59aa92c..13e91c4 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -215,12 +215,10 @@ void __init early_setup(unsigned long dt
 	/*
 	 * Initialize stab / SLB management except on iSeries
 	 */
-	if (!firmware_has_feature(FW_FEATURE_ISERIES)) {
-		if (cpu_has_feature(CPU_FTR_SLB))
-			slb_initialize();
-		else
-			stab_initialize(get_paca()->stab_real);
-	}
+	if (cpu_has_feature(CPU_FTR_SLB))
+		slb_initialize();
+	else if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		stab_initialize(get_paca()->stab_real);
 
 	DBG(" <- early_setup()\n");
 }
-- 
1.2.4
