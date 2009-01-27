Return-Path: <paulfax@conspiracy.net>
Received: from ns.seriouslyclued.net (ns.seriouslyclued.net [209.189.226.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "", Issuer "My Company Ltd" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 39F9BDDFCF
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 19:51:00 +1100 (EST)
Message-ID: <497EC957.2050205@conspiracy.net>
Date: Tue, 27 Jan 2009 02:44:07 -0600
From: paulfax <paulfax@conspiracy.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/cpm2 Fix set interrupt type
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a simple change to correct problems when using set_irq_type on platforms using CPM2.
This code correct the problem on most platform but still fails on 8272 derived platforms for some interrupts.
On 8272 PC2 & 3 are missing and PC 23 & 29 are added, which this patch does not address.

Signed-off-by: Paul Bilke <paul at conspiracy.net>
---




diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index b16ca3e..78f1f7c 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -165,7 +165,7 @@ static int cpm2_set_irq_type(unsigned int virq, unsigned int flow_type)
                        edibit = (14 - (src - CPM2_IRQ_EXT1));
        else
                if (src >= CPM2_IRQ_PORTC15 && src <= CPM2_IRQ_PORTC0)
-                       edibit = (31 - (src - CPM2_IRQ_PORTC15));
+                       edibit = (31 - (CPM2_IRQ_PORTC0 - src));
                else
                        return (flow_type & IRQ_TYPE_LEVEL_LOW) ? 0 : -EINVAL;
