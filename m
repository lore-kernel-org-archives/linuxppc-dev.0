Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: powerpc: Fix missing includes needed for chroma
Date: Thu, 21 Nov 2013 15:40:57 +1100
Message-ID: <12118.1385008857@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, Jimi Xenidis <jimix@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

chroma_defconfig is horribly broken currently, so add a bunch of
#includes to fix it.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
So when are we dropping arch/powerpc/platforms/wsp?

diff --git a/arch/powerpc/platforms/wsp/chroma.c b/arch/powerpc/platforms/wsp/chroma.c
index 8ef53bc..aaa46b3 100644
--- a/arch/powerpc/platforms/wsp/chroma.c
+++ b/arch/powerpc/platforms/wsp/chroma.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/smp.h>
 #include <linux/time.h>
+#include <linux/of_fdt.h>
 
 #include <asm/machdep.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/wsp/h8.c b/arch/powerpc/platforms/wsp/h8.c
index d18e6cc..a3c87f3 100644
--- a/arch/powerpc/platforms/wsp/h8.c
+++ b/arch/powerpc/platforms/wsp/h8.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/io.h>
+#include <linux/of_address.h>
 
 #include "wsp.h"
 
diff --git a/arch/powerpc/platforms/wsp/ics.c b/arch/powerpc/platforms/wsp/ics.c
index 2d3b1dd..3b782ce 100644
--- a/arch/powerpc/platforms/wsp/ics.c
+++ b/arch/powerpc/platforms/wsp/ics.c
@@ -18,6 +18,8 @@
 #include <linux/smp.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
diff --git a/arch/powerpc/platforms/wsp/opb_pic.c b/arch/powerpc/platforms/wsp/opb_pic.c
index cb565bf..3f67298 100644
--- a/arch/powerpc/platforms/wsp/opb_pic.c
+++ b/arch/powerpc/platforms/wsp/opb_pic.c
@@ -15,6 +15,8 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <asm/reg_a2.h>
 #include <asm/irq.h>
diff --git a/arch/powerpc/platforms/wsp/psr2.c b/arch/powerpc/platforms/wsp/psr2.c
index 508ec82..a87b414 100644
--- a/arch/powerpc/platforms/wsp/psr2.c
+++ b/arch/powerpc/platforms/wsp/psr2.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/smp.h>
 #include <linux/time.h>
+#include <linux/of_fdt.h>
 
 #include <asm/machdep.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/wsp/scom_wsp.c b/arch/powerpc/platforms/wsp/scom_wsp.c
index 8928507..6538b4d 100644
--- a/arch/powerpc/platforms/wsp/scom_wsp.c
+++ b/arch/powerpc/platforms/wsp/scom_wsp.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
+#include <linux/of_address.h>
 
 #include <asm/cputhreads.h>
 #include <asm/reg_a2.h>
diff --git a/arch/powerpc/platforms/wsp/wsp.c b/arch/powerpc/platforms/wsp/wsp.c
index ddb6efe..58cd1f0 100644
--- a/arch/powerpc/platforms/wsp/wsp.c
+++ b/arch/powerpc/platforms/wsp/wsp.c
@@ -13,6 +13,7 @@
 #include <linux/smp.h>
 #include <linux/delay.h>
 #include <linux/time.h>
+#include <linux/of_address.h>
 
 #include <asm/scom.h>
 
