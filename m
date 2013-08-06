Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 53/63] powerpc: Handle VSX alignment faults in little endian
 mode
Date: Wed,  7 Aug 2013 02:02:10 +1000
Message-Id: <1375804940-22050-54-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Things are complicated by the fact that VSX elements are big
endian ordered even in little endian mode. 8 byte loads and
stores also write to the top 8 bytes of the register.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/align.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 0a1a8f2..033d04a 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -630,7 +630,7 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 }
 #endif /* CONFIG_SPE */
 
-#if defined(CONFIG_VSX) && defined(__BIG_ENDIAN__)
+#ifdef CONFIG_VSX
 /*
  * Emulate VSX instructions...
  */
@@ -654,8 +654,25 @@ static int emulate_vsx(unsigned char __user *addr, unsigned int reg,
 
 	lptr = (unsigned long *) ptr;
 
+#ifdef __LITTLE_ENDIAN__
+	if (flags & SW) {
+		elsize = length;
+		sw = length-1;
+	} else {
+		/*
+		 * The elements are BE ordered, even in LE mode, so process
+		 * them in reverse order.
+		 */
+		addr += length - elsize;
+
+		/* 8 byte memory accesses go in the top 8 bytes of the VR */
+		if (length == 8)
+			ptr += 8;
+	}
+#else
 	if (flags & SW)
 		sw = elsize-1;
+#endif
 
 	for (j = 0; j < length; j += elsize) {
 		for (i = 0; i < elsize; ++i) {
@@ -665,19 +682,31 @@ static int emulate_vsx(unsigned char __user *addr, unsigned int reg,
 				ret |= __get_user(ptr[i^sw], addr + i);
 		}
 		ptr  += elsize;
+#ifdef __LITTLE_ENDIAN__
+		addr -= elsize;
+#else
 		addr += elsize;
+#endif
 	}
 
+#ifdef __BIG_ENDIAN__
+#define VSX_HI 0
+#define VSX_LO 1
+#else
+#define VSX_HI 1
+#define VSX_LO 0
+#endif
+
 	if (!ret) {
 		if (flags & U)
 			regs->gpr[areg] = regs->dar;
 
 		/* Splat load copies the same data to top and bottom 8 bytes */
 		if (flags & SPLT)
-			lptr[1] = lptr[0];
-		/* For 8 byte loads, zero the top 8 bytes */
+			lptr[VSX_LO] = lptr[VSX_HI];
+		/* For 8 byte loads, zero the low 8 bytes */
 		else if (!(flags & ST) && (8 == length))
-			lptr[1] = 0;
+			lptr[VSX_LO] = 0;
 	} else
 		return -EFAULT;
 
@@ -801,7 +830,6 @@ int fix_alignment(struct pt_regs *regs)
 	/* DAR has the operand effective address */
 	addr = (unsigned char __user *)regs->dar;
 
-#ifdef __BIG_ENDIAN__
 #ifdef CONFIG_VSX
 	if ((instruction & 0xfc00003e) == 0x7c000018) {
 		unsigned int elsize;
@@ -836,9 +864,6 @@ int fix_alignment(struct pt_regs *regs)
 		return emulate_vsx(addr, reg, areg, regs, flags, nb, elsize);
 	}
 #endif
-#else
-	return -EFAULT;
-#endif
 	/* A size of 0 indicates an instruction we don't support, with
 	 * the exception of DCBZ which is handled as a special case here
 	 */
-- 
1.8.1.2
