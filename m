Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7435DB700C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 06:47:21 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next] ibm emac: delete module references;
 phy.c only supported as built-in
Date: Mon, 27 Feb 2012 14:47:04 -0500
Message-Id: <1330372024-30974-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Makefile has it as "ibm_emac-y := mal.o core.o phy.o" so there is
no way this can be built modular, so remove all references to module
support.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/net/ethernet/ibm/emac/phy.c b/drivers/net/ethernet/ibm/emac/phy.c
index d3b9d10..fb96387 100644
--- a/drivers/net/ethernet/ibm/emac/phy.c
+++ b/drivers/net/ethernet/ibm/emac/phy.c
@@ -11,13 +11,15 @@
  * Copyright 2007 Benjamin Herrenschmidt, IBM Corp.
  *                <benh@kernel.crashing.org>
  *
+ * Originally listed as MODULE_LICENSE("GPL") in the code, but that
+ * was removed, since this code is only supported as non-modular.
+ *
  * Based on the arch/ppc version of the driver:
  *
  * (c) 2003, Benjamin Herrenscmidt (benh@kernel.crashing.org)
  * (c) 2004-2005, Eugene Surovegin <ebs@ebshome.net>
  *
  */
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/netdevice.h>
@@ -537,5 +539,3 @@ int emac_mii_phy_probe(struct mii_phy *phy, int address)
 
 	return 0;
 }
-
-MODULE_LICENSE("GPL");
-- 
1.7.9.1
