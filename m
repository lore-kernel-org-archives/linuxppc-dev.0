Return-Path: <mostrows@watson.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 09C0B67B77
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 15:35:46 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBE4ZhsA016306
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 23:35:43 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBE4Zhsn487286
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 21:35:43 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBE4ZhOs002030
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 21:35:43 -0700
Received: from kdsk1.austin.ibm.com (kdsk1.austin.ibm.com [9.41.71.25])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	kBE4ZfS0001910
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 21:35:43 -0700
Received: from localhost ([127.0.0.1])
	by kdsk1.austin.ibm.com with esmtp (Exim 4.60)
	(envelope-from <mostrows@watson.ibm.com>) id 1GuiJq-00049R-OV
	for linuxppc-dev@ozlabs.org; Wed, 13 Dec 2006 22:35:42 -0600
Subject: [PATCH] Avoid calling get_irq_server() with a real, not virtual irq.
From: Michal Ostrowski <mostrows@watson.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 13 Dec 2006 22:35:41 -0600
Message-Id: <1166070941.5438.53.camel@kdsk1.austin.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We can use default_server when masking an interrupt vector.
get_irq_server() assumes a virtual irq, so badness may happen if we
give it a real one.

Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>
---
 arch/powerpc/platforms/pseries/xics.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index d071abe..7223595 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -224,7 +224,6 @@ static void xics_unmask_irq(unsigned int
 static void xics_mask_real_irq(unsigned int irq)
 {
        int call_status;
-       unsigned int server;
 
        if (irq == XICS_IPI)
                return;
@@ -236,9 +235,9 @@ static void xics_mask_real_irq(unsigned 
                return;
        }
 
-       server = get_irq_server(irq);
        /* Have to set XIVE to 0xff to be able to remove a slot */
-       call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server, 0xff);
+       call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, 
+                               default_server, 0xff);
        if (call_status != 0) {
                printk(KERN_ERR "xics_disable_irq: irq=%u: ibm_set_xive(0xff)"
                       " returned %d\n", irq, call_status);
-- 
1.4.1.1
