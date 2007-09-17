Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7A6E8DDE98
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 06:10:41 +1000 (EST)
Date: Mon, 17 Sep 2007 15:12:29 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Support setting affinity for U3/U4 MSI sources
Message-ID: <20070917201229.GA17302@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hook up affinity-setting for U3/U4 MSI interrupt sources.

Tested on Quad G5 with myri10ge.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 8de29f2..22600fd 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -768,7 +768,7 @@ static void mpic_end_ipi(unsigned int irq)
 
 #endif /* CONFIG_SMP */
 
-static void mpic_set_affinity(unsigned int irq, cpumask_t cpumask)
+void mpic_set_affinity(unsigned int irq, cpumask_t cpumask)
 {
 	struct mpic *mpic = mpic_from_irq(irq);
 	unsigned int src = mpic_irq_to_hw(irq);
diff --git a/arch/powerpc/sysdev/mpic.h b/arch/powerpc/sysdev/mpic.h
index 3a1c3d2..1cb6bd8 100644
--- a/arch/powerpc/sysdev/mpic.h
+++ b/arch/powerpc/sysdev/mpic.h
@@ -34,5 +34,6 @@ extern int mpic_set_irq_type(unsigned int virq, unsigned int flow_type);
 extern void mpic_end_irq(unsigned int irq);
 extern void mpic_mask_irq(unsigned int irq);
 extern void mpic_unmask_irq(unsigned int irq);
+extern void mpic_set_affinity(unsigned int irq, cpumask_t cpumask);
 
 #endif /* _POWERPC_SYSDEV_MPIC_H */
diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index 305b864..0fc4e96 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -40,6 +40,7 @@ static struct irq_chip mpic_u3msi_chip = {
 	.unmask		= mpic_u3msi_unmask_irq,
 	.eoi		= mpic_end_irq,
 	.set_type	= mpic_set_irq_type,
+	.set_affinity	= mpic_set_affinity,
 	.typename	= "MPIC-U3MSI",
 };
 
