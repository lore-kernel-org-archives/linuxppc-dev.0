Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 26140DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 11:42:33 +1000 (EST)
Date: Tue, 29 Apr 2008 11:42:32 +1000
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] Allow builing of pmac32 when CONFIG_NVRAM=m
Message-ID: <20080429014232.GC20457@bakeyournoodle.com>
References: <alpine.DEB.1.10.0804271951190.11017@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.DEB.1.10.0804271951190.11017@sheep.housecafe.de>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kamalesh Babulal (kamalesh@linux.vnet.ibm.com) reports that CONFIG_NVRAM=m
is valid in terms of Kconfig but fails to build with:
  Building modules, stage 2.
  MODPOST 1401 modules
ERROR: "pmac_newworld" [arch/powerpc/platforms/powermac/nvram.ko] undefined!
ERROR: "__alloc_bootmem" [arch/powerpc/platforms/powermac/nvram.ko] undefined!
make[1]: *** [__modpost] Error

The arch/powerpc/platforms/powermac/nvram.c code really needs to be builtin,
but as it's compilation is dependant on a generic Kconfig symbol we
force nvram.c to be builtin if CONFIG_NVRAM is 'y' or 'm'

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/platforms/powermac/Makefile |    5 ++++-
 arch/powerpc/platforms/powermac/setup.c  |    3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/Makefile b/arch/powerpc/platforms/powermac/Makefile
index 78093d7..4d72c8f 100644
--- a/arch/powerpc/platforms/powermac/Makefile
+++ b/arch/powerpc/platforms/powermac/Makefile
@@ -6,7 +6,10 @@ obj-y				+= pic.o setup.o time.o feature.o pci.o \
 obj-$(CONFIG_PMAC_BACKLIGHT)	+= backlight.o
 obj-$(CONFIG_CPU_FREQ_PMAC)	+= cpufreq_32.o
 obj-$(CONFIG_CPU_FREQ_PMAC64)	+= cpufreq_64.o
-obj-$(CONFIG_NVRAM)		+= nvram.o
+# CONFIG_NVRAM is an arch. independant tristate symbol, for pmac32 we really
+# need this to be a bool.  Cheat here and pretend CONFIG_NVRAM=m is really
+# CONFIG_NVRAM=y
+obj-$(CONFIG_NVRAM:m=y)		+= nvram.o
 # ppc64 pmac doesn't define CONFIG_NVRAM but needs nvram stuff
 obj-$(CONFIG_PPC64)		+= nvram.o
 obj-$(CONFIG_PPC32)		+= bootx_init.o
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index bf44c54..00bd016 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -337,7 +337,8 @@ static void __init pmac_setup_arch(void)
 	find_via_pmu();
 	smu_init();
 
-#if defined(CONFIG_NVRAM) || defined(CONFIG_PPC64)
+#if defined(CONFIG_NVRAM) || defined(CONFIG_NVRAM_MODULE) || \
+    defined(CONFIG_PPC64)
 	pmac_nvram_init();
 #endif
 
-- 
1.5.5.1

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
