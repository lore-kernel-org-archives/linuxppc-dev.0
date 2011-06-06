Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <galak@kernel.crashing.org>
MIME-Version: 1.0
Subject: [PATCH] Fix doorbell type shift
Date: Mon, 06 Jun 2011 12:48:47 +1000
Message-ID: <23877.1307328527@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

doorbell type is defined as bits 32:36 so should be shifted by 63-36 =
27 rather than 28.

We never noticed this bug as we've only every used type PPC_DBELL = 0.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/dbell.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-ozlabs/arch/powerpc/include/asm/dbell.h
===================================================================
--- linux-ozlabs.orig/arch/powerpc/include/asm/dbell.h
+++ linux-ozlabs/arch/powerpc/include/asm/dbell.h
@@ -18,7 +18,7 @@
 #include <asm/ppc-opcode.h>
 
 #define PPC_DBELL_MSG_BRDCAST	(0x04000000)
-#define PPC_DBELL_TYPE(x)	(((x) & 0xf) << 28)
+#define PPC_DBELL_TYPE(x)	(((x) & 0xf) << (63-36))
 enum ppc_dbell {
 	PPC_DBELL = 0,		/* doorbell */
 	PPC_DBELL_CRIT = 1,	/* critical doorbell */
