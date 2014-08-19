Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB7C01A015A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:00:08 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 2/6] powerpc: Move via-cuda symbol exports next to function
 definitions
Date: Wed, 20 Aug 2014 08:00:01 +1000
Message-Id: <1408485605-10490-2-git-send-email-anton@samba.org>
In-Reply-To: <1408485605-10490-1-git-send-email-anton@samba.org>
References: <1408485605-10490-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/ppc_ksyms.c | 4 ----
 drivers/macintosh/via-cuda.c    | 2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 351f447..521291d 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -128,10 +128,6 @@ EXPORT_SYMBOL(smp_hw_index);
 #endif
 #endif
 
-#ifdef CONFIG_ADB_CUDA
-EXPORT_SYMBOL(cuda_request);
-EXPORT_SYMBOL(cuda_poll);
-#endif /* CONFIG_ADB_CUDA */
 EXPORT_SYMBOL(to_tm);
 
 #ifdef CONFIG_PPC32
diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index d61f271..bad1813 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -379,6 +379,7 @@ cuda_request(struct adb_request *req, void (*done)(struct adb_request *),
     req->reply_expected = 1;
     return cuda_write(req);
 }
+EXPORT_SYMBOL(cuda_request);
 
 static int
 cuda_write(struct adb_request *req)
@@ -441,6 +442,7 @@ cuda_poll(void)
     if (cuda_irq)
 	enable_irq(cuda_irq);
 }
+EXPORT_SYMBOL(cuda_poll);
 
 static irqreturn_t
 cuda_interrupt(int irq, void *arg)
-- 
1.9.1
