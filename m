Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc/opal: Add missing include
Date: Tue, 25 Mar 2014 11:43:08 +1100
Message-ID: <13762.1395708188@ale.ozlabs.ibm.com>
Cc: sfr@canb.auug.org.au, linux-next@vger.kernel.org,
 Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

next-20140324 currently fails compiling celleb_defconfig with:

arch/powerpc/include/asm/opal.h:894:42: error: 'struct notifier_block' declared inside parameter list [-Werror]
arch/powerpc/include/asm/opal.h:894:42: error: its scope is only this definition or declaration, which is probably not what you want [-Werror]
arch/powerpc/include/asm/opal.h:896:14: error: 'struct notifier_block' declared inside parameter list [-Werror]

This is due to a missing include which is added here.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index fe2aa0b..f57fb58 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -177,6 +177,8 @@ extern int opal_enter_rtas(struct rtas_args *args,
 
 #ifndef __ASSEMBLY__
 
+#include <linux/notifier.h>
+
 /* Other enums */
 enum OpalVendorApiTokens {
 	OPAL_START_VENDOR_API_RANGE = 1000, OPAL_END_VENDOR_API_RANGE = 1999
