Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FZLR2T3YzF1Gt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 04:28:47 +1000 (AEST)
Received: by mail-wr0-x243.google.com with SMTP id f16-v6so18228171wrm.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 11:28:47 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, James Morris <jmorris@namei.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v9 2/6] module: allow symbol exports to be disabled
Date: Tue, 26 Jun 2018 20:27:57 +0200
Message-Id: <20180626182802.19932-3-ard.biesheuvel@linaro.org>
In-Reply-To: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To allow existing C code to be incorporated into the decompressor or
the UEFI stub, introduce a CPP macro that turns all EXPORT_SYMBOL_xxx
declarations into nops, and #define it in places where such exports
are undesirable. Note that this gets rid of a rather dodgy redefine
of linux/export.h's header guard.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/compressed/kaslr.c      |  5 +----
 drivers/firmware/efi/libstub/Makefile |  3 ++-
 include/linux/export.h                | 11 ++++++++++-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b87a7582853d..ed7a123bba42 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -23,11 +23,8 @@
  * _ctype[] in lib/ctype.c is needed by isspace() of linux/ctype.h.
  * While both lib/ctype.c and lib/cmdline.c will bring EXPORT_SYMBOL
  * which is meaningless and will cause compiling error in some cases.
- * So do not include linux/export.h and define EXPORT_SYMBOL(sym)
- * as empty.
  */
-#define _LINUX_EXPORT_H
-#define EXPORT_SYMBOL(sym)
+#define __DISABLE_EXPORTS
 
 #include "misc.h"
 #include "error.h"
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index a34e9290a699..0d0d3483241c 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -20,7 +20,8 @@ cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -D__NO_FORTIFY \
 				   $(call cc-option,-ffreestanding) \
-				   $(call cc-option,-fno-stack-protector)
+				   $(call cc-option,-fno-stack-protector) \
+				   -D__DISABLE_EXPORTS
 
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
diff --git a/include/linux/export.h b/include/linux/export.h
index b768d6dd3c90..ea7df303d68d 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -66,7 +66,16 @@ extern struct module __this_module;
 	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
-#if defined(__KSYM_DEPS__)
+#if defined(__DISABLE_EXPORTS)
+
+/*
+ * Allow symbol exports to be disabled completely so that C code may
+ * be reused in other execution contexts such as the UEFI stub or the
+ * decompressor.
+ */
+#define __EXPORT_SYMBOL(sym, sec)
+
+#elif defined(__KSYM_DEPS__)
 
 /*
  * For fine grained build dependencies, we want to tell the build system
-- 
2.11.0
