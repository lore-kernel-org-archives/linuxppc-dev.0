Return-Path: <labbott@redhat.com>
Received: from mail-qt0-f194.google.com (mail-qt0-f194.google.com
 [209.85.216.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41MGMz3zMszDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 10:49:51 +1000 (AEST)
Received: by mail-qt0-f194.google.com with SMTP id h5-v6so8695883qtm.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jul 2018 17:49:51 -0700 (PDT)
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
Subject: [PATCHv6 1/4] kbuild: Add build salt to the kernel and modules
Date: Thu,  5 Jul 2018 17:49:37 -0700
Message-Id: <20180706004940.32587-2-labbott@redhat.com>
In-Reply-To: <20180706004940.32587-1-labbott@redhat.com>
References: <20180706004940.32587-1-labbott@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


In Fedora, the debug information is packaged separately (foo-debuginfo) and
can be installed separately. There's been a long standing issue where only
one version of a debuginfo info package can be installed at a time. There's
been an effort for Fedora for parallel debuginfo to rectify this problem.

Part of the requirement to allow parallel debuginfo to work is that build ids
are unique between builds. The existing upstream rpm implementation ensures
this by re-calculating the build-id using the version and release as a
seed. This doesn't work 100% for the kernel because of the vDSO which is
its own binary and doesn't get updated when embedded.

Fix this by adding some data in an ELF note for both the kernel and modules.
The data is controlled via a Kconfig option so distributions can set it
to an appropriate value to ensure uniqueness between builds.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v6: Added more detail to the commit text about why exactly this feature
is useful. Default string now ""
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
index 041f3a022122..d39b31484c52 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -107,6 +107,15 @@ config LOCALVERSION_AUTO
 
 	  which is done within the script "scripts/setlocalversion".)
 
+config BUILD_SALT
+       string "Build ID Salt"
+       default ""
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
