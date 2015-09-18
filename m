Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB3791A2C01
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2015 00:17:06 +1000 (AEST)
From: Thomas Huth <thuth@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, boqun.feng@gmail.com
Subject: [PATCH] powerpc: Kconfig.cputype: Disallow TUNE_CELL on LE systems
Date: Fri, 18 Sep 2015 16:17:00 +0200
Message-Id: <1442585820-18623-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It looks somewhat weird that you can enable TUNE_CELL on little
endian systems, so let's disable this option with CPU_LITTLE_ENDIAN.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 I first thought that it might be better to make this option depend
 on PPC_CELL instead ... but I guess it's a bad idea to depend a
 CPU option on a platform option? Alternatively, would it make
 sense to make it depend on (GENERIC_CPU || CELL_CPU) instead?

 arch/powerpc/platforms/Kconfig.cputype | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index c140e94..d93e131 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -149,7 +149,7 @@ config 6xx
 
 config TUNE_CELL
 	bool "Optimize for Cell Broadband Engine"
-	depends on PPC64 && PPC_BOOK3S
+	depends on PPC64 && PPC_BOOK3S && !CPU_LITTLE_ENDIAN
 	help
 	  Cause the compiler to optimize for the PPE of the Cell Broadband
 	  Engine. This will make the code run considerably faster on Cell
-- 
1.8.3.1
