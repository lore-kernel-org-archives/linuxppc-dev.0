Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1796CB7EB7
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 04:41:17 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: stable@kernel.org
Subject: [PATCH] powerpc: Fix ioremap_flags() with book3e pte definition
Date: Mon, 24 May 2010 13:38:37 -0500
Message-Id: <1274726319-4673-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

We can't just clear the user read permission in book3e pte, because
that will also clear supervisor read permission.  This surely isn't
desired.  Fix the problem by adding the supervisor read back.

BenH: Slightly simplified the ifdef and applied to ppc64 too

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
For 2.6.34 stable commit 55052eeca6d71d76f7c3f156c0501814d8e5e6d3

 arch/powerpc/mm/pgtable_32.c |    8 ++++++++
 arch/powerpc/mm/pgtable_64.c |    8 ++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index b9243e7..767b0cf 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -146,6 +146,14 @@ ioremap_flags(phys_addr_t addr, unsigned long size, unsigned long flags)
 	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
 	flags &= ~(_PAGE_USER | _PAGE_EXEC);
 
+#ifdef _PAGE_BAP_SR
+	/* _PAGE_USER contains _PAGE_BAP_SR on BookE using the new PTE format
+	 * which means that we just cleared supervisor access... oops ;-) This
+	 * restores it
+	 */
+	flags |= _PAGE_BAP_SR;
+#endif
+
 	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_flags);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index d95679a..d050fc8 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -265,6 +265,14 @@ void __iomem * ioremap_flags(phys_addr_t addr, unsigned long size,
 	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
 	flags &= ~(_PAGE_USER | _PAGE_EXEC);
 
+#ifdef _PAGE_BAP_SR
+	/* _PAGE_USER contains _PAGE_BAP_SR on BookE using the new PTE format
+	 * which means that we just cleared supervisor access... oops ;-) This
+	 * restores it
+	 */
+	flags |= _PAGE_BAP_SR;
+#endif
+
 	if (ppc_md.ioremap)
 		return ppc_md.ioremap(addr, size, flags, caller);
 	return __ioremap_caller(addr, size, flags, caller);
-- 
1.6.0.6
