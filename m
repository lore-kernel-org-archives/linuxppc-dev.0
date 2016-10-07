Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sr6kX1F7TzDrPL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2016 22:29:56 +1100 (AEDT)
Received: by mail-pa0-x244.google.com with SMTP id hh10so2631166pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Oct 2016 04:29:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc: build time sort extable
Date: Fri,  7 Oct 2016 22:29:41 +1100
Message-Id: <20161007112941.20073-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Can we just switch this on? Powerpc does not use relative extables
(that's a nice exercise left for the reader), so it should just use
the standard sort.

This patch seems to work, famous last words...

Sorting probably only takes a few ms on any real hardware, but on on
very large kernel configs, extable sorting can take several seconds in
simulators and be a noticable cost to booting.

---
 arch/powerpc/Kconfig  | 1 +
 scripts/sortextable.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 927d2ab..2340483 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -85,6 +85,7 @@ config ARCH_HAS_DMA_SET_COHERENT_MASK
 config PPC
 	bool
 	default y
+	select BUILDTIME_EXTABLE_SORT
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select BINFMT_ELF
diff --git a/scripts/sortextable.c b/scripts/sortextable.c
index f453b7c..30337e1 100644
--- a/scripts/sortextable.c
+++ b/scripts/sortextable.c
@@ -324,6 +324,8 @@ do_file(char const *const fname)
 	case EM_MICROBLAZE:
 	case EM_MIPS:
 	case EM_XTENSA:
+	case EM_PPC:
+	case EM_PPC64:
 		break;
 	}  /* end switch */
 
-- 
2.9.3
