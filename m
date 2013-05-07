Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Make CONFIG_RTAS_PROC depend on CONFIG_PROC_FS
Date: Tue,  7 May 2013 14:43:39 +1000
Message-Id: <1367901819-24305-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are getting build errors with CONFIG_PROC_FS=n:

arch/powerpc/kernel/rtas_flash.c
   In function 'rtas_flash_init':
  745:33: error: unused variable 'f' [-Werror=unused-variable]

But rtas_flash.c should not be built when CONFIG_PROC_FS=n, beacause all
it does is provide a /proc interface to the RTAS flash routines.

CONFIG_RTAS_FLASH already depends on CONFIG_RTAS_PROC, to indicate that
it depends on the RTAS proc support, but CONFIG_RTAS_PROC does not
depend on CONFIG_PROC_FS. So fix that.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 34d224b..632444f 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -128,7 +128,7 @@ config PPC_RTAS_DAEMON
 
 config RTAS_PROC
 	bool "Proc interface to RTAS"
-	depends on PPC_RTAS
+	depends on PPC_RTAS && PROC_FS
 	default y
 
 config RTAS_FLASH
-- 
1.7.10.4
