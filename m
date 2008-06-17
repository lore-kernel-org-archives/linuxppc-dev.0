Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E1391DDEE4
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 09:30:08 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5HNWN6I010934
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 19:32:23 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5HNTstR216142
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 19:29:54 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5HNTrSt021579
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 19:29:54 -0400
Date: Tue, 17 Jun 2008 19:27:55 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: jgarzik@pobox.com
Subject: [PATCH] ibm_newemac: select CRC32 in Kconfig
Message-ID: <20080617192755.575dcad4@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ibm_newemac driver requires ether_crc to be defined.  Apparently it is
possible to generate a .config without CONFIG_CRC32 set which causes the
following link errors if IBM_NEW_EMAC is selected:

  LD      .tmp_vmlinux1
drivers/built-in.o: In function `emac_hash_mc':
core.c:(.text+0x2f524): undefined reference to `crc32_le'
core.c:(.text+0x2f528): undefined reference to `bitrev32'
make: *** [.tmp_vmlinux1] Error 1

This patch has IBM_NEW_EMAC select CRC32 so we don't hit this error.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 drivers/net/ibm_newemac/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ibm_newemac/Kconfig b/drivers/net/ibm_newemac/Kconfig
index 0d3e738..70a3272 100644
--- a/drivers/net/ibm_newemac/Kconfig
+++ b/drivers/net/ibm_newemac/Kconfig
@@ -1,6 +1,7 @@
 config IBM_NEW_EMAC
 	tristate "IBM EMAC Ethernet support"
 	depends on PPC_DCR && PPC_MERGE
+	select CRC32
 	help
 	  This driver supports the IBM EMAC family of Ethernet controllers
 	  typically found on 4xx embedded PowerPC chips, but also on the
-- 
1.5.4.3
