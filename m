Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C3393DDE43
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 22:50:11 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l3CCldrw020564
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 08:47:39 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3CCo8eW200890
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 06:50:08 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3CCo8p6009402
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 06:50:08 -0600
Subject: [PATCH] powerpc: Fix PowerPC 750CL CPU features
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Thu, 12 Apr 2007 07:49:06 -0500
Message-Id: <1176382146.6379.28.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PowerPC 750CL has high BATs.  The patch below sets cpu_features to match that.
Without it, the original firmware mappings in the high BATs aren't cleared
which can cause "odd" address translations to occur.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/cputable.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.orig/arch/powerpc/kernel/cputable.c
+++ linux-2.6/arch/powerpc/kernel/cputable.c
@@ -562,12 +562,12 @@ static struct cpu_spec cpu_specs[] = {
 		.pvr_mask		= 0xfffff0f0,
 		.pvr_value		= 0x00087010,
 		.cpu_name		= "750CL",
-		.cpu_features		= CPU_FTRS_750,
+		.cpu_features		= CPU_FTRS_750GX,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750cx,
+		.cpu_setup		= __setup_cpu_750fx,
 		.platform		= "ppc750",
 	},
 	{	/* 745/755 */
