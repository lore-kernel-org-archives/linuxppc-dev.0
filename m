Return-Path: <haren@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3BAE52C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2012 21:40:45 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sun, 9 Sep 2012 05:40:42 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 6B4443E4003D
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2012 05:40:38 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q89Becve206970
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Sep 2012 05:40:38 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q89BecYC024703
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Sep 2012 05:40:38 -0600
Subject: [PATCH 3/6] powerpc: Add ppr in thread_info struct
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 mikey@neuling.org
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 09 Sep 2012 04:40:36 -0700
Message-ID: <1347190836.3418.15.camel@hbabu-laptop>
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


ppr in thread_info is used to save PPR and restore it before process exits
from kernel.

This patch sets the default priority to 3 when tasks are created such
that users can use 4 for higher priority tasks.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 arch/powerpc/include/asm/thread_info.h |   11 +++++++++++
 arch/powerpc/kernel/asm-offsets.c      |    1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index faf9352..ea53542 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -46,10 +46,20 @@ struct thread_info {
 	struct restart_block restart_block;
 	unsigned long	local_flags;		/* private flags for thread */
 
+	unsigned long	ppr;			/* SMT Thread status register */
 	/* low level flags - has atomic operations done on it */
 	unsigned long	flags ____cacheline_aligned_in_smp;
 };
 
+#ifdef CONFIG_PPC64
+/* Default SMT priority to (11- 13bits). */
+/* .ppr is Used to save/restore only on P7 or later */
+#define INIT_PPR \
+	.ppr =  (3ull << 50),
+#else
+#define INIT_PPR
+#endif
+
 /*
  * macros/functions for gaining access to the thread information structure
  */
@@ -62,6 +72,7 @@ struct thread_info {
 	.restart_block = {			\
 		.fn = do_no_restart_syscall,	\
 	},					\
+	INIT_PPR				\
 	.flags =	0,			\
 }
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index e899572..1c2c066 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -128,6 +128,7 @@ int main(void)
 	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
 
 #ifdef CONFIG_PPC64
+	DEFINE(TI_PPR,  offsetof(struct thread_info, ppr));
 	DEFINE(DCACHEL1LINESIZE, offsetof(struct ppc64_caches, dline_size));
 	DEFINE(DCACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_dline_size));
 	DEFINE(DCACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, dlines_per_page));
-- 
1.7.10.4
