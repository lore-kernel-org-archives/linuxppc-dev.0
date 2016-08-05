Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5QgV2pwMzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 22:13:10 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id cf3so19184904pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 05:13:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Alan Modra <amodra@gmail.com>
Subject: [PATCH 5/5] powerpc/64: use linker dce
Date: Fri,  5 Aug 2016 22:12:03 +1000
Message-Id: <1470399123-8455-6-git-send-email-npiggin@gmail.com>
In-Reply-To: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---
 arch/powerpc/kernel/Makefile           | 3 +++
 arch/powerpc/kernel/vmlinux.lds.S      | 2 +-
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2da380f..b356e59 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -4,7 +4,10 @@
 
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
+ccflags-y		+= -fno-function-sections -fno-data-sections
+
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+subdir-ccflags-y	+= -fno-function-sections -fno-data-sections
 
 ifeq ($(CONFIG_PPC64),y)
 CFLAGS_prom_init.o	+= $(NO_MINIMAL_TOC)
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 2dd91f7..c157b8d 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -50,7 +50,7 @@ SECTIONS
 		HEAD_TEXT
 		_text = .;
 		/* careful! __ftr_alt_* sections need to be close to .text */
-		*(.text .fixup __ftr_alt_* .ref.text)
+		*(.text .text.* .fixup __ftr_alt_* .ref.text)
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 3c77091..6afeb9d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -3,6 +3,7 @@ config PPC64
 	default n
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select THIN_ARCHIVES
+	select LINKER_DCE
 	select ZLIB_DEFLATE
 	help
 	  This option selects whether a 32-bit or a 64-bit kernel
-- 
2.8.1
