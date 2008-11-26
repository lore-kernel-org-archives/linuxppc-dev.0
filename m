Return-Path: <hollisb@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71CFADDE21
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 03:19:35 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAQGF8ES006094
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 11:15:08 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAQGJSjc194836
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 11:19:28 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAQHJbsF002767
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 12:19:37 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] [v4] ppc: force memory size to be a multiple of PAGE_SIZE
Message-Id: <654d47bb9cbd63f515bf.1227716366@localhost.localdomain>
Date: Wed, 26 Nov 2008 10:19:26 -0600
From: Hollis Blanchard <hollisb@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Milton Miller <miltonm@bga.com>, Wolfgang Denk <wd@denx.de>,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ensure that total memory size is page-aligned, because otherwise
mark_bootmem() gets upset.

This error case was triggered by using 64 KiB pages in the kernel while
arch/powerpc/boot/4xx.c arbitrarily reduced the amount of memory by 4096 (to
work around a chip bug that affects the last 256 bytes of physical memory).

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
---
Changes from v3:
- No need to call lmb_enforce_memory_limit() with limit=lmb_phys_mem_size().

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1160,6 +1160,8 @@ static inline void __init phyp_dump_rese
 
 void __init early_init_devtree(void *params)
 {
+	unsigned long limit;
+
 	DBG(" -> early_init_devtree(%p)\n", params);
 
 	/* Setup flat device-tree pointer */
@@ -1200,7 +1202,19 @@ void __init early_init_devtree(void *par
 	early_reserve_mem();
 	phyp_dump_reserve_mem();
 
-	lmb_enforce_memory_limit(memory_limit);
+	limit = memory_limit;
+	if (! limit) {
+		unsigned long memsize;
+
+		/* Ensure that total memory size is page-aligned, because
+		 * otherwise mark_bootmem() gets upset. */
+		lmb_analyze();
+		memsize = lmb_phys_mem_size();
+		if ((memsize & PAGE_MASK) != memsize)
+			limit = memsize & PAGE_MASK;
+	}
+	lmb_enforce_memory_limit(limit);
+
 	lmb_analyze();
 
 	DBG("Phys. mem: %lx\n", lmb_phys_mem_size());
