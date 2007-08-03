Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EBEFADDE2E
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 02:33:13 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l73GXApq004875
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 12:33:10 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l73GX9UA263090
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 10:33:09 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l73GX98W026280
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 10:33:09 -0600
Message-Id: <20070803161710.335369000@linux.vnet.ibm.com>>
References: <20070803160900.069522000@linux.vnet.ibm.com>>
Date: Fri, 03 Aug 2007 11:09:02 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [patch 02/10] 4xx Kconfig cleanup
In-Reply-To: <20070803160900.069522000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
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
 arch/powerpc/platforms/40x/Kconfig     |   77 ---------------------------------
 arch/powerpc/platforms/Kconfig.cputype |    1 
 2 files changed, 1 insertion(+), 77 deletions(-)

--- linux-2.6.orig/arch/powerpc/platforms/40x/Kconfig
+++ linux-2.6/arch/powerpc/platforms/40x/Kconfig
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

-- 
