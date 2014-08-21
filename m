Return-Path: <zhouzhouyi@gmail.com>
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE2501A0273
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 12:41:47 +1000 (EST)
Received: by mail-pd0-f172.google.com with SMTP id y13so13236169pdi.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 19:41:45 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <paulmck@linux.vnet.ibm.com>, <anton@samba.org>,
 <aneesh.kumar@linux.vnet.ibm.com>, <jk@ozlabs.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <jbaron@akamai.com>
Subject: [PATCH 1/1] powerpc/jump_label: use HAVE_JUMP_LABEL?  
Date: Thu, 21 Aug 2014 10:41:23 +0800
Message-Id: <1408588883-26783-1-git-send-email-yizhouzhou@ict.ac.cn>
Cc: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_JUMP_LABEL doesn't ensure HAVE_JUMP_LABEL, if it
is not the case use maintainers's own mutex to guard
the modification of global values.


Signed-off-by: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
---
 arch/powerpc/platforms/powernv/opal-tracepoints.c |    2 +-
 arch/powerpc/platforms/pseries/lpar.c             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-tracepoints.c b/arch/powerpc/platforms/powernv/opal-tracepoints.c
index d8a000a..ae14c40 100644
--- a/arch/powerpc/platforms/powernv/opal-tracepoints.c
+++ b/arch/powerpc/platforms/powernv/opal-tracepoints.c
@@ -2,7 +2,7 @@
 #include <linux/jump_label.h>
 #include <asm/trace.h>
 
-#ifdef CONFIG_JUMP_LABEL
+#ifdef HAVE_JUMP_LABEL
 struct static_key opal_tracepoint_key = STATIC_KEY_INIT;
 
 void opal_tracepoint_regfunc(void)
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 34e6423..059cfe0 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -642,7 +642,7 @@ EXPORT_SYMBOL(arch_free_page);
 #endif
 
 #ifdef CONFIG_TRACEPOINTS
-#ifdef CONFIG_JUMP_LABEL
+#ifdef HAVE_JUMP_LABEL
 struct static_key hcall_tracepoint_key = STATIC_KEY_INIT;
 
 void hcall_tracepoint_regfunc(void)
-- 
1.7.10.4
