Return-Path: <xerofoify@gmail.com>
Received: from mail-ig0-x22d.google.com (mail-ig0-x22d.google.com
 [IPv6:2607:f8b0:4001:c05::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA8C41A0015
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 12:47:45 +1000 (EST)
Received: by mail-ig0-f173.google.com with SMTP id uq10so5019583igb.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jun 2014 19:47:40 -0700 (PDT)
From: Nicholas Krause <xerofoify@gmail.com>
To: benh@kernel.crashing.org
Subject: [PATCH] Remove FIXME messages in arch/powerpc/sysdev/uic.c
Date: Mon, 30 Jun 2014 22:47:36 -0400
Message-Id: <1404182856-4945-1-git-send-email-xerofoify@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes FIXME messages in the function uic_init_one
as this FIXMEs are not valid due to the kernel being better
to panic due to boards without these allocated not being
able to service IRQs.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/powerpc/sysdev/uic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 9203393..937f6a5 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -239,7 +239,7 @@ static struct uic * __init uic_init_one(struct device_node *node)
 
 	uic = kzalloc(sizeof(*uic), GFP_KERNEL);
 	if (! uic)
-		return NULL; /* FIXME: panic? */
+		return NULL;
 
 	raw_spin_lock_init(&uic->lock);
 	indexp = of_get_property(node, "cell-index", &len);
@@ -261,7 +261,7 @@ static struct uic * __init uic_init_one(struct device_node *node)
 	uic->irqhost = irq_domain_add_linear(node, NR_UIC_INTS, &uic_host_ops,
 					     uic);
 	if (! uic->irqhost)
-		return NULL; /* FIXME: panic? */
+		return NULL;
 
 	/* Start with all interrupts disabled, level and non-critical */
 	mtdcr(uic->dcrbase + UIC_ER, 0);
-- 
1.9.1
