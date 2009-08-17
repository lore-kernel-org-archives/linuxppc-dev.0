Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C6C57B70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 09:01:34 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B0F73DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 09:01:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
Date: Tue, 18 Aug 2009 09:00:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3 v3] powerpc/32: Always order writes to halves of 64-bit
	PTEs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 32-bit systems with 64-bit PTEs, the PTEs have to be written in two
32-bit halves.  On SMP we write the higher-order half and then the
lower-order half, with a write barrier between the two halves, but on
UP there was no particular ordering of the writes to the two halves.

This extends the ordering that we already do on SMP to the UP case as
well.  The reason is that with the perf_counter subsystem potentially
accessing user memory at interrupt time to get stack traces, we have
to be careful not to create an incorrect but apparently valid PTE even
on UP.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/pgtable.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index eb17da7..2a5da06 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -104,8 +104,8 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	else
 		pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte));
 
-#elif defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT) && defined(CONFIG_SMP)
-	/* Second case is 32-bit with 64-bit PTE in SMP mode. In this case, we
+#elif defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
+	/* Second case is 32-bit with 64-bit PTE.  In this case, we
 	 * can just store as long as we do the two halves in the right order
 	 * with a barrier in between. This is possible because we take care,
 	 * in the hash code, to pre-invalidate if the PTE was already hashed,
@@ -140,7 +140,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #else
 	/* Anything else just stores the PTE normally. That covers all 64-bit
-	 * cases, and 32-bit non-hash with 64-bit PTEs in UP mode
+	 * cases, and 32-bit non-hash with 32-bit PTEs.
 	 */
 	*ptep = pte;
 #endif
-- 
1.6.0.4
