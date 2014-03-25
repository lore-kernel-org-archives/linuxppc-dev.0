Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 26/33] powerpc: Fix up TOC. for modules.
Date: Tue, 25 Mar 2014 22:44:32 +1100
Message-Id: <1395747879-5948-27-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rusty Russell <rusty@rustcorp.com.au>

The kernel resolved the '.TOC.' to a fake symbol, so we need to fix it up
to point to our .toc section plus 0x8000.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/include/asm/module.h |  1 +
 arch/powerpc/kernel/module_64.c   | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index 49fa55b..c9c7aaa 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -35,6 +35,7 @@ struct mod_arch_specific {
 #ifdef __powerpc64__
 	unsigned int stubs_section;	/* Index of stubs section in module */
 	unsigned int toc_section;	/* What section is the TOC? */
+	bool toc_fixed;			/* Have we fixed up .TOC.? */
 #ifdef CONFIG_DYNAMIC_FTRACE
 	unsigned long toc;
 	unsigned long tramp;
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index a8694d4..f6544d7 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -196,6 +196,24 @@ static void dedotify(Elf64_Sym *syms, unsigned int numsyms, char *strtab)
 	}
 }
 
+static Elf64_Sym *find_dot_toc(Elf64_Shdr *sechdrs,
+			       const char *strtab,
+			       unsigned int symindex)
+{
+	unsigned int i, numsyms;
+	Elf64_Sym *syms;
+
+	syms = (Elf64_Sym *)sechdrs[symindex].sh_addr;
+	numsyms = sechdrs[symindex].sh_size / sizeof(Elf64_Sym);
+
+	for (i = 1; i < numsyms; i++) {
+		if (syms[i].st_shndx == SHN_UNDEF
+		    && strcmp(strtab + syms[i].st_name, ".TOC.") == 0)
+			return &syms[i];
+	}
+	return NULL;
+}
+
 int module_frob_arch_sections(Elf64_Ehdr *hdr,
 			      Elf64_Shdr *sechdrs,
 			      char *secstrings,
@@ -337,6 +355,17 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 
 	DEBUGP("Applying ADD relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
+
+	/* First time we're called, we can fix up .TOC. */
+	if (!me->arch.toc_fixed) {
+		sym = find_dot_toc(sechdrs, strtab, symindex);
+		/* It's theoretically possible that a module doesn't want a
+		 * .TOC. so don't fail it just for that. */
+		if (sym)
+			sym->st_value = my_r2(sechdrs, me);
+		me->arch.toc_fixed = true;
+	}
+
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rela); i++) {
 		/* This is where to make the change */
 		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
-- 
1.8.3.2
