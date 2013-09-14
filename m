Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 153F22C0158
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Sep 2013 13:50:34 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 1/3] powerpc/booke64: add sync after writing PTE
Date: Fri, 13 Sep 2013 22:50:20 -0500
Message-ID: <1379130622-17436-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ISA says that a sync is needed to order a PTE write with a
subsequent hardware tablewalk lookup.  On e6500, without this sync
we've been observed to die with a DSI due to a PTE write not being seen
by a subsequent access, even when everything happens on the same
CPU.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: new patch

Note that we saw this problem when running in emulation (died early in
boot), but when I tried just now with the mb() removed on actual
hardware, I didn't see any problem.  But since I'm not aware of any
change having been made in the hardware relative to this, and since it
is architecturally required, I'd be more comfortable leaving it in
unlesss something has changed in the kernel recently such that a sync
is happening somewhere else along the code path.
---
 arch/powerpc/include/asm/pgtable.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 7d6eacf..0459077 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -143,6 +143,13 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	 * cases, and 32-bit non-hash with 32-bit PTEs.
 	 */
 	*ptep = pte;
+#ifdef CONFIG_PPC_BOOK3E_64
+	/*
+	 * With hardware tablewalk, a sync is needed to ensure that
+	 * subsequent accesses see the PTE we just wrote.
+	 */
+	mb();
+#endif
 #endif
 }
 
-- 
1.8.1.2
