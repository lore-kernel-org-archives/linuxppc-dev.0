Return-Path: <hollisb@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59BEDDDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 08:54:05 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAPLrhmT022136
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 16:53:43 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAPLs1K2152742
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 16:54:01 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAPLrcZY022672
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 16:53:39 -0500
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
From: Hollis Blanchard <hollisb@us.ibm.com>
To: michael@ellerman.id.au
In-Reply-To: <1227571828.20022.5.camel@localhost>
References: <4b6790c7a989dce8c200000687275224@bga.com>
	<84e16946c1ed4b782568f6492931512a@bga.com>
	<200811141609.44161.hollisb@us.ibm.com>
	<1227557235.17746.25.camel@localhost.localdomain>
	<1227571828.20022.5.camel@localhost>
Content-Type: text/plain
Date: Tue, 25 Nov 2008 15:53:59 -0600
Message-Id: <1227650039.7434.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Milton Miller <miltonm@bga.com>, Wolfgang Denk <wd@denx.de>,
	Ilya Yanok <yanok@emcraft.com>, linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-11-25 at 11:10 +1100, Michael Ellerman wrote:
> 
> Still, I think it would be better to only set memory_limit when the mem
> size is not a multiple of the PAGE_SIZE - so that memory_limit retains
> it's function as both the value of the limit and a boolean.

OK, how's this?

ppc: force memory size to be a multiple of PAGE_SIZE

Ensure that total memory size is page-aligned, because otherwise
mark_bootmem() gets upset.

This error case was triggered by using 64 KiB pages in the kernel while
arch/powerpc/boot/4xx.c arbitrarily reduced the amount of memory by 4096 (to
work around a chip bug that affects the last 256 bytes of physical memory).

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

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
@@ -1200,7 +1202,15 @@ void __init early_init_devtree(void *par
 	early_reserve_mem();
 	phyp_dump_reserve_mem();
 
-	lmb_enforce_memory_limit(memory_limit);
+	limit = memory_limit;
+	if (! limit) {
+		/* Ensure that total memory size is page-aligned, because
+		 * otherwise mark_bootmem() gets upset. */
+		lmb_analyze();
+		limit = lmb_phys_mem_size() & PAGE_MASK;
+	}
+	lmb_enforce_memory_limit(limit);
+
 	lmb_analyze();
 
 	DBG("Phys. mem: %lx\n", lmb_phys_mem_size());

-- 
Hollis Blanchard
IBM Linux Technology Center
