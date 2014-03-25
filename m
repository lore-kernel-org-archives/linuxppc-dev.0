Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 11/33] powerpc: Add ABIv2 support to ppc_function_entry
Date: Tue, 25 Mar 2014 22:44:17 +1100
Message-Id: <1395747879-5948-12-git-send-email-anton@samba.org>
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

Skip over the well known global entry point code for ABIv2.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/code-patching.h | 40 ++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 97e02f9..37991e1 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -42,15 +42,47 @@ void __patch_exception(int exc, unsigned long addr);
 } while (0)
 #endif
 
+#define OP_RT_RA_MASK	0xffff0000UL
+#define LIS_R2		0x3c020000UL
+#define ADDIS_R2_R12	0x3c4c0000UL
+#define ADDI_R2_R2	0x38420000UL
+
 static inline unsigned long ppc_function_entry(void *func)
 {
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64)
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+	u32 *insn = func;
+
+	/*
+	 * A PPC64 ABIv2 function may have a local and a global entry
+	 * point. We need to use the local entry point when patching
+	 * functions, so identify and step over the global entry point
+	 * sequence.
+	 *
+	 * The global entry point sequence is always of the form:
+	 *
+	 * addis r2,r12,XXXX
+	 * addi  r2,r2,XXXX
+	 *
+	 * A linker optimisation may convert the addis to lis:
+	 *
+	 * lis   r2,XXXX
+	 * addi  r2,r2,XXXX
+	 */
+	if ((((*insn & OP_RT_RA_MASK) == ADDIS_R2_R12) ||
+	     ((*insn & OP_RT_RA_MASK) == LIS_R2)) &&
+	    ((*(insn+1) & OP_RT_RA_MASK) == ADDI_R2_R2))
+		return (unsigned long)(insn + 2);
+	else
+		return (unsigned long)func;
+#else
 	/*
-	 * On PPC64 the function pointer actually points to the function's
-	 * descriptor. The first entry in the descriptor is the address
-	 * of the function text.
+	 * On PPC64 ABIv1 the function pointer actually points to the
+	 * function's descriptor. The first entry in the descriptor is the
+	 * address of the function text.
 	 */
 	return ((func_descr_t *)func)->entry;
+#endif
 #else
 	return (unsigned long)func;
 #endif
-- 
1.8.3.2
