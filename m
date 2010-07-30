Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D9C05B6F14
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jul 2010 03:35:08 +1000 (EST)
Message-Id: <20100730173109.573358136@clark.site>
Date: Fri, 30 Jul 2010 10:30:41 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org,
 stable@kernel.org
Subject: [076/140] genirq: Deal with desc->set_type() changing desc->chip
In-Reply-To: <20100730173205.GA22581@kroah.com>
Cc: stable-review@kernel.org, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2.6.33-stable review patch.  If anyone has any objections, please let us know.

------------------

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
