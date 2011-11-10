Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id D39E9100946
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 11:09:09 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 14/17] powerpc/e500: Don't make kgdb use e500v1/e500v2
 registers on e500mc
Date: Wed,  9 Nov 2011 19:07:12 -0500
Message-Id: <1320883635-17194-15-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <4E42AB6F.1050900@freescale.com>
References: <4E42AB6F.1050900@freescale.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Timur Tabi <B04825@freescale.com>,
 linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only systems which need the sparse PowerPC register map are the
e500v1/e500v2.

NOTE: The kgdb code does not otherwise use CONFIG_E500, so this support
is probably still buggy on e500v1/e500v2, but I don't know kgdb enough
to fix it.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/include/asm/kgdb.h |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/kgdb.h b/arch/powerpc/include/asm/kgdb.h
index 9db24e7..4dea066 100644
--- a/arch/powerpc/include/asm/kgdb.h
+++ b/arch/powerpc/include/asm/kgdb.h
@@ -46,14 +46,17 @@ static inline void arch_kgdb_breakpoint(void)
 #define NUMREGBYTES		((68 * 8) + (3 * 4))
 #define NUMCRITREGBYTES		184
 #else /* CONFIG_PPC32 */
-/* On non-E500 family PPC32 we determine the size by picking the last
- * register we need, but on E500 we skip sections so we list what we
- * need to store, and add it up. */
-#ifndef CONFIG_E500
-#define MAXREG			(PT_FPSCR+1)
-#else
+/*
+ * On FreeScale e500v1 or e500v2 processors we need to skip some register
+ * sections, so just add up a list of what we need to store.
+ *
+ * On all other 32-bit PowerPC we can just pick the last needed register.
+ */
+#ifdef CONFIG_FSL_E500_V1_V2
 /* 32 GPRs (8 bytes), nip, msr, ccr, link, ctr, xer, acc (8 bytes), spefscr*/
-#define MAXREG                 ((32*2)+6+2+1)
+#define MAXREG			((32*2)+6+2+1)
+#else
+#define MAXREG			(PT_FPSCR+1)
 #endif
 #define NUMREGBYTES		(MAXREG * sizeof(int))
 /* CR/LR, R1, R2, R13-R31 inclusive. */
-- 
1.7.2.5
