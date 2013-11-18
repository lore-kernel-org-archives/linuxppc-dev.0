Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A546E2C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:20:40 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Nov 2013 19:20:33 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E21083578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:20:31 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAI9KJoh6160754
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:20:19 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAI9KUfW006679
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:20:31 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: booke: Fix build failures
Date: Mon, 18 Nov 2013 14:50:18 +0530
Message-Id: <1384766418-9019-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

arch/powerpc/platforms/wsp/wsp.c: In function ‘wsp_probe_devices’:
arch/powerpc/platforms/wsp/wsp.c:76:3: error: implicit declaration of function ‘of_address_to_resource’ [-Werror=implicit-function-declaration]

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/wsp/chroma.c   | 1 +
 arch/powerpc/platforms/wsp/h8.c       | 1 +
 arch/powerpc/platforms/wsp/ics.c      | 2 ++
 arch/powerpc/platforms/wsp/opb_pic.c  | 2 ++
 arch/powerpc/platforms/wsp/psr2.c     | 1 +
 arch/powerpc/platforms/wsp/scom_wsp.c | 1 +
 arch/powerpc/platforms/wsp/wsp.c      | 1 +
 7 files changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/wsp/chroma.c b/arch/powerpc/platforms/wsp/chroma.c
index 8ef53bc2e70e..aaa46b353715 100644
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
index d18e6cc19df3..a3c87f395750 100644
--- a/arch/powerpc/platforms/wsp/h8.c
+++ b/arch/powerpc/platforms/wsp/h8.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/io.h>
+#include <linux/of_address.h>
 
 #include "wsp.h"
 
diff --git a/arch/powerpc/platforms/wsp/ics.c b/arch/powerpc/platforms/wsp/ics.c
index 2d3b1dd9571d..9cd92e645028 100644
--- a/arch/powerpc/platforms/wsp/ics.c
+++ b/arch/powerpc/platforms/wsp/ics.c
@@ -18,6 +18,8 @@
 #include <linux/smp.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
diff --git a/arch/powerpc/platforms/wsp/opb_pic.c b/arch/powerpc/platforms/wsp/opb_pic.c
index cb565bf93650..3f6729807938 100644
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
index 508ec8282b96..a87b414c766a 100644
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
index 8928507affea..6538b4de34fc 100644
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
index ddb6efe88914..58cd1f00e1ef 100644
--- a/arch/powerpc/platforms/wsp/wsp.c
+++ b/arch/powerpc/platforms/wsp/wsp.c
@@ -13,6 +13,7 @@
 #include <linux/smp.h>
 #include <linux/delay.h>
 #include <linux/time.h>
+#include <linux/of_address.h>
 
 #include <asm/scom.h>
 
-- 
1.8.3.2
