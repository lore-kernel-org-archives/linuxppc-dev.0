Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34C83DDF4A
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 21:28:38 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9JBSXqP007763
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 04:28:33 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9JBSNKi016129
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 06:28:32 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v7 7/9] ipic: clean up unsupported ack operations
Date: Fri, 19 Oct 2007 19:38:48 +0800
Message-Id: <1192793930-26039-8-git-send-email-leoli@freescale.com>
In-Reply-To: <1192793930-26039-7-git-send-email-leoli@freescale.com>
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
	<1192793930-26039-4-git-send-email-leoli@freescale.com>
	<1192793930-26039-5-git-send-email-leoli@freescale.com>
	<1192793930-26039-6-git-send-email-leoli@freescale.com>
	<1192793930-26039-7-git-send-email-leoli@freescale.com>
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
index 7168b03..174fd7a 100644
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
