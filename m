Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 17B9B67A7F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Feb 2005 07:34:58 +1100 (EST)
Date: Fri, 18 Feb 2005 12:34:55 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050218203455.GA18041@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Lindentify PPC4xx PIC driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Andrew,

this patch fixes whitespace in PPC4xx PIC driver.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ppc4xx_pic_lindent.diff"

diff -Nru a/arch/ppc/syslib/ppc4xx_pic.c b/arch/ppc/syslib/ppc4xx_pic.c
--- a/arch/ppc/syslib/ppc4xx_pic.c	2005-02-18 12:12:29 -08:00
+++ b/arch/ppc/syslib/ppc4xx_pic.c	2005-02-18 12:12:29 -08:00
@@ -29,8 +29,9 @@
 /* See comment in include/arch-ppc/ppc4xx_pic.h
  * for more info about these two variables
  */
-extern struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[NR_UICS] __attribute__((weak));
-extern unsigned char ppc4xx_uic_ext_irq_cfg[] __attribute__((weak));
+extern struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[NR_UICS]
+    __attribute__ ((weak));
+extern unsigned char ppc4xx_uic_ext_irq_cfg[] __attribute__ ((weak));
 
 #define IRQ_MASK_UIC0(irq)		(1 << (31 - (irq)))
 #define IRQ_MASK_UICx(irq)		(1 << (31 - ((irq) & 0x1f)))
@@ -63,11 +64,11 @@
 {									\
 	unsigned int status = irq_desc[irq].status;			\
 	u32 mask = IRQ_MASK_UIC##n(irq);				\
-	if (status & IRQ_LEVEL){					\
+	if (status & IRQ_LEVEL) {					\
 		mtdcr(DCRN_UIC_SR(UIC##n), mask);			\
 		ACK_UIC##n##_PARENT					\
 	}								\
-	if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS))){		\
+	if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {		\
 		ppc_cached_irq_mask[n] |= mask;				\
 		mtdcr(DCRN_UIC_ER(UIC##n), ppc_cached_irq_mask[n]);	\
 	}								\
@@ -86,7 +87,9 @@
 #define ACK_UIC0_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC0NC);
 #define ACK_UIC1_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC1NC);
 #define ACK_UIC2_PARENT	mtdcr(DCRN_UIC_SR(UICB), UICB_UIC2NC);
-UIC_HANDLERS(0); UIC_HANDLERS(1); UIC_HANDLERS(2);
+UIC_HANDLERS(0);
+UIC_HANDLERS(1);
+UIC_HANDLERS(2);
 
 static int ppc4xx_pic_get_irq(struct pt_regs *regs)
 {
@@ -114,7 +117,8 @@
 #elif NR_UICS == 2
 #define ACK_UIC0_PARENT
 #define ACK_UIC1_PARENT	mtdcr(DCRN_UIC_SR(UIC0), UIC0_UIC1NC);
-UIC_HANDLERS(0); UIC_HANDLERS(1);
+UIC_HANDLERS(0);
+UIC_HANDLERS(1);
 
 static int ppc4xx_pic_get_irq(struct pt_regs *regs)
 {
@@ -143,18 +147,20 @@
 	return uic0 ? 32 - ffs(uic0) : -1;
 }
 
-static inline void ppc4xx_pic_impl_init(void){}
+static inline void ppc4xx_pic_impl_init(void)
+{
+}
 #endif
 
 static struct ppc4xx_uic_impl {
 	struct hw_interrupt_type decl;
-	int			 base;		/* Base DCR number */
+	int base;			/* Base DCR number */
 } __uic[] = {
-    { .decl = DECLARE_UIC(0), .base = UIC0 },
+	{ .decl = DECLARE_UIC(0), .base = UIC0 },
 #if NR_UICS > 1
-    { .decl = DECLARE_UIC(1), .base = UIC1 },
+	{ .decl = DECLARE_UIC(1), .base = UIC1 },
 #if NR_UICS > 2
-    { .decl = DECLARE_UIC(2), .base = UIC2 },
+	{ .decl = DECLARE_UIC(2), .base = UIC2 },
 #endif
 #endif
 };
@@ -168,9 +174,9 @@
 void __init ppc4xx_pic_init(void)
 {
 	int i;
-	unsigned char* eirqs = ppc4xx_uic_ext_irq_cfg;
+	unsigned char *eirqs = ppc4xx_uic_ext_irq_cfg;
 
-	for (i = 0; i < NR_UICS; ++i){
+	for (i = 0; i < NR_UICS; ++i) {
 		int base = __uic[i].base;
 
 		/* Disable everything by default */
@@ -181,23 +187,23 @@
 		mtdcr(DCRN_UIC_CR(base), 0);
 
 		/* Configure polarity and triggering */
-		if (ppc4xx_core_uic_cfg){
-			struct ppc4xx_uic_settings* p = ppc4xx_core_uic_cfg + i;
+		if (ppc4xx_core_uic_cfg) {
+			struct ppc4xx_uic_settings *p = ppc4xx_core_uic_cfg + i;
 			u32 mask = p->ext_irq_mask;
 			u32 pr = mfdcr(DCRN_UIC_PR(base)) & mask;
 			u32 tr = mfdcr(DCRN_UIC_TR(base)) & mask;
 
 			/* "Fixed" interrupts (on-chip devices) */
-			pr |= p->polarity   & ~mask;
+			pr |= p->polarity & ~mask;
 			tr |= p->triggering & ~mask;
 
 			/* Merge external IRQs settings if board port
 			 * provided them
 			 */
-			if (eirqs && mask){
+			if (eirqs && mask) {
 				pr &= ~mask;
 				tr &= ~mask;
-				while (mask){
+				while (mask) {
 					/* Extract current external IRQ mask */
 					u32 eirq_mask = 1 << __ilog2(mask);
 
@@ -227,8 +233,8 @@
 	ppc4xx_pic_impl_init();
 
 	/* Attach low-level handlers */
-	for (i = 0; i < (NR_UICS << 5); ++i){
-    		irq_desc[i].handler = &__uic[i >> 5].decl;
+	for (i = 0; i < (NR_UICS << 5); ++i) {
+		irq_desc[i].handler = &__uic[i >> 5].decl;
 		if (is_level_sensitive(i))
 			irq_desc[i].status |= IRQ_LEVEL;
 	}
diff -Nru a/include/asm-ppc/ppc4xx_pic.h b/include/asm-ppc/ppc4xx_pic.h
--- a/include/asm-ppc/ppc4xx_pic.h	2005-02-18 12:12:29 -08:00
+++ b/include/asm-ppc/ppc4xx_pic.h	2005-02-18 12:12:29 -08:00
@@ -43,11 +43,11 @@
  *
  */
 struct ppc4xx_uic_settings {
-	u32 	polarity;
-	u32 	triggering;
-	u32	ext_irq_mask;
+	u32 polarity;
+	u32 triggering;
+	u32 ext_irq_mask;
 };
 
 extern void ppc4xx_pic_init(void);
 
-#endif	/* __PPC4XX_PIC_H__ */
+#endif				/* __PPC4XX_PIC_H__ */

--W/nzBZO5zC0uMSeA--
