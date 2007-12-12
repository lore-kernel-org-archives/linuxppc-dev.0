Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC37FDDF9A
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 09:54:38 +1100 (EST)
Date: Wed, 12 Dec 2007 16:54:32 -0600
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH v2 3/3] Eliminate section mismatch warning in cpm2_reset().
Message-ID: <20071212225431.GC19027@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/cpm2_common.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index 859362f..c1d8240 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -61,8 +61,7 @@ cpm2_map_t __iomem *cpm2_immr;
 					   of space for CPM as it is larger
 					   than on PQ2 */
 
-void
-cpm2_reset(void)
+void __init cpm2_reset(void)
 {
 #ifdef CONFIG_PPC_85xx
 	cpm2_immr = ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
-- 
1.5.3.7
