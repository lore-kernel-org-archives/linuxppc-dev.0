Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [194.2.40.7])
	by ozlabs.org (Postfix) with ESMTP id E04F810CF6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 17:05:14 +1000 (EST)
Subject: [PATCH] spi_mpc8xxx: issue with using definition of pram in Device
	Tree
From: christophe leroy <christophe.leroy@c-s.fr>
To: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20100916070503.10046C7391@messagerie.si.c-s.fr>
Date: Thu, 16 Sep 2010 09:05:03 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch applies to 2.6.34.7 and 2.6.35.4
It fixes an issue during the probe for CPM1 with definition of parameter ram from DTS

Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>

diff -urN b/drivers/spi/spi_mpc8xxx.c c/drivers/spi/spi_mpc8xxx.c
--- b/drivers/spi/spi_mpc8xxx.c	2010-09-08 16:43:50.000000000 +0200
+++ c/drivers/spi/spi_mpc8xxx.c	2010-09-08 16:44:03.000000000 +0200
@@ -822,7 +822,7 @@
 	if (!iprop || size != sizeof(*iprop) * 4)
 		return -ENOMEM;
 
-	spi_base_ofs = cpm_muram_alloc_fixed(iprop[2], 2);
+	spi_base_ofs = iprop[2];
 	if (IS_ERR_VALUE(spi_base_ofs))
 		return -ENOMEM;
 
@@ -844,7 +844,6 @@
 			return spi_base_ofs;
 	}
 
-	cpm_muram_free(spi_base_ofs);
 	return pram_ofs;
 }
