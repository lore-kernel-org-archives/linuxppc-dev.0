Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VVPh4hM9zF1RV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 14:16:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	msuchanek@suse.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] powerpc/64s: Patch barrier_nospec in modules
Date: Tue, 24 Apr 2018 14:15:56 +1000
Message-Id: <20180424041559.32410-3-mpe@ellerman.id.au>
In-Reply-To: <20180424041559.32410-1-mpe@ellerman.id.au>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michal Suchanek <msuchanek@suse.de>

Note that unlike RFI which is patched only in kernel the nospec state
reflects settings at the time the module was loaded.

Iterating all modules and re-patching every time the settings change
is not implemented.

Based on lwsync patching.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/setup.h  |  6 ++++++
 arch/powerpc/kernel/module.c      |  6 ++++++
 arch/powerpc/lib/feature-fixups.c | 16 +++++++++++++---
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index afc7280cce3b..4335cddc1cf2 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -54,6 +54,12 @@ void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
 void do_barrier_nospec_fixups(bool enable);
 
+#ifdef CONFIG_PPC_BOOK3S_64
+void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
+#else
+static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #endif	/* _ASM_POWERPC_SETUP_H */
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 3f7ba0f5bf29..a72698cd3dd0 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -72,6 +72,12 @@ int module_finalize(const Elf_Ehdr *hdr,
 		do_feature_fixups(powerpc_firmware_features,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
+
+	sect = find_section(hdr, sechdrs, "__spec_barrier_fixup");
+	if (sect != NULL)
+		do_barrier_nospec_fixups_range(true,
+				  (void *)sect->sh_addr,
+				  (void *)sect->sh_addr + sect->sh_size);
 #endif
 
 	sect = find_section(hdr, sechdrs, "__lwsync_fixup");
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 093c1d2ea5fd..3b37529f82f8 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -163,14 +163,14 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 						: "unknown");
 }
 
-void do_barrier_nospec_fixups(bool enable)
+void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_end)
 {
 	unsigned int instr, *dest;
 	long *start, *end;
 	int i;
 
-	start = PTRRELOC(&__start___barrier_nospec_fixup),
-	end = PTRRELOC(&__stop___barrier_nospec_fixup);
+	start = fixup_start;
+	end = fixup_end;
 
 	instr = 0x60000000; /* nop */
 
@@ -189,6 +189,16 @@ void do_barrier_nospec_fixups(bool enable)
 	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
 }
 
+void do_barrier_nospec_fixups(bool enable)
+{
+	void *start, *end;
+
+	start = PTRRELOC(&__start___barrier_nospec_fixup),
+	end = PTRRELOC(&__stop___barrier_nospec_fixup);
+
+	do_barrier_nospec_fixups_range(enable, start, end);
+}
+
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
-- 
2.14.1
