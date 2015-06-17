Return-Path: <apopple@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06E411A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 11:38:12 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D33E5140295
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2015 11:38:11 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <apopple@au1.ibm.com>;
 Wed, 17 Jun 2015 11:38:10 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 86C173578048
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2015 11:38:06 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5H1bu8E54984904
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2015 11:38:04 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5H1bXl4023478
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2015 11:37:33 +1000
From: Alistair Popple <alistair@popple.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, dja@axtens.net,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powerpc/powernv: Increase opal-irqchip initcall priority
Date: Wed, 17 Jun 2015 11:36:57 +1000
Message-Id: <1434505017-18313-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The eeh subsystem for powernv requires the opal event irqchip to be
initialised prior to initialisation or the following errors are
produced (and eeh doesn't work as expected):

irq: XICS didn't like hwirq-0x9 to VIRQ17 mapping (rc=-22)
pnv_eeh_post_init: Can't request OPAL event interrupt (0)

On powernv eeh is initialised from a subsys_initcall due to a check
for machine_is(powernv) in eeh_init(). This patch increases the
initcall priority of opal_event_init() to an arch_initcall to ensure
the opal event interface is initialised prior to any users of it.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Reported-by: Daniel Axtens <dja@axtens.net>
---

Michael,

This supercedes my previous patch (powerpc/powernv: Bump opal_init
initcall priority).

Thanks.

 arch/powerpc/platforms/powernv/opal-irqchip.c | 4 ++++
 arch/powerpc/platforms/powernv/opal.c         | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index 841135f..e2e7d75 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -231,6 +231,7 @@ out:
 	of_node_put(opal_node);
 	return rc;
 }
+machine_arch_initcall(powernv, opal_event_init);

 /**
  * opal_event_request(unsigned int opal_event_nr) - Request an event
@@ -244,6 +245,9 @@ out:
  */
 int opal_event_request(unsigned int opal_event_nr)
 {
+	if (WARN_ON_ONCE(!opal_event_irqchip.domain))
+		return NO_IRQ;
+
 	return irq_create_mapping(opal_event_irqchip.domain, opal_event_nr);
 }
 EXPORT_SYMBOL(opal_event_request);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 9e9c483..f084afa 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -657,9 +657,6 @@ static int __init opal_init(void)
 		return -ENODEV;
 	}

-	/* Initialise OPAL events */
-	opal_event_init();
-
 	/* Register OPAL consoles if any ports */
 	if (firmware_has_feature(FW_FEATURE_OPALv2))
 		consoles = of_find_node_by_path("/ibm,opal/consoles");
--
1.8.3.2
