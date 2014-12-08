Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 71C851A0BAF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 01:17:05 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH] powerpc32/chrp: fix section mismatch warning
Message-Id: <20141208141644.8D8741A5D5C@localhost.localdomain>
Date: Mon,  8 Dec 2014 15:16:44 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes a section mismatch warning

WARNING: vmlinux.o(.text+0x213b6): Section mismatch in reference from the function chrp_init_early() to the variable .init.data:boot_command_line
The function chrp_init_early() references
the variable __initdata boot_command_line.
This is often because chrp_init_early lacks a __initdata 
annotation or the annotation of boot_command_line is wrong.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/platforms/chrp/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 5b77b19..d5d1ea5 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -253,7 +253,7 @@ static void briq_restart(char *cmd)
  * But unfortunately, the firmware does not connect /chosen/{stdin,stdout}
  * the the built-in serial node. Instead, a /failsafe node is created.
  */
-static void chrp_init_early(void)
+static __init void chrp_init_early(void)
 {
 	struct device_node *node;
 	const char *property;
-- 
2.1.0
