Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2DAE5DDEB8
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 04:44:37 +1000 (EST)
Date: Fri, 19 Oct 2007 13:51:10 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: mpic: minor optimization of ipi handler
Message-ID: <20071019185110.GA11911@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeff Garzik pointed out that we don't actually have to lookup the mpic
instance since it's passed in as the interrupt handler data for IPIs.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index e479388..6bf56f4 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -612,11 +612,10 @@ static inline void mpic_eoi(struct mpic *mpic)
 }
 
 #ifdef CONFIG_SMP
-static irqreturn_t mpic_ipi_action(int irq, void *dev_id)
+static irqreturn_t mpic_ipi_action(int irq, void *data)
 {
-	struct mpic *mpic;
+	struct mpic *mpic = data;
 
-	mpic = mpic_find(irq, NULL);
 	smp_message_recv(mpic_irq_to_hw(irq) - mpic->ipi_vecs[0]);
 
 	return IRQ_HANDLED;
