Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCRc635HHzDr67
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 21:17:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, benh@kernel.crashing.org, stewart@linux.vnet.ibm.com,
 cyrilbur@gmail.com
Subject: [PATCH 2/4] powerpc: Add PPC_FEATURE2_HTM_NO_SUSPEND
Date: Thu, 12 Oct 2017 21:17:17 +1100
Message-Id: <1507803439-12862-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some CPUs can operate in a mode where TM (Transactional Memory) is
enabled but the suspended state of TM is disabled. In this mode
tsuspend does not enter suspended state, instead the transaction is
aborted. Similarly any other event that would lead to suspended state
instead aborts the transaction.

There is also an ABI change, in that in this mode processes are not
allowed to sigreturn with an MSR that would lead to suspended state,
Linux will instead return an error to the sigreturn syscall.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/uapi/asm/cputable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
index 4d877144f377..b3b64cba71ec 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -48,6 +48,7 @@
 #define PPC_FEATURE2_HAS_IEEE128	0x00400000 /* VSX IEEE Binary Float 128-bit */
 #define PPC_FEATURE2_DARN		0x00200000 /* darn random number insn */
 #define PPC_FEATURE2_SCV		0x00100000 /* scv syscall */
+#define PPC_FEATURE2_HTM_NO_SUSPEND	0x00080000 /* TM w/out suspended state */
 
 /*
  * IMPORTANT!
-- 
2.7.4
