Return-Path: <jeffmerkey@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5188B1A0201
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 06:47:50 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id x141so2473327oia.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 11:47:50 -0800 (PST)
From: Jeffrey Merkey <jeffmerkey@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linux.mdb@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 29/31] Add debugger entry points for POWERPC
Date: Thu, 28 Jan 2016 12:47:44 -0700
Message-Id: <1454010464-29609-1-git-send-email-jeffmerkey@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series adds an export which can be set by system debuggers to
direct the hard lockup and soft lockup detector to trigger a breakpoint
exception and enter a debugger if one is active.  It is assumed that if
someone sets this variable, then an breakpoint handler of some sort will
be actively loaded or registered via the notify die handler chain.

This addition is extremely useful for debugging hard and soft lockups
real time and quickly from a console debugger.

Signed-off-by: Jeffrey Merkey <jeffmerkey@gmail.com>
---
 arch/powerpc/include/asm/kdebug.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/kdebug.h b/arch/powerpc/include/asm/kdebug.h
index ae6d206..54f5ca8 100644
--- a/arch/powerpc/include/asm/kdebug.h
+++ b/arch/powerpc/include/asm/kdebug.h
@@ -11,5 +11,10 @@ enum die_val {
 	DIE_SSTEP,
 };
 
+static inline void arch_breakpoint(void)
+{
+	asm(".long 0x7d821008"); /* twge r2, r2 */
+}
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_KDEBUG_H */
-- 
1.8.3.1
