Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <277d6dd54a145c8f214ea15c2d63b7180afd4fc4.1192440801.git.michael@ellerman.id.au>
In-Reply-To: <33ee227bae85a8d7ccde69a717cff47000888354.1192440801.git.michael@ellerman.id.au>
References: <33ee227bae85a8d7ccde69a717cff47000888354.1192440801.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 5/5] Remove msic_dcr_read() in axon_msi.c
Date: Mon, 15 Oct 2007 19:34:38 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

msic_dcr_read() doesn't really do anything useful, just replace it with
direct calls to dcr_read().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/axon_msi.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index aca1500..095988f 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -80,18 +80,13 @@ static void msic_dcr_write(struct axon_msic *msic, unsigned int dcr_n, u32 val)
 	dcr_write(msic->dcr_host, dcr_n, val);
 }
 
-static u32 msic_dcr_read(struct axon_msic *msic, unsigned int dcr_n)
-{
-	return dcr_read(msic->dcr_host, dcr_n);
-}
-
 static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	struct axon_msic *msic = get_irq_data(irq);
 	u32 write_offset, msi;
 	int idx;
 
-	write_offset = msic_dcr_read(msic, MSIC_WRITE_OFFSET_REG);
+	write_offset = dcr_read(msic->dcr_host, MSIC_WRITE_OFFSET_REG);
 	pr_debug("axon_msi: original write_offset 0x%x\n", write_offset);
 
 	/* write_offset doesn't wrap properly, so we have to mask it */
@@ -306,7 +301,7 @@ static int axon_msi_notify_reboot(struct notifier_block *nb,
 	list_for_each_entry(msic, &axon_msic_list, list) {
 		pr_debug("axon_msi: disabling %s\n",
 			  msic->irq_host->of_node->full_name);
-		tmp  = msic_dcr_read(msic, MSIC_CTRL_REG);
+		tmp  = dcr_read(msic->dcr_host, MSIC_CTRL_REG);
 		tmp &= ~MSIC_CTRL_ENABLE & ~MSIC_CTRL_IRQ_ENABLE;
 		msic_dcr_write(msic, MSIC_CTRL_REG, tmp);
 	}
-- 
1.5.1.3.g7a33b
