Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zB4pt5h3DzF0Ph
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 07:07:18 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id g75so63340670wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jan 2018 12:07:18 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Ralf Baechle <ralf@linux-mips.org>,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: [PATCH v7 10/10] x86/kernel: jump_table: use relative references
Date: Tue,  2 Jan 2018 20:05:49 +0000
Message-Id: <20180102200549.22984-11-ard.biesheuvel@linaro.org>
In-Reply-To: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similar to the arm64 case, 64-bit x86 can benefit from using 32-bit
relative references rather than 64-bit absolute ones when emitting
struct jump_entry instances. Not only does this reduce the memory
footprint of the entries themselves by 50%, it also removes the need
for carrying relocation metadata on relocatable builds (i.e., for KASLR)
which saves a fair chunk of .init space as well (although the savings
are not as dramatic as on arm64)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/jump_label.h | 35 ++++++++++++--------
 arch/x86/kernel/jump_label.c      | 16 +++++++++
 tools/objtool/special.c           |  4 +--
 3 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 009ff2699d07..35fc2c5ec846 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -36,8 +36,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	asm_volatile_goto("1:"
 		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		".balign 4\n\t"
+		".long 1b - ., %l[l_yes] - ., %c0 + %c1 - .\n\t"
 		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -52,8 +52,8 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
 		"2:\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		".balign 4\n\t"
+		".long 1b - ., %l[l_yes] - ., %c0 + %c1 - .\n\t"
 		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -69,19 +69,26 @@ typedef u32 jump_label_t;
 #endif
 
 struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
+	s32 code;
+	s32 target;
+	s32 key;
 };
 
 static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
 {
-	return entry->code;
+	return (unsigned long)&entry->code + entry->code;
+}
+
+static inline jump_label_t jump_entry_target(const struct jump_entry *entry)
+{
+	return (unsigned long)&entry->target + entry->target;
 }
 
 static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
 {
-	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+	unsigned long key = (unsigned long)&entry->key + entry->key;
+
+	return (struct static_key *)(key & ~1UL);
 }
 
 static inline bool jump_entry_is_branch(const struct jump_entry *entry)
@@ -99,7 +106,7 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
 	entry->code = 0;
 }
 
-#define jump_label_swap		NULL
+void jump_label_swap(void *a, void *b, int size);
 
 #else	/* __ASSEMBLY__ */
 
@@ -114,8 +121,8 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
 	.byte		STATIC_KEY_INIT_NOP
 	.endif
 	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key
+	.balign		4
+	.long		.Lstatic_jump_\@ - ., \target - ., \key - .
 	.popsection
 .endm
 
@@ -130,8 +137,8 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
 .Lstatic_jump_after_\@:
 	.endif
 	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key + 1
+	.balign		4
+	.long		.Lstatic_jump_\@ - ., \target - ., \key + 1 - .
 	.popsection
 .endm
 
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index d64296092ef5..cc5034b42335 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -149,4 +149,20 @@ __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
 		__jump_label_transform(entry, type, text_poke_early, 1);
 }
 
+void jump_label_swap(void *a, void *b, int size)
+{
+	long delta = (unsigned long)a - (unsigned long)b;
+	struct jump_entry *jea = a;
+	struct jump_entry *jeb = b;
+	struct jump_entry tmp = *jea;
+
+	jea->code	= jeb->code - delta;
+	jea->target	= jeb->target - delta;
+	jea->key	= jeb->key - delta;
+
+	jeb->code	= tmp.code + delta;
+	jeb->target	= tmp.target + delta;
+	jeb->key	= tmp.key + delta;
+}
+
 #endif
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 84f001d52322..98ae55b39037 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -30,9 +30,9 @@
 #define EX_ORIG_OFFSET		0
 #define EX_NEW_OFFSET		4
 
-#define JUMP_ENTRY_SIZE		24
+#define JUMP_ENTRY_SIZE		12
 #define JUMP_ORIG_OFFSET	0
-#define JUMP_NEW_OFFSET		8
+#define JUMP_NEW_OFFSET		4
 
 #define ALT_ENTRY_SIZE		13
 #define ALT_ORIG_OFFSET		0
-- 
2.11.0
