Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71FD667BD9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 18:25:20 +1000 (EST)
Date: Wed, 18 Oct 2006 10:16:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Olaf Hering <olaf@aepfle.de>
Subject: [patch] genirq: clean up irq-flow-type naming, fix
Message-ID: <20061018081659.GA5778@elte.hu>
References: <20061018080411.GA13340@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061018080411.GA13340@aepfle.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Olaf Hering <olaf@aepfle.de> wrote:

> There is no prototype anymore, but still many users.
> 
> a460e745e8f9c75a0525ff94154a0629f9d3e05d is likely the culprit:
>  [PATCH] genirq: clean up irq-flow-type naming

oops, that was unintended. The patch below should fix this.

	Ingo

--------------->
Subject: genirq: clean up irq-flow-type naming, fix
From: Ingo Molnar <mingo@elte.hu>

re-add the set_irq_chip_and_handler() prototype, it's still widely used.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/irq.h |    3 +++
 1 file changed, 3 insertions(+)

Index: linux/include/linux/irq.h
===================================================================
--- linux.orig/include/linux/irq.h
+++ linux/include/linux/irq.h
@@ -322,6 +322,9 @@ extern struct irq_chip no_irq_chip;
 extern struct irq_chip dummy_irq_chip;
 
 extern void
+set_irq_chip_and_handler(unsigned int irq, struct irq_chip *chip,
+			 irq_flow_handler_t handle);
+extern void
 set_irq_chip_and_handler_name(unsigned int irq, struct irq_chip *chip,
 			      irq_flow_handler_t handle, const char *name);
 
