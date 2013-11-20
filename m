Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 Ulrich.Weigand@de.ibm.com, alistair@popple.id.au
Subject: [PATCH] powerpc: Wrong DWARF CFI in the kernel vdso for little-endian
 / ELFv2
Date: Thu, 21 Nov 2013 07:38:05 +1100
Message-Id: <1384979885-22869-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>

I've finally tracked down why my CR signal-unwind test case still
fails on little-endian.  The problem turned to be that the kernel
installs a signal trampoline in the vDSO, and provides a DWARF CFI
record for that trampoline.  This CFI describes the save location
for CR:

  rsave (70, 38*RSIZE + (RSIZE - CRSIZE))

which is correct for big-endian, but points to the wrong word on
little-endian.   This is wrong no matter which ABI.

In addition, for the ELFv2 ABI, we should not only provide a CFI
record for register 70 (cr2), but for all CR fields separately.
Strictly speaking, I guess this would mean providing two separate
vDSO images, one for ELFv1 processes and one for ELFv2 processes (or
maybe playing some tricks with conditional DWARF expressions).
However, having CFI records for the other CR fields in ELFv1 is not
actually wrong, they just will be ignored.   So it seems the simplest
fix would be just to always provide CFI for all the fields.

Signed-off-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/vdso64/sigtramp.S | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vdso64/sigtramp.S b/arch/powerpc/kernel/vdso64/sigtramp.S
index 45ea281..542c6f42 100644
--- a/arch/powerpc/kernel/vdso64/sigtramp.S
+++ b/arch/powerpc/kernel/vdso64/sigtramp.S
@@ -142,6 +142,13 @@ V_FUNCTION_END(__kernel_sigtramp_rt64)
 /* Size of CR reg in DWARF unwind info. */
 #define CRSIZE	4
 
+/* Offset of CR reg within a full word. */
+#ifdef __LITTLE_ENDIAN__
+#define CROFF 0
+#else
+#define CROFF (RSIZE - CRSIZE)
+#endif
+
 /* This is the offset of the VMX reg pointer.  */
 #define VREGS	48*RSIZE+33*8
 
@@ -181,7 +188,14 @@ V_FUNCTION_END(__kernel_sigtramp_rt64)
   rsave (31, 31*RSIZE);							\
   rsave (67, 32*RSIZE);		/* ap, used as temp for nip */		\
   rsave (65, 36*RSIZE);		/* lr */				\
-  rsave (70, 38*RSIZE + (RSIZE - CRSIZE)) /* cr */
+  rsave (68, 38*RSIZE + CROFF);	/* cr fields */				\
+  rsave (69, 38*RSIZE + CROFF);						\
+  rsave (70, 38*RSIZE + CROFF);						\
+  rsave (71, 38*RSIZE + CROFF);						\
+  rsave (72, 38*RSIZE + CROFF);						\
+  rsave (73, 38*RSIZE + CROFF);						\
+  rsave (74, 38*RSIZE + CROFF);						\
+  rsave (75, 38*RSIZE + CROFF)
 
 /* Describe where the FP regs are saved.  */
 #define EH_FRAME_FP \
-- 
1.8.3.2
