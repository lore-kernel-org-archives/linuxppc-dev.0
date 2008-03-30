Return-Path: <bunk@kernel.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by ozlabs.org (Postfix) with ESMTP id EA321DDEE2
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 08:40:26 +1000 (EST)
Date: Mon, 31 Mar 2008 01:40:12 +0300
From: Adrian Bunk <bunk@kernel.org>
To: paulus@samba.org
Subject: [2.6 patch] powerpc: remove the non-functional PPC_PREP bits
Message-ID: <20080330224012.GD28445@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Back in November 2005, the PPC_PREP bits under arch/powerpc/ were marked 
as BROKEN due to not being working.

It doesn't seem to make much sense to keep this rudimentary support even 
longer.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/powerpc/Kconfig                |    5 +---
 arch/powerpc/kernel/setup-common.c  |    6 -----
 arch/powerpc/platforms/Kconfig      |    3 --
 arch/powerpc/platforms/prep/Kconfig |   31 ----------------------------
 include/asm-powerpc/processor.h     |    7 ------
 5 files changed, 3 insertions(+), 49 deletions(-)

75e5883ddd71921318afb01dd7d2402528f3b8e5 diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1189d8d..380b7a0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -309,7 +309,6 @@ config CRASH_DUMP
 
 config PPCBUG_NVRAM
 	bool "Enable reading PPCBUG NVRAM during boot" if PPLUS || LOPEC
-	default y if PPC_PREP
 
 config IRQ_ALL_CPUS
 	bool "Distribute interrupts on all CPUs by default"
@@ -453,7 +452,7 @@ menu "Bus options"
 
 config ISA
 	bool "Support for ISA-bus hardware"
-	depends on PPC_PREP || PPC_CHRP
+	depends on PPC_CHRP
 	select PPC_I8259
 	help
 	  Find out whether you have ISA slots on your motherboard.  ISA is the
@@ -635,7 +634,7 @@ config TASK_SIZE_BOOL
 
 config TASK_SIZE
 	hex "Size of user task space" if TASK_SIZE_BOOL
-	default "0x80000000" if PPC_PREP || PPC_8xx
+	default "0x80000000" if PPC_8xx
 	default "0xc0000000"
 
 config CONSISTENT_START_BOOL
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 6adb5a1..fc32f53 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -570,12 +570,6 @@ int check_legacy_ioport(unsigned long base_port)
 	case FDC_BASE: /* FDC1 */
 		np = of_find_node_by_type(NULL, "fdc");
 		break;
-#ifdef CONFIG_PPC_PREP
-	case _PIDXR:
-	case _PNPWRP:
-	case PNPBIOS_BASE:
-		/* implement me */
-#endif
 	default:
 		/* ipmi is supposed to fail here */
 		break;
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index a578b96..3a2954d 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -42,7 +42,6 @@ source "arch/powerpc/platforms/chrp/Kconfig"
 source "arch/powerpc/platforms/512x/Kconfig"
 source "arch/powerpc/platforms/52xx/Kconfig"
 source "arch/powerpc/platforms/powermac/Kconfig"
-source "arch/powerpc/platforms/prep/Kconfig"
 source "arch/powerpc/platforms/maple/Kconfig"
 source "arch/powerpc/platforms/pasemi/Kconfig"
 source "arch/powerpc/platforms/celleb/Kconfig"
@@ -210,7 +209,7 @@ endmenu
 
 config PPC601_SYNC_FIX
 	bool "Workarounds for PPC601 bugs"
-	depends on 6xx && (PPC_PREP || PPC_PMAC)
+	depends on 6xx && PPC_PMAC
 	help
 	  Some versions of the PPC601 (the first PowerPC chip) have bugs which
 	  mean that extra synchronization instructions are required near
diff --git a/arch/powerpc/platforms/prep/Kconfig b/arch/powerpc/platforms/prep/Kconfig
deleted file mode 100644
index 29d4112..0000000
--- a/arch/powerpc/platforms/prep/Kconfig
+++ /dev/null
@@ -1,31 +0,0 @@
-config PPC_PREP
-	bool "PowerPC Reference Platform (PReP) based machines"
-	depends on PPC_MULTIPLATFORM && PPC32 && BROKEN
-	select MPIC
-	select PPC_I8259
-	select PPC_INDIRECT_PCI
-	select PPC_UDBG_16550
-	select PPC_NATIVE
-	default n
-
-config PREP_RESIDUAL
-	bool "Support for PReP Residual Data"
-	depends on PPC_PREP
-	help
-	  Some PReP systems have residual data passed to the kernel by the
-	  firmware.  This allows detection of memory size, devices present and
-	  other useful pieces of information.  Sometimes this information is
-	  not present or incorrect, in which case it could lead to the machine 
-	  behaving incorrectly.  If this happens, either disable PREP_RESIDUAL
-	  or pass the 'noresidual' option to the kernel.
-
-	  If you are running a PReP system, say Y here, otherwise say N.
-
-config PROC_PREPRESIDUAL
-	bool "Support for reading of PReP Residual Data in /proc"
-	depends on PREP_RESIDUAL && PROC_FS
-	help
-	  Enabling this option will create a /proc/residual file which allows
-	  you to get at the residual data on PReP systems.  You will need a tool
-	  (lsresidual) to parse it.  If you aren't on a PReP system, you don't
-	  want this.
diff --git a/include/asm-powerpc/processor.h b/include/asm-powerpc/processor.h
index fd98ca9..077bcbd 100644
--- a/include/asm-powerpc/processor.h
+++ b/include/asm-powerpc/processor.h
@@ -38,13 +38,6 @@
 
 extern int _chrp_type;
 
-#ifdef CONFIG_PPC_PREP
-
-/* what kind of prep workstation we are */
-extern int _prep_type;
-
-#endif /* CONFIG_PPC_PREP */
-
 #endif /* defined(__KERNEL__) && defined(CONFIG_PPC32) */
 
 /*
