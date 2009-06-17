Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 89C94B718D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 11:55:57 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 17 Jun 2009 11:55:19 +1000
Subject: [PATCH 2/2] powerpc/440: Fix warning early debug code
Message-Id: <20090617015557.7ADA7DDDA1@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function udbg_44x_as1_flush() has the wrong prototype causing
a warning when enabling 440 early debug.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/udbg_16550.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/kernel/udbg_16550.c	2009-06-17 11:52:05.000000000 +1000
+++ linux-work/arch/powerpc/kernel/udbg_16550.c	2009-06-17 11:52:08.000000000 +1000
@@ -219,7 +219,7 @@ void udbg_init_pas_realmode(void)
 #ifdef CONFIG_PPC_EARLY_DEBUG_44x
 #include <platforms/44x/44x.h>
 
-static int udbg_44x_as1_flush(void)
+static void udbg_44x_as1_flush(void)
 {
 	if (udbg_comport) {
 		while ((as1_readb(&udbg_comport->lsr) & LSR_THRE) == 0)
