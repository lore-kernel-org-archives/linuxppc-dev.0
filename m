Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78AFE1A1D71
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 14:14:57 +1000 (AEST)
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com
 [IPv6:2607:f8b0:400e:c02::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EE1BA140291
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2015 14:14:56 +1000 (AEST)
Received: by pdrh1 with SMTP id h1so14616229pdr.0
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 21:14:55 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, cyrilbur@gmail.com,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, mikey@neuling.org, imunsie@au.ibm.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH v4 11/11] cxl: Add CONFIG_CXL_EEH symbol
Date: Thu, 13 Aug 2015 14:11:29 +1000
Message-Id: <1439439089-25151-12-git-send-email-dja@axtens.net>
In-Reply-To: <1439439089-25151-1-git-send-email-dja@axtens.net>
References: <1439439089-25151-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_CXL_EEH is for CXL's EEH related code.

Other drivers can depend on or #ifdef on this symbol to configure
PERST behaviour, allowing CXL to participate in the EEH process.

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
index b6db9ebd52c2..c151fc1fe14c 100644
--- a/drivers/misc/cxl/Kconfig
+++ b/drivers/misc/cxl/Kconfig
@@ -11,11 +11,17 @@ config CXL_KERNEL_API
 	bool
 	default n
 
+config CXL_EEH
+	bool
+	default n
+	select EEH
+
 config CXL
 	tristate "Support for IBM Coherent Accelerators (CXL)"
 	depends on PPC_POWERNV && PCI_MSI
 	select CXL_BASE
 	select CXL_KERNEL_API
+	select CXL_EEH
 	default m
 	help
 	  Select this option to enable driver support for IBM Coherent
-- 
2.1.4
