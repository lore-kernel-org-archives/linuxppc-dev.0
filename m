Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F091A2C0172
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 18:56:27 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 24 Feb 2014 00:56:25 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 8458E3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 00:56:22 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1O7tvlC10158368
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 08:55:57 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1O7uLSw025978
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 00:56:22 -0700
Date: Mon, 24 Feb 2014 15:56:07 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 03/26] powerpc: eeh: Kill another abuse of irq_desc
Message-ID: <20140224075607.GA20727@shangw.(null)>
References: <20140223212703.511977310@linutronix.de>
 <20140223212736.562906212@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140223212736.562906212@linutronix.de>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@elte.hu>, ppc <linuxppc-dev@lists.ozlabs.org>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 23, 2014 at 09:40:09PM -0000, Thomas Gleixner wrote:
>commit 91150af3a (powerpc/eeh: Fix unbalanced enable for IRQ) is
>another brilliant example of trainwreck engineering.
>
>The patch "fixes" the issue of an unbalanced call to irq_enable()
>which causes a prominent warning by checking the disabled state of the
>interrupt line and call conditionally into the core code.
>
>This is wrong in two aspects:
>
>1) The warning is there to tell users, that they need to fix their
>   asymetric enable/disable patterns by finding the root cause and
>   solving it there.
>
>   It's definitely not meant to work around it by conditionally
>   calling into the core code depending on the random state of the irq
>   line.
>
>   Asymetric irq_disable/enable calls are a clear sign of wrong usage
>   of the interfaces which have to be cured at the root and not by
>   somehow hacking around it.
>
>2) The abuse of core internal data structure instead of using the
>   proper interfaces for retrieving the information for the 'hack
>   around'
>
>   irq_desc is core internal and it's clear enough stated.
>
>Replace at least the irq_desc abuse with the proper functions and add
>a big fat comment why this is absurd and completely wrong.
>

Thanks for pointing it out. I think we might have this patch for now
and I'll look into individual drivers to fix the unbalanced function
calls later one by one.

Thanks,
Gavin

>Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
>Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>Cc: ppc <linuxppc-dev@lists.ozlabs.org>
>---
> arch/powerpc/kernel/eeh_driver.c |   26 +++++++++++++++++++++-----
> 1 file changed, 21 insertions(+), 5 deletions(-)
>
>Index: tip/arch/powerpc/kernel/eeh_driver.c
>===================================================================
>--- tip.orig/arch/powerpc/kernel/eeh_driver.c
>+++ tip/arch/powerpc/kernel/eeh_driver.c
>@@ -143,15 +143,31 @@ static void eeh_disable_irq(struct pci_d
> static void eeh_enable_irq(struct pci_dev *dev)
> {
> 	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
>-	struct irq_desc *desc;
>
> 	if ((edev->mode) & EEH_DEV_IRQ_DISABLED) {
> 		edev->mode &= ~EEH_DEV_IRQ_DISABLED;
>-
>-		desc = irq_to_desc(dev->irq);
>-		if (desc && desc->depth > 0)
>+		/*
>+		 * FIXME !!!!!
>+		 *
>+		 * This is just ass backwards. This maze has
>+		 * unbalanced irq_enable/disable calls. So instead of
>+		 * finding the root cause it works around the warning
>+		 * in the irq_enable code by conditionally calling
>+		 * into it.
>+		 *
>+		 * That's just wrong.The warning in the core code is
>+		 * there to tell people to fix their assymetries in
>+		 * their own code, not by abusing the core information
>+		 * to avoid it.
>+		 *
>+		 * I so wish that the assymetry would be the other way
>+		 * round and a few more irq_disable calls render that
>+		 * shit unusable forever.
>+		 *
>+		 *	tglx
>+		 */
>+		if (irqd_irq_disabled(irq_get_irq_data(dev->irq))
> 			enable_irq(dev->irq);
>-	}
> }
>
> /**
>
>
