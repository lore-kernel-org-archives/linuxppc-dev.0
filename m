Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F20441A0024
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jan 2015 20:48:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Reword the "returning from prom_init" message
Date: Mon, 12 Jan 2015 20:48:16 +1100
Message-Id: <1421056096-20043-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We get way too many bug reports that say "the kernel is hung in
prom_init", which stems from the fact that the last piece of output
people see is "returning from prom_init".

The kernel is almost never hung in prom_init(), it's just that it's
crashed somewhere after prom_init() but prior to the console coming up.

The existing message should give a clue to that, ie. "returning from"
indicates that prom_init() has finished, but it doesn't seem to work.
Let's try something different.

This prints:

  Calling quiesce...
  Shutting down Open Firmware, booting Linux via __start() ...

Which hopefully makes it clear that prom_init() is not the problem, and
although __start() probably isn't either, it's at least the right place
to begin looking.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 1a85d8f96739..bd3e0d8ac8fd 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2910,7 +2910,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 
 	/* Don't print anything after quiesce under OPAL, it crashes OFW */
 	if (of_platform != PLATFORM_OPAL) {
-		prom_printf("returning from prom_init\n");
+		prom_printf("Shutting down Open Firmware, booting Linux via __start() ...\n");
 		prom_debug("->dt_header_start=0x%x\n", hdr);
 	}
 
-- 
2.1.0
