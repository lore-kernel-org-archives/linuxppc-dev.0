Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 77A85DDFC7
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 18:31:44 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: w.sang@pengutronix.de
Subject: [PATCH] powerpc/cpm2: make cpm2_pic the default host
Date: Fri, 29 May 2009 10:31:33 +0200
Message-Id: <1243585893-29401-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <547eba1b0905281746h970028br9685085d18dceb6e@mail.gmail.com>
References: <547eba1b0905281746h970028br9685085d18dceb6e@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As stated in the source, this one is usually the only
interrupt-controller. To ease creating virq mappings, let it be the
default host.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Daniel Ng <daniel.ng1234@gmail.com>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/sysdev/cpm2_pic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index 78f1f7c..7a7d4e5 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -272,4 +272,5 @@ void cpm2_pic_init(struct device_node *node)
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
 		return;
 	}
+	irq_set_default_host(cpm2_pic_host);
 }
-- 
1.6.2
