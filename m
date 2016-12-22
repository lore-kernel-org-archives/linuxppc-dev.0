Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tksSB1ZPXzDwKg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Dec 2016 00:14:34 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id y68so12493927pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 05:14:34 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64: quieten section mismatch warnings
Date: Thu, 22 Dec 2016 23:14:19 +1000
Message-Id: <20161222131419.18062-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the boot code located at the start of kernel text is "init"
class, in that it only runs at boot time, however marking it as normal
init code is problematic because that puts it into a different section
located at the very end of kernel text.

E.g., in case the TOC is not set up, we may not be able to tolerate a
branch trampoline to reach the init function.

Create a whitelist function prefix that prevents the init section
reference warnings for these cases.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

I've had enough of seeing these warnings and having my build break
when I forget to turn the non-fatal option on! Can we just hit them
on the head with a hammer?

Thanks,
Nick

 arch/powerpc/kernel/head_64.S | 14 ++++++--------
 scripts/mod/modpost.c         | 18 ++++++++++++++++--
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 1dc5eae2ced3..6be7b9f55278 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -478,7 +478,6 @@ __mmu_off:
  *   
  *   r5 == NULL -> kexec style entry. r3 is a physical pointer to the
  *                 DT block, r4 is a physical pointer to the kernel itself
- *
  */
 __start_initialization_multiplatform:
 	/* Make sure we are running in 64 bits mode */
@@ -498,7 +497,7 @@ __start_initialization_multiplatform:
 	 */
 	cmpldi	cr0,r5,0
 	beq	1f
-	b	__boot_from_prom		/* yes -> prom */
+	b	boot_initref__boot_from_prom	/* yes -> prom */
 1:
 	/* Save parameters */
 	mr	r31,r3
@@ -532,7 +531,7 @@ __start_initialization_multiplatform:
 	b	__after_prom_start
 #endif /* CONFIG_PPC_BOOK3E */
 
-__boot_from_prom:
+boot_initref__boot_from_prom:
 #ifdef CONFIG_PPC_OF_BOOT_TRAMPOLINE
 	/* Save parameters */
 	mr	r31,r3
@@ -662,7 +661,7 @@ p_end: .llong _end - copy_to_here
 	add	r5,r5,r8
 5:	bl	copy_and_flush		/* copy the rest */
 
-9:	b	start_here_multiplatform
+9:	b	boot_initref__start_here_multiplatform
 
 /*
  * Copy routine used to copy the kernel to start at physical address 0
@@ -897,7 +896,7 @@ p_toc:	.llong	__toc_start + 0x8000 - 0b
 /*
  * This is where the main kernel code starts.
  */
-start_here_multiplatform:
+boot_initref__start_here_multiplatform:
 	/* set up the TOC */
 	bl      relative_toc
 	tovirt(r2,r2)
@@ -962,7 +961,7 @@ start_here_multiplatform:
 	mr	r3,r31
 	bl	early_setup		/* also sets r13 and SPRG_PACA */
 
-	LOAD_REG_ADDR(r3, start_here_common)
+	LOAD_REG_ADDR(r3, boot_initref__start_here_common)
 	ld	r4,PACAKMSR(r13)
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
@@ -970,8 +969,7 @@ start_here_multiplatform:
 	b	.	/* prevent speculative execution */
 
 	/* This is where all platforms converge execution */
-
-start_here_common:
+boot_initref__start_here_common:
 	/* relocation is on at this point */
 	std	r1,PACAKSAVE(r13)
 
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 29c89a6bad3d..548a160b4d24 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1162,8 +1162,16 @@ static const struct sectioncheck *section_mismatch(
  *   fromsec = text section
  *   refsymname = *.constprop.*
  *
+ * Pattern 6:
+ *   powerpc64 has early boot functions that reference init, but must
+ *   remain close to architectural boot entry address.
+ *   This pattern is identified by
+ *   tosec   = init section
+ *   fromsym = boot_initref__*
+ *
  **/
-static int secref_whitelist(const struct sectioncheck *mismatch,
+static int secref_whitelist(const struct elf_info *elf,
+			    const struct sectioncheck *mismatch,
 			    const char *fromsec, const char *fromsym,
 			    const char *tosec, const char *tosym)
 {
@@ -1200,6 +1208,12 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
 	    match(fromsym, optim_symbols))
 		return 0;
 
+	/* Check for pattern 6 */
+	if (elf->hdr->e_machine == EM_PPC64)
+		if (match(tosec, init_sections) &&
+		    !strncmp(fromsym, "boot_initref__", strlen("boot_initref__")))
+			return 0;
+
 	return 1;
 }
 
@@ -1540,7 +1554,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	tosym = sym_name(elf, to);
 
 	/* check whitelist - we may ignore it */
-	if (secref_whitelist(mismatch,
+	if (secref_whitelist(elf, mismatch,
 			     fromsec, fromsym, tosec, tosym)) {
 		report_sec_mismatch(modname, mismatch,
 				    fromsec, r->r_offset, fromsym,
-- 
2.11.0
