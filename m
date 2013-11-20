Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc/pseries: Fix SMP=n build of rng.c
Date: Wed, 20 Nov 2013 11:05:02 +1100
Message-Id: <1384905902-18042-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1384905902-18042-1-git-send-email-mpe@ellerman.id.au>
References: <1384905902-18042-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit a489043 "Implement arch_get_random_long() based on H_RANDOM" I
broke the SMP=n build. We were getting plpar_wrappers.h via spinlock.h
which breaks when SMP=n.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/rng.c b/arch/powerpc/platforms/pseries/rng.c
index a702f1c..72a1027 100644
--- a/arch/powerpc/platforms/pseries/rng.c
+++ b/arch/powerpc/platforms/pseries/rng.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <asm/archrandom.h>
 #include <asm/machdep.h>
+#include <asm/plpar_wrappers.h>
 
 
 static int pseries_get_random_long(unsigned long *v)
-- 
1.8.3.2
