Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7FEEDDDF3A
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 00:02:06 +1000 (EST)
Subject: [PATCH] powerpc: fix 64-bit hibernation with 64k pages
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 24 Sep 2008 16:01:09 +0200
Message-Id: <1222264869.4257.13.camel@johannes.berg>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Brown paper bag patch, the fact that it didn't work is entirely my fault
for hardcoding 512 in the original patch.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
Contains the revert for the earlier patch just in case; probably better
to not apply the earlier patch and only the first hunk of this.

---
 arch/powerpc/Kconfig               |    2 +-
 arch/powerpc/kernel/swsusp_asm64.S |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- wireless-testing.orig/arch/powerpc/kernel/swsusp_asm64.S	2008-09-24 15:32:07.119071976 +0200
+++ wireless-testing/arch/powerpc/kernel/swsusp_asm64.S	2008-09-24 15:32:15.723824535 +0200
@@ -133,7 +133,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 
 	cmpdi	r12,0
 	beq-	nothing_to_copy
-	li	r15,512
+	li	r15,PAGE_SIZE>>3
 copyloop:
 	ld	r13,pbe_address(r12)
 	ld	r14,pbe_orig_address(r12)
--- wireless-testing.orig/arch/powerpc/Kconfig	2008-09-24 15:32:36.483825650 +0200
+++ wireless-testing/arch/powerpc/Kconfig	2008-09-24 15:32:42.837826811 +0200
@@ -194,7 +194,7 @@ config HIBERNATE_32
 
 config HIBERNATE_64
 	bool
-	depends on BROKEN || (PPC_PMAC64 && !PPC_64K_PAGES && EXPERIMENTAL)
+	depends on BROKEN || (PPC_PMAC64 && EXPERIMENTAL)
 	default y
 
 config ARCH_HIBERNATION_POSSIBLE
