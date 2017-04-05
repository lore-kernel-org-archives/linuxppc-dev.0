Return-Path: <srs0=xpzz=3n=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vydTB1t3dzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 17:56:30 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vydTB0tMBz8t15
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 17:56:30 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vydT84rBXz9s84
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2017 17:56:28 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 05/10] powerpc/kvm: Massage order of #include
Date: Wed,  5 Apr 2017 17:54:51 +1000
Message-Id: <20170405075456.13561-5-benh@kernel.crashing.org>
In-Reply-To: <20170405075456.13561-1-benh@kernel.crashing.org>
References: <20170405075456.13561-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We traditionally have linux/ before asm/

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kvm/book3s.c    |  8 ++++----
 arch/powerpc/kvm/book3s_hv.c | 18 +++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index b6b5c18..aedacef 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -20,6 +20,10 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/miscdevice.h>
+#include <linux/gfp.h>
+#include <linux/sched.h>
+#include <linux/vmalloc.h>
+#include <linux/highmem.h>
 
 #include <asm/reg.h>
 #include <asm/cputable.h>
@@ -31,10 +35,6 @@
 #include <asm/kvm_book3s.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
-#include <linux/gfp.h>
-#include <linux/sched.h>
-#include <linux/vmalloc.h>
-#include <linux/highmem.h>
 
 #include "book3s.h"
 #include "trace.h"
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 1ec86d9..fadb75a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -35,6 +35,15 @@
 #include <linux/srcu.h>
 #include <linux/miscdevice.h>
 #include <linux/debugfs.h>
+#include <linux/gfp.h>
+#include <linux/vmalloc.h>
+#include <linux/highmem.h>
+#include <linux/hugetlb.h>
+#include <linux/kvm_irqfd.h>
+#include <linux/irqbypass.h>
+#include <linux/module.h>
+#include <linux/compiler.h>
+#include <linux/of.h>
 
 #include <asm/reg.h>
 #include <asm/cputable.h>
@@ -58,15 +67,6 @@
 #include <asm/mmu.h>
 #include <asm/opal.h>
 #include <asm/xics.h>
-#include <linux/gfp.h>
-#include <linux/vmalloc.h>
-#include <linux/highmem.h>
-#include <linux/hugetlb.h>
-#include <linux/kvm_irqfd.h>
-#include <linux/irqbypass.h>
-#include <linux/module.h>
-#include <linux/compiler.h>
-#include <linux/of.h>
 
 #include "book3s.h"
 
-- 
2.9.3
