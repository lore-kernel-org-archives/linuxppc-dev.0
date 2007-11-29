Return-Path: <gorcunov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 1F74EDDEBD
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 06:45:33 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so2140057uge
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 11:45:33 -0800 (PST)
Date: Thu, 29 Nov 2007 22:46:13 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: PPCML <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/5] PPC cleanup: 82xx - do use for_each macro
Message-ID: <20071129194613.GD12123@cvg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Cyrill Gorcunov <gorcunov@gmail.com>

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---

 arch/powerpc/platforms/82xx/pq2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
index a497cba..9e74393 100644
--- a/arch/powerpc/platforms/82xx/pq2.c
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -72,11 +72,11 @@ err:
 
 void __init pq2_init_pci(void)
 {
-	struct device_node *np = NULL;
+	struct device_node *np;
 
 	ppc_md.pci_exclude_device = pq2_pci_exclude_device;
 
-	while ((np = of_find_compatible_node(np, NULL, "fsl,pq2-pci")))
+	for_each_compatible_node(np, NULL, "fsl,pq2-pci")
 		pq2_pci_add_bridge(np);
 }
 #endif
-- 
1.5.3.5
