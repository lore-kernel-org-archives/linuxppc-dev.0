Return-Path: <bobby.prani@gmail.com>
Received: from mail-yk0-x235.google.com (mail-yk0-x235.google.com
 [IPv6:2607:f8b0:4002:c07::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D367C1A1930
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 01:23:14 +1100 (AEDT)
Received: by mail-yk0-x235.google.com with SMTP id v14so161954952ykd.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 06:23:14 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND
 64-BIT)), linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH] PPC32: Fix build failure caused by missing dirty pte
 handlers
Date: Mon, 25 Jan 2016 09:22:58 -0500
Message-Id: <1453731778-18464-1-git-send-email-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In 4.5-rc1, I am getting a build failure as follows:

mm/memory.c: In function ‘do_swap_page’:
mm/memory.c:2573:9: error: implicit declaration of function ‘pte_mksoft_dirty’
[-Werror=implicit-function-declaration]
   pte = pte_mksoft_dirty(pte);

The soft dirty pte handlers are declared only for PPC64 on PPC_BOOK3S in
arch/powerpc/include/asm/book3s/64/hash.h and missing in the 32-bit arch.

Avoid this error by not setting HAVE_ARCH_SOFT_DIRTY for 32-bit system.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 arch/powerpc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e4824fd..21cb5c5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -557,7 +557,7 @@ choice
 
 config PPC_4K_PAGES
 	bool "4k page size"
-	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S
+	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S && PPC64
 
 config PPC_16K_PAGES
 	bool "16k page size"
@@ -566,7 +566,7 @@ config PPC_16K_PAGES
 config PPC_64K_PAGES
 	bool "64k page size"
 	depends on !PPC_FSL_BOOK3E && (44x || PPC_STD_MMU_64 || PPC_BOOK3E_64)
-	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S
+	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S && PPC64
 
 config PPC_256K_PAGES
 	bool "256k page size"
-- 
2.7.0
