Return-Path: <G.Chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63BBBDDE37
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 21:05:51 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6NB5iCx008268
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 04:05:44 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6NB5fFf008974
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 06:05:43 -0500 (CDT)
From: Chen Gong <g.chen@freescale.com>
To: paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH 1/3] Add a new member name to structure irq_host
Date: Mon, 23 Jul 2007 19:13:48 +0800
Message-Id: <11851892311178-git-send-email-g.chen@freescale.com>
In-Reply-To: <11851892302391-git-send-email-g.chen@freescale.com>
References: <11851892302391-git-send-email-g.chen@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Chen Gong <g.chen@freescale.com>,
	Chen Gong <G.Chen@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a new member 'name' for irq host's name to
structure irq_host and modifies the definition of the
function irq_alloc_host(). The assignment to the
irq host's name is also added to irq_alloc_host().

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Chen Gong <G.Chen@freescale.com>
---
 arch/powerpc/kernel/irq.c |    4 +++-
 include/asm-powerpc/irq.h |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 2fc8786..2c46c6d 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -421,7 +421,8 @@ EXPORT_SYMBOL_GPL(virq_to_hw);
 struct irq_host *irq_alloc_host(unsigned int revmap_type,
 				unsigned int revmap_arg,
 				struct irq_host_ops *ops,
-				irq_hw_number_t inval_irq)
+				irq_hw_number_t inval_irq,
+				const char *name)
 {
 	struct irq_host *host;
 	unsigned int size = sizeof(struct irq_host);
@@ -446,6 +447,7 @@ struct irq_host *irq_alloc_host(unsigned int revmap_type,
 	host->revmap_type = revmap_type;
 	host->inval_irq = inval_irq;
 	host->ops = ops;
+	host->name = name;
 
 	spin_lock_irqsave(&irq_big_lock, flags);
 
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 0485c53..cd0ba2d 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -124,6 +124,7 @@ struct irq_host {
 	struct irq_host_ops	*ops;
 	void			*host_data;
 	irq_hw_number_t		inval_irq;
+	const char		*name;
 };
 
 /* The main irq map itself is an array of NR_IRQ entries containing the
@@ -159,7 +160,8 @@ extern irq_hw_number_t virq_to_hw(unsigned int virq);
 extern struct irq_host *irq_alloc_host(unsigned int revmap_type,
 				       unsigned int revmap_arg,
 				       struct irq_host_ops *ops,
-				       irq_hw_number_t inval_irq);
+				       irq_hw_number_t inval_irq,
+				       const char *name);
 
 
 /**
-- 
1.5.1
