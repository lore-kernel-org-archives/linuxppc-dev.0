Return-Path: <Paul.Burton@mips.com>
Received: from 9pmail.ess.barracuda.com (9pmail.ess.barracuda.com
 [64.235.150.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416znW53DKzDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2018 11:10:55 +1000 (AEST)
From: Paul Burton <paul.burton@mips.com>
To: <linux-kbuild@vger.kernel.org>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, <linux-mips@linux-mips.org>,
 Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Matthew Wilcox
 <matthew@wil.cx>, Thomas Gleixner <tglx@linutronix.de>, Douglas Anderson
 <dianders@chromium.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Matthias Kaehlcke <mka@chromium.org>, He Zhe
 <zhe.he@windriver.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michal Marek <michal.lkml@markovi.net>, Khem Raj <raj.khem@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Al Viro
 <viro@zeniv.linux.org.uk>, Stafford Horne <shorne@gmail.com>, Gideon Israel
 Dsouza <gidisrael@gmail.com>, Masahiro Yamada
 <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH 1/3] kbuild: add macro for controlling warnings to
 linux/compiler.h
Date: Fri, 15 Jun 2018 17:53:20 -0700
Message-ID: <20180616005323.7938-2-paul.burton@mips.com>
In-Reply-To: <20180616005323.7938-1-paul.burton@mips.com>
References: <20180616005323.7938-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd@arndb.de>

I have occasionally run into a situation where it would make sense to
control a compiler warning from a source file rather than doing so from
a Makefile using the $(cc-disable-warning, ...) or $(cc-option, ...)
helpers.

The approach here is similar to what glibc uses, using __diag() and
related macros to encapsulate a _Pragma("GCC diagnostic ...") statement
that gets turned into the respective "#pragma GCC diagnostic ..." by
the preprocessor when the macro gets expanded.

Like glibc, I also have an argument to pass the affected compiler
version, but decided to actually evaluate that one. For now, this
supports GCC_4_6, GCC_4_7, GCC_4_8, GCC_4_9, GCC_5, GCC_6, GCC_7,
GCC_8 and GCC_9. Adding support for CLANG_5 and other interesting
versions is straightforward here. GNU compilers starting with gcc-4.2
could support it in principle, but "#pragma GCC diagnostic push"
was only added in gcc-4.6, so it seems simpler to not deal with those
at all. The same versions show a large number of warnings already,
so it seems easier to just leave it at that and not do a more
fine-grained control for them.

The use cases I found so far include:

- turning off the gcc-8 -Wattribute-alias warning inside of the
  SYSCALL_DEFINEx() macro without having to do it globally.

- Reducing the build time for a simple re-make after a change,
  once we move the warnings from ./Makefile and
  ./scripts/Makefile.extrawarn into linux/compiler.h

- More control over the warnings based on other configurations,
  using preprocessor syntax instead of Makefile syntax. This should make
  it easier for the average developer to understand and change things.

- Adding an easy way to turn the W=1 option on unconditionally
  for a subdirectory or a specific file. This has been requested
  by several developers in the past that want to have their subsystems
  W=1 clean.

- Integrating clang better into the build systems. Clang supports
  more warnings than GCC, and we probably want to classify them
  as default, W=1, W=2 etc, but there are cases in which the
  warnings should be classified differently due to excessive false
  positives from one or the other compiler.

- Adding a way to turn the default warnings into errors (e.g. using
  a new "make E=0" tag) while not also turning the W=1 warnings into
  errors.

This patch for now just adds the minimal infrastructure in order to
do the first of the list above. As the #pragma GCC diagnostic
takes precedence over command line options, the next step would be
to convert a lot of the individual Makefiles that set nonstandard
options to use __diag() instead.

[paul.burton@mips.com:
  - Rebase atop current master.
  - Add __diag_GCC, or more generally __diag_<compiler>, abstraction to
    avoid code outside of linux/compiler-gcc.h needing to duplicate
    knowledge about different GCC versions.
  - Add a comment argument to __diag_{ignore,warn,error} which isn't
    used in the expansion of the macros but serves to push people to
    document the reason for using them - per feedback from Kees Cook.]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Matthew Wilcox <matthew@wil.cx>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Gideon Israel Dsouza <gidisrael@gmail.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>
Cc: He Zhe <zhe.he@windriver.com>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
---

 include/linux/compiler-gcc.h   | 66 ++++++++++++++++++++++++++++++++++
 include/linux/compiler_types.h | 18 ++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index f1a7492a5cc8..aba64a2912d8 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -347,3 +347,69 @@
 #if GCC_VERSION >= 50100
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
+
+/*
+ * turn individual warnings and errors on and off locally, depending
+ * on version.
+ */
+#define __diag_GCC(version, s) __diag_GCC_ ## version(s)
+
+#if GCC_VERSION >= 40600
+#define __diag_str1(s) #s
+#define __diag_str(s) __diag_str1(s)
+#define __diag(s) _Pragma(__diag_str(GCC diagnostic s))
+
+/* compilers before gcc-4.6 do not understand "#pragma GCC diagnostic push" */
+#define __diag_GCC_4_6(s) __diag(s)
+#else
+#define __diag(s)
+#define __diag_GCC_4_6(s)
+#endif
+
+#if GCC_VERSION >= 40700
+#define __diag_GCC_4_7(s) __diag(s)
+#else
+#define __diag_GCC_4_7(s)
+#endif
+
+#if GCC_VERSION >= 40800
+#define __diag_GCC_4_8(s) __diag(s)
+#else
+#define __diag_GCC_4_8(s)
+#endif
+
+#if GCC_VERSION >= 40900
+#define __diag_GCC_4_9(s) __diag(s)
+#else
+#define __diag_GCC_4_9(s)
+#endif
+
+#if GCC_VERSION >= 50000
+#define __diag_GCC_5(s) __diag(s)
+#else
+#define __diag_GCC_5(s)
+#endif
+
+#if GCC_VERSION >= 60000
+#define __diag_GCC_6(s) __diag(s)
+#else
+#define __diag_GCC_6(s)
+#endif
+
+#if GCC_VERSION >= 70000
+#define __diag_GCC_7(s) __diag(s)
+#else
+#define __diag_GCC_7(s)
+#endif
+
+#if GCC_VERSION >= 80000
+#define __diag_GCC_8(s) __diag(s)
+#else
+#define __diag_GCC_8(s)
+#endif
+
+#if GCC_VERSION >= 90000
+#define __diag_GCC_9(s) __diag(s)
+#else
+#define __diag_GCC_9(s)
+#endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 6b79a9bba9a7..313a2ad884e0 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -271,4 +271,22 @@ struct ftrace_likely_data {
 # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 #endif
 
+#ifndef __diag
+#define __diag(string)
+#endif
+
+#ifndef __diag_GCC
+#define __diag_GCC(string)
+#endif
+
+#define __diag_push()	__diag(push)
+#define __diag_pop()	__diag(pop)
+
+#define __diag_ignore(compiler, version, option, comment) \
+	__diag_ ## compiler(version, ignored option)
+#define __diag_warn(compiler, version, option, comment) \
+	__diag_ ## compiler(version, warning option)
+#define __diag_error(compiler, version, option, comment) \
+	__diag_ ## compiler(version, error   option)
+
 #endif /* __LINUX_COMPILER_TYPES_H */
-- 
2.17.1
