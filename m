Return-Path: <haren@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 660122C0477
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 17:55:22 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Wed, 31 Oct 2012 00:55:19 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 5EFEE3E4003C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 00:55:17 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9V6tHPw226930
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 00:55:17 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9V6tGRO020242
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 00:55:17 -0600
Subject: [PATCH 4/6] powerpc: Define ppr in thread_struct
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@au1.ibm.com,
 mikey@neuling.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Oct 2012 23:55:15 -0700
Message-ID: <1351666515.32304.17.camel@hbabu-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
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
 arch/powerpc/include/asm/processor.h |    6 ++++++
 arch/powerpc/kernel/asm-offsets.c    |    1 +
 arch/powerpc/kernel/process.c        |    2 ++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 8750204..7db5df4 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -245,6 +245,7 @@ struct thread_struct {
 #ifdef CONFIG_PPC64
 	unsigned long	dscr;
 	int		dscr_inherit;
+	unsigned long	ppr;
 #endif
 };
 
@@ -270,6 +271,10 @@ struct thread_struct {
 	SPEFSCR_INIT \
 }
 #else
+/* Default SMT priority is 3. Use 11- 13bits to save priority. */
+/* .ppr is used to save/restore only on P7 or later processors */
+#define INIT_PPR (3ull << 50)
+
 #define INIT_THREAD  { \
 	.ksp = INIT_SP, \
 	.ksp_limit = INIT_SP_LIMIT, \
@@ -278,6 +283,7 @@ struct thread_struct {
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
