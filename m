Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 233EC1A0431
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 16:45:45 +1000 (AEST)
Message-ID: <1434437144.17070.32.camel@neuling.org>
Subject: [PATCH] cxl: Add CXL_KERNEL_API config option
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, "Manoj N.Kumar"
 <manoj@linux.vnet.ibm.com>, Brian King <brking@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "James.Bottomley"
 <James.Bottomley@HansenPartnership.com>,  Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Date: Tue, 16 Jun 2015 16:45:44 +1000
In-Reply-To: <1434436498.17070.27.camel@neuling.org>
References: <20150613160038.367B18EE112@bedivere.hansenpartnership.com>
 <1434235143.5042.63.camel@neuling.org>
 <3746D390-571E-4D17-83A3-4D0D36335929@ellerman.id.au>
 <1434244818.5042.68.camel@neuling.org>
 <1434379526.2170.57.camel@HansenPartnership.com>
 <1434436498.17070.27.camel@neuling.org>
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

Add CXL_KERNEL_API config option so drivers which depend on this new
functionality won't be enabled until this is visible.

This is useful for merging the cxlflash driver which comes in via the SCSI
tree.  The cxlflash driver can depend on CXL_KERNEL_API, hence it won't be
enabled in the SCSI tree until this new config option is merged via the pow=
erpc
tree.  Hence all trees will be bisectable at all times.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
index a990b39..b6db9eb 100644
--- a/drivers/misc/cxl/Kconfig
+++ b/drivers/misc/cxl/Kconfig
@@ -7,10 +7,15 @@ config CXL_BASE
 	default n
 	select PPC_COPRO_BASE
=20
+config CXL_KERNEL_API
+	bool
+	default n
+
 config CXL
 	tristate "Support for IBM Coherent Accelerators (CXL)"
 	depends on PPC_POWERNV && PCI_MSI
 	select CXL_BASE
+	select CXL_KERNEL_API
 	default m
 	help
 	  Select this option to enable driver support for IBM Coherent
