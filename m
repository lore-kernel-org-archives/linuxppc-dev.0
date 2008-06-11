Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C5B02DDF2D
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 22:32:49 +1000 (EST)
Date: Wed, 11 Jun 2008 16:32:48 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/QE: qe_reset should be __init
Message-ID: <20080611123248.GA8207@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes following section mismatch:

WARNING: arch/powerpc/sysdev/built-in.o(.text+0x11d8): Section mismatch in
reference from the function qe_reset() to the function
.init.text:cpm_muram_init()

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/qe.c |    2 +-
 include/asm-powerpc/qe.h        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 28e05df..9e82d7e 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -87,7 +87,7 @@ phys_addr_t get_qe_base(void)
 
 EXPORT_SYMBOL(get_qe_base);
 
-void qe_reset(void)
+void __init qe_reset(void)
 {
 	if (qe_immr == NULL)
 		qe_immr = ioremap(get_qe_base(), QE_IMMAP_SIZE);
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index 80807fd..1355e72 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -84,7 +84,7 @@ static inline bool qe_clock_is_brg(enum qe_clock clk)
 extern spinlock_t cmxgcr_lock;
 
 /* Export QE common operations */
-extern void qe_reset(void);
+extern void __init qe_reset(void);
 
 /* QE PIO */
 #define QE_PIO_PINS 32
-- 
1.5.5.4
