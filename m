Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4013Qq4KkZzDq82
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 05:33:55 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Peter Zijlstra <peterz@infradead.org>, Michal Suchanek <msuchanek@suse.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Tobin C. Harding" <me@tobin.cc>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Al Viro <viro@zeniv.linux.org.uk>, Michael Neuling <mikey@neuling.org>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Russell Currey <ruscur@russell.cc>,
 Joe Perches <joe@perches.com>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC 4/8] powerpc/64s: Add support for ori barrier_nospec
Date: Tue, 13 Mar 2018 19:33:02 +0100
Message-Id: <50e3f58ffadc2ffdda68df768610816734b30ddd.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Copypasta from rfi implementation

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/barrier.h        |  4 ++--
 arch/powerpc/include/asm/feature-fixups.h |  9 +++++++++
 arch/powerpc/include/asm/setup.h          |  8 ++++++++
 arch/powerpc/kernel/setup_64.c            | 29 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/vmlinux.lds.S         |  7 +++++++
 arch/powerpc/lib/feature-fixups.c         | 27 +++++++++++++++++++++++++++
 6 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 8e47b3abe405..4079a95e84c2 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -75,9 +75,9 @@ do {									\
 	___p1;								\
 })
 
-/* TODO: add patching so this can be disabled */
 /* Prevent speculative execution past this barrier. */
-#define barrier_nospec_asm ori 31,31,0
+#define barrier_nospec_asm SPEC_BARRIER_FIXUP_SECTION;			\
+				nop
 #ifdef __ASSEMBLY__
 #define barrier_nospec barrier_nospec_asm
 #else
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 1e82eb3caabd..9d3382618ffd 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -195,11 +195,20 @@ label##3:					       	\
 	FTR_ENTRY_OFFSET 951b-952b;			\
 	.popsection;
 
+#define SPEC_BARRIER_FIXUP_SECTION			\
+953:							\
+	.pushsection __spec_barrier_fixup,"a";		\
+	.align 2;					\
+954:							\
+	FTR_ENTRY_OFFSET 953b-954b;			\
+	.popsection;
+
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 
 extern long __start___rfi_flush_fixup, __stop___rfi_flush_fixup;
+extern long __start___spec_barrier_fixup, __stop___spec_barrier_fixup;
 
 void apply_feature_fixups(void);
 void setup_feature_keys(void);
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 469b7fdc9be4..486d02e4a310 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -49,8 +49,16 @@ enum l1d_flush_type {
 	L1D_FLUSH_MTTRIG	= 0x8,
 };
 
+/* These are bit flags */
+enum spec_barrier_type {
+	SPEC_BARRIER_NONE	= 0x1,
+	SPEC_BARRIER_ORI	= 0x2,
+};
+
 void __init setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
+void __init setup_barrier_nospec(enum spec_barrier_type, bool enable);
+void do_barrier_nospec_fixups(enum spec_barrier_type type);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index c388cc3357fa..09f21a954bfc 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -815,6 +815,10 @@ static enum l1d_flush_type enabled_flush_types;
 static void *l1d_flush_fallback_area;
 static bool no_rfi_flush;
 bool rfi_flush;
+enum spec_barrier_type powerpc_barrier_nospec;
+static enum spec_barrier_type barrier_nospec_type;
+static bool no_nospec;
+bool barrier_nospec_enabled;
 
 static int __init handle_no_rfi_flush(char *p)
 {
@@ -899,6 +903,31 @@ void __init setup_rfi_flush(enum l1d_flush_type types, bool enable)
 		rfi_flush_enable(enable);
 }
 
+void barrier_nospec_enable(bool enable)
+{
+	barrier_nospec_enabled = enable;
+
+	if (enable) {
+		powerpc_barrier_nospec = barrier_nospec_type;
+		do_barrier_nospec_fixups(powerpc_barrier_nospec);
+		on_each_cpu(do_nothing, NULL, 1);
+	} else {
+		powerpc_barrier_nospec = SPEC_BARRIER_NONE;
+		do_barrier_nospec_fixups(powerpc_barrier_nospec);
+	}
+}
+
+void __init setup_barrier_nospec(enum spec_barrier_type type, bool enable)
+{
+	if (type & SPEC_BARRIER_ORI)
+		pr_info("barrier_nospec: Using ori type flush\n");
+
+	barrier_nospec_type = type;
+
+	if (!no_nospec)
+		barrier_nospec_enable(enable);
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int rfi_flush_set(void *data, u64 val)
 {
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index c8af90ff49f0..744b58ff77f1 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -139,6 +139,13 @@ SECTIONS
 		*(__rfi_flush_fixup)
 		__stop___rfi_flush_fixup = .;
 	}
+
+	. = ALIGN(8);
+	__spec_barrier_fixup : AT(ADDR(__spec_barrier_fixup) - LOAD_OFFSET) {
+		__start___spec_barrier_fixup = .;
+		*(__spec_barrier_fixup)
+		__stop___spec_barrier_fixup = .;
+	}
 #endif
 
 	EXCEPTION_TABLE(0)
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 73697c4e3468..000e153184ad 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -155,6 +155,33 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 
 	printk(KERN_DEBUG "rfi-flush: patched %d locations\n", i);
 }
+
+void do_barrier_nospec_fixups(enum spec_barrier_type type)
+{
+	unsigned int instr, *dest;
+	long *start, *end;
+	int i;
+
+	start = PTRRELOC(&__start___spec_barrier_fixup),
+	end = PTRRELOC(&__stop___spec_barrier_fixup);
+
+	instr = 0x60000000; /* nop */
+
+	if (type == SPEC_BARRIER_ORI) {
+		pr_info("barrier_nospec: using ORI speculation barrier\n");
+		instr = 0x63ff0000; /* ori 31,31,0 speculation barrier */
+	}
+
+	for (i = 0; start < end; start++, i++) {
+		dest = (void *)start + *start;
+
+		pr_devel("patching dest %lx\n", (unsigned long)dest);
+		patch_instruction(dest, instr);
+	}
+
+	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
+}
+
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
-- 
2.13.6
