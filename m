Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 24/33] powerpc: EXPORT_SYMBOL(.TOC.)
Date: Tue, 25 Mar 2014 22:44:30 +1100
Message-Id: <1395747879-5948-25-git-send-email-anton@samba.org>
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

For the ELFv2 ABI, powerpc introduces a magic symbol ".TOC.".  depmod
then complains that this doesn't resolve (so does modpost, but we could
easily fix that).  To export this, we need to use asm.

modpost and depmod both strip "." from symbols for the old PPC64 ELFv1
ABI, so we actually export a "TOC.".

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/kernel/misc_64.S | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index bda85a1..b80fafb 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -634,3 +634,22 @@ _GLOBAL(kexec_sequence)
 	li	r5,0
 	blr	/* image->start(physid, image->start, 0); */
 #endif /* CONFIG_KEXEC */
+
+#ifdef CONFIG_MODULES
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+/*
+ * Export a fake .TOC. since both modpost and depmod will complain otherwise.
+ * Both modpost and depmod strip the leading . so we do the same here.
+ */
+.section "__ksymtab_strings","a"
+__kstrtab_TOC.:
+	.asciz "TOC."
+
+.section "___ksymtab+TOC.","a"
+/* This symbol name is important: it's used by modpost to find exported syms */
+.globl __ksymtab_TOC.
+__ksymtab_TOC.:
+	.llong 0 /* .value */
+	.llong __kstrtab_TOC.
+#endif /* ELFv2 */
+#endif /* MODULES */
-- 
1.8.3.2
