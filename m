Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhsYK18W3zDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 14:12:53 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xhsYJ3mY8z9sP5
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2017 14:12:52 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 13/17] powerpc: Emulate the dcbz instruction
Date: Wed, 30 Aug 2017 14:12:36 +1000
Message-Id: <1504066360-30128-14-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
References: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds code to analyse_instr() and emulate_step() to understand the
dcbz (data cache block zero) instruction.  The emulate_dcbz() function
is made public so it can be used by the alignment handler in future.
(The apparently unnecessary cropping of the address to 32 bits is
there because it will be needed in that situation.)

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/sstep.h |  2 ++
 arch/powerpc/lib/sstep.c         | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index 474a992..793639a 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -84,6 +84,7 @@ enum instruction_type {
 #define DCBTST		0x200
 #define DCBT		0x300
 #define ICBI		0x400
+#define DCBZ		0x500
 
 /* VSX flags values */
 #define VSX_FPCONV	1	/* do floating point SP/DP conversion */
@@ -155,3 +156,4 @@ extern void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
 			     const void *mem);
 extern void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
 			      void *mem);
+extern int emulate_dcbz(unsigned long ea, struct pt_regs *regs);
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 817cdc9..fa20f3a 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -780,6 +780,30 @@ static nokprobe_inline int do_vsx_store(struct instruction_op *op,
 }
 #endif /* CONFIG_VSX */
 
+int emulate_dcbz(unsigned long ea, struct pt_regs *regs)
+{
+	int err;
+	unsigned long i, size;
+
+#ifdef __powerpc64__
+	size = ppc64_caches.l1d.block_size;
+	if (!(regs->msr & MSR_64BIT))
+		ea &= 0xffffffffUL;
+#else
+	size = L1_CACHE_BYTES;
+#endif
+	ea &= ~(size - 1);
+	if (!address_ok(regs, ea, size))
+		return -EFAULT;
+	for (i = 0; i < size; i += sizeof(long)) {
+		err = __put_user(0, (unsigned long __user *) (ea + i));
+		if (err)
+			return err;
+	}
+	return 0;
+}
+NOKPROBE_SYMBOL(emulate_dcbz);
+
 #define __put_user_asmx(x, addr, err, op, cr)		\
 	__asm__ __volatile__(				\
 		"1:	" op " %2,0,%3\n"		\
@@ -1748,6 +1772,11 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			op->type = MKOP(CACHEOP, ICBI, 0);
 			op->ea = xform_ea(instr, regs);
 			return 0;
+
+		case 1014:	/* dcbz */
+			op->type = MKOP(CACHEOP, DCBZ, 0);
+			op->ea = xform_ea(instr, regs);
+			return 0;
 		}
 		break;
 	}
@@ -2607,6 +2636,9 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 		case ICBI:
 			__cacheop_user_asmx(ea, err, "icbi");
 			break;
+		case DCBZ:
+			err = emulate_dcbz(ea, regs);
+			break;
 		}
 		if (err)
 			return 0;
-- 
2.7.4
