Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A09D72C009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 22:11:43 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/52xx: fix build breakage for MPC5200 LPBFIFO module
Date: Wed, 16 Oct 2013 13:11:27 +0200
Message-Id: <1381921887-3057-1-git-send-email-agust@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MPC5200 LPBFIFO driver requires the bestcomm module to be
enabled, otherwise building will fail. Fix it.

Cc: <stable@vger.kernel.org> # 3.10+
Reported-by: Wolfgang Denk <wd@denx.de>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/platforms/52xx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index 90f4496..af54174 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -57,5 +57,5 @@ config PPC_MPC5200_BUGFIX
 
 config PPC_MPC5200_LPBFIFO
 	tristate "MPC5200 LocalPlus bus FIFO driver"
-	depends on PPC_MPC52xx
+	depends on PPC_MPC52xx && PPC_BESTCOMM
 	select PPC_BESTCOMM_GEN_BD
-- 
1.8.3.1
