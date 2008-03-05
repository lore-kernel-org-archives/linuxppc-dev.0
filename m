Return-Path: <ionut.nicu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A739DE036
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 03:34:33 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m25GQx4o028682
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 09:34:25 -0700 (MST)
From: Ionut Nicu <ionut.nicu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix kernel panic in arch_arm_kprobe
Date: Wed,  5 Mar 2008 18:12:54 +0200
Message-Id: <1204733574-7445-1-git-send-email-ionut.nicu@freescale.com>
Cc: Ionut Nicu <ionut.nicu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The code in arch_arm_kprobe was trying to set a breakpoint which
resulted in a page fault because the kernel text pages were write
protected. Disable the write protect when CONFIG_KPROBES is defined.

Signed-off-by: Ionut Nicu <ionut.nicu@freescale.com>
---
 include/asm-powerpc/pgtable-ppc32.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/asm-powerpc/pgtable-ppc32.h b/include/asm-powerpc/pgtable-ppc32.h
index d1332bb..ce66f72 100644
--- a/include/asm-powerpc/pgtable-ppc32.h
+++ b/include/asm-powerpc/pgtable-ppc32.h
@@ -428,7 +428,8 @@ extern int icache_44x_need_flush;
 #define _PAGE_IO	(_PAGE_KERNEL | _PAGE_NO_CACHE | _PAGE_GUARDED)
 #define _PAGE_RAM	(_PAGE_KERNEL | _PAGE_HWEXEC)
 
-#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH)
+#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
+	defined(CONFIG_KPROBES)
 /* We want the debuggers to be able to set breakpoints anywhere, so
  * don't write protect the kernel text */
 #define _PAGE_RAM_TEXT	_PAGE_RAM
-- 
1.5.4.2
