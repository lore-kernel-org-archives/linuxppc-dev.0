Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrGbX60QNzDqpn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 22:25:59 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: fix cpm_cascade() dual end of interrupt
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180227112555.DEBCE6E8BA@po15720vm.idsi0.si.c-s.fr>
Date: Tue, 27 Feb 2018 12:25:55 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cpm_cascade() doesn't have to call eoi() as it is already called
by handle_fasteoi_irq()

And cpm_get_irq() will always return an unsigned int so the test
is useless

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/8xx/m8xx_setup.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index e1274db53d48..2188d691a40f 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -217,13 +217,7 @@ void __noreturn mpc8xx_restart(char *cmd)
 
 static void cpm_cascade(struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int cascade_irq = cpm_get_irq();
-
-	if (cascade_irq >= 0)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
+	generic_handle_irq(cpm_get_irq());
 }
 
 /* Initialize the internal interrupt controllers.  The number of
-- 
2.13.3
