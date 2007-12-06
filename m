Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Dec 2007 19:00:11 +1100
Subject: [PATCH 13/25] powerpc: Remove useless volatiles in udbg_16550.c
In-Reply-To: <1196927999.714593.205329520306.qpush@grosgo>
Message-Id: <20071206080123.C9332DDFC5@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This removes "volatile" from the MMIO pointer udbg_comport
in udbg_16550.c driver, it's useless and makes checkpatch.pl
complain when adding things to this file.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/udbg_16550.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-work/arch/powerpc/kernel/udbg_16550.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/udbg_16550.c	2007-12-03 12:54:04.000000000 +1100
+++ linux-work/arch/powerpc/kernel/udbg_16550.c	2007-12-03 12:56:07.000000000 +1100
@@ -46,7 +46,7 @@ struct NS16550 {
 
 #define LCR_DLAB 0x80
 
-static volatile struct NS16550 __iomem *udbg_comport;
+static struct NS16550 __iomem *udbg_comport;
 
 static void udbg_550_putc(char c)
 {
@@ -117,7 +117,7 @@ unsigned int udbg_probe_uart_speed(void 
 {
 	unsigned int dll, dlm, divisor, prescaler, speed;
 	u8 old_lcr;
-	volatile struct NS16550 __iomem *port = comport;
+	struct NS16550 __iomem *port = comport;
 
 	old_lcr = in_8(&port->lcr);
 
@@ -162,7 +162,7 @@ void udbg_maple_real_putc(char c)
 
 void __init udbg_init_maple_realmode(void)
 {
-	udbg_comport = (volatile struct NS16550 __iomem *)0xf40003f8;
+	udbg_comport = (struct NS16550 __iomem *)0xf40003f8;
 
 	udbg_putc = udbg_maple_real_putc;
 	udbg_getc = NULL;
@@ -184,7 +184,7 @@ void udbg_pas_real_putc(char c)
 
 void udbg_init_pas_realmode(void)
 {
-	udbg_comport = (volatile struct NS16550 __iomem *)0xfcff03f8UL;
+	udbg_comport = (struct NS16550 __iomem *)0xfcff03f8UL;
 
 	udbg_putc = udbg_pas_real_putc;
 	udbg_getc = NULL;
@@ -219,7 +219,7 @@ static int udbg_44x_as1_getc(void)
 void __init udbg_init_44x_as1(void)
 {
 	udbg_comport =
-		(volatile struct NS16550 __iomem *)PPC44x_EARLY_DEBUG_VIRTADDR;
+		(struct NS16550 __iomem *)PPC44x_EARLY_DEBUG_VIRTADDR;
 
 	udbg_putc = udbg_44x_as1_putc;
 	udbg_getc = udbg_44x_as1_getc;
