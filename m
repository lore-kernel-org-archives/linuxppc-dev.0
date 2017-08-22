Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcS1G2DjbzDqgQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 09:48:18 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xcS1F6GyVz9t0j
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2017 09:48:17 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC 7/7] powerpc: Handle opposite-endian processes in
 emulation code
Date: Wed, 23 Aug 2017 09:48:03 +1000
Message-Id: <1503445683-12011-8-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1503445683-12011-1-git-send-email-paulus@ozlabs.org>
References: <1503445683-12011-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds code to the load and store emulation code to byte-swap
the data appropriately when the process being emulated is set to
the opposite endianness to that of the kernel.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/sstep.h |   4 +-
 arch/powerpc/lib/sstep.c         | 146 ++++++++++++++++++++++++++++-----------
 2 files changed, 107 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index 0e5dd23..5a3d3d4 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -149,6 +149,6 @@ void emulate_update_regs(struct pt_regs *reg, struct instruction_op *op);
 extern int emulate_step(struct pt_regs *regs, unsigned int instr);
 
 extern void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
-			     const void *mem);
+			     const void *mem, bool cross_endian);
 extern void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
-			      void *mem);
+			      void *mem, bool cross_endian);
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index c05d5c4..6117c36 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -210,6 +210,33 @@ static nokprobe_inline unsigned long byterev_8(unsigned long x)
 }
 #endif
 
