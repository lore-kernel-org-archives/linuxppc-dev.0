Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 3/3] Improve robustness of the UIC cascade handler
In-Reply-To: <20070814034811.GA8791@localhost.localdomain>
Message-Id: <20070814035242.CAE2BDDEFD@ozlabs.org>
Date: Tue, 14 Aug 2007 13:52:42 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At present the cascade interrupt handler for the UIC (interrupt
controller on 4xx embedded chips) will misbehave badly if it is called
spuriously - that is if the handler is invoked when no interrupts are
asserted in the child UIC.

Although spurious interrupts shouldn't happen, it's good to behave
robustly if they do.  This patch does so by checking for and ignoring
spurious interrupts.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 arch/powerpc/sysdev/uic.c |    3 +++
 1 file changed, 3 insertions(+)

Index: working-2.6/arch/powerpc/sysdev/uic.c
===================================================================
--- working-2.6.orig/arch/powerpc/sysdev/uic.c	2007-08-14 13:46:02.000000000 +1000
+++ working-2.6/arch/powerpc/sysdev/uic.c	2007-08-14 13:46:02.000000000 +1000
@@ -266,6 +266,9 @@ irqreturn_t uic_cascade(int virq, void *
 	int subvirq;
 
 	msr = mfdcr(uic->dcrbase + UIC_MSR);
+	if (!msr) /* spurious interrupt */
+		return IRQ_HANDLED;
+
 	src = 32 - ffs(msr);
 
 	subvirq = irq_linear_revmap(uic->irqhost, src);
