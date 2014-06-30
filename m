Return-Path: <xerofoify@gmail.com>
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com
 [IPv6:2607:f8b0:4001:c05::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9798F1A0016
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jun 2014 14:02:21 +1000 (EST)
Received: by mail-ig0-f170.google.com with SMTP id h15so3797735igd.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:02:19 -0700 (PDT)
From: Nicholas Krause <xerofoify@gmail.com>
To: paulus@samba.org
Subject: [PATCH] Fixes return issues in uic_init_one
Date: Mon, 30 Jun 2014 00:02:14 -0400
Message-Id: <1404100934-7490-1-git-send-email-xerofoify@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes the FIXME messages for returning a ENOMEM error
if uic is not allocated and if uic->irqhost is not allocated a
IRQ domain that is linear returns EIO.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/powerpc/sysdev/uic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 9203393..f95010a 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -239,7 +239,7 @@ static struct uic * __init uic_init_one(struct device_node *node)
 
 	uic = kzalloc(sizeof(*uic), GFP_KERNEL);
 	if (! uic)
-		return NULL; /* FIXME: panic? */
+		return -ENOMEM; 
 
 	raw_spin_lock_init(&uic->lock);
 	indexp = of_get_property(node, "cell-index", &len);
@@ -261,7 +261,7 @@ static struct uic * __init uic_init_one(struct device_node *node)
 	uic->irqhost = irq_domain_add_linear(node, NR_UIC_INTS, &uic_host_ops,
 					     uic);
 	if (! uic->irqhost)
-		return NULL; /* FIXME: panic? */
+		return -EIO; 
 
 	/* Start with all interrupts disabled, level and non-critical */
 	mtdcr(uic->dcrbase + UIC_ER, 0);
-- 
1.9.1
