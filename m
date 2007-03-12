Return-Path: <will_schmidt@vnet.ibm.com>
Received: from news.rchland.ibm.com (rchp4.rochester.ibm.com [129.42.161.36])
	by ozlabs.org (Postfix) with ESMTP id E8D5ADDD07
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 06:41:00 +1100 (EST)
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: [PATCH 1/2] [powerpc] export symbols for use by lparcfg
Date: Mon, 12 Mar 2007 13:21:14 -0600
To: linuxppc-dev@ozlabs.org
Message-Id: <20070312192114.16630.90671.stgit@joxer.rchland.ibm.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Cc: sfr@canb.auug.org.au, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Updates the Kconfig to allow lparcfg to be built as a module, and
add the necessary EXPORT_SYMBOLS needed for a successful build.

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
---

 arch/powerpc/kernel/paca.c             |    1 +
 arch/powerpc/kernel/process.c          |    1 +
 arch/powerpc/kernel/vdso.c             |    1 +
 arch/powerpc/platforms/pseries/Kconfig |    2 +-
 4 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 55f1a25..0b2c875 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -45,6 +45,7 @@ struct lppaca lppaca[] = {
 		.vmxregs_in_use = 0,
 	},
 };
+EXPORT_SYMBOL_GPL(lppaca);
 
 /*
  * 3 persistent SLBs are registered here.  The buffer will be zero
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index f3d4dd5..19b209b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -233,6 +233,7 @@ #endif
 
 #ifdef CONFIG_PPC64
 DEFINE_PER_CPU(struct cpu_usage, cpu_usage_array);
+EXPORT_PER_CPU_SYMBOL_GPL(cpu_usage_array);
 static DEFINE_PER_CPU(unsigned long, current_dabr);
 #endif
 
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index e46c31b..ea2e015 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -76,6 +76,7 @@ static union {
 	u8			page[PAGE_SIZE];
 } vdso_data_store __attribute__((__section__(".data.page_aligned")));
 struct vdso_data *vdso_data = &vdso_data_store.data;
+EXPORT_SYMBOL_GPL(vdso_data);
 
 /* Format of the patch table */
 struct vdso_patch_def
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index a57032c..4e5c8f8 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -19,7 +19,7 @@ config SCANLOG
 	depends on RTAS_PROC && PPC_PSERIES
 
 config LPARCFG
-	bool "LPAR Configuration Data"
+	tristate "LPAR Configuration Data"
 	depends on PPC_PSERIES || PPC_ISERIES
 	help
 	Provide system capacity information via human readable
