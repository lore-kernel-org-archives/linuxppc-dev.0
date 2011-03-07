Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4B89B7733
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 10:59:29 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:25 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/28] powerpc: platforms/8xx irq_data conversion.
Message-ID: <20110307235925.GL16649@mail.wantstofly.org>
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
 arch/powerpc/platforms/8xx/m8xx_setup.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index 60168c1..fabb108 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -218,15 +218,20 @@ void mpc8xx_restart(char *cmd)
 
 static void cpm_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip;
 	int cascade_irq;
 
 	if ((cascade_irq = cpm_get_irq()) >= 0) {
 		struct irq_desc *cdesc = irq_to_desc(cascade_irq);
 
 		generic_handle_irq(cascade_irq);
-		cdesc->chip->eoi(cascade_irq);
+
+		chip = get_irq_desc_chip(cdesc);
+		chip->irq_eoi(&cdesc->irq_data);
 	}
-	desc->chip->eoi(irq);
+
+	chip = get_irq_desc_chip(desc);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 /* Initialize the internal interrupt controllers.  The number of
-- 
1.7.4
