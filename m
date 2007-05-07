Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 May 2007 12:13:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: ppc: Fix build problem in ppc4xx_sgdma.c
Message-ID: <20070507021336.GJ16165@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ppc4xx_sgdma.c is #including asm/dma-mapping.h directly, which should
only ever be included via linux/dma-mapping.h.  asm/dma-mapping.h
relies on an enum defined in linux/dma-mapping.h before its own
include.  This fixes the problem.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/ppc/syslib/ppc4xx_sgdma.c
===================================================================
--- working-2.6.orig/arch/ppc/syslib/ppc4xx_sgdma.c	2007-05-07 12:04:40.000000000 +1000
+++ working-2.6/arch/ppc/syslib/ppc4xx_sgdma.c	2007-05-07 12:04:47.000000000 +1000
@@ -23,10 +23,10 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
-#include <asm/dma-mapping.h>
 #include <asm/ppc4xx_dma.h>
 
 void

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
