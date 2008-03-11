Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B427CDEB22
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 04:24:22 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id A95F28814
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 22:24:34 +0400 (SAMT)
Date: Tue, 11 Mar 2008 20:24:21 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/8] [POWERPC] immap_qe.h should include asm/io.h
Message-ID: <20080311172421.GD7727@localhost.localdomain>
References: <20080311172106.GA4766@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080311172106.GA4766@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Headers should include prototypes they use, otherwise build will
break if we use it without explicitly including io.h:

  CC      arch/powerpc/sysdev/qe_lib/gtm.o
In file included from include/asm/qe.h:20,
                 from arch/powerpc/sysdev/qe_lib/gtm.c:18:
include/asm/immap_qe.h: In function ‘immrbar_virt_to_phys’:
include/asm/immap_qe.h:480: error: implicit declaration of function ‘virt_to_phys’
make[2]: *** [arch/powerpc/sysdev/qe_lib/gtm.o] Error 1
make[1]: *** [arch/powerpc/sysdev/qe_lib] Error 2

gtm.c needs qe.h (which includes immap_qe.h) to use qe_get_brg_clk().

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 include/asm-powerpc/immap_qe.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index 924aefb..7b6f411 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -20,6 +20,7 @@
 #ifdef __KERNEL__
 
 #include <linux/kernel.h>
+#include <asm/io.h>
 
 #define QE_IMMAP_SIZE	(1024 * 1024)	/* 1MB from 1MB+IMMR */
 
-- 
1.5.2.2
