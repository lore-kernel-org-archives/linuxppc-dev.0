Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9297BB7D47
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Feb 2010 03:12:35 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o14GCGf7022981
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Feb 2010 09:12:27 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o14GJM2h029034
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Feb 2010 10:19:23 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: benh@kernel.crashing.org, galak@gate.crashing.org
Subject: [PATCH] powerpc: fix ioremap_flags() with book3e pte definition
Date: Fri,  5 Feb 2010 00:53:02 +0800
Message-Id: <1265302382-15142-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can't just clear the user read permission in book3e pte, because
that will also clear supervisor read permission.  This surely isn't
desired.  Fix the problem by adding the supervisor read back.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/mm/pgtable_32.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index cb96cb2..aff7c04 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -144,6 +144,11 @@ ioremap_flags(phys_addr_t addr, unsigned long size, unsigned long flags)
 	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
 	flags &= ~(_PAGE_USER | _PAGE_EXEC);
 
+#if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_PTE_64BIT)
+	/* supervisor read permission has just been cleared, add back */
+	flags |= _PAGE_BAP_SR;
+#endif
+
 	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_flags);
-- 
1.6.6-rc1.GIT