+static nokprobe_inline void do_byte_reverse(void *ptr, int nb)
+{
+	switch (nb) {
+	case 2:
+		*(u16 *)ptr = byterev_2(*(u16 *)ptr);
+		break;
+	case 4:
+		*(u32 *)ptr = byterev_4(*(u32 *)ptr);
+		break;
+#ifdef __powerpc64__
+	case 8:
+		*(unsigned long *)ptr = byterev_8(*(unsigned long *)ptr);
+		break;
+	case 16: {
+		unsigned long *up = (unsigned long *)ptr;
+		unsigned long tmp;
+		tmp = byterev_8(up[0]);
+		up[0] = byterev_8(up[1]);
+		up[1] = tmp;
+		break;
+	}
+#endif
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+
 static nokprobe_inline int read_mem_aligned(unsigned long *dest,
 					unsigned long ea, int nb)
 {
@@ -424,6 +451,11 @@ static int do_fp_load(int rn, unsigned long ea, int nb, struct pt_regs *regs)
 	err = copy_mem_in(u.b, ea, nb);
 	if (err)
 		return err;
+	if (unlikely((regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE))) {
+		do_byte_reverse(u.b, min(nb, 8));
+		if (nb == 16)
+			do_byte_reverse(&u.b[8], 8);
+	}
 	preempt_disable();
 	if (nb == 4)
 		conv_sp_to_dp(&u.f, &u.d[0]);
@@ -470,6 +502,11 @@ static int do_fp_store(int rn, unsigned long ea, int nb, struct pt_regs *regs)
 			u.l[1] = current->thread.TS_FPR(rn);
 	}
 	preempt_enable();
+	if (unlikely((regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE))) {
+		do_byte_reverse(u.b, min(nb, 8));
+		if (nb == 16)
+			do_byte_reverse(&u.b[8], 8);
+	}
 	return copy_mem_out(u.b, ea, nb);
 }
 NOKPROBE_SYMBOL(do_fp_store);
@@ -493,7 +530,8 @@ static nokprobe_inline int do_vec_load(int rn, unsigned long ea,
 	err = copy_mem_in(&u.b[ea & 0xf], ea, size);
 	if (err)
 		return err;
-
+	if (unlikely((regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE)))
+		do_byte_reverse(&u.b[ea & 0xf], size);
 	preempt_disable();
 	if (regs->msr & MSR_VEC)
 		put_vr(rn, &u.v);
@@ -522,6 +560,8 @@ static nokprobe_inline int do_vec_store(int rn, unsigned long ea,
 	else
 		u.v = current->thread.vr_state.vr[rn];
 	preempt_enable();
+	if (unlikely((regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE)))
+		do_byte_reverse(&u.b[ea & 0xf], size);
 	return copy_mem_out(&u.b[ea & 0xf], ea, size);
 }
 #endif /* CONFIG_ALTIVEC */
@@ -535,12 +575,15 @@ static nokprobe_inline int emulate_lq(struct pt_regs *regs, unsigned long ea,
 	if (!address_ok(regs, ea, 16))
 		return -EFAULT;
 	/* if aligned, should be atomic */
-	if ((ea & 0xf) == 0)
-		return do_lq(ea, &regs->gpr[reg]);
-
-	err = read_mem(&regs->gpr[reg + IS_LE], ea, 8, regs);
-	if (!err)
-		err = read_mem(&regs->gpr[reg + IS_BE], ea + 8, 8, regs);
+	if ((ea & 0xf) == 0) {
+		err = do_lq(ea, &regs->gpr[reg]);
+	} else {
+		err = read_mem(&regs->gpr[reg + IS_LE], ea, 8, regs);
+		if (!err)
+			err = read_mem(&regs->gpr[reg + IS_BE], ea + 8, 8, regs);
+	}
+	if (!err && unlikely((regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE)))
+		do_byte_reverse(&regs->gpr[reg], 16);
 	return err;
 }
 
@@ -548,68 +591,74 @@ static nokprobe_inline int emulate_stq(struct pt_regs *regs, unsigned long ea,
 				       int reg)
 {
 	int err;
+	unsigned long vals[2];
 
 	if (!address_ok(regs, ea, 16))
 		return -EFAULT;
+	vals[0] = regs->gpr[reg];
+	vals[1] = regs->gpr[reg + 1];
+	if (unlikely((regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE)))
+		do_byte_reverse(vals, 16);
+
 	/* if aligned, should be atomic */
 	if ((ea & 0xf) == 0)
-		return do_stq(ea, regs->gpr[reg], regs->gpr[reg + 1]);
+		return do_stq(ea, vals[0], vals[1]);
 
-	err = write_mem(regs->gpr[reg + IS_LE], ea, 8, regs);
+	err = write_mem(vals[IS_LE], ea, 8, regs);
 	if (!err)
-		err = write_mem(regs->gpr[reg + IS_BE], ea + 8, 8, regs);
+		err = write_mem(vals[IS_BE], ea + 8, 8, regs);
 	return err;
 }
 #endif /* __powerpc64 */
 
 #ifdef CONFIG_VSX
 void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
-		      const void *mem)
+		      const void *mem, bool cross_endian)
 {
 	int size, read_size;
 	int i, j;
-	union vsx_reg buf;
+	bool rev = cross_endian;
 	const unsigned int *wp;
 	const unsigned short *hp;
 	const unsigned char *bp;
 
 	size = GETSIZE(op->type);
-	buf.d[0] = buf.d[1] = 0;
+	reg->d[0] = reg->d[1] = 0;
 
 	switch (op->element_size) {
 	case 16:
 		/* whole vector; lxv[x] or lxvl[l] */
 		if (size == 0)
 			break;
-		memcpy(&buf, mem, size);
-		if (IS_LE && (op->vsx_flags & VSX_LDLEFT)) {
-			/* reverse 16 bytes */
-			unsigned long tmp;
-			tmp = byterev_8(buf.d[0]);
-			buf.d[0] = byterev_8(buf.d[1]);
-			buf.d[1] = tmp;
-		}
+		memcpy(reg, mem, size);
+		if (IS_LE && (op->vsx_flags & VSX_LDLEFT))
+			rev = !rev;
+		if (rev)
+			do_byte_reverse(reg, 16);
 		break;
 	case 8:
 		/* scalar loads, lxvd2x, lxvdsx */
 		read_size = (size >= 8) ? 8 : size;
 		i = IS_LE ? 8 : 8 - read_size;
-		memcpy(&buf.b[i], mem, read_size);
+		memcpy(&reg->b[i], mem, read_size);
+		if (rev)
+			do_byte_reverse(&reg->b[i], 8);
 		if (size < 8) {
 			if (op->type & SIGNEXT) {
 				/* size == 4 is the only case here */
-				buf.d[IS_LE] = (signed int) buf.d[IS_LE];
+				reg->d[IS_LE] = (signed int) reg->d[IS_LE];
 			} else if (op->vsx_flags & VSX_FPCONV) {
 				preempt_disable();
-				conv_sp_to_dp(&buf.fp[1 + IS_LE],
-					      &buf.dp[IS_LE]);
+				conv_sp_to_dp(&reg->fp[1 + IS_LE],
+					      &reg->dp[IS_LE]);
 				preempt_enable();
 			}
 		} else {
-			if (size == 16)
-				buf.d[IS_BE] = *(unsigned long *)(mem + 8);
-			else if (op->vsx_flags & VSX_SPLAT)
-				buf.d[IS_BE] = buf.d[IS_LE];
+			if (size == 16) {
+				unsigned long v = *(unsigned long *)(mem + 8);
+				reg->d[IS_BE] = !rev ? v : byterev_8(v);
+			} else if (op->vsx_flags & VSX_SPLAT)
+				reg->d[IS_BE] = reg->d[IS_LE];
 		}
 		break;
 	case 4:
@@ -617,13 +666,13 @@ void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
 		wp = mem;
 		for (j = 0; j < size / 4; ++j) {
 			i = IS_LE ? 3 - j : j;
-			buf.w[i] = *wp++;
+			reg->w[i] = !rev ? *wp++ : byterev_4(*wp++);
 		}
 		if (op->vsx_flags & VSX_SPLAT) {
-			u32 val = buf.w[IS_LE ? 3 : 0];
+			u32 val = reg->w[IS_LE ? 3 : 0];
 			for (; j < 4; ++j) {
 				i = IS_LE ? 3 - j : j;
-				buf.w[i] = val;
+				reg->w[i] = val;
 			}
 		}
 		break;
@@ -632,7 +681,7 @@ void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
 		hp = mem;
 		for (j = 0; j < size / 2; ++j) {
 			i = IS_LE ? 7 - j : j;
-			buf.h[i] = *hp++;
+			reg->h[i] = !rev ? *hp++ : byterev_2(*hp++);
 		}
 		break;
 	case 1:
@@ -640,20 +689,20 @@ void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
 		bp = mem;
 		for (j = 0; j < size; ++j) {
 			i = IS_LE ? 15 - j : j;
-			buf.b[i] = *bp++;
+			reg->b[i] = *bp++;
 		}
 		break;
 	}
-	*reg = buf;
 }
 EXPORT_SYMBOL_GPL(emulate_vsx_load);
 NOKPROBE_SYMBOL(emulate_vsx_load);
 
 void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
