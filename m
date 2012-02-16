Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Thomas Gleixner <tglx@linutronix.de>, Milton Miller <miltonm@bga.com>,
 Rob Herring <rob.herring@calxeda.com>
Subject: [PATCH v5 02/27] irq_domain: Be less verbose
Date: Thu, 16 Feb 2012 02:09:03 -0700
Message-Id: <1329383368-12122-3-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

irq_domain printk's too much.  Drop some output.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Olof Johansson <olof@lixom.net>
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
1.7.9
