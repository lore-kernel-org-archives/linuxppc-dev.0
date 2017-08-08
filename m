Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRPrq1dhHzDqp9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 16:39:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 9/9] powerpc/traps: Use SRR1 defines for program check reasons
Date: Tue,  8 Aug 2017 16:39:25 +1000
Message-Id: <1502174365-8293-9-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1502174365-8293-1-git-send-email-mpe@ellerman.id.au>
References: <1502174365-8293-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we open code the reason codes for program checks. Instead use
the existing SRR1 defines.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/reg.h |  1 +
 arch/powerpc/kernel/traps.c    | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 73be2f71dbbb..c0600e9e0ff5 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -724,6 +724,7 @@
 					  * may not be recoverable */
 #define	  SRR1_WS_DEEPER	0x00020000 /* Some resources not maintained */
 #define	  SRR1_WS_DEEP		0x00010000 /* All resources maintained */
+#define   SRR1_PROGTM		0x00200000 /* TM Bad Thing */
 #define   SRR1_PROGFPE		0x00100000 /* Floating Point Enabled */
 #define   SRR1_PROGILL		0x00080000 /* Illegal instruction */
 #define   SRR1_PROGPRIV		0x00040000 /* Privileged instruction */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 4d584f08c8ea..9107f7f86058 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -377,11 +377,11 @@ static inline int check_io_access(struct pt_regs *regs)
 /* On non-4xx, the reason for the machine check or program
    exception is in the MSR. */
 #define get_reason(regs)	((regs)->msr)
-#define REASON_TM		0x200000
-#define REASON_FP		0x100000
-#define REASON_ILLEGAL		0x80000
-#define REASON_PRIVILEGED	0x40000
-#define REASON_TRAP		0x20000
+#define REASON_TM		SRR1_PROGTM
+#define REASON_FP		SRR1_PROGFPE
+#define REASON_ILLEGAL		SRR1_PROGILL
+#define REASON_PRIVILEGED	SRR1_PROGPRIV
+#define REASON_TRAP		SRR1_PROGTRAP
 
 #define single_stepping(regs)	((regs)->msr & MSR_SE)
 #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
-- 
2.7.4
