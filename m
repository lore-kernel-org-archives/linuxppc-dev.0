Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D85F7DDF25
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 23:18:43 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l9CDIbgX003701
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 06:18:38 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9CDIKNJ006039
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 08:18:36 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v3 7/9] ipic: clean up unsupported ack operations
Date: Fri, 12 Oct 2007 21:28:46 +0800
Message-Id: <1192195728-24189-8-git-send-email-leoli@freescale.com>
In-Reply-To: <1192195728-24189-7-git-send-email-leoli@freescale.com>
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-2-git-send-email-leoli@freescale.com>
	<1192195728-24189-3-git-send-email-leoli@freescale.com>
	<1192195728-24189-4-git-send-email-leoli@freescale.com>
	<1192195728-24189-5-git-send-email-leoli@freescale.com>
	<1192195728-24189-6-git-send-email-leoli@freescale.com>
	<1192195728-24189-7-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

IPIC controller doesn't support ack operations.  The pending registers
are read-only.  The patch removes ack operations which are not needed.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/ipic.c |   40 ++--------------------------------------
 1 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index cd8590d..6835c15 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -533,42 +533,7 @@ static void ipic_mask_irq(unsigned int virq)
 	temp = ipic_read(ipic->regs, ipic_info[src].mask);
 	temp &= ~(1 << (31 - ipic_info[src].bit));
 	ipic_write(ipic->regs, ipic_info[src].mask, temp);
-
-	spin_unlock_irqrestore(&ipic_lock, flags);
-}
-
-static void ipic_ack_irq(unsigned int virq)
-{
-	struct ipic *ipic = ipic_from_irq(virq);
-	unsigned int src = ipic_irq_to_hw(virq);
-	unsigned long flags;
-	u32 temp;
-
-	spin_lock_irqsave(&ipic_lock, flags);
-
-	temp = ipic_read(ipic->regs, ipic_info[src].pend);
-	temp |= (1 << (31 - ipic_info[src].bit));
-	ipic_write(ipic->regs, ipic_info[src].pend, temp);
-
-	spin_unlock_irqrestore(&ipic_lock, flags);
-}
-
-static void ipic_mask_irq_and_ack(unsigned int virq)
-{
-	struct ipic *ipic = ipic_from_irq(virq);
-	unsigned int src = ipic_irq_to_hw(virq);
-	unsigned long flags;
-	u32 temp;
-
-	spin_lock_irqsave(&ipic_lock, flags);
-
-	temp = ipic_read(ipic->regs, ipic_info[src].mask);
-	temp &= ~(1 << (31 - ipic_info[src].bit));
-	ipic_write(ipic->regs, ipic_info[src].mask, temp);
-
-	temp = ipic_read(ipic->regs, ipic_info[src].pend);
-	temp |= (1 << (31 - ipic_info[src].bit));
-	ipic_write(ipic->regs, ipic_info[src].pend, temp);
+	mb();
 
 	spin_unlock_irqrestore(&ipic_lock, flags);
 }
@@ -626,8 +591,7 @@ static struct irq_chip ipic_irq_chip = {
 	.typename	= " IPIC  ",
 	.unmask		= ipic_unmask_irq,
 	.mask		= ipic_mask_irq,
-	.mask_ack	= ipic_mask_irq_and_ack,
-	.ack		= ipic_ack_irq,
+	.mask_ack	= ipic_mask_irq,
 	.set_type	= ipic_set_irq_type,
 };
 
-- 
1.5.3.2.104.g41ef
