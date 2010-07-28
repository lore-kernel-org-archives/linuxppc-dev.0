Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 389C1B70B9
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 10:34:21 +1000 (EST)
Subject: Patch "genirq: Deal with desc->set_type() changing desc->chip" has
	been added to the 2.6.33-stable tree
To: tglx@linutronix.de, benh@kernel.crashing.org, eha@doredevelopment.dk,
	gregkh@suse.de, linuxppc-dev@ozlabs.org
From: <gregkh@suse.de>
Date: Tue, 27 Jul 2010 17:26:55 -0700
Message-ID: <12802768153307@site>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Cc: stable@kernel.org, stable-commits@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

    genirq: Deal with desc->set_type() changing desc->chip

to the 2.6.33-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
    genirq-deal-with-desc-set_type-changing-desc-chip.patch
and it can be found in the queue-2.6.33 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@kernel.org> know about it.


>From 4673247562e39a17e09440fa1400819522ccd446 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 7 Jun 2010 17:53:51 +0200
Subject: genirq: Deal with desc->set_type() changing desc->chip

From: Thomas Gleixner <tglx@linutronix.de>

commit 4673247562e39a17e09440fa1400819522ccd446 upstream.

The set_type() function can change the chip implementation when the
trigger mode changes. That might result in using an non-initialized
irq chip when called from __setup_irq() or when called via
set_irq_type() on an already enabled irq.

The set_irq_type() function should not be called on an enabled irq,
but because we forgot to put a check into it, we have a bunch of users
which grew the habit of doing that and it never blew up as the
function is serialized via desc->lock against all users of desc->chip
and they never hit the non-initialized irq chip issue.

The easy fix for the __setup_irq() issue would be to move the
irq_chip_set_defaults(desc->chip) call after the trigger setting to
make sure that a chip change is covered.

But as we have already users, which do the type setting after
request_irq(), the safe fix for now is to call irq_chip_set_defaults()
from __irq_set_trigger() when desc->set_type() changed the irq chip.

It needs a deeper analysis whether we should refuse to change the chip
on an already enabled irq, but that'd be a large scale change to fix
all the existing users. So that's neither stable nor 2.6.35 material.

Reported-by: Esben Haabendal <eha@doredevelopment.dk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 kernel/irq/manage.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -436,6 +436,9 @@ int __irq_set_trigger(struct irq_desc *d
 		/* note that IRQF_TRIGGER_MASK == IRQ_TYPE_SENSE_MASK */
 		desc->status &= ~(IRQ_LEVEL | IRQ_TYPE_SENSE_MASK);
 		desc->status |= flags;
+
+		if (chip != desc->chip)
+			irq_chip_set_defaults(desc->chip);
 	}
 
 	return ret;


Patches currently in stable-queue which might be from tglx@linutronix.de are

queue-2.6.33/genirq-deal-with-desc-set_type-changing-desc-chip.patch
queue-2.6.33/x86-send-a-sigtrap-for-user-icebp-traps.patch
