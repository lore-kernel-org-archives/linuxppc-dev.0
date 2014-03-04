Return-Path: <tipbot@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7749C2C0303
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 04:14:46 +1100 (EST)
Date: Tue, 4 Mar 2014 08:40:05 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-b8a9a11b976810ba12a43c4fe699a14892c97e52@git.kernel.org>
In-Reply-To: <20140223212736.562906212@linutronix.de>
References: <20140223212736.562906212@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] powerpc: Eeh: Kill another abuse of irq_desc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: shangw@linux.vnet.ibm.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 peterz@infradead.org, linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 tglx@linutronix.de, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  b8a9a11b976810ba12a43c4fe699a14892c97e52
Gitweb:     http://git.kernel.org/tip/b8a9a11b976810ba12a43c4fe699a14892c97e52
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Feb 2014 21:40:09 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 4 Mar 2014 17:37:52 +0100

powerpc: Eeh: Kill another abuse of irq_desc

commit 91150af3a (powerpc/eeh: Fix unbalanced enable for IRQ) is
another brilliant example of trainwreck engineering.

The patch "fixes" the issue of an unbalanced call to irq_enable()
which causes a prominent warning by checking the disabled state of the
interrupt line and call conditionally into the core code.

This is wrong in two aspects:

1) The warning is there to tell users, that they need to fix their
   asymetric enable/disable patterns by finding the root cause and
   solving it there.

   It's definitely not meant to work around it by conditionally
   calling into the core code depending on the random state of the irq
   line.

   Asymetric irq_disable/enable calls are a clear sign of wrong usage
   of the interfaces which have to be cured at the root and not by
   somehow hacking around it.

2) The abuse of core internal data structure instead of using the
   proper interfaces for retrieving the information for the 'hack
   around'

   irq_desc is core internal and it's clear enough stated.

Replace at least the irq_desc abuse with the proper functions and add
a big fat comment why this is absurd and completely wrong.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ppc <linuxppc-dev@lists.ozlabs.org>
Link: http://lkml.kernel.org/r/20140223212736.562906212@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/kernel/eeh_driver.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index fdc679d..3e1d7de 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -143,15 +143,31 @@ static void eeh_disable_irq(struct pci_dev *dev)
 static void eeh_enable_irq(struct pci_dev *dev)
 {
 	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
-	struct irq_desc *desc;
 
 	if ((edev->mode) & EEH_DEV_IRQ_DISABLED) {
 		edev->mode &= ~EEH_DEV_IRQ_DISABLED;
-
-		desc = irq_to_desc(dev->irq);
-		if (desc && desc->depth > 0)
+		/*
+		 * FIXME !!!!!
+		 *
+		 * This is just ass backwards. This maze has
+		 * unbalanced irq_enable/disable calls. So instead of
+		 * finding the root cause it works around the warning
+		 * in the irq_enable code by conditionally calling
+		 * into it.
+		 *
+		 * That's just wrong.The warning in the core code is
+		 * there to tell people to fix their assymetries in
+		 * their own code, not by abusing the core information
+		 * to avoid it.
+		 *
+		 * I so wish that the assymetry would be the other way
+		 * round and a few more irq_disable calls render that
+		 * shit unusable forever.
+		 *
+		 *	tglx
+		 */
+		if (irqd_irq_disabled(irq_get_irq_data(dev->irq))
 			enable_irq(dev->irq);
-	}
 }
 
 /**
