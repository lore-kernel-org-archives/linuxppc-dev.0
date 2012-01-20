Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F31341007D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2012 12:23:33 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: galak@kernel.crashing.org, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/85xx: fix Kconfig warning about missing 8250
 dependency
Date: Thu, 19 Jan 2012 20:23:20 -0500
Message-Id: <1327022600-24206-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SERIAL_8250_EXTENDED option just enables access to other
less regularly used options, like SERIAL_8250_SHARE_IRQ.
Select it to get rid of this warning when selecting the child
option living underneath it.

  warning: (FSL_SOC_BOOKE && SERIAL_8250_RM9K) selects
  SERIAL_8250_SHARE_IRQ which has unmet direct dependencies
  (HAS_IOMEM && SERIAL_8250_EXTENDED)

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index d7946be..b221236 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -6,6 +6,7 @@ menuconfig FSL_SOC_BOOKE
 	select MPIC
 	select PPC_PCI_CHOICE
 	select FSL_PCI if PCI
+	select SERIAL_8250_EXTENDED if SERIAL_8250
 	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
 	default y
 
-- 
1.7.7.2
