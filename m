Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59A251A041B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 22:20:05 +1100 (AEDT)
Received: by mail-pd0-f169.google.com with SMTP id w10so3111247pde.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 04:20:02 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: move ppc_init() to common place
Date: Thu, 16 Oct 2014 19:18:40 +0800
Message-Id: <1413458321-23880-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1413458321-23880-1-git-send-email-haokexin@gmail.com>
References: <1413458321-23880-1-git-send-email-haokexin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>,
 Mike Turquette <mturquette@linaro.org>,
 Jingchang Lu <jingchang.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So they can be used by ppc64 board. Also remove the unneeded {} to
make checkpatch happy.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/machdep.h |  2 +-
 arch/powerpc/kernel/setup-common.c | 15 +++++++++++++++
 arch/powerpc/kernel/setup_32.c     | 15 ---------------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 307347f8ddbd..4b913d53333b 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -213,11 +213,11 @@ struct machdep_calls {
 	int		(*set_dawr)(unsigned long dawr,
 				    unsigned long dawrx);
 
-#ifdef CONFIG_PPC32	/* XXX for now */
 	/* A general init function, called by ppc_init in init/main.c.
 	   May be NULL. */
 	void		(*init)(void);
 
+#ifdef CONFIG_PPC32	/* XXX for now */
 	void		(*kgdb_map_scc)(void);
 
 	/*
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 1362cd62b3fa..f76d4a1dbe73 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -750,3 +750,18 @@ void arch_setup_pdev_archdata(struct platform_device *pdev)
 	pdev->dev.dma_mask = &pdev->archdata.dma_mask;
  	set_dma_ops(&pdev->dev, &dma_direct_ops);
 }
+
+int __init ppc_init(void)
+{
+	/* clear the progress line */
+	if (ppc_md.progress)
+		ppc_md.progress("             ", 0xffff);
+
+	/* call platform init */
+	if (ppc_md.init != NULL)
+		ppc_md.init();
+
+	return 0;
+}
+
+arch_initcall(ppc_init);
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 07831ed0d9ef..59d8c6e15782 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -208,21 +208,6 @@ EXPORT_SYMBOL(nvram_sync);
 
 #endif /* CONFIG_NVRAM */
 
-int __init ppc_init(void)
-{
-	/* clear the progress line */
-	if (ppc_md.progress)
-		ppc_md.progress("             ", 0xffff);
-
-	/* call platform init */
-	if (ppc_md.init != NULL) {
-		ppc_md.init();
-	}
-	return 0;
-}
-
-arch_initcall(ppc_init);
-
 static void __init irqstack_early_init(void)
 {
 	unsigned int i;
-- 
1.9.3
