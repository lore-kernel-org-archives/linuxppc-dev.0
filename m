Date: Thu, 17 Jun 2004 22:28:56 +0200
Message-Id: <HZGZK8$667E2D7E4C025BB78A3C1CC4A4CDCE07@scarlet.be>
Subject: [PATCH] fix alignment exception for lmw, stmw, lswi, stswi, lswx, stswx
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "Stef Simoens" <stef.simoens@pi.be>
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Cc: "paulus" <paulus@samba.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch handles the exceptions when there is more than one register involved.

I tested this patch and it works, but I'm not sure my CodingStyle is OK.
Testcases are available...
The patch is also available on http://users.tijd.com/~tdn46485/linux-2.6.7-align.patch

Changes:
* Get the number of bytes and the number of registers involved
* Load/store the registers individually from/to memory

Signed-off-by: Stef Simoens <stef.simoens@pi.be>

--- linux-2.6.7/arch/ppc/kernel/align.c	2004-06-16 07:18:37.000000000 +0200
+++ linux-2.6.7-mq/arch/ppc/kernel/align.c	2004-06-17 22:13:35.000000000 +0200
@@ -17,8 +17,8 @@
 #include <asm/cache.h>

 struct aligninfo {
-	unsigned char len;
-	unsigned char flags;
+	unsigned int len;
+	unsigned int flags;
 };

 #if defined(CONFIG_4xx) || defined(CONFIG_POWER4)
@@ -30,14 +30,16 @@

 #define INVALID	{ 0, 0 }

-#define LD	1	/* load */
-#define ST	2	/* store */
-#define	SE	4	/* sign-extend value */
-#define F	8	/* to/from fp regs */
-#define U	0x10	/* update index register */
-#define M	0x20	/* multiple load/store */
-#define S	0x40	/* single-precision fp, or byte-swap value */
-#define HARD	0x80	/* string, stwcx. */
+#define LD	0x001	/* load */
+#define ST	0x002	/* store */
+#define SE	0x004	/* sign-extend value */
+#define F	0x008	/* to/from fp regs */
+#define U	0x010	/* update index register */
+#define M	0x020	/* multiple load/store */
+#define S	0x040	/* single-precision fp, or byte-swap value */
+#define STR_OP	0x080	/* string, length stored in instruction */
+#define STR_XER	0x100	/* string, length stored in XER[25-31] */
+#define HARD	0x200	/* too hard: stwcx. */

 #define DCBZ	0x5f	/* 8xx/82xx dcbz faults when cache not enabled */

@@ -88,10 +90,10 @@
 	INVALID,		/* 01 0 0101: lwax */
 	INVALID,		/* 01 0 0110 */
 	INVALID,		/* 01 0 0111 */
-	{ 0, LD+HARD },		/* 01 0 1000: lswx */
-	{ 0, LD+HARD },		/* 01 0 1001: lswi */
-	{ 0, ST+HARD },		/* 01 0 1010: stswx */
-	{ 0, ST+HARD },		/* 01 0 1011: stswi */
+	{ 4, LD+STR_XER },	/* 01 0 1000: lswx */
+	{ 4, LD+STR_OP },	/* 01 0 1001: lswi */
+	{ 4, ST+STR_XER },	/* 01 0 1010: stswx */
+	{ 4, ST+STR_OP },	/* 01 0 1011: stswi */
 	INVALID,		/* 01 0 1100 */
 	INVALID,		/* 01 0 1101 */
 	INVALID,		/* 01 0 1110 */
@@ -183,11 +185,11 @@
 int
 fix_alignment(struct pt_regs *regs)
 {
-	int instr, nb, flags;
+	int instr, nb, mb, mr, flags;
 #if defined(CONFIG_4xx) || defined(CONFIG_POWER4)
 	int opcode, f1, f2, f3;
 #endif
-	int i, t;
+	int i, j, t;
 	int reg, areg;
 	unsigned char __user *addr;
 	union {
@@ -195,7 +197,7 @@
 		float f;
 		double d;
 		unsigned char v[8];
-	} data;
+	} data[32];

 	CHECK_FULL_REGS(regs);

@@ -256,9 +258,34 @@

 	addr = (unsigned char __user *)regs->dar;

+	/* Get mb (total number of bytes to load)
+	   and mr (number of registers needed) if we're dealing with strings */
+	if (flags & M) {
+		mr = 32 - reg;
+		mb = nb * mr; /* nb = bytes per register */
+	} else if (flags & STR_OP) {
+		instr = *((unsigned int *)regs->nip);
+		mb = (instr >> 11) & 0x1f;
+		if (mb == 0)
+			mb = 32; /* mb = 32 if bits are 0 */
+		mr = mb / 4;
+		if ((mb % 4) > 0)
+			mr++;
+	} else if (flags & STR_XER) {
+		mb = regs->xer & 0x7f;
+		/* This shouldn't be 128 if XER[25-31] is 0,
+		   in that case it's actually a no-op */
+		mr = mb / 4;
+		if ((mb % 4) > 0)
+			mr++;
+	} else {
+		mb = nb;
+		mr = 1;
+	}
+
 	/* Verify the address of the operand */
 	if (user_mode(regs)) {
-		if (verify_area((flags & ST? VERIFY_WRITE: VERIFY_READ), addr, nb))
+		if (verify_area((flags & ST? VERIFY_WRITE: VERIFY_READ), addr, mb))
 			return -EFAULT;	/* bad address */
 	}