-		       void *mem)
+		       void *mem, bool cross_endian)
 {
 	int size, write_size;
 	int i, j;
+	bool rev = cross_endian;
 	union vsx_reg buf;
 	unsigned int *wp;
 	unsigned short *hp;
@@ -666,7 +715,9 @@ void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
 		/* stxv, stxvx, stxvl, stxvll */
 		if (size == 0)
 			break;
-		if (IS_LE && (op->vsx_flags & VSX_LDLEFT)) {
+		if (IS_LE && (op->vsx_flags & VSX_LDLEFT))
+			rev = !rev;
+		if (rev) {
 			/* reverse 16 bytes */
 			buf.d[0] = byterev_8(reg->d[1]);
 			buf.d[1] = byterev_8(reg->d[0]);
@@ -688,13 +739,18 @@ void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
 		memcpy(mem, &reg->b[i], write_size);
 		if (size == 16)
 			memcpy(mem + 8, &reg->d[IS_BE], 8);
+		if (unlikely(rev)) {
+			do_byte_reverse(mem, write_size);
+			if (size == 16)
+				do_byte_reverse(mem + 8, 8);
+		}
 		break;
 	case 4:
 		/* stxvw4x */
 		wp = mem;
 		for (j = 0; j < size / 4; ++j) {
 			i = IS_LE ? 3 - j : j;
-			*wp++ = reg->w[i];
+			*wp++ = !rev ? reg->w[i] : byterev_4(reg->w[i]);
 		}
 		break;
 	case 2:
@@ -702,7 +758,7 @@ void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
 		hp = mem;
 		for (j = 0; j < size / 2; ++j) {
 			i = IS_LE ? 7 - j : j;
-			*hp++ = reg->h[i];
+			*hp++ = !rev ? reg->h[i] : byterev_2(reg->h[i]);
 		}
 		break;
 	case 1:
@@ -725,11 +781,13 @@ static nokprobe_inline int do_vsx_load(struct instruction_op *op,
 	u8 mem[16];
 	union vsx_reg buf;
 	int size = GETSIZE(op->type);
+	bool cross_endian;
 
 	if (!address_ok(regs, op->ea, size) || copy_mem_in(mem, op->ea, size))
 		return -EFAULT;
+	cross_endian = (regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE);
 
-	emulate_vsx_load(op, &buf, mem);
+	emulate_vsx_load(op, &buf, mem, cross_endian);
 	preempt_disable();
 	if (reg < 32) {
 		/* FP regs + extensions */
@@ -756,9 +814,11 @@ static nokprobe_inline int do_vsx_store(struct instruction_op *op,
 	u8 mem[16];
 	union vsx_reg buf;
 	int size = GETSIZE(op->type);
+	bool cross_endian;
 
 	if (!address_ok(regs, op->ea, size))
 		return -EFAULT;
+	cross_endian = (regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE);
 
 	preempt_disable();
 	if (reg < 32) {
@@ -776,7 +836,7 @@ static nokprobe_inline int do_vsx_store(struct instruction_op *op,
 			buf.v = current->thread.vr_state.vr[reg - 32];
 	}
 	preempt_enable();
-	emulate_vsx_store(op, &buf, mem);
+	emulate_vsx_store(op, &buf, mem, cross_endian);
 	return  copy_mem_out(mem, op->ea, size);
 }
 #endif /* CONFIG_VSX */
@@ -2720,6 +2780,8 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 		if (!err) {
 			if (op.type & SIGNEXT)
 				do_signext(&regs->gpr[op.reg], size);
+			if (unlikely((regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE)))
+				op.type ^= BYTEREV;
 			if (op.type & BYTEREV)
 				do_byterev(&regs->gpr[op.reg], size);
 		}
@@ -2772,6 +2834,8 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 			err = handle_stack_update(op.ea, regs);
 			goto ldst_done;
 		}
+		if (unlikely((regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE)))
+			do_byterev(&op.val, size);
 		err = write_mem(op.val, op.ea, size, regs);
 		goto ldst_done;
 
-- 
2.7.4
