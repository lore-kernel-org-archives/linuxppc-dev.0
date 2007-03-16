Return-Path: <wei.zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 9262BDDEF2
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 15:33:16 +1100 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org, benh@kernel.crashing.org, galak@kernel.crashing.org
Subject: [PATCH 1/4] Add a new member 'name' to structure irq_host.
Date: Fri, 16 Mar 2007 12:38:32 +0800
Message-Id: <11740199151814-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, r54964@freescale.com
Reply-To: Zhang Wei <wei.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a new member 'name' for irq host's name to structure irq_host and modifies the definition of the function irq_alloc_host(). The assignment to the irq host's name is also added to irq_alloc_host().

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/kernel/irq.c |    4 +++-
 include/asm-powerpc/irq.h |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 919fbf5..2cbf87f 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -404,7 +404,8 @@ static struct irq_host *irq_default_host
 struct irq_host *irq_alloc_host(unsigned int revmap_type,
 				unsigned int revmap_arg,
 				struct irq_host_ops *ops,
-				irq_hw_number_t inval_irq)
+				irq_hw_number_t inval_irq,
+				const char *name)
 {
 	struct irq_host *host;
 	unsigned int size = sizeof(struct irq_host);
@@ -429,6 +430,7 @@ struct irq_host *irq_alloc_host(unsigned
 	host->revmap_type = revmap_type;
 	host->inval_irq = inval_irq;
 	host->ops = ops;
+	host->name = name;
 
 	spin_lock_irqsave(&irq_big_lock, flags);
 
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index cf927c1..d8d77ef 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -124,6 +124,7 @@ #define IRQ_HOST_MAP_TREE	3 /* radix tre
 	struct irq_host_ops	*ops;
 	void			*host_data;
 	irq_hw_number_t		inval_irq;
+	const char		*name;
 };
 
 /* The main irq map itself is an array of NR_IRQ entries containing the
@@ -162,7 +163,8 @@ static inline irq_hw_number_t virq_to_hw
 extern struct irq_host *irq_alloc_host(unsigned int revmap_type,
 				       unsigned int revmap_arg,
 				       struct irq_host_ops *ops,
-				       irq_hw_number_t inval_irq);
+				       irq_hw_number_t inval_irq,
+				       const char *name);
 
 
 /**
-- 
1.4.0
