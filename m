Return-Path: <hollisb@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4184DDE04
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 10:24:42 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAANODbM019315
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 16:24:13 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAANOaQt137784
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 16:24:36 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAANO7K0023283
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 16:24:08 -0700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] [v2] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
Message-Id: <a861cad705fe7ebccef3.1226359474@localhost.localdomain>
Date: Mon, 10 Nov 2008 17:24:34 -0600
From: Hollis Blanchard <hollisb@us.ibm.com>
To: dwg@au1.ibm.com, jwboyer@linux.vnet.ibm.com
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current CHIP11 errata truncates the device tree memory node, and subtracts
(hardcoded) 4096 bytes. This breaks kernels with larger PAGE_SIZE, since the
bootmem allocator assumes that total memory is a multiple of PAGE_SIZE.

Instead, use a device tree memory reservation to reserve only the 256 bytes
actually affected by the errata, leaving the total memory size unaltered.

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

---

Using large pages results in a huge performance improvement for KVM, and this
patch is required to make Ilya's large page patch work. David and/or Josh,
please apply.

diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
--- a/arch/powerpc/boot/4xx.c
+++ b/arch/powerpc/boot/4xx.c
@@ -21,7 +21,7 @@
 #include "reg.h"
 #include "dcr.h"
 
-static unsigned long chip_11_errata(unsigned long memsize)
+static void chip_11_errata(unsigned long memsize)
 {
 	unsigned long pvr;
 
@@ -31,13 +31,11 @@ static unsigned long chip_11_errata(unsi
 		case 0x40000850:
 		case 0x400008d0:
 		case 0x200008d0:
-			memsize -= 4096;
+			fdt_add_mem_rsv(fdt, memsize - 256, 256);
 			break;
 		default:
 			break;
 	}
-
-	return memsize;
 }
 
 /* Read the 4xx SDRAM controller to get size of system memory. */
@@ -53,7 +51,7 @@ void ibm4xx_sdram_fixup_memsize(void)
 			memsize += SDRAM_CONFIG_BANK_SIZE(bank_config);
 	}
 
-	memsize = chip_11_errata(memsize);
+	chip_11_errata(memsize);
 	dt_fixup_memory(0, memsize);
 }
 
@@ -219,7 +217,7 @@ void ibm4xx_denali_fixup_memsize(void)
 		bank = 4; /* 4 banks */
 
 	memsize = cs * (1 << (col+row)) * bank * dpath;
-	memsize = chip_11_errata(memsize);
+	chip_11_errata(memsize);
 	dt_fixup_memory(0, memsize);
 }
 
diff --git a/arch/powerpc/boot/libfdt-wrapper.c b/arch/powerpc/boot/libfdt-wrapper.c
--- a/arch/powerpc/boot/libfdt-wrapper.c
+++ b/arch/powerpc/boot/libfdt-wrapper.c
@@ -51,7 +51,7 @@
 #define devp_offset_find(devp)	(((int)(devp))-1)
 #define devp_offset(devp)	(devp ? ((int)(devp))-1 : 0)
 
-static void *fdt;
+void *fdt;
 static void *buf; /* = NULL */
 
 #define EXPAND_GRANULARITY	1024
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -14,6 +14,7 @@
 #include <stddef.h>
 #include "types.h"
 #include "string.h"
+#include "libfdt_env.h"
 
 #define	COMMAND_LINE_SIZE	512
 #define	MAX_PATH_LEN		256
@@ -32,6 +33,9 @@ struct platform_ops {
 	void *	(*vmlinux_alloc)(unsigned long size);
 };
 extern struct platform_ops platform_ops;
+
+/* The device tree itself. Should almost always be accessed via dt_ops. */
+extern void *fdt;
 
 /* Device Tree operations */
 struct dt_ops {
@@ -98,6 +102,8 @@ void dt_get_reg_format(void *node, u32 *
 void dt_get_reg_format(void *node, u32 *naddr, u32 *nsize);
 int dt_get_virtual_reg(void *node, void **addr, int nres);
 
+int fdt_add_mem_rsv(void *fdt, uint64_t address, uint64_t size);
+
 static inline void *finddevice(const char *name)
 {
 	return (dt_ops.finddevice) ? dt_ops.finddevice(name) : NULL;
