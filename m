Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1D8CCDDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 23:53:55 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6BDrqdJ022982
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 09:53:52 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6BDrqMn268444
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:53:52 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6BDrpAR023262
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:53:51 -0600
Subject: [RFC][PATCH 1/8] 4xx Kconfig cleanup
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 11 Jul 2007 08:53:50 -0500
Message-Id: <1184162031.32199.54.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove some leftover cruft in the 40x Kconfig file.  Also make sure we
select WANT_DEVICE_TREE for 40x.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/platforms/4xx/Kconfig     |   77 ---------------------------------
 arch/powerpc/platforms/Kconfig.cputype |    1 
 2 files changed, 1 insertion(+), 77 deletions(-)

--- linux-2.6.orig/arch/powerpc/platforms/4xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/4xx/Kconfig
@@ -1,16 +1,3 @@
-config 4xx
-	bool
-	depends on 40x || 44x
-	default y
-
-config BOOKE
-	bool
-	depends on 44x
-	default y
-
-menu "AMCC 40x options"
-	depends on 40x
-
 #config BUBINGA
 #	bool "Bubinga"
 #	depends on 40x
@@ -82,8 +69,6 @@ menu "AMCC 40x options"
 #	help
 #	  This option enables support for the Xilinx ML300 evaluation board.
 
-endmenu
-
 # 40x specific CPU modules, selected based on the board above.
 config NP405H
 	bool
@@ -126,68 +111,6 @@ config IBM405_ERR77
 config IBM405_ERR51
 	bool
 
-menu "AMCC 44x options"
-	depends on 44x
-
-#config BAMBOO
-#	bool "Bamboo"
-#	depends on 44x
-#	default n
-#	select 440EP
-#	help
-#	  This option enables support for the IBM PPC440EP evaluation board.
-
-config EBONY
-	bool "Ebony"
-	depends on 44x
-	default y
-	select 440GP
-	help
-	  This option enables support for the IBM PPC440GP evaluation board.
-
-#config LUAN
-#	bool "Luan"
-#	depends on 44x
-#	default n
-#	select 440SP
-#	help
-#	  This option enables support for the IBM PPC440SP evaluation board.
-
-#config OCOTEA
-#	bool "Ocotea"
-#	depends on 44x
-#	default n
-#	select 440GX
-#	help
-#	  This option enables support for the IBM PPC440GX evaluation board.
-
-endmenu
-
-# 44x specific CPU modules, selected based on the board above.
-config 440EP
-	bool
-	select PPC_FPU
-	select IBM440EP_ERR42
-
-config 440GP
-	bool
-	select IBM_NEW_EMAC_ZMII
-
-config 440GX
-	bool
-
-config 440SP
-	bool
-
-config 440A
-	bool
-	depends on 440GX
-	default y
-
-# 44x errata/workaround config symbols, selected by the CPU models above
-config IBM440EP_ERR42
-	bool
-
 #config XILINX_OCP
 #	bool
 #	depends on XILINX_ML300
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig.cputype
+++ linux-2.6/arch/powerpc/platforms/Kconfig.cputype
@@ -40,6 +40,7 @@ config PPC_8xx
 config 40x
 	bool "AMCC 40x"
 	select PPC_DCR_NATIVE
+	select WANT_DEVICE_TREE
 
 config 44x
 	bool "AMCC 44x"
