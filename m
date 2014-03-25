Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 31/33] powerpc: modules: skip r2 setup for ELFv2
Date: Tue, 25 Mar 2014 22:44:37 +1100
Message-Id: <1395747879-5948-32-git-send-email-anton@samba.org>
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

ELFv2 doesn't need to set up r2 when calling a function.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/kernel/module_64.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index f8b6d28..d722249 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -59,12 +59,19 @@ struct ppc64_stub_entry
 	struct ppc64_opd_entry opd;
 };
 
-/* We use a stub to fix up r2 (TOC ptr) and to jump to the (external)
-   function which may be more than 24-bits away.  We could simply
-   patch the new r2 value and function pointer into the stub, but it's
-   significantly shorter to put these values at the end of the stub
-   code, and patch the stub address (32-bits relative to the TOC ptr,
-   r2) into the stub. */
+/*
+ * PPC64 uses 24 bit jumps, but we need to jump into other modules or
+ * the kernel which may be further.  So we jump to a stub.
+ *
+ * For ELFv1 we need to use this to set up the new r2 value (aka TOC
+ * pointer).  For ELFv2 it's the callee's responsibility to set up the
+ * new r2, but for both we need to save the old r2.
+ *
+ * We could simply patch the new r2 value and function pointer into
+ * the stub, but it's significantly shorter to put these values at the
+ * end of the stub code, and patch the stub address (32-bits relative
+ * to the TOC ptr, r2) into the stub.
+ */
 static struct ppc64_stub_entry ppc64_stub =
 { .jump = {
 	0x3d620000,			/* addis   r11,r2, <high> */
@@ -72,7 +79,10 @@ static struct ppc64_stub_entry ppc64_stub =
 	/* Save current r2 value in magic place on the stack. */
 	0xf8410000|R2_STACK_OFFSET,	/* std     r2,R2_STACK_OFFSET(r1) */
 	0xe98b0020,			/* ld      r12,32(r11) */
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
+	/* Set up new r2 from function descriptor */
 	0xe84b0026,			/* ld      r2,40(r11) */
+#endif
 	0x7d8903a6,			/* mtctr   r12 */
 	0x4e800420			/* bctr */
 } };
-- 
1.8.3.2
