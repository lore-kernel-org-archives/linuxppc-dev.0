Return-Path: <bounces.tip@hpa.at.zytor.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5794B7D20
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 01:07:06 +1000 (EST)
Date: Wed, 9 Jun 2010 15:06:37 GMT
Sender: tip tree robot <bounces.tip@hpa.at.zytor.com>
From: tip-bot for Thomas Gleixner <tglx@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq: Deal with desc->set_type() changing
	desc->chip
Message-ID: <tip-4673247562e39a17e09440fa1400819522ccd446@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: eha@doredevelopment.dk, linuxppc-dev@ozlabs.org, mingo@redhat.com,
	hpa@zytor.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
	benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	eha@doredevelopment.dk, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  4673247562e39a17e09440fa1400819522ccd446
Gitweb:     http://git.kernel.org/tip/4673247562e39a17e09440fa1400819522ccd446
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 7 Jun 2010 17:53:51 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 9 Jun 2010 17:05:08 +0200

genirq: Deal with desc->set_type() changing desc->chip

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
Cc: stable@kernel.org
---
 kernel/irq/manage.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 3164ba7..e149748 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -456,6 +456,9 @@ int __irq_set_trigger(struct irq_desc *desc, unsigned int irq,
 		/* note that IRQF_TRIGGER_MASK == IRQ_TYPE_SENSE_MASK */
 		desc->status &= ~(IRQ_LEVEL | IRQ_TYPE_SENSE_MASK);
 		desc->status |= flags;
+
+		if (chip != desc->chip)
+			irq_chip_set_defaults(desc->chip);
 	}
 
 	return ret;
