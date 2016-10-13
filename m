Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svflt2gX4zDt1F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 16:43:22 +1100 (AEDT)
Received: by mail-pa0-x243.google.com with SMTP id fn2so3380744pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 22:43:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/3] powerpc: build-time sort exception table
Date: Thu, 13 Oct 2016 16:42:55 +1100
Message-Id: <20161013054255.7205-4-npiggin@gmail.com>
In-Reply-To: <20161013054255.7205-1-npiggin@gmail.com>
References: <20161013054255.7205-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig              | 1 +
 arch/powerpc/include/asm/module.h | 4 ----
 scripts/sortextable.c             | 2 ++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5d43cb8..b49062b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -80,6 +80,7 @@ config ARCH_HAS_DMA_SET_COHERENT_MASK
 config PPC
 	bool
 	default y
+	select BUILDTIME_EXTABLE_SORT
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select BINFMT_ELF
diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index cd4ffd8..cc12c61 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -90,10 +90,6 @@ static inline int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sec
 }
 #endif
 
-struct exception_table_entry;
-void sort_ex_table(struct exception_table_entry *start,
-		   struct exception_table_entry *finish);
-
 #if defined(CONFIG_MODVERSIONS) && defined(CONFIG_PPC64)
 #define ARCH_RELOCATES_KCRCTAB
 #define reloc_start PHYSICAL_START
diff --git a/scripts/sortextable.c b/scripts/sortextable.c
index f453b7c..365a907 100644
--- a/scripts/sortextable.c
+++ b/scripts/sortextable.c
@@ -316,6 +316,8 @@ do_file(char const *const fname)
 	case EM_S390:
 	case EM_AARCH64:
 	case EM_PARISC:
+	case EM_PPC:
+	case EM_PPC64:
 		custom_sort = sort_relative_table;
 		break;
 	case EM_ARCOMPACT:
-- 
2.9.3
