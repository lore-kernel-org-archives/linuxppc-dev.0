Return-Path: <arnd@arndb.de>
Message-Id: <20060429004327.520785000@localhost.localdomain>
References: <20060429004019.126937000@localhost.localdomain>
Date: Sat, 29 Apr 2006 02:40:21 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/3] spufs: Disable local interrupts for SPE hash_page calls.
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch disables and saves local interrupts during
hash_page processing for SPE contexts.

We have to do it explicitly in the spu_irq_class_1_bottom
function. For the interrupt handlers, we get the behaviour
implicitly by using SA_INTERRUPT to disable interrupts while
in the handler.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linus-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linus-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -306,19 +306,19 @@ spu_request_irqs(struct spu *spu)
 
 	snprintf(spu->irq_c0, sizeof (spu->irq_c0), "spe%02d.0", spu->number);
 	ret = request_irq(irq_base + spu->isrc,
-		 spu_irq_class_0, 0, spu->irq_c0, spu);
+		 spu_irq_class_0, SA_INTERRUPT, spu->irq_c0, spu);
 	if (ret)
 		goto out;
 
 	snprintf(spu->irq_c1, sizeof (spu->irq_c1), "spe%02d.1", spu->number);
 	ret = request_irq(irq_base + IIC_CLASS_STRIDE + spu->isrc,
-		 spu_irq_class_1, 0, spu->irq_c1, spu);
+		 spu_irq_class_1, SA_INTERRUPT, spu->irq_c1, spu);
 	if (ret)
 		goto out1;
 
 	snprintf(spu->irq_c2, sizeof (spu->irq_c2), "spe%02d.2", spu->number);
 	ret = request_irq(irq_base + 2*IIC_CLASS_STRIDE + spu->isrc,
-		 spu_irq_class_2, 0, spu->irq_c2, spu);
+		 spu_irq_class_2, SA_INTERRUPT, spu->irq_c2, spu);
 	if (ret)
 		goto out2;
 	goto out;
@@ -487,10 +487,14 @@ int spu_irq_class_1_bottom(struct spu *s
 	ea = spu->dar;
 	dsisr = spu->dsisr;
 	if (dsisr & (MFC_DSISR_PTE_NOT_FOUND | MFC_DSISR_ACCESS_DENIED)) {
+		u64 flags;
+
 		access = (_PAGE_PRESENT | _PAGE_USER);
 		access |= (dsisr & MFC_DSISR_ACCESS_PUT) ? _PAGE_RW : 0UL;
+		local_irq_save(flags);
 		if (hash_page(ea, access, 0x300) != 0)
 			error |= CLASS1_ENABLE_STORAGE_FAULT_INTR;
+		local_irq_restore(flags);
 	}
 	if (error & CLASS1_ENABLE_STORAGE_FAULT_INTR) {
 		if ((ret = spu_handle_mm_fault(spu)) != 0)

--
