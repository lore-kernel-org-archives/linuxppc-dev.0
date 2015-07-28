Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5A331A0D78
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 15:31:42 +1000 (AEST)
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 159A21401AF
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 15:31:42 +1000 (AEST)
Received: by padck2 with SMTP id ck2so63787550pad.0
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 22:31:40 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 10/10] cxl: Add CONFIG_CXL_EEH symbol
Date: Tue, 28 Jul 2015 15:28:43 +1000
Message-Id: <1438061323-20710-11-git-send-email-dja@axtens.net>
In-Reply-To: <1438061323-20710-1-git-send-email-dja@axtens.net>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_CXL_EEH is for CXL's EEH related code.

As well as the EEH callbacks, it should guard sysfs and
kernel API changes that are only required for CXL EEH.

We now have all the pieces in place, so add it now.

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
