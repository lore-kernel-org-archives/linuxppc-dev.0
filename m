Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6B298B6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 02:15:47 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 1D373DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2009 02:15:46 +1000 (EST)
Date: Wed, 8 Jul 2009 09:15:43 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: bluesmoke-devel@lists.sourceforge.net, Dave Jiang <djiang@mvista.com>,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] edac: mpc85xx: fix warning when building without CONFIG_PCI
Message-ID: <20090708161543.GB14979@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When building without CONFIG_PCI the edac_pci_idx variable is unused,
causing a build-time warning. Wrap the variable in #ifdef CONFIG_PCI, just
like the rest of the PCI support.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/edac/mpc85xx_edac.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 3f2ccfc..b4f5c63 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -26,7 +26,9 @@
 #include "mpc85xx_edac.h"
 
 static int edac_dev_idx;
+#ifdef CONFIG_PCI
 static int edac_pci_idx;
+#endif
 static int edac_mc_idx;
 
 static u32 orig_ddr_err_disable;
-- 
1.5.4.3
