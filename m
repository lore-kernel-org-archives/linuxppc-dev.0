Return-Path: <alistair@popple.id.au>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E7BF92C010F
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 12:16:48 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <alistair@popple.id.au>;
 Wed, 24 Apr 2013 12:07:18 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0C2D82CE8053
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 12:16:42 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O234YV11665720
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 12:03:07 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O2GcgM010413
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 12:16:38 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3O2GcEO010410
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 12:16:38 +1000
Received: from mexican (haven.au.ibm.com [9.190.164.82])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 28575A010D
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 12:16:38 +1000 (EST)
Message-ID: <cone.1366769803.675979.7618.1000@mexican>
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Make =?UTF-8?Q?CONFIG=5FBOOTX?= an exclusive early debug
 option
Date: Wed, 24 Apr 2013 12:16:43 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch makes the kernel configuration option "Support for early boot text
console (BootX or OpenFirmware only)" an exclusive choice under the "Early
debugging" menu. This prevents selection of two early debug consoles
simultaneously which does not appear to be supported by the code in
arch/powerpc/kernel/udbg.c.

Currently if two consoles are enabled the code in udbg.c selects one based on
the order in which initialisation functions are called which seems fairly
arbitrary.

For example if both CONFIG_BOOTX_TEXT and CONFIG_PPC_EARLY_DEBUG_LPAR are
enabled then the BootX console will be used. However if both CONFIG_BOOTX_TEXT
and CONFIG_PPC_EARLY_DEBUG_PS3GELIC are selected then the latter will be used.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 5416e28..659120c 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -122,13 +122,6 @@ config BDI_SWITCH
 	  Unless you are intending to debug the kernel with one of these
 	  machines, say N here.

-config BOOTX_TEXT
-	bool "Support for early boot text console (BootX or OpenFirmware only)"
-	depends on PPC_OF && PPC_BOOK3S
-	help
-	  Say Y here to see progress messages from the boot firmware in text
-	  mode. Requires either BootX or Open Firmware.
-
 config PPC_EARLY_DEBUG
 	bool "Early debugging (dangerous)"
 	help
@@ -147,6 +140,13 @@ choice
 	  enable debugging for the wrong type of machine your kernel
 	  _will not boot_.

+config BOOTX_TEXT
+	bool "Support for early boot text console (BootX or OpenFirmware only)"
+	depends on PPC_OF && PPC_BOOK3S
+	help
+	  Say Y here to see progress messages from the boot firmware in text
+	  mode. Requires either BootX or Open Firmware.
+
 config PPC_EARLY_DEBUG_LPAR
 	bool "LPAR HV Console"
 	depends on PPC_PSERIES
