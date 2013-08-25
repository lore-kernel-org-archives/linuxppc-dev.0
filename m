Return-Path: <haokexin@gmail.com>
Received: from mail7.windriver.com (mail7.windriver.com [128.224.252.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail7.windriver.com",
 Issuer "Intel External Basic Issuing CA 3B" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 57FC72C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Aug 2013 18:00:03 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/5] jump_label: factor out the base part of jump_label.h to a
 separate file
Date: Sun, 25 Aug 2013 15:15:48 +0800
Message-ID: <1377414952-15995-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1377414952-15995-1-git-send-email-haokexin@gmail.com>
References: <1377414952-15995-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We plan to use the jump label in the cpu/mmu feature check on ppc.
This will need to include the jump_label.h in several very basic header
files of ppc which seems to be included by most of the other head
files implicitly or explicitly. But in the current jump_label.h,
it also include the "linux/workqueue.h" and this will cause recursive
inclusion. In order to fix this, we choose to factor out the base
part of jump_label.h to a separate header file and we can include
that file instead of jump_label.h to avoid the recursive inclusion.
No functional change.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 include/linux/jump_label.h      | 132 +------------------------------------
 include/linux/jump_label_base.h | 142 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 130 deletions(-)
 create mode 100644 include/linux/jump_label_base.h

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 0976fc4..14bae65 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -46,20 +46,11 @@
  *
 */
 
-#include <linux/types.h>
-#include <linux/compiler.h>
 #include <linux/workqueue.h>
+#include <linux/jump_label_base.h>
 
-#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)
 
-struct static_key {
-	atomic_t enabled;
-/* Set lsb bit to 1 if branch is default true, 0 ot */
-	struct jump_entry *entries;
-#ifdef CONFIG_MODULES
-	struct static_key_mod *next;
-#endif
-};
+#ifdef HAVE_JUMP_LABEL
 
 struct static_key_deferred {
 	struct static_key key;
@@ -67,145 +58,26 @@ struct static_key_deferred {
 	struct delayed_work work;
 };
 
-# include <asm/jump_label.h>
-# define HAVE_JUMP_LABEL
-#endif	/* CC_HAVE_ASM_GOTO && CONFIG_JUMP_LABEL */
-
-enum jump_label_type {
-	JUMP_LABEL_DISABLE = 0,
-	JUMP_LABEL_ENABLE,
-};
-
-struct module;
-
-#ifdef HAVE_JUMP_LABEL
-
-#define JUMP_LABEL_TRUE_BRANCH 1UL
-
-static
-inline struct jump_entry *jump_label_get_entries(struct static_key *key)
-{
-	return (struct jump_entry *)((unsigned long)key->entries
-						& ~JUMP_LABEL_TRUE_BRANCH);
-}
-
-static inline bool jump_label_get_branch_default(struct static_key *key)
-{
-	if ((unsigned long)key->entries & JUMP_LABEL_TRUE_BRANCH)
-		return true;
-	return false;
-}
-
-static __always_inline bool static_key_false(struct static_key *key)
-{
-	return arch_static_branch(key);
-}
-
-static __always_inline bool static_key_true(struct static_key *key)
-{
-	return !static_key_false(key);
-}
-
-extern struct jump_entry __start___jump_table[];
-extern struct jump_entry __stop___jump_table[];
-
-extern void jump_label_init(void);
-extern void jump_label_lock(void);
-extern void jump_label_unlock(void);
-extern void arch_jump_label_transform(struct jump_entry *entry,
-				      enum jump_label_type type);
-extern void arch_jump_label_transform_static(struct jump_entry *entry,
-					     enum jump_label_type type);
-extern int jump_label_text_reserved(void *start, void *end);
-extern void static_key_slow_inc(struct static_key *key);
-extern void static_key_slow_dec(struct static_key *key);
 extern void static_key_slow_dec_deferred(struct static_key_deferred *key);
-extern void jump_label_apply_nops(struct module *mod);
 extern void
 jump_label_rate_limit(struct static_key_deferred *key, unsigned long rl);
 
-#define STATIC_KEY_INIT_TRUE ((struct static_key) \
-	{ .enabled = ATOMIC_INIT(1), .entries = (void *)1 })
-#define STATIC_KEY_INIT_FALSE ((struct static_key) \
-	{ .enabled = ATOMIC_INIT(0), .entries = (void *)0 })
-
 #else  /* !HAVE_JUMP_LABEL */
 
-#include <linux/atomic.h>
-
-struct static_key {
-	atomic_t enabled;
-};
-
-static __always_inline void jump_label_init(void)
-{
-}
-
 struct static_key_deferred {
 	struct static_key  key;
 };
 
-static __always_inline bool static_key_false(struct static_key *key)
-{
-	if (unlikely(atomic_read(&key->enabled)) > 0)
-		return true;
-	return false;
-}
-
-static __always_inline bool static_key_true(struct static_key *key)
-{
-	if (likely(atomic_read(&key->enabled)) > 0)
-		return true;
-	return false;
-}
-
-static inline void static_key_slow_inc(struct static_key *key)
-{
-	atomic_inc(&key->enabled);
-}
-
-static inline void static_key_slow_dec(struct static_key *key)
-{
-	atomic_dec(&key->enabled);
-}
-
 static inline void static_key_slow_dec_deferred(struct static_key_deferred *key)
 {
 	static_key_slow_dec(&key->key);
 }
 
