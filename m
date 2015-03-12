Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 48C2B1A075A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 02:35:46 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Vitaly Bordug <vitb@kernel.crashing.org>,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>
Subject: [PATCH 4/8] net: freescale: replace CONFIG_8xx by CONFIG_PPC_8xx
Message-Id: <20150312152354.A47721A241F@localhost.localdomain>
Date: Thu, 12 Mar 2015 16:23:54 +0100 (CET)
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
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c | 2 +-
 drivers/net/ethernet/freescale/fs_enet/mac-scc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
index b34214e..0e02bb4 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
@@ -38,7 +38,7 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
-#ifdef CONFIG_8xx
+#ifdef CONFIG_PPC_8xx
 #include <asm/8xx_immap.h>
 #include <asm/pgtable.h>
 #include <asm/cpm1.h>
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
index 7a184e8..eec8963 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
@@ -37,7 +37,7 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
-#ifdef CONFIG_8xx
+#ifdef CONFIG_PPC_8xx
 #include <asm/8xx_immap.h>
 #include <asm/pgtable.h>
 #include <asm/cpm1.h>
-- 
2.1.0
