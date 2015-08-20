Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x235.google.com (mail-yk0-x235.google.com
 [IPv6:2607:f8b0:4002:c07::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67ADD1A1D61
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 22:15:08 +1000 (AEST)
Received: by ykdt205 with SMTP id t205so35183920ykd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 05:15:06 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/8] powerpc: invoke jump_label_init() in a much earlier stage
Date: Thu, 20 Aug 2015 20:14:32 +0800
Message-Id: <1440072876-8321-5-git-send-email-haokexin@gmail.com>
In-Reply-To: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
References: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So we can use static_key for cpu_has_feature() and mmu_has_feature().

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/setup_32.c | 2 ++
 arch/powerpc/kernel/setup_64.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index bb02e9f6944e..35980a2785ba 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -113,6 +113,8 @@ notrace void __init machine_init(u64 dt_ptr)
 {
 	lockdep_init();
 
+	jump_label_init();
+
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index bdcbb716f4d6..f0802a0b4a20 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -250,6 +250,8 @@ void __init early_setup(unsigned long dt_ptr)
 	/* Initialize lockdep early or else spinlocks will blow */
 	lockdep_init();
 
+	jump_label_init();
+
 	/* -------- printk is now safe to use ------- */
 
 	/* Enable early debugging if any specified (see udbg.h) */
-- 
2.1.0
