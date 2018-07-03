Return-Path: <labbott@redhat.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41L0p76ngDzF1QP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 09:34:39 +1000 (AEST)
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so7225118oib.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 16:34:39 -0700 (PDT)
From: Laura Abbott <labbott@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
 "H . J . Lu" <hjl.tools@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Cc: Laura Abbott <labbott@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>,
 linux-kernel@vger.kernel.org, Nick Clifton <nickc@redhat.com>,
 Cary Coutant <ccoutant@gmail.com>, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCHv5 1/4] kbuild: Add build salt to the kernel and modules
Date: Tue,  3 Jul 2018 16:34:27 -0700
Message-Id: <20180703233430.14416-2-labbott@redhat.com>
In-Reply-To: <20180703233430.14416-1-labbott@redhat.com>
References: <20180703233430.14416-1-labbott@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The build id generated from --build-id can be generated in several different
ways, with the default being the sha1 on the output of the linked file. For
distributions, it can be useful to make sure this ID is unique, even if the
actual file contents don't change. The easiest way to do this is to insert
a section with some data.

Add an ELF note to both the kernel and module which contains some data based
off of a config option.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v5: I used S-o-b here since the majority of the code was written
already. Please feel free to change the tag if you think it's not
appropriate. I also tweaked this to take an ascii string instead of just
a hex value since this makes things much easier on the distribution
side.
---
 include/linux/build-salt.h | 20 ++++++++++++++++++++
 init/Kconfig               |  9 +++++++++
 init/version.c             |  3 +++
 scripts/mod/modpost.c      |  3 +++
 4 files changed, 35 insertions(+)
 create mode 100644 include/linux/build-salt.h

diff --git a/include/linux/build-salt.h b/include/linux/build-salt.h
new file mode 100644
index 000000000000..bb007bd05e7a
--- /dev/null
+++ b/include/linux/build-salt.h
@@ -0,0 +1,20 @@
+#ifndef __BUILD_SALT_H
+#define __BUILD_SALT_H
+
+#include <linux/elfnote.h>
+
+#define LINUX_ELFNOTE_BUILD_SALT       0x100
+
+#ifdef __ASSEMBLER__
+
+#define BUILD_SALT \
+       ELFNOTE(Linux, LINUX_ELFNOTE_BUILD_SALT, .asciz CONFIG_BUILD_SALT)
+
+#else
+
+#define BUILD_SALT \
+       ELFNOTE32("Linux", LINUX_ELFNOTE_BUILD_SALT, CONFIG_BUILD_SALT)
+
+#endif
+
+#endif /* __BUILD_SALT_H */
diff --git a/init/Kconfig b/init/Kconfig
index 041f3a022122..8de789f40db9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -107,6 +107,15 @@ config LOCALVERSION_AUTO
 
 	  which is done within the script "scripts/setlocalversion".)
 
+config BUILD_SALT
+       string "Build ID Salt"
+       default "Linux"
+       help
+          The build ID is used to link binaries and their debug info. Setting
+          this option will use the value in the calculation of the build id.
+          This is mostly useful for distributions which want to ensure the
+          build is unique between builds. It's safe to leave the default.
+
 config HAVE_KERNEL_GZIP
 	bool
 
diff --git a/init/version.c b/init/version.c
index bfb4e3f4955e..ef4012ec4375 100644
--- a/init/version.c
+++ b/init/version.c
@@ -7,6 +7,7 @@
  */
 
 #include <generated/compile.h>
+#include <linux/build-salt.h>
 #include <linux/export.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
@@ -49,3 +50,5 @@ const char linux_proc_banner[] =
 	"%s version %s"
 	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
 	" (" LINUX_COMPILER ") %s\n";
+
+BUILD_SALT;
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 1663fb19343a..dc6d714e4dcb 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2125,10 +2125,13 @@ static int check_modname_len(struct module *mod)
  **/
 static void add_header(struct buffer *b, struct module *mod)
 {
+	buf_printf(b, "#include <linux/build-salt.h>\n");
 	buf_printf(b, "#include <linux/module.h>\n");
 	buf_printf(b, "#include <linux/vermagic.h>\n");
 	buf_printf(b, "#include <linux/compiler.h>\n");
 	buf_printf(b, "\n");
+	buf_printf(b, "BUILD_SALT;\n");
+	buf_printf(b, "\n");
 	buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
 	buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
 	buf_printf(b, "\n");
-- 
2.17.1
