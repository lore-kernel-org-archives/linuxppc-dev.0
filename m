Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A82FB71B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2012 07:22:40 +1100 (EST)
Received: by mail-iy0-f179.google.com with SMTP id e36so646801iag.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 12:22:40 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
To: linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Rob Herring <rob.herring@calxeda.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Russell King <linux@arm.linux.org.uk>, sfr@canb.auug.org.au
Subject: [RFC 01/14] dt: Make irqdomain less verbose
Date: Wed, 11 Jan 2012 13:22:04 -0700
Message-Id: <1326313337-24603-2-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It printk's too much.  Drop some output.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/irqdomain.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 1f9e265..cc2cd43 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -170,13 +170,11 @@ void irq_domain_generate_simple(const struct of_device_id *match,
 				u64 phys_base, unsigned int irq_start)
 {
 	struct device_node *node;
-	pr_info("looking for phys_base=%llx, irq_start=%i\n",
+	pr_debug("looking for phys_base=%llx, irq_start=%i\n",
 		(unsigned long long) phys_base, (int) irq_start);
 	node = of_find_matching_node_by_address(NULL, match, phys_base);
 	if (node)
 		irq_domain_add_simple(node, irq_start);
-	else
-		pr_info("no node found\n");
 }
 EXPORT_SYMBOL_GPL(irq_domain_generate_simple);
 #endif /* CONFIG_OF_IRQ */
-- 
1.7.5.4
