Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C667DDE0F8
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:45 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:35 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-xics-9@bga.com>
In-Reply-To: <patch-xics-0@bga.com>
Subject: [PATCH 9/16] powerpc: eoi xics ipi by hand in kexec 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

EOI normally has the side effect of returning the cpu to the base
priority to recieve the next interrupt.  This is actually controlled
by the top byte of the xirr register.   When we are exiting the
kernel in kexec we must eoi the ipi for the next kernel because we
never return from the handler, but we want to leave interrupt
delivery blocked until the next kernel takes action.

Since the hardware ipi vector is fixed, its easiest to just do the
eoi explicitly.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: next.git/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- next.git.orig/arch/powerpc/platforms/pseries/xics.c	2008-10-04 17:43:17.000000000 -0500
+++ next.git/arch/powerpc/platforms/pseries/xics.c	2008-10-04 21:56:17.000000000 -0500
@@ -757,25 +757,21 @@ void xics_teardown_cpu(void)
 
 void xics_kexec_teardown_cpu(int secondary)
 {
-	unsigned int ipi;
-	struct irq_desc *desc;
-
 	xics_teardown_cpu();
 
 	/*
-	 * we need to EOI the IPI
+	 * we take the ipi irq but and never return so we
+	 * need to EOI the IPI, but want to leave our priority 0
 	 *
-	 * probably need to check all the other interrupts too
+	 * should we check all the other interrupts too?
 	 * should we be flagging idle loop instead?
 	 * or creating some task to be scheduled?
 	 */
 
-	ipi = irq_find_mapping(xics_host, XICS_IPI);
-	if (ipi == XICS_IRQ_SPURIOUS)
-		return;
-	desc = get_irq_desc(ipi);
-	if (desc->chip && desc->chip->eoi)
-		desc->chip->eoi(ipi);
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		lpar_xirr_info_set((0x00 << 24) | XICS_IPI);
+	else
+		direct_xirr_info_set((0x00 << 24) | XICS_IPI);
 
 	/*
 	 * Some machines need to have at least one cpu in the GIQ,
