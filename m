Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id DD7F168501
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 00:31:35 +1100 (EST)
Message-Id: <20061102125628.027744000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
Date: Thu, 02 Nov 2006 13:56:05 +0100
From: s.hauer@pengutronix.de
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 10/16] powerpc: make hash_native_64.o a 64bit-only object
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make hash_native_64.o dependent on 64bit, not on MULTIPLATFORM

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: arch/powerpc/mm/Makefile
===================================================================
--- a/arch/powerpc/mm/Makefile.orig
+++ b/arch/powerpc/mm/Makefile
@@ -8,7 +8,7 @@ endif
 
 obj-y				:= fault.o mem.o lmb.o
 obj-$(CONFIG_PPC32)		+= init_32.o pgtable_32.o mmu_context_32.o
-hash-$(CONFIG_PPC_MULTIPLATFORM) := hash_native_64.o
+hash-$(CONFIG_PPC64)		:= hash_native_64.o
 obj-$(CONFIG_PPC64)		+= init_64.o pgtable_64.o mmu_context_64.o \
 				   hash_utils_64.o hash_low_64.o tlb_64.o \
 				   slb_low.o slb.o stab.o mmap.o imalloc.o \

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
