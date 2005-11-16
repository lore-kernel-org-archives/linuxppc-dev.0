Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17275.44856.347629.443417@cargo.ozlabs.ibm.com>
Date: Thu, 17 Nov 2005 09:14:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1132025664.6094.47.camel@gaston>
References: <1132025664.6094.47.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Merge align.c (#2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> Since it's likely that I won't be able to test all scenario, code
> inspection is much welcome.

I think you need this patch on top...

Paul.

diff -urN powerpc/arch/powerpc/kernel/align.c merge-hack/arch/powerpc/kernel/align.c
--- powerpc/arch/powerpc/kernel/align.c	2005-11-17 09:05:04.000000000 +1100
+++ merge-hack/arch/powerpc/kernel/align.c	2005-11-17 09:06:29.000000000 +1100
@@ -198,21 +198,20 @@
 	/* bits  6:15 --> 22:31 */
 	dsisr = (instr & 0x03ff0000) >> 16;
 
-	if ( IS_XFORM(instr) ) {
+	if (IS_XFORM(instr)) {
 		/* bits 29:30 --> 15:16 */
 		dsisr |= (instr & 0x00000006) << 14;
 		/* bit     25 -->    17 */
 		dsisr |= (instr & 0x00000040) << 8;
 		/* bits 21:24 --> 18:21 */
 		dsisr |= (instr & 0x00000780) << 3;
-	}
-	else {
+	} else {
 		/* bit      5 -->    17 */
 		dsisr |= (instr & 0x04000000) >> 12;
 		/* bits  1: 4 --> 18:21 */
 		dsisr |= (instr & 0x78000000) >> 17;
 		/* bits 30:31 --> 12:13 */
-		if ( IS_DSFORM(instr) )
+		if (IS_DSFORM(instr))
 			dsisr |= (instr & 0x00000003) << 18;
 	}
 
@@ -247,13 +246,22 @@
 
 /*
  * Emulate load & store multiple instructions
+ * On 64-bit machines, these instructions only affect/use the
+ * bottom 4 bytes of each register, and the loads clear the
+ * top 4 bytes of the affected register.
  */
+#ifdef CONFIG_PPC64
+#define REG_BYTE(rp, i)		*((u8 *)((rp) + ((i) >> 2)) + ((i) & 3) + 4)
+#else
+#define REG_BYTE(rp, i)		*((u8 *)(rp) + (i))
+#endif
+
 static int emulate_multiple(struct pt_regs *regs, unsigned char __user *addr,
 			    unsigned int reg, unsigned int nb,
 			    unsigned int flags, unsigned int instr)
 {
-	unsigned char *rptr;
-	int nb0, i;
+	unsigned long *rptr;
+	unsigned int nb0, i;
 
 	/*
 	 * We do not try to emulate 8 bytes multiple as they aren't really
@@ -291,29 +299,38 @@
 	if (!access_ok((flags & ST ? VERIFY_WRITE: VERIFY_READ), addr, nb+nb0))
 		return -EFAULT;	/* bad address */
 
-	rptr = (unsigned char *) &regs->gpr[reg];
+	rptr = &regs->gpr[reg];
 	if (flags & LD) {
+		/*
+		 * This zeroes the top 4 bytes of the affected registers
+		 * in 64-bit mode, and also zeroes out any remaining
+		 * bytes of the last register for lsw*.
+		 */
+		memset(rptr, 0, ((nb + 3) / 4) * sizeof(unsigned long));
+		if (nb0 > 0)
+			memset(&regs->gpr[0], 0,
+			       ((nb0 + 3) / 4) * sizeof(unsigned long));
+
 		for (i = 0; i < nb; ++i)
-			if (__get_user(rptr[i], addr + i))
+			if (__get_user(REG_BYTE(rptr, i), addr + i))
 				return -EFAULT;
 		if (nb0 > 0) {
-			rptr = (unsigned char *) &regs->gpr[0];
+			rptr = &regs->gpr[0];
 			addr += nb;
 			for (i = 0; i < nb0; ++i)
-				if (__get_user(rptr[i], addr + i))
+				if (__get_user(REG_BYTE(rptr, i), addr + i))
 					return -EFAULT;
 		}
-		for (; (i & 3) != 0; ++i)
-			rptr[i] = 0;
+
 	} else {
 		for (i = 0; i < nb; ++i)
-			if (__put_user(rptr[i], addr + i))
+			if (__put_user(REG_BYTE(rptr, i), addr + i))
 				return -EFAULT;
 		if (nb0 > 0) {
-			rptr = (unsigned char *) &regs->gpr[0];
+			rptr = &regs->gpr[0];
 			addr += nb;
 			for (i = 0; i < nb0; ++i)
-				if (__put_user(rptr[i], addr + i))
+				if (__put_user(REG_BYTE(rptr, i), addr + i))
 					return -EFAULT;
 		}
 	}
@@ -338,7 +355,7 @@
 	unsigned char __user *p;
 	int ret, t;
 	union {
-		long ll;
+		u64 ll;
 		double dd;
 		unsigned char v[8];
 		struct {