-static inline int jump_label_text_reserved(void *start, void *end)
-{
-	return 0;
-}
-
-static inline void jump_label_lock(void) {}
-static inline void jump_label_unlock(void) {}
-
-static inline int jump_label_apply_nops(struct module *mod)
-{
-	return 0;
-}
-
 static inline void
 jump_label_rate_limit(struct static_key_deferred *key,
 		unsigned long rl)
 {
 }
 
-#define STATIC_KEY_INIT_TRUE ((struct static_key) \
-		{ .enabled = ATOMIC_INIT(1) })
-#define STATIC_KEY_INIT_FALSE ((struct static_key) \
-		{ .enabled = ATOMIC_INIT(0) })
-
 #endif	/* HAVE_JUMP_LABEL */
-
-#define STATIC_KEY_INIT STATIC_KEY_INIT_FALSE
-#define jump_label_enabled static_key_enabled
-
-static inline bool static_key_enabled(struct static_key *key)
-{
-	return (atomic_read(&key->enabled) > 0);
-}
-
 #endif	/* _LINUX_JUMP_LABEL_H */
diff --git a/include/linux/jump_label_base.h b/include/linux/jump_label_base.h
new file mode 100644
index 0000000..20df08f
--- /dev/null
+++ b/include/linux/jump_label_base.h
@@ -0,0 +1,142 @@
+#ifndef _LINUX_JUMP_LABEL_BASE_H
+#define _LINUX_JUMP_LABEL_BASE_H
+
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+
+#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)
+
+struct static_key {
+	atomic_t enabled;
+/* Set lsb bit to 1 if branch is default true, 0 ot */
+	struct jump_entry *entries;
+#ifdef CONFIG_MODULES
+	struct static_key_mod *next;
+#endif
+};
+
+# include <asm/jump_label.h>
+# define HAVE_JUMP_LABEL
+#endif	/* CC_HAVE_ASM_GOTO && CONFIG_JUMP_LABEL */
+
+enum jump_label_type {
+	JUMP_LABEL_DISABLE = 0,
+	JUMP_LABEL_ENABLE,
+};
+
+struct module;
+
+#ifdef HAVE_JUMP_LABEL
+
+#define JUMP_LABEL_TRUE_BRANCH 1UL
+
+static
+inline struct jump_entry *jump_label_get_entries(struct static_key *key)
+{
+	return (struct jump_entry *)((unsigned long)key->entries
+						& ~JUMP_LABEL_TRUE_BRANCH);
+}
+
+static inline bool jump_label_get_branch_default(struct static_key *key)
+{
+	if ((unsigned long)key->entries & JUMP_LABEL_TRUE_BRANCH)
+		return true;
+	return false;
+}
+
+static __always_inline bool static_key_false(struct static_key *key)
+{
+	return arch_static_branch(key);
+}
+
+static __always_inline bool static_key_true(struct static_key *key)
+{
+	return !static_key_false(key);
+}
+
+extern struct jump_entry __start___jump_table[];
+extern struct jump_entry __stop___jump_table[];
+
+extern void jump_label_init(void);
+extern void jump_label_lock(void);
+extern void jump_label_unlock(void);
+extern void arch_jump_label_transform(struct jump_entry *entry,
+				      enum jump_label_type type);
+extern void arch_jump_label_transform_static(struct jump_entry *entry,
+					     enum jump_label_type type);
+extern int jump_label_text_reserved(void *start, void *end);
+extern void static_key_slow_inc(struct static_key *key);
+extern void static_key_slow_dec(struct static_key *key);
+extern void jump_label_apply_nops(struct module *mod);
+
+#define STATIC_KEY_INIT_TRUE ((struct static_key) \
+	{ .enabled = ATOMIC_INIT(1), .entries = (void *)1 })
+#define STATIC_KEY_INIT_FALSE ((struct static_key) \
+	{ .enabled = ATOMIC_INIT(0), .entries = (void *)0 })
+
+#else  /* !HAVE_JUMP_LABEL */
+
+#include <linux/atomic.h>
+
+struct static_key {
+	atomic_t enabled;
+};
+
+static __always_inline void jump_label_init(void)
+{
+}
+
+static __always_inline bool static_key_false(struct static_key *key)
+{
+	if (unlikely(atomic_read(&key->enabled)) > 0)
+		return true;
+	return false;
+}
+
+static __always_inline bool static_key_true(struct static_key *key)
+{
+	if (likely(atomic_read(&key->enabled)) > 0)
+		return true;
+	return false;
+}
+
+static inline void static_key_slow_inc(struct static_key *key)
+{
+	atomic_inc(&key->enabled);
+}
+
+static inline void static_key_slow_dec(struct static_key *key)
+{
+	atomic_dec(&key->enabled);
+}
+
+static inline int jump_label_text_reserved(void *start, void *end)
+{
+	return 0;
+}
+
+static inline void jump_label_lock(void) {}
+static inline void jump_label_unlock(void) {}
+
+static inline int jump_label_apply_nops(struct module *mod)
+{
+	return 0;
+}
+
+#define STATIC_KEY_INIT_TRUE ((struct static_key) \
+		{ .enabled = ATOMIC_INIT(1) })
+#define STATIC_KEY_INIT_FALSE ((struct static_key) \
+		{ .enabled = ATOMIC_INIT(0) })
+
+#endif	/* HAVE_JUMP_LABEL */
+
+#define STATIC_KEY_INIT STATIC_KEY_INIT_FALSE
+#define jump_label_enabled static_key_enabled
+
+static inline bool static_key_enabled(struct static_key *key)
+{
+	return (atomic_read(&key->enabled) > 0);
+}
+
+#endif	/* _LINUX_JUMP_LABEL_BASE_H */
-- 
1.8.3.1
