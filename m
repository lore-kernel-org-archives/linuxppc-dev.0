Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2DBCB70DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Mar 2011 15:09:13 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p27498xC007738
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Mar 2011 22:09:09 -0600
Subject: [PATCH] powerpc/mm: Move the STAB0 location to 0x8000 to make room
	in low memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Mar 2011 15:09:07 +1100
Message-ID: <1299470947.8833.1035.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent linux-next builds with allmodconfig fail due to lack of space
between 0x3000 and 0x6000. We have a hard block at 0x7000 but we can
spare a page by moving the STAB0 from 0x6000 to 0x8000.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Seems to still boot on legacy iSeries...

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index acac35d..ae7b3ef 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -27,7 +27,7 @@
 #define STE_VSID_SHIFT	12
 
 /* Location of cpu0's segment table */
-#define STAB0_PAGE	0x6
+#define STAB0_PAGE	0x8
 #define STAB0_OFFSET	(STAB0_PAGE << 12)
 #define STAB0_PHYS_ADDR	(STAB0_OFFSET + PHYSICAL_START)
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 8a81799..70f0f99 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -977,20 +977,6 @@ _GLOBAL(do_stab_bolted)
 	rfid
 	b	.	/* prevent speculative execution */
 
-/*
- * Space for CPU0's segment table.
- *
- * On iSeries, the hypervisor must fill in at least one entry before
- * we get control (with relocate on).  The address is given to the hv
- * as a page number (see xLparMap below), so this must be at a
- * fixed address (the linker can't compute (u64)&initial_stab >>
- * PAGE_SHIFT).
- */
-	. = STAB0_OFFSET	/* 0x6000 */
-	.globl initial_stab
-initial_stab:
-	.space	4096
-
 #ifdef CONFIG_PPC_PSERIES
 /*
  * Data area reserved for FWNMI option.
@@ -1027,3 +1013,18 @@ xLparMap:
 #ifdef CONFIG_PPC_PSERIES
         . = 0x8000
 #endif /* CONFIG_PPC_PSERIES */
+
+/*
+ * Space for CPU0's segment table.
+ *
+ * On iSeries, the hypervisor must fill in at least one entry before
+ * we get control (with relocate on).  The address is given to the hv
+ * as a page number (see xLparMap above), so this must be at a
+ * fixed address (the linker can't compute (u64)&initial_stab >>
+ * PAGE_SHIFT).
+ */
+	. = STAB0_OFFSET	/* 0x8000 */
+	.globl initial_stab
+initial_stab:
+	.space	4096
+