@@ -268,57 +295,74 @@
 			giveup_fpu(current);
 		preempt_enable();
 	}
-	if (flags & M)
-		return 0;		/* too hard for now */

 	/* If we read the operand, copy it in */
 	if (flags & LD) {
-		if (nb == 2) {
-			data.v[0] = data.v[1] = 0;
-			if (__get_user(data.v[2], addr)
-			    || __get_user(data.v[3], addr+1))
-				return -EFAULT;
-		} else {
-			for (i = 0; i < nb; ++i)
-				if (__get_user(data.v[i], addr+i))
+		for (j = 0; j < mr; ++j) {
+			if (nb == 2) {
+				data[j].v[0] = data[j].v[1] = 0;
+				if (__get_user(data[j].v[2], addr)
+				    || __get_user(data[j].v[3], addr+1))
 					return -EFAULT;
+			} else {
+				for (i = 0; i < nb; ++i) {
+					if ((j*4)+i < mb) {
+						if (__get_user(data[j].v[i], addr+(j*4)+i))
+							return -EFAULT;
+					} else {
+						data[j].v[i] = 0;
+					}
+				}
+			}
 		}
 	}

 	switch (flags & ~U) {
 	case LD+SE:
-		if (data.v[2] >= 0x80)
-			data.v[0] = data.v[1] = -1;
+		if (data[0].v[2] >= 0x80)
+			data[0].v[0] = data[0].v[1] = -1;
 		/* fall through */
 	case LD:
-		regs->gpr[reg] = data.l;
+		regs->gpr[reg] = data[0].l;
 		break;
 	case LD+S:
 		if (nb == 2) {
-			SWAP(data.v[2], data.v[3]);
+			SWAP(data[0].v[2], data[0].v[3]);
 		} else {
-			SWAP(data.v[0], data.v[3]);
-			SWAP(data.v[1], data.v[2]);
+			SWAP(data[0].v[0], data[0].v[3]);
+			SWAP(data[0].v[1], data[0].v[2]);
 		}
-		regs->gpr[reg] = data.l;
+		regs->gpr[reg] = data[0].l;
+		break;
+	case LD+M:
+	case LD+STR_OP:
+	case LD+STR_XER:
+		for (i = 0; i < mr; ++i)
+			regs->gpr[reg+i] = data[i].l;
 		break;
 	case ST:
-		data.l = regs->gpr[reg];
+		data[0].l = regs->gpr[reg];
 		break;
 	case ST+S:
-		data.l = regs->gpr[reg];
+		data[0].l = regs->gpr[reg];
 		if (nb == 2) {
-			SWAP(data.v[2], data.v[3]);
+			SWAP(data[0].v[2], data[0].v[3]);
 		} else {
-			SWAP(data.v[0], data.v[3]);
-			SWAP(data.v[1], data.v[2]);
+			SWAP(data[0].v[0], data[0].v[3]);
+			SWAP(data[0].v[1], data[0].v[2]);
 		}
 		break;
+	case ST+M:
+	case ST+STR_OP:
+	case ST+STR_XER:
+		for (i = 0; i < mr; ++i)
+			data[i].l = regs->gpr[reg+i];
+		break;
 	case LD+F:
-		current->thread.fpr[reg] = data.d;
+		current->thread.fpr[reg] = data[0].d;
 		break;
 	case ST+F:
-		data.d = current->thread.fpr[reg];
+		data[0].d = current->thread.fpr[reg];
 		break;
 	/* these require some floating point conversions... */
 	/* we'd like to use the assignment, but we have to compile
@@ -327,15 +371,15 @@
 	case LD+F+S:
 		preempt_disable();
 		enable_kernel_fp();
-		cvt_fd(&data.f, &current->thread.fpr[reg], &current->thread.fpscr);
-		/* current->thread.fpr[reg] = data.f; */
+		cvt_fd(&data[0].f, &current->thread.fpr[reg], &current->thread.fpscr);
+		/* current->thread.fpr[reg] = data[0].f; */
 		preempt_enable();
 		break;
 	case ST+F+S:
 		preempt_disable();
 		enable_kernel_fp();
-		cvt_df(&current->thread.fpr[reg], &data.f, &current->thread.fpscr);
-		/* data.f = current->thread.fpr[reg]; */
+		cvt_df(&current->thread.fpr[reg], &data[0].f, &current->thread.fpscr);
+		/* data[0].f = current->thread.fpr[reg]; */
 		preempt_enable();
 		break;
 	default:
@@ -344,14 +388,16 @@
 	}

 	if (flags & ST) {
-		if (nb == 2) {
-			if (__put_user(data.v[2], addr)
-			    || __put_user(data.v[3], addr+1))
-				return -EFAULT;
-		} else {
-			for (i = 0; i < nb; ++i)
-				if (__put_user(data.v[i], addr+i))
+		for (j = 0; j < mr; ++j) {
+			if (nb == 2) {
+				if (__put_user(data[j].v[2], addr)
+				    || __put_user(data[j].v[3], addr+1))
 					return -EFAULT;
+			} else {
+				for (i = 0; (i < nb) && (((j*4)+i) < mb); ++i)
+					if (__put_user(data[j].v[i], addr+(j*4)+i))
+						return -EFAULT;
+			}
 		}
 	}


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
