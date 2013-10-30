Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 38ADF2C0353
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 13:58:33 +1100 (EST)
Message-ID: <5270752B.50500@asianux.com>
Date: Wed, 30 Oct 2013 10:55:39 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: platforms: powernv: include "asm/prom.h" in "rng.c"
Content-Type: text/plain; charset=windows-1252
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Need include the related header file, or can not pass compiling with
allmodconfig.

The related error (with allmodconfig):

    CC      arch/powerpc/platforms/powernv/rng.o
  arch/powerpc/platforms/powernv/rng.c: In function ‘rng_init_per_cpu’:
  arch/powerpc/platforms/powernv/rng.c:64:2: error: implicit declaration of function ‘of_get_ibm_chip_id’ [-Werror=implicit-function-declaration]
  arch/powerpc/platforms/powernv/rng.c: In function ‘rng_create’:
  arch/powerpc/platforms/powernv/rng.c:85:2: error: implicit declaration of function ‘of_iomap’ [-Werror=implicit-function-declaration]
  arch/powerpc/platforms/powernv/rng.c:85:12: warning: assignment makes pointer from integer without a cast [enabled by default]


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/powerpc/platforms/powernv/rng.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
index 02db7d7..b3e1ebc 100644
--- a/arch/powerpc/platforms/powernv/rng.c
+++ b/arch/powerpc/platforms/powernv/rng.c
@@ -16,6 +16,7 @@
 #include <asm/archrandom.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
+#include <asm/prom.h>
 
 
 struct powernv_rng {
-- 
1.7.7.6
