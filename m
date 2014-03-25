Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 29/33] powerpc: modules: change r2 save/restore offset for
 ELFv2 ABI.
Date: Tue, 25 Mar 2014 22:44:35 +1100
Message-Id: <1395747879-5948-30-git-send-email-anton@samba.org>
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

ELFv2 uses a different stack offset (24 vs 40) to save r2.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/kernel/module_64.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 05b27a5..8bfcf1b 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -41,6 +41,12 @@
 #define DEBUGP(fmt , ...)
 #endif
 
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+#define R2_STACK_OFFSET 24
+#else
+#define R2_STACK_OFFSET 40
+#endif
+
 /* Like PPC32, we need little trampolines to do > 24-bit jumps (into
    the kernel itself).  But on PPC64, these need to be used for every
    jump, actually, to reset r2 (TOC+0x8000). */
@@ -61,14 +67,14 @@ struct ppc64_stub_entry
    r2) into the stub. */
 static struct ppc64_stub_entry ppc64_stub =
 { .jump = {
-	0x3d820000, /* addis   r12,r2, <high> */
-	0x398c0000, /* addi    r12,r12, <low> */
+	0x3d820000,			/* addis   r12,r2, <high> */
+	0x398c0000,			/* addi    r12,r12, <low> */
 	/* Save current r2 value in magic place on the stack. */
-	0xf8410028, /* std     r2,40(r1) */
-	0xe96c0020, /* ld      r11,32(r12) */
-	0xe84c0028, /* ld      r2,40(r12) */
-	0x7d6903a6, /* mtctr   r11 */
-	0x4e800420  /* bctr */
+	0xf8410000|R2_STACK_OFFSET,	/* std     r2,R2_STACK_OFFSET(r1) */
+	0xe96c0020,			/* ld      r11,32(r12) */
+	0xe84c0028,			/* ld      r2,40(r12) */
+	0x7d6903a6,			/* mtctr   r11 */
+	0x4e800420			/* bctr */
 } };
 
 /* Count how many different 24-bit relocations (different symbol,
@@ -338,7 +344,8 @@ static int restore_r2(u32 *instruction, struct module *me)
 		       me->name, *instruction);
 		return 0;
 	}
-	*instruction = 0xe8410028;	/* ld r2,40(r1) */
+	/* ld r2,R2_STACK_OFFSET(r1) */
+	*instruction = 0xe8410000 | R2_STACK_OFFSET;
 	return 1;
 }
 
-- 
1.8.3.2
