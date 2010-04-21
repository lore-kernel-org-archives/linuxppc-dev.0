Return-Path: <brking@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D9997B7CFA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Apr 2010 11:54:40 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3L1qFl9011810
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2010 21:52:15 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3L1sZm4180742
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2010 21:54:35 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3L1sYLw001803
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2010 21:54:35 -0400
Message-Id: <201004210154.o3L1sXaR001791@d01av04.pok.ibm.com>
Subject: [PATCH 1/1] powerpc: Ignore IPIs to offline CPUs
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Tue, 20 Apr 2010 20:54:31 -0500
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Since there is nothing to stop an IPI from occurring to an
offline CPU, rather than printing a warning to the logs,
just ignore the IPI. This was seen while stress testing
SMT enable/disable.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/pseries/xics.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/powerpc/platforms/pseries/xics.c~powerpc_xics_ipi_offline arch/powerpc/platforms/pseries/xics.c
--- linux-2.6/arch/powerpc/platforms/pseries/xics.c~powerpc_xics_ipi_offline	2010-04-20 20:46:06.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/xics.c	2010-04-20 20:47:53.000000000 -0500
@@ -545,7 +545,8 @@ static irqreturn_t xics_ipi_dispatch(int
 {
 	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
 
-	WARN_ON(cpu_is_offline(cpu));
+	if (cpu_is_offline(cpu))
+		return IRQ_HANDLED;
 
 	mb();	/* order mmio clearing qirr */
 	while (*tgt) {
_
