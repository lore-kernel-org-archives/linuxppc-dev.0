Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 964661A018B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 02:35:41 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Karsten Keil <isdn@linux-pingi.de>
Subject: [PATCH 7/8] isdn: replace CONFIG_8xx by CONFIG_PPC_8xx
Message-Id: <20150312152409.E7B5C1A2422@localhost.localdomain>
Date: Thu, 12 Mar 2015 16:24:09 +0100 (CET)
Cc: linux-fbdev@vger.kernel.org, linux-serial@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 user-mode-linux-user@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Two config options exist to define powerpc MPC8xx:
* CONFIG_PPC_8xx
* CONFIG_8xx
In addition, CONFIG_PPC_8xx also defines CONFIG_CPM1 as
communication co-processor

arch/powerpc/platforms/Kconfig.cputype has contained the following
comment about CONFIG_8xx item for some years:
"# this is temp to handle compat with arch=ppc"

It looks like not many places still have that old CONFIG_8xx used,
so it is likely to be a good time to get rid of it completely ?

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 drivers/isdn/hardware/mISDN/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/Kconfig b/drivers/isdn/hardware/mISDN/Kconfig
index 09df54f..ad9deab 100644
--- a/drivers/isdn/hardware/mISDN/Kconfig
+++ b/drivers/isdn/hardware/mISDN/Kconfig
@@ -13,7 +13,7 @@ config MISDN_HFCPCI
 
 config MISDN_HFCMULTI
 	tristate "Support for HFC multiport cards (HFC-4S/8S/E1)"
-	depends on PCI || 8xx
+	depends on PCI || PPC_8xx
 	depends on MISDN
 	help
 	  Enable support for cards with Cologne Chip AG's HFC multiport
@@ -28,7 +28,7 @@ config MISDN_HFCMULTI_8xx
 	depends on MISDN
 	depends on MISDN_HFCMULTI
 	depends on 8xx
-	default 8xx
+	default PPC_8xx
 	help
 	  Enable support for the XHFC embedded solution from Speech Design.
 
-- 
2.1.0
