Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 729AC2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 19:00:28 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r4M90MsB009743
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 04:00:23 -0500
Message-ID: <1369213222.3870.14.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Build a zImage.epapr
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 22 May 2013 19:00:22 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The zImage.epapr wrapper allows to use zImages when booting via a flat
device-tree which can be used on powernv.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

TODO: Make the main zImage.pseries cope with an epapr boot...

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 91bec0e..a18e9b7 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -6,6 +6,7 @@ config PPC_POWERNV
 	select PPC_ICP_NATIVE
 	select PPC_P7_NAP
 	select PPC_PCI_CHOICE if EMBEDDED
+	select EPAPR_BOOT
 	default y
 
 config POWERNV_MSI
