Return-Path: <brking@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25DE1B6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Jul 2010 04:48:40 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6EIYJf5017590
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jul 2010 14:34:19 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6EImERq152926
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jul 2010 14:48:15 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6EImEBZ027618
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jul 2010 15:48:14 -0300
Message-Id: <201007141848.o6EImD6D027565@d01av03.pok.ibm.com>
Subject: [PATCH 1/1] powerpc: Remove redundant xics badness warning
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Wed, 14 Jul 2010 13:48:13 -0500
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


While testing cpu offlining, we are regularly seeing the WARN_ON go off
in xics_ipi_dispatch. It can occur when an IPI gets sent to the CPU while
it is going offline. There is already a similar WARN_ON in the handlers
for PPC_MSG_CALL_FUNCTION and PPC_MSG_CALL_FUNC_SINGLE, so the warning
is not needed in that path. The debugger handler handles this case by
simply ignoring IPIs for offline CPUs, so no warning is needed there.
And the reschedule IPI, which is what is occurring in our test environment,
can be safely ignored, so we can simply remove the WARN_ON from xics_ipi_dispatch.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/pseries/xics.c |    2 --
 1 file changed, 2 deletions(-)

diff -puN arch/powerpc/platforms/pseries/xics.c~powerpc_xics_fix_badness arch/powerpc/platforms/pseries/xics.c
--- linux-2.6/arch/powerpc/platforms/pseries/xics.c~powerpc_xics_fix_badness	2010-07-14 13:47:13.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/xics.c	2010-07-14 13:47:13.000000000 -0500
@@ -549,8 +549,6 @@ static irqreturn_t xics_ipi_dispatch(int
 {
 	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
 
-	WARN_ON(cpu_is_offline(cpu));
-
 	mb();	/* order mmio clearing qirr */
 	while (*tgt) {
 		if (test_and_clear_bit(PPC_MSG_CALL_FUNCTION, tgt)) {
_
