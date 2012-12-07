Return-Path: <haren@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EC2F22C00B4
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2012 18:50:02 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Fri, 7 Dec 2012 02:50:00 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 57E0D6E8036
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2012 02:49:58 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qB77nww2304526
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2012 02:49:58 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qB77nwpB024069
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2012 05:49:58 -0200
Subject: [PATCH 4/6] powerpc: Define ppr in thread_struct
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@au1.ibm.com,
 michael.neuling@au1.ibm.com, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 06 Dec 2012 23:49:56 -0800
Message-ID: <1354866596.1281.17.camel@hbabu-laptop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 4/6] powerpc: Define ppr in thread_struct

ppr in thread_struct is used to save PPR and restore it before process exits
from kernel.

This patch sets the default priority to 3 when tasks are created such
that users can use 4 for higher priority tasks.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 arch/powerpc/include/asm/processor.h |   12 ++++++++++++
 arch/powerpc/kernel/asm-offsets.c    |    1 +
 arch/powerpc/kernel/process.c        |    2 ++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 8750204..37f87f0 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -18,6 +18,16 @@
 #define TS_FPRWIDTH 1
 #endif
 
+#ifdef CONFIG_PPC64
+/* Default SMT priority is set to 3. Use 11- 13bits to save priority. */
+#define PPR_PRIORITY 3
+#ifdef __ASSEMBLY__
+#define INIT_PPR (PPR_PRIORITY << 50)
+#else
+#define INIT_PPR ((u64)PPR_PRIORITY << 50)
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PPC64 */
+
 #ifndef __ASSEMBLY__
 #include <linux/compiler.h>
 #include <linux/cache.h>
@@ -245,6 +255,7 @@ struct thread_struct {
 #ifdef CONFIG_PPC64
 	unsigned long	dscr;
 	int		dscr_inherit;
+	unsigned long	ppr;	/* used to save/restore SMT priority */
 #endif
 };
 
@@ -278,6 +289,7 @@ struct thread_struct {
 	.fpr = {{0}}, \
 	.fpscr = { .val = 0, }, \
 	.fpexc_mode = 0, \
+	.ppr = INIT_PPR, \
 }
 #endif
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 7523539..41f65ec 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -77,6 +77,7 @@ int main(void)
 	DEFINE(NMI_MASK, NMI_MASK);
 	DEFINE(THREAD_DSCR, offsetof(struct thread_struct, dscr));
 	DEFINE(THREAD_DSCR_INHERIT, offsetof(struct thread_struct, dscr_inherit));
+	DEFINE(TASKTHREADPPR, offsetof(struct task_struct, thread.ppr));
 #else
 	DEFINE(THREAD_INFO, offsetof(struct task_struct, stack));
 #endif /* CONFIG_PPC64 */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ba48233..2563acc 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -814,6 +814,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 		p->thread.dscr_inherit = current->thread.dscr_inherit;
 		p->thread.dscr = current->thread.dscr;
 	}
+	if (cpu_has_feature(CPU_FTR_HAS_PPR))
+		p->thread.ppr = INIT_PPR;
 #endif
 	/*
 	 * The PPC64 ABI makes use of a TOC to contain function 
-- 
1.7.1
