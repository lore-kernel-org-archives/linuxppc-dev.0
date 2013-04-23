Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 127672C0258
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 21:04:16 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Apr 2013 05:04:13 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B86F21FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 04:59:00 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3NB42u7097006
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 05:04:02 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3NB41FD024380
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 05:04:01 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] powerpc/powernv: Add option CONFIG_POWERNV_MSI
Date: Tue, 23 Apr 2013 19:03:52 +0800
Message-Id: <1366715034-24594-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1366715034-24594-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366715034-24594-1-git-send-email-shangw@linux.vnet.ibm.com>
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
