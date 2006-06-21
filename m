Return-Path: <kelly@au1.ibm.com>
From: Kelly Daly <kelly@au1.ibm.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH] powerpc: disable OProfile for iSeries (take 2!)
Date: Wed, 21 Jun 2006 13:52:55 +1000
References: <200606211151.01386.kelly@au.ibm.com>
	<1150859433.8293.9.camel@localhost.localdomain>
In-Reply-To: <1150859433.8293.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606211352.55446.kelly@au.ibm.com>
Cc: linuxppc64-dev@ozlabs.org, Kelly Daly <kelly@au1.ibm.com>, paulus@samba.org,
	anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch removes the changes from an earlier patch that disables
oProfile for iSeries within the oProfile KConfig (submitted Feb 23,
2006).  Checks within the arch init for iSeries, still allowing profiling
for timer interrupts (using firmware_has_feature).

Signed-off-by: Kelly Daly <kelly@au.ibm.com>

---

diff -urdp linux-2.6.16.20/arch/powerpc/oprofile/Kconfig linux-2.6.16.20_kel/arch/powerpc/oprofile/Kconfig
--- linux-2.6.16.20/arch/powerpc/oprofile/Kconfig	2006-06-06 03:18:23.000000000 +1000
+++ linux-2.6.16.20_kel/arch/powerpc/oprofile/Kconfig	2006-06-20 15:53:02.000000000 +1000
@@ -1,5 +1,4 @@
 config PROFILING
-	depends on !PPC_ISERIES
 	bool "Profiling support (EXPERIMENTAL)"
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
diff -urp linux-2.6.16.20/arch/powerpc/oprofile/common.c linux-2.6.16.20_kel/arch/powerpc/oprofile/common.c
--- linux-2.6.16.20/arch/powerpc/oprofile/common.c	2006-06-06 03:18:23.000000000 +1000
+++ linux-2.6.16.20_kel/arch/powerpc/oprofile/common.c	2006-06-21 13:42:14.000000000 +1000
@@ -22,6 +22,7 @@
 #include <asm/pmc.h>
 #include <asm/cputable.h>
 #include <asm/oprofile_impl.h>
+#include <asm/firmware.h>
 
 static struct op_powerpc_model *model;
 
@@ -138,6 +139,9 @@ int __init oprofile_arch_init(struct opr
 	if (!cur_cpu_spec->oprofile_cpu_type)
 		return -ENODEV;
 
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return -ENODEV;
+
 	switch (cur_cpu_spec->oprofile_type) {
 #ifdef CONFIG_PPC64
 		case PPC_OPROFILE_RS64:
