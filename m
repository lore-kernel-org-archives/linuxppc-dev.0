Return-Path: <hollisb@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EE0ADDDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 07:07:36 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAOK6pOM022908
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 13:06:51 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAOK7IVr089896
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 13:07:20 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAOK7GN4030877
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 13:07:17 -0700
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <200811141609.44161.hollisb@us.ibm.com>
References: <4b6790c7a989dce8c200000687275224@bga.com>
	<84e16946c1ed4b782568f6492931512a@bga.com>
	<200811141609.44161.hollisb@us.ibm.com>
Content-Type: text/plain
Date: Mon, 24 Nov 2008 14:07:15 -0600
Message-Id: <1227557235.17746.25.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Wolfgang Denk <wd@denx.de>, Ilya Yanok <yanok@emcraft.com>,
	Milton Miller <miltonm@bga.com>, linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-11-14 at 16:09 -0600, Hollis Blanchard wrote:
> 
> If this is all too much, then I'm close to giving up and burning a
> 64KB page, which requires only ALIGN_DOWN() in the kernel.

ppc: force memory size to be a multiple of PAGE_SIZE

Ensure that total memory size is page-aligned, because otherwise
bootmem.c gets upset.

This error case was triggered by using 64 KiB pages in the kernel while
arch/powerpc/boot/4xx.c arbitrarily reduced the amount of memory by 4096 (to
work around the "CHIP11" errata which affects the last 256 bytes of physical memory).

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
---
This is on a common code path, and lmb_enforce_memory_limit() will now
always take action, so wider testing would be good.

This patch supercedes http://patchwork.ozlabs.org/patch/8211/ .

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1200,6 +1200,11 @@ void __init early_init_devtree(void *par
 	early_reserve_mem();
 	phyp_dump_reserve_mem();
 
+	/* Ensure that total memory size is page-aligned, because otherwise
+	 * bootmem.c gets upset. */
+	lmb_analyze();
+	memory_limit = lmb_phys_mem_size() & PAGE_MASK;
+
 	lmb_enforce_memory_limit(memory_limit);
 	lmb_analyze();
 
-- 
Hollis Blanchard
IBM Linux Technology Center
