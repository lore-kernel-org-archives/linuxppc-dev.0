Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BE69CDDE42
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 05:37:26 +1100 (EST)
Date: Wed, 2 Jan 2008 12:45:49 -0600
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] pasemi: Fix NMI handling check
Message-ID: <20080102184549.GA17792@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC] pasemi: Fix NMI handling check
    
The logic that checks to see if a machine check is caused by an NMI will
always match when NMI hasn't been initialized, since the mpic routine
will return NO_IRQ (and that's what the nmi_virq value is as well).
    
Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 1940e67..a89d098 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -264,7 +264,7 @@ static int pas_machine_check_handler(struct pt_regs *regs)
 	srr0 = regs->nip;
 	srr1 = regs->msr;
 
-	if (mpic_get_mcirq() == nmi_virq) {
+	if (nmi_virq != NO_IRQ && mpic_get_mcirq() == nmi_virq) {
 		printk(KERN_ERR "NMI delivered\n");
 		debugger(regs);
 		mpic_end_irq(nmi_virq);
