Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 022A8B7864
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 10:10:45 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p19MjQ8x017370
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 17:45:29 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0CFEB7281A0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 18:09:34 -0500 (EST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p19N8HTs149838
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 18:08:17 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p19N8Gds022990
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 16:08:17 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 5/6] powerpc/44x: boot wrapper: allow kernel to load into
	non-zero address
Date: Wed,  9 Feb 2011 17:08:12 -0600
Message-Id: <1297292893-30241-6-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1297292893-30241-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1297292893-30241-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For AMP, different kernel instances load into separate memory regions.
Read the start of memory from the device tree and limit the memory to what's
specified in the device tree.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/boot/treeboot-iss4xx.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/treeboot-iss4xx.c b/arch/powerpc/boot/treeboot-iss4xx.c
index fcc4495..674e3bd 100644
--- a/arch/powerpc/boot/treeboot-iss4xx.c
+++ b/arch/powerpc/boot/treeboot-iss4xx.c
@@ -34,9 +34,28 @@
 
 BSS_STACK(4096);
 
+static u32 ibm4xx_memstart;
+
 static void iss_4xx_fixups(void)
 {
-	ibm4xx_sdram_fixup_memsize();
+	void *memory;
+	u32 reg[3];
+
+	memory = finddevice("/memory");
+	if (!memory)
+		fatal("Can't find memory node\n");
+	getprop(memory, "reg", reg, sizeof(reg));
+	if (reg[2])
+		/* If the device tree specifies the memory range, use it */
+		ibm4xx_memstart = reg[1];
+	else
+		/* othersize, read it from the SDRAM controller */
+		ibm4xx_sdram_fixup_memsize();
+}
+
+static void *iss_4xx_vmlinux_alloc(unsigned long size)
+{
+	return (void *)ibm4xx_memstart;
 }
 
 #define SPRN_PIR	0x11E	/* Processor Indentification Register */
@@ -48,6 +67,7 @@ void platform_init(void)
 
 	simple_alloc_init(_end, avail_ram, 128, 64);
 	platform_ops.fixups = iss_4xx_fixups;
+	platform_ops.vmlinux_alloc = iss_4xx_vmlinux_alloc;
 	platform_ops.exit = ibm44x_dbcr_reset;
 	pir_reg = mfspr(SPRN_PIR);
 	fdt_set_boot_cpuid_phys(_dtb_start, pir_reg);
-- 
1.7.3.4
