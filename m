Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <3cdc6bd05b505600609a79667f3674168e2e855b.1182493056.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/5] Store the base address in dcr_host_t
Date: Fri, 22 Jun 2007 16:18:07 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In its current form, dcr_map() doesn't remember the base address you passed
it, which means you need to store it somewhere else. Rather than adding the
base to another struct it seems simpler to store it in the dcr_host_t.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/sysdev/dcr.c        |    2 +-
 include/asm-powerpc/dcr-mmio.h   |    6 +++++-
 include/asm-powerpc/dcr-native.h |    6 ++++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/dcr.c b/arch/powerpc/sysdev/dcr.c
index 574b6ef..f3c5646 100644
--- a/arch/powerpc/sysdev/dcr.c
+++ b/arch/powerpc/sysdev/dcr.c
@@ -102,7 +102,7 @@ u64 of_translate_dcr_address(struct device_node *dev,
 dcr_host_t dcr_map(struct device_node *dev, unsigned int dcr_n,
 		   unsigned int dcr_c)
 {
-	dcr_host_t ret = { .token = NULL, .stride = 0 };
+	dcr_host_t ret = { .token = NULL, .stride = 0, .base = dcr_n };
 	u64 addr;
 
 	pr_debug("dcr_map(%s, 0x%x, 0x%x)\n",
diff --git a/include/asm-powerpc/dcr-mmio.h b/include/asm-powerpc/dcr-mmio.h
index 5dbfca8..6b82c3b 100644
--- a/include/asm-powerpc/dcr-mmio.h
+++ b/include/asm-powerpc/dcr-mmio.h
@@ -23,7 +23,11 @@
 
 #include <asm/io.h>
 
-typedef struct { void __iomem *token; unsigned int stride; } dcr_host_t;
+typedef struct {
+	void __iomem *token;
+	unsigned int stride;
+	unsigned int base;
+} dcr_host_t;
 
 #define DCR_MAP_OK(host)	((host).token != NULL)
 
diff --git a/include/asm-powerpc/dcr-native.h b/include/asm-powerpc/dcr-native.h
index 05af081..f41058c 100644
--- a/include/asm-powerpc/dcr-native.h
+++ b/include/asm-powerpc/dcr-native.h
@@ -22,11 +22,13 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
-typedef struct {} dcr_host_t;
+typedef struct {
+	unsigned int base;
+} dcr_host_t;
 
 #define DCR_MAP_OK(host)	(1)
 
-#define dcr_map(dev, dcr_n, dcr_c)	((dcr_host_t){})
+#define dcr_map(dev, dcr_n, dcr_c)	((dcr_host_t){ .base = (dcr_n) })
 #define dcr_unmap(host, dcr_n, dcr_c)	do {} while (0)
 #define dcr_read(host, dcr_n)		mfdcr(dcr_n)
 #define dcr_write(host, dcr_n, value)	mtdcr(dcr_n, value)
-- 
1.5.1.3.g7a33b
