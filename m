Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <cf9e5d00e218ff175e080bdbc66e79bf90aa532c.1214271072.git.michael@ellerman.id.au>
In-Reply-To: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 11/14] powerpc: Introduce infrastructure for feature sections
	with alternatives
Date: Tue, 24 Jun 2008 11:32:54 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current feature section logic only supports nop'ing out code, this means
if you want to choose at runtime between instruction sequences, one or both
cases will have to execute the nop'ed out contents of the other section, eg:

BEGIN_FTR_SECTION
	or	1,1,1
END_FTR_SECTION_IFSET(FOO)
BEGIN_FTR_SECTION
	or	2,2,2
END_FTR_SECTION_IFCLR(FOO)

and the resulting code will be either,

	or	1,1,1
	nop

or,
	nop
	or	2,2,2

For small code segments this is fine, but for larger code blocks and in
performance criticial code segments, it would be nice to avoid the nops.
This commit starts to implement logic to allow the following:

BEGIN_FTR_SECTION
	or	1,1,1
FTR_SECTION_ELSE
	or	2,2,2
ALT_FTR_SECTION_END_IFSET(FOO)

and the resulting code will be:

	or	1,1,1
or,
	or	2,2,2

We achieve this by extending the existing FTR macros. The current feature
section semantic just becomes a special case, ie. if the else case is empty
we nop out the default case.

The key limitation is that the size of the else case must be less than or
equal to the size of the default case. If the else case is smaller the
remainder of the section is nop'ed.

We let the linker put the else case code in with the rest of the text,
so that relative branches from the else case are more likley to link,
this has the disadvantage that we can't free the unused else cases.

This commit introduces the required macro and linker script changes, but
does not enable the patching of the alternative sections.

We also need to update two hand-made section entries in reg.h and timex.h

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/vdso32/vdso32.lds.S |    2 +-
 arch/powerpc/kernel/vdso64/vdso64.lds.S |    2 +-
 arch/powerpc/kernel/vmlinux.lds.S       |    2 +-
 arch/powerpc/lib/feature-fixups.c       |    2 +
 include/asm-powerpc/feature-fixups.h    |   68 +++++++++++++++++++++++++------
 include/asm-powerpc/reg.h               |    2 +
 include/asm-powerpc/timex.h             |    2 +
 7 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index 9352ab5..2717935 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -24,7 +24,7 @@ SECTIONS
 
 	. = ALIGN(16);
 	.text		: {
-		*(.text .stub .text.* .gnu.linkonce.t.*)
+		*(.text .stub .text.* .gnu.linkonce.t.* __ftr_alt_*)
 	}
 	PROVIDE(__etext = .);
 	PROVIDE(_etext = .);
diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso64/vdso64.lds.S
index 7d6585f..e608d1b 100644
--- a/arch/powerpc/kernel/vdso64/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso64/vdso64.lds.S
@@ -24,7 +24,7 @@ SECTIONS
 
 	. = ALIGN(16);
 	.text		: {
-		*(.text .stub .text.* .gnu.linkonce.t.*)
+		*(.text .stub .text.* .gnu.linkonce.t.* __ftr_alt_*)
 		*(.sfpr .glink)
 	}						:text
 	PROVIDE(__etext = .);
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 0c3000b..3c07811 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -35,7 +35,7 @@ SECTIONS
 		ALIGN_FUNCTION();
 		*(.text.head)
 		_text = .;
-		*(.text .fixup .text.init.refok .exit.text.refok)
+		*(.text .fixup .text.init.refok .exit.text.refok __ftr_alt_*)
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index f6fd5d2..973d547 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -22,6 +22,8 @@ struct fixup_entry {
 	unsigned long	value;
 	long		start_off;
 	long		end_off;
+	long		alt_start_off;
+	long		alt_end_off;
 };
 
 static void patch_feature_section(unsigned long value, struct fixup_entry *fcur)
diff --git a/include/asm-powerpc/feature-fixups.h b/include/asm-powerpc/feature-fixups.h
index 35f9278..ab30129 100644
--- a/include/asm-powerpc/feature-fixups.h
+++ b/include/asm-powerpc/feature-fixups.h
@@ -29,24 +29,35 @@
 #define FTR_ENTRY_OFFSET	PPC_LONG
 #endif
 
+#define START_FTR_SECTION(label)	label##1:
+
+#define FTR_SECTION_ELSE_NESTED(label)			\
+label##2:						\
+	.pushsection __ftr_alt_##label,"a";		\
+	.align 2;					\
+label##3:
+
 #define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)	\
-99:							\
-	.section sect,"a";				\
+label##4:						\
+	.popsection;					\
+	.pushsection sect,"a";				\
 	.align 3;					\
-98:						       	\
+label##5:					       	\
 	FTR_ENTRY_LONG msk;				\
 	FTR_ENTRY_LONG val;				\
-	FTR_ENTRY_OFFSET label##b-98b;			\
-	FTR_ENTRY_OFFSET 99b-98b;		 	\
-	.previous
-
+	FTR_ENTRY_OFFSET label##1b-label##5b;		\
+	FTR_ENTRY_OFFSET label##2b-label##5b;	 	\
+	FTR_ENTRY_OFFSET label##3b-label##5b;		\
+	FTR_ENTRY_OFFSET label##4b-label##5b;	 	\
+	.popsection;
 
 
 /* CPU feature dependent sections */
-#define BEGIN_FTR_SECTION_NESTED(label)	label:
-#define BEGIN_FTR_SECTION		BEGIN_FTR_SECTION_NESTED(97)
+#define BEGIN_FTR_SECTION_NESTED(label)	START_FTR_SECTION(label)
+#define BEGIN_FTR_SECTION		START_FTR_SECTION(97)
 
