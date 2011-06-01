Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
	by ozlabs.org (Postfix) with ESMTP id 9B422B6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 18:44:14 +1000 (EST)
Received: from juliette.telenet-ops.be (unknown [195.130.137.74])
	by wilson.telenet-ops.be (Postfix) with ESMTP id 46ED47285F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 10:44:10 +0200 (CEST)
Date: Wed, 1 Jun 2011 10:44:07 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/fsl: Use irq_data_get_irq_handler_data() in chain
	handler
Message-ID: <alpine.DEB.2.00.1106011042080.30334@ayla.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If you already have a pointer to a struct irq_data , it's more efficient
to use irq_data_get_irq_handler_data().
irq_get_handler_data() has to look up the struct irq_desc pointer again,
which was already passed to the chain handler.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Completely untested, not even compile-tested.
If this is correct, there are probably more of these?

 arch/powerpc/sysdev/fsl_msi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 92e7833..9b92c82 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -193,7 +193,7 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 	u32 have_shift = 0;
 	struct fsl_msi_cascade_data *cascade_data;
 
-	cascade_data = irq_get_handler_data(irq);
+	cascade_data = irq_data_get_irq_handler_data(idata);
 	msi_data = cascade_data->msi_data;
 
 	raw_spin_lock(&desc->lock);
-- 
1.7.0.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
