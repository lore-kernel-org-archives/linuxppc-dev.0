Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2520ADE1FF
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:53 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:39 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-xics-11@bga.com>
In-Reply-To: <patch-xics-0@bga.com>
Subject: [PATCH 11/16] powerpc: mark xics ipi percpu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Its physically per-cpu, and we want the irq layer to treat it that way.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: next.git/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- next.git.orig/arch/powerpc/platforms/pseries/xics.c	2008-10-04 23:54:18.000000000 -0500
+++ next.git/arch/powerpc/platforms/pseries/xics.c	2008-10-04 23:55:43.000000000 -0500
@@ -557,11 +557,11 @@ static void xics_request_ipi(void)
 	 */
 	set_irq_handler(ipi, handle_percpu_irq);
 	if (firmware_has_feature(FW_FEATURE_LPAR))
-		rc = request_irq(ipi, xics_ipi_action_lpar, IRQF_DISABLED,
-				"IPI", NULL);
+		rc = request_irq(ipi, xics_ipi_action_lpar,
+				IRQF_DISABLED|IRQF_PERCPU, "IPI", NULL);
 	else
-		rc = request_irq(ipi, xics_ipi_action_direct, IRQF_DISABLED,
-				"IPI", NULL);
+		rc = request_irq(ipi, xics_ipi_action_direct,
+				IRQF_DISABLED|IRQF_PERCPU, "IPI", NULL);
 	BUG_ON(rc);
 }
 