-#define END_FTR_SECTION_NESTED(msk, val, label) \
+#define END_FTR_SECTION_NESTED(msk, val, label) 		\
+	FTR_SECTION_ELSE_NESTED(label)				\
 	MAKE_FTR_SECTION_ENTRY(msk, val, label, __ftr_fixup)
 
 #define END_FTR_SECTION(msk, val)		\
@@ -55,12 +66,27 @@
 #define END_FTR_SECTION_IFSET(msk)	END_FTR_SECTION((msk), (msk))
 #define END_FTR_SECTION_IFCLR(msk)	END_FTR_SECTION((msk), 0)
 
+/* CPU feature sections with alternatives, use BEGIN_FTR_SECTION to start */
+#define FTR_SECTION_ELSE	FTR_SECTION_ELSE_NESTED(97)
+#define ALT_FTR_SECTION_END_NESTED(msk, val, label)	\
+	MAKE_FTR_SECTION_ENTRY(msk, val, label, __ftr_fixup)
+#define ALT_FTR_SECTION_END_NESTED_IFSET(msk, label)	\
+	ALT_FTR_SECTION_END_NESTED(msk, msk, label)
+#define ALT_FTR_SECTION_END_NESTED_IFCLR(msk, label)	\
+	ALT_FTR_SECTION_END_NESTED(msk, 0, label)
+#define ALT_FTR_SECTION_END(msk, val)	\
+	ALT_FTR_SECTION_END_NESTED(msk, val, 97)
+#define ALT_FTR_SECTION_END_IFSET(msk)	\
+	ALT_FTR_SECTION_END_NESTED_IFSET(msk, 97)
+#define ALT_FTR_SECTION_END_IFCLR(msk)	\
+	ALT_FTR_SECTION_END_NESTED_IFCLR(msk, 97)
 
 /* Firmware feature dependent sections */
-#define BEGIN_FW_FTR_SECTION_NESTED(label)	label:
-#define BEGIN_FW_FTR_SECTION			BEGIN_FW_FTR_SECTION_NESTED(97)
+#define BEGIN_FW_FTR_SECTION_NESTED(label)	START_FTR_SECTION(label)
+#define BEGIN_FW_FTR_SECTION			START_FTR_SECTION(97)
 
-#define END_FW_FTR_SECTION_NESTED(msk, val, label) \
+#define END_FW_FTR_SECTION_NESTED(msk, val, label) 		\
+	FTR_SECTION_ELSE_NESTED(label)				\
 	MAKE_FTR_SECTION_ENTRY(msk, val, label, __fw_ftr_fixup)
 
 #define END_FW_FTR_SECTION(msk, val)		\
@@ -69,6 +95,22 @@
 #define END_FW_FTR_SECTION_IFSET(msk)	END_FW_FTR_SECTION((msk), (msk))
 #define END_FW_FTR_SECTION_IFCLR(msk)	END_FW_FTR_SECTION((msk), 0)
 
+/* Firmware feature sections with alternatives */
+#define FW_FTR_SECTION_ELSE_NESTED(label)	FTR_SECTION_ELSE_NESTED(label)
+#define FW_FTR_SECTION_ELSE	FTR_SECTION_ELSE_NESTED(97)
+#define ALT_FW_FTR_SECTION_END_NESTED(msk, val, label)	\
+	MAKE_FTR_SECTION_ENTRY(msk, val, label, __fw_ftr_fixup)
+#define ALT_FW_FTR_SECTION_END_NESTED_IFSET(msk, label)	\
+	ALT_FW_FTR_SECTION_END_NESTED(msk, msk, label)
+#define ALT_FW_FTR_SECTION_END_NESTED_IFCLR(msk, label)	\
+	ALT_FW_FTR_SECTION_END_NESTED(msk, 0, label)
+#define ALT_FW_FTR_SECTION_END(msk, val)	\
+	ALT_FW_FTR_SECTION_END_NESTED(msk, val, 97)
+#define ALT_FW_FTR_SECTION_END_IFSET(msk)	\
+	ALT_FW_FTR_SECTION_END_NESTED_IFSET(msk, 97)
+#define ALT_FW_FTR_SECTION_END_IFCLR(msk)	\
+	ALT_FW_FTR_SECTION_END_NESTED_IFCLR(msk, 97)
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_POWERPC_FEATURE_FIXUPS_H */
diff --git a/include/asm-powerpc/reg.h b/include/asm-powerpc/reg.h
index edc0cfd..f8d7563 100644
--- a/include/asm-powerpc/reg.h
+++ b/include/asm-powerpc/reg.h
@@ -732,6 +732,8 @@
 				"	.llong %1\n"			\
 				"	.llong 97b-98b\n"		\
 				"	.llong 99b-98b\n"		\
+				"	.llong 0\n"			\
+				"	.llong 0\n"			\
 				".previous"				\
 			: "=r" (rval) : "i" (CPU_FTR_CELL_TB_BUG)); rval;})
 #else
diff --git a/include/asm-powerpc/timex.h b/include/asm-powerpc/timex.h
index 92dedde..c55e14f 100644
--- a/include/asm-powerpc/timex.h
+++ b/include/asm-powerpc/timex.h
@@ -38,6 +38,8 @@ static inline cycles_t get_cycles(void)
 		"	.long 0\n"
 		"	.long 97b-98b\n"
 		"	.long 99b-98b\n"
+		"	.long 0\n"
+		"	.long 0\n"
 		".previous"
 		: "=r" (ret) : "i" (CPU_FTR_601));
 	return ret;
-- 
1.5.5
