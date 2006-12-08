Return-Path: <anton@ozlabs.org>
Date: Fri, 8 Dec 2006 17:51:13 +1100
From: Anton Blanchard <anton@samba.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Add SPURR SPR to sysfs
Message-ID: <20061208065113.GB29167@krispykreme>
References: <20061206205818.GA27857@krispykreme>
	<17784.62591.729512.791358@cargo.ozlabs.ibm.com>
	<20061208054106.GB9391@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061208054106.GB9391@krispykreme>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Now we have a SPURR cpu feature bit, we can export it to userspace in
sysfs.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/sysfs.c	2006-12-08 00:07:35.000000000 -0600
+++ linux-2.6/arch/powerpc/kernel/sysfs.c	2006-12-08 00:08:50.000000000 -0600
@@ -181,6 +181,7 @@
 SYSFS_PMCSETUP(pmc7, SPRN_PMC7);
 SYSFS_PMCSETUP(pmc8, SPRN_PMC8);
 SYSFS_PMCSETUP(purr, SPRN_PURR);
+SYSFS_PMCSETUP(spurr, SPRN_SPURR);
 SYSFS_PMCSETUP(dscr, SPRN_DSCR);
 
 static SYSDEV_ATTR(mmcr0, 0600, show_mmcr0, store_mmcr0);
@@ -195,6 +196,7 @@
 static SYSDEV_ATTR(pmc7, 0600, show_pmc7, store_pmc7);
 static SYSDEV_ATTR(pmc8, 0600, show_pmc8, store_pmc8);
 static SYSDEV_ATTR(purr, 0600, show_purr, NULL);
+static SYSDEV_ATTR(spurr, 0600, show_spurr, NULL);
 static SYSDEV_ATTR(dscr, 0600, show_dscr, store_dscr);
 
 static void register_cpu_online(unsigned int cpu)
@@ -234,6 +236,9 @@
 	if (cpu_has_feature(CPU_FTR_PURR))
 		sysdev_create_file(s, &attr_purr);
 
+	if (cpu_has_feature(CPU_FTR_SPURR))
+		sysdev_create_file(s, &attr_spurr);
+
 	if (cpu_has_feature(CPU_FTR_DSCR))
 		sysdev_create_file(s, &attr_dscr);
 }
@@ -278,6 +283,9 @@
 	if (cpu_has_feature(CPU_FTR_PURR))
 		sysdev_remove_file(s, &attr_purr);
 
+	if (cpu_has_feature(CPU_FTR_SPURR))
+		sysdev_remove_file(s, &attr_spurr);
+
 	if (cpu_has_feature(CPU_FTR_DSCR))
 		sysdev_remove_file(s, &attr_dscr);
 }
Index: linux-2.6/include/asm-powerpc/reg.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/reg.h	2006-12-08 00:34:29.000000000 -0600
+++ linux-2.6/include/asm-powerpc/reg.h	2006-12-08 00:35:35.000000000 -0600
@@ -164,6 +164,7 @@
 #define SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
 #define SPRN_TBWL	0x11C	/* Time Base Lower Register (super, R/W) */
 #define SPRN_TBWU	0x11D	/* Time Base Upper Register (super, R/W) */
+#define SPRN_SPURR	0x134	/* Scaled PURR */
 #define SPRN_HIOR	0x137	/* 970 Hypervisor interrupt offset */
 #define SPRN_DBAT0L	0x219	/* Data BAT 0 Lower Register */
 #define SPRN_DBAT0U	0x218	/* Data BAT 0 Upper Register */
