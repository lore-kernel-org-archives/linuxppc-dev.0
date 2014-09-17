Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id C146D1A009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 02:37:17 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 05/21] powerpc/8xx: Fix comment about DIRTY update
Message-Id: <20140917163657.C9A151AB034@localhost.localdomain>
Date: Wed, 17 Sep 2014 18:36:57 +0200 (CEST)
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit 2321f33790a6c5b80322d907a92d5739e7521a13, dirty handling is not
handled here anymore. So we fix the comment.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
Changes in v2:
- None

Changes in v3:
- None

 arch/powerpc/kernel/head_8xx.S |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index e59e39e..171c6ef 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -477,12 +477,8 @@ InstructionTLBError:
 	EXC_XFER_LITE(0x1300, handle_page_fault)
 
 /* This is the data TLB error on the MPC8xx.  This could be due to
- * many reasons, including a dirty update to a pte.  We can catch that
- * one here, but anything else is an error.  First, we track down the
- * Linux pte.  If it is valid, write access is allowed, but the
- * page dirty bit is not set, we will set it and reload the TLB.  For
- * any other case, we bail out to a higher level function that can
- * handle it.
+ * many reasons, including a dirty update to a pte.  We bail out to
+ * a higher level function that can handle it.
  */
 	. = 0x1400
 DataTLBError:
-- 
1.7.1
