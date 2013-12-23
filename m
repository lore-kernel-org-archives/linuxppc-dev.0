Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B291F2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 12:24:54 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc: Add relocation code for fixups
Date: Mon, 23 Dec 2013 02:24:43 +0100
Message-Id: <1387761885-39599-3-git-send-email-agraf@suse.de>
In-Reply-To: <1387761885-39599-1-git-send-email-agraf@suse.de>
References: <1387761885-39599-1-git-send-email-agraf@suse.de>
Cc: Dinar Valeev <dvaleev@suse.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to patch an instruction that is covered by the fixup
framework. If we don't do anything about it we end up getting
our own patched instruction unpatched by nops by the fixups.

So add an export to the fixup code that allows us to tell it
that an instruction moved location in memory. This works because
we move the instruction into a different location, but still
execute it.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/cputable.h |  2 ++
 arch/powerpc/lib/feature-fixups.c   | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 0d4939b..c981f99 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -99,6 +99,8 @@ extern unsigned int __start___ftr_fixup, __stop___ftr_fixup;
 extern struct cpu_spec *identify_cpu(unsigned long offset, unsigned int pvr);
 extern void do_feature_fixups(unsigned long value, void *fixup_start,
 			      void *fixup_end);
+extern void relocate_fixup_entry(void *fixup_start, void *fixup_end,
+				 void *old_addr, void *new_addr);
 
 extern const char *powerpc_base_platform;
 
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 7a8a748..33996a4 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -151,6 +151,28 @@ void do_final_fixups(void)
 #endif
 }
 
+/*
+ * This changes the internal fixup location of a code block from
+ * old_addr to new_addr.
+ */
+void relocate_fixup_entry(void *fixup_start, void *fixup_end,
+			  void *old_addr, void *new_addr)
+{
+	struct fixup_entry *fcur, *fend;
+
+	fcur = fixup_start;
+	fend = fixup_end;
+
+	for (; fcur < fend; fcur++) {
+		long diff = (long)new_addr -
+			    (long)calc_addr(fcur, fcur->start_off);
+		if (calc_addr(fcur, fcur->start_off) == old_addr) {
+			fcur->start_off += diff;
+			fcur->end_off += diff;
+		}
+	}
+}
+
 #ifdef CONFIG_FTR_FIXUP_SELFTEST
 
 #define check(x)	\
-- 
1.8.1.4
