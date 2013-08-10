Return-Path: <ra8135@perf2farm5.am.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 705B72C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 14:49:45 +1000 (EST)
From: James Yang <James.Yang@freescale.com>
To: <benh@kernel.crashing.org>, <scottwood@freescale.com>
Subject: [PATCH] powerpc/ppc64: remove __volatile__ in  get_current()
Date: Fri, 9 Aug 2013 23:49:22 -0500
Message-ID: <1376110162-3462-1-git-send-email-James.Yang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: James Yang <James.Yang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Uses of get_current() that normally get optimized away still result in
a load instruction of the current pointer in 64-bit because the inline
asm uses __volatile__.  This patch removes __volatile__ so that nop-ed
uses of get_current() don't actually result in a load of the pointer.

Signed-off-by: James Yang <James.Yang@freescale.com>
---
 arch/powerpc/include/asm/current.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/current.h b/arch/powerpc/include/asm/current.h
index e2c7f06..bb250c8 100644
--- a/arch/powerpc/include/asm/current.h
+++ b/arch/powerpc/include/asm/current.h
@@ -19,7 +19,7 @@ static inline struct task_struct *get_current(void)
 {
 	struct task_struct *task;
 
-	__asm__ __volatile__("ld %0,%1(13)"
+	__asm__ ("ld %0,%1(13)"
 	: "=r" (task)
 	: "i" (offsetof(struct paca_struct, __current)));
 
-- 
1.7.0.4
