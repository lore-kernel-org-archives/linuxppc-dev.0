Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4F7472C0154
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 10:13:13 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r7G0D8G9020770
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 19:13:09 -0500
Message-ID: <1376611986.4255.123.camel@pasglop>
Subject: [PATCH] powerpc/wsp: Fix early debug build
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 16 Aug 2013 10:13:06 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When reworking udbg_16550.c I forgot to remove the old and now useless
code for the CONFIG_PPC_EARLY_DEBUG_WSP case, which doesn't build as
a result. I also missed a cast.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/udbg_16550.c b/arch/powerpc/kernel/udbg_16550.c
index 25c58e8..75702e2 100644
--- a/arch/powerpc/kernel/udbg_16550.c
+++ b/arch/powerpc/kernel/udbg_16550.c
@@ -300,45 +300,9 @@ void __init udbg_init_40x_realmode(void)
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_WSP
 
-static void udbg_wsp_flush(void)
-{
-	if (udbg_comport) {
-		while ((readb(&udbg_comport->lsr) & LSR_THRE) == 0)
-			/* wait for idle */;
-	}
-}
-
-static void udbg_wsp_putc(char c)
-{
-	if (udbg_comport) {
-		if (c == '\n')
-			udbg_wsp_putc('\r');
-		udbg_wsp_flush();
-		writeb(c, &udbg_comport->thr); eieio();
-	}
-}
-
-static int udbg_wsp_getc(void)
-{
-	if (udbg_comport) {
-		while ((readb(&udbg_comport->lsr) & LSR_DR) == 0)
-			; /* wait for char */
-		return readb(&udbg_comport->rbr);
-	}
-	return -1;
-}
-
-static int udbg_wsp_getc_poll(void)
-{
-	if (udbg_comport)
-		if (readb(&udbg_comport->lsr) & LSR_DR)
-			return readb(&udbg_comport->rbr);
-	return -1;
-}
-
 void __init udbg_init_wsp(void)
 {
-	udbg_uart_init_mmio(WSP_UART_VIRT, 1);
+	udbg_uart_init_mmio((void *)WSP_UART_VIRT, 1);
 	udbg_uart_setup(57600, 50000000);
 }
 
