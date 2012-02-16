Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Thomas Gleixner <tglx@linutronix.de>, Milton Miller <miltonm@bga.com>,
 Rob Herring <rob.herring@calxeda.com>
Subject: [PATCH v5 04/27] irq_domain: convert microblaze from irq_host to
 irq_domain
Date: Thu, 16 Feb 2012 02:09:05 -0700
Message-Id: <1329383368-12122-5-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
Cc: Michal Simek <monstr@monstr.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Trivial change, microblaze doesn't use irq remapping yet.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/microblaze/include/asm/irq.h |    4 ++--
 arch/microblaze/kernel/irq.c      |    2 +-
 arch/microblaze/kernel/setup.c    |    2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/irq.h
index a175132..7798ad1 100644
--- a/arch/microblaze/include/asm/irq.h
+++ b/arch/microblaze/include/asm/irq.h
@@ -39,7 +39,7 @@ static inline void irq_dispose_mapping(unsigned int virq)
 	return;
 }
 
-struct irq_host;
+struct irq_domain;
 
 /**
  * irq_create_mapping - Map a hardware interrupt into linux virq space
@@ -51,7 +51,7 @@ struct irq_host;
  * If the sense/trigger is to be specified, set_irq_type() should be called
  * on the number returned from that call.
  */
-extern unsigned int irq_create_mapping(struct irq_host *host,
+extern unsigned int irq_create_mapping(struct irq_domain *host,
 					irq_hw_number_t hwirq);
 
 #endif /* _ASM_MICROBLAZE_IRQ_H */
diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
index bbebcae..3f613df 100644
--- a/arch/microblaze/kernel/irq.c
+++ b/arch/microblaze/kernel/irq.c
@@ -51,7 +51,7 @@ next_irq:
 
 /* MS: There is no any advance mapping mechanism. We are using simple 32bit
   intc without any cascades or any connection that's why mapping is 1:1 */
-unsigned int irq_create_mapping(struct irq_host *host, irq_hw_number_t hwirq)
+unsigned int irq_create_mapping(struct irq_domain *host, irq_hw_number_t hwirq)
 {
 	return hwirq + IRQ_OFFSET;
 }
diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index 604cd9d..70e6d0b 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -51,8 +51,6 @@ void __init setup_arch(char **cmdline_p)
 
 	unflatten_device_tree();
 
-	/* NOTE I think that this function is not necessary to call */
-	/* irq_early_init(); */
 	setup_cpuinfo();
 
 	microblaze_cache_init();
-- 
1.7.9
