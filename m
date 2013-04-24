Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E8002C011A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 19:37:53 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 05:37:49 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CD27F38C801A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 05:37:46 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O9bkf162456014
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 05:37:46 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O9bkYk003596
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 05:37:46 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/7] powerpc/powernv: Add option CONFIG_POWERNV_MSI
Date: Wed, 24 Apr 2013 17:37:35 +0800
Message-Id: <1366796259-29412-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As Michael Ellerman suggested, to add CONFIG_POWERNV_MSI for PowerNV
platform. That's similar to CONFIG_PSERIES_MSI for pSeries platform.
For now, we don't make it dependent on CONFIG_EEH since it's not ready
to enable that yet.

Apart from that, we also enable CONFIG_PPC_MSI_BITMAP on selecting
CONFIG_POWERNV_MSI.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Kconfig |    5 +++++
 arch/powerpc/sysdev/Kconfig            |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 74fea5c..d3e840d 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -8,6 +8,11 @@ config PPC_POWERNV
 	select PPC_PCI_CHOICE if EMBEDDED
 	default y
 
+config POWERNV_MSI
+	bool "Support PCI MSI on PowerNV platform"
+	depends on PCI_MSI
+	default y
+
 config PPC_POWERNV_RTAS
 	depends on PPC_POWERNV
 	bool "Support for RTAS based PowerNV platforms such as BML"
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index a84fecf..ab4cb54 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -19,6 +19,7 @@ config PPC_MSI_BITMAP
 	default y if MPIC
 	default y if FSL_PCI
 	default y if PPC4xx_MSI
+	default y if POWERNV_MSI
 
 source "arch/powerpc/sysdev/xics/Kconfig"
 
-- 
1.7.5.4
