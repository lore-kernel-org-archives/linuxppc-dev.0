Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86D56DDF05
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 00:19:31 +1100 (EST)
Subject: [PATCH 13/12] mpic: add affinity callback for IPI "chip"
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20070207124536.963531000@sipsolutions.net>
References: <20070207124536.963531000@sipsolutions.net>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 14:16:51 +0100
Message-Id: <1170940611.4385.56.camel@johannes.berg>
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a dummy affinity callback for the IPI "chip" to avoid
getting a warning ("Cannot set affinity for irq 251") when taking a
CPU offline via sysfs or during suspend.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-git.orig/arch/powerpc/sysdev/mpic.c	2007-02-08 00:19:46.105926568 +0100
+++ linux-2.6-git/arch/powerpc/sysdev/mpic.c	2007-02-08 00:22:31.810926568 +0100
@@ -700,6 +700,12 @@ static void mpic_end_ipi(unsigned int ir
 	mpic_eoi(mpic);
 }
 
+static void mpic_set_ipi_affinity(unsigned int irq, cpumask_t cpumask)
+{
+	/* we can't set affinity but also don't need to since we only
+	 * send IPIs to online CPUs */
+}
+
 #endif /* CONFIG_SMP */
 
 static void mpic_set_affinity(unsigned int irq, cpumask_t cpumask)
@@ -788,6 +794,7 @@ static struct irq_chip mpic_ipi_chip = {
 	.mask		= mpic_mask_ipi,
 	.unmask		= mpic_unmask_ipi,
 	.eoi		= mpic_end_ipi,
+	.set_affinity	= mpic_set_ipi_affinity,
 };
 #endif /* CONFIG_SMP */
 
