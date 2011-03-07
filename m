Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B573B78A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 10:59:35 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:31 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/28] powerpc: platforms/chrp irq_data conversion.
Message-ID: <20110307235931.GN16649@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1299541392.git.buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/powerpc/platforms/chrp/setup.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 8553cc4..4c12884 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -365,10 +365,13 @@ void __init chrp_setup_arch(void)
 
 static void chrp_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
+
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
+
+	chip->irq_eoi(&desc->irq_data);
 }
 
 /*
-- 
1.7.4
