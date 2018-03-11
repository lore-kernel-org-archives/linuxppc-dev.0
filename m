Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zzgff01kMzDrf5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 23:39:21 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id i3so11210625wmi.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 05:39:21 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v8 6/6] kernel: tracepoints: add support for relative
 references
Date: Sun, 11 Mar 2018 12:38:15 +0000
Message-Id: <20180311123815.17916-7-ard.biesheuvel@linaro.org>
In-Reply-To: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To avoid the need for relocating absolute references to tracepoint
structures at boot time when running relocatable kernels (which may
take a disproportionate amount of space), add the option to emit
these tables as relative references instead.

Cc: Ingo Molnar <mingo@redhat.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/tracepoint.h | 19 ++++++--
 kernel/tracepoint.c        | 49 +++++++++++---------
 2 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index c94f466d57ef..cdb0a9461d71 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -225,6 +225,19 @@ extern void syscall_unregfunc(void);
 		return static_key_false(&__tracepoint_##name.key);	\
 	}
 
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __TRACEPOINT_ENTRY(name)					 \
+	asm("	.section \"__tracepoints_ptrs\", \"a\"		     \n" \
+	    "	.balign 4					     \n" \
+	    "	.long " VMLINUX_SYMBOL_STR(__tracepoint_##name) " - .\n" \
+	    "	.previous					     \n")
+#else
+#define __TRACEPOINT_ENTRY(name)					 \
+	static struct tracepoint * const __tracepoint_ptr_##name __used	 \
+	__attribute__((section("__tracepoints_ptrs"))) =		 \
+		&__tracepoint_##name
+#endif
+
 /*
  * We have no guarantee that gcc and the linker won't up-align the tracepoint
  * structures, so we create an array of pointers that will be used for iteration
@@ -234,11 +247,9 @@ extern void syscall_unregfunc(void);
 	static const char __tpstrtab_##name[]				 \
 	__attribute__((section("__tracepoints_strings"))) = #name;	 \
 	struct tracepoint __tracepoint_##name				 \
-	__attribute__((section("__tracepoints"))) =			 \
+	__attribute__((section("__tracepoints"), used)) =		 \
 		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
-	static struct tracepoint * const __tracepoint_ptr_##name __used	 \
-	__attribute__((section("__tracepoints_ptrs"))) =		 \
-		&__tracepoint_##name;
+	__TRACEPOINT_ENTRY(name);
 
 #define DEFINE_TRACE(name)						\
 	DEFINE_TRACE_FN(name, NULL, NULL);
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 671b13457387..4ce8cc4bf2c3 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -326,6 +326,27 @@ int tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data)
 }
 EXPORT_SYMBOL_GPL(tracepoint_probe_unregister);
 
+static void for_each_tracepoint_range(struct tracepoint * const *begin,
+		struct tracepoint * const *end,
+		void (*fct)(struct tracepoint *tp, void *priv),
+		void *priv)
+{
+	if (!begin)
+		return;
+
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)) {
+		const int *iter;
+
+		for (iter = (const int *)begin; iter < (const int *)end; iter++)
+			fct(offset_to_ptr(iter), priv);
+	} else {
+		struct tracepoint * const *iter;
+
+		for (iter = begin; iter < end; iter++)
+			fct(*iter, priv);
+	}
+}
+
 #ifdef CONFIG_MODULES
 bool trace_module_has_bad_taint(struct module *mod)
 {
@@ -390,15 +411,9 @@ EXPORT_SYMBOL_GPL(unregister_tracepoint_module_notifier);
  * Ensure the tracer unregistered the module's probes before the module
  * teardown is performed. Prevents leaks of probe and data pointers.
  */
-static void tp_module_going_check_quiescent(struct tracepoint * const *begin,
-		struct tracepoint * const *end)
+static void tp_module_going_check_quiescent(struct tracepoint *tp, void *priv)
 {
-	struct tracepoint * const *iter;
-
-	if (!begin)
-		return;
-	for (iter = begin; iter < end; iter++)
-		WARN_ON_ONCE((*iter)->funcs);
+	WARN_ON_ONCE(tp->funcs);
 }
 
 static int tracepoint_module_coming(struct module *mod)
@@ -449,8 +464,9 @@ static void tracepoint_module_going(struct module *mod)
 			 * Called the going notifier before checking for
 			 * quiescence.
 			 */
-			tp_module_going_check_quiescent(mod->tracepoints_ptrs,
-				mod->tracepoints_ptrs + mod->num_tracepoints);
+			for_each_tracepoint_range(mod->tracepoints_ptrs,
+				mod->tracepoints_ptrs + mod->num_tracepoints,
+				tp_module_going_check_quiescent, NULL);
 			break;
 		}
 	}
@@ -502,19 +518,6 @@ static __init int init_tracepoints(void)
 __initcall(init_tracepoints);
 #endif /* CONFIG_MODULES */
 
-static void for_each_tracepoint_range(struct tracepoint * const *begin,
-		struct tracepoint * const *end,
-		void (*fct)(struct tracepoint *tp, void *priv),
-		void *priv)
-{
-	struct tracepoint * const *iter;
-
-	if (!begin)
-		return;
-	for (iter = begin; iter < end; iter++)
-		fct(*iter, priv);
-}
-
 /**
  * for_each_kernel_tracepoint - iteration on all kernel tracepoints
  * @fct: callback
-- 
2.15.1
