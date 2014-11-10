Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A36A01A00A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2014 09:12:29 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: Bad NULL pointer check in udbg_uart_getc_poll
Date: Tue, 11 Nov 2014 09:12:28 +1100
Message-Id: <1415657548-17802-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have some code in udbg_uart_getc_poll that tries to protect
against a NULL udbg_uart_in, but gets it all wrong.

Found with the LLVM static analyzer (scan-build).

Fixes: 309257484cc1 ("powerpc: Cleanup udbg_16550 and add support for LPC PIO-only UARTs")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/udbg_16550.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/udbg_16550.c b/arch/powerpc/kernel/udbg_16550.c
index 6e7c492..3faf393 100644
--- a/arch/powerpc/kernel/udbg_16550.c
+++ b/arch/powerpc/kernel/udbg_16550.c
@@ -69,7 +69,9 @@ static void udbg_uart_putc(char c)
 
 static int udbg_uart_getc_poll(void)
 {
-	if (!udbg_uart_in || !(udbg_uart_in(UART_LSR) & LSR_DR))
+	if (!udbg_uart_in)
+		return -1;
+	if (!(udbg_uart_in(UART_LSR) & LSR_DR))
 		return udbg_uart_in(UART_RBR);
 	return -1;
 }
-- 
1.9.1
