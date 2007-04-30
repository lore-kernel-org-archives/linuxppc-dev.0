Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 09ACFDDEFD
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 06:42:17 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3UKgFPR027130
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Apr 2007 16:42:15 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3UKgFJ9169154
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Apr 2007 14:42:15 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3UKgEdQ027071
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Apr 2007 14:42:15 -0600
Subject: [PATCH] powerpc: fix spurious vectors on weird MPIC
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Mon, 30 Apr 2007 15:38:11 -0500
Message-Id: <1177965491.3026.47.camel@zod.rchland.ibm.com>
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

The weird TSI 10x MPIC needs an EOI after getting a spurious vector.  This
patch uses the existing MPIC_SPV_EOI flag to fix this issue.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/sysdev/mpic.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.orig/arch/powerpc/sysdev/mpic.c
+++ linux-2.6/arch/powerpc/sysdev/mpic.c
@@ -1333,8 +1333,11 @@ unsigned int mpic_get_one_irq(struct mpi
 #ifdef DEBUG_LOW
 	DBG("%s: get_one_irq(): %d\n", mpic->name, src);
 #endif
-	if (unlikely(src == mpic->spurious_vec))
+	if (unlikely(src == mpic->spurious_vec)) {
+		if (mpic->flags & MPIC_SPV_EOI)
+			mpic_eoi(mpic);
 		return NO_IRQ;
+	}
 	return irq_linear_revmap(mpic->irqhost, src);
 }
 
