Return-Path: <glikely@secretlab.ca>
Received: from mail-ea0-x231.google.com (mail-ea0-x231.google.com
 [IPv6:2a00:1450:4013:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 130722C02B8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 10:49:33 +1000 (EST)
Received: by mail-ea0-f177.google.com with SMTP id j14so4974786eak.36
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Jun 2013 17:49:29 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC 01/10] irqdomain: Relax failure path on setting up mappings
Date: Mon, 10 Jun 2013 01:49:13 +0100
Message-Id: <1370825362-11145-2-git-send-email-grant.likely@linaro.org>
In-Reply-To: <1370825362-11145-1-git-send-email-grant.likely@linaro.org>
References: <1370825362-11145-1-git-send-email-grant.likely@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Mundt <lethal@linux-sh.org>,
 Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 98aa468e, "irqdomain: Support for static IRQ mapping and
association" introduced an API for directly associating blocks of hwirqs
to linux irqs. However, if any irq in that block failed to map (say if
the mapping functions returns an error because the irq is already
mapped) then the whole thing will fail and roll back. This is probably
too aggressive since there are valid reasons why a mapping may fail.
ie. Firmware may have a particular IRQ marked as unusable.

This patch drops the error path out of irq_domain_associate(). If a
mapping fails, then it is simply skipped. There is no reason to fail the
entire allocation.

v2: Still output an information message on failed mappings and make sure
    attempted mapping gets cleared out of the irq_data structure.

Signed-off-by: Grant Likely <grant.likely@linaro.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/irqdomain.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 20b677d..61d6d3c 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -464,23 +464,15 @@ int irq_domain_associate_many(struct irq_domain *domain, unsigned int irq_base,
 				/*
 				 * If map() returns -EPERM, this interrupt is protected
 				 * by the firmware or some other service and shall not
-				 * be mapped.
-				 *
-				 * Since on some platforms we blindly try to map everything
-				 * we end up with a log full of backtraces.
-				 *
-				 * So instead, we silently fail on -EPERM, it is the
-				 * responsibility of the PIC driver to display a relevant
-				 * message if needed.
+				 * be mapped. Don't bother telling the user about it.
 				 */
 				if (ret != -EPERM) {
-					pr_err("irq-%i==>hwirq-0x%lx mapping failed: %d\n",
-					       virq, hwirq, ret);
-					WARN_ON(1);
+					pr_info("%s didn't like hwirq-0x%lx to VIRQ%i mapping (rc=%d)\n",
+					       of_node_full_name(domain->of_node), hwirq, virq, ret);
 				}
 				irq_data->domain = NULL;
 				irq_data->hwirq = 0;
-				goto err_unmap;
+				continue;
 			}
 		}
 
-- 
1.8.1.2
