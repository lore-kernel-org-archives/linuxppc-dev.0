Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdrDW6LtHzDrS2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 16:02:51 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xdrDW4MKRz9t0M
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2017 16:02:51 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 09/10] powerpc: Handle opposite-endian processes in
 emulation code
Date: Fri, 25 Aug 2017 15:42:01 +1000
Message-Id: <1503639722-19121-10-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1503639722-19121-1-git-send-email-paulus@ozlabs.org>
References: <1503639722-19121-1-git-send-email-paulus@ozlabs.org>
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

This also enables the emulation for the multiple-register loads
and stores (lmw, stmw, lswi, stswi, lswx, stswx) to work for
little-endian.  In little-endian mode, the partial word at the
end of a transfer for lsw*/stsw* (when the byte count is not a
multiple of 4) is loaded/stored at the least-significant end of
the register.  Additionally, this fixes a bug in the previous
code in that it could call read_mem/write_mem with a byte count
that was not 1, 2, 4 or 8.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/sstep.h |   4 +-
 arch/powerpc/lib/sstep.c         | 202 ++++++++++++++++++++++++++-------------
 2 files changed, 135 insertions(+), 71 deletions(-)

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
index 4773055..7afb8ef 100644
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
@@ -409,7 +436,8 @@ NOKPROBE_SYMBOL(write_mem);
  * These access either the real FP register or the image in the
  * thread_struct, depending on regs->msr & MSR_FP.
  */
-static int do_fp_load(int rn, unsigned long ea, int nb, struct pt_regs *regs)
+static int do_fp_load(int rn, unsigned long ea, int nb, struct pt_regs *regs,
+		      bool cross_endian)
 {
 	int err;
 	union {
@@ -424,6 +452,11 @@ static int do_fp_load(int rn, unsigned long ea, int nb, struct pt_regs *regs)
 	err = copy_mem_in(u.b, ea, nb);
 	if (err)
 		return err;
+	if (unlikely(cross_endian)) {
+		do_byte_reverse(u.b, min(nb, 8));
+		if (nb == 16)
+			do_byte_reverse(&u.b[8], 8);
+	}
 	preempt_disable();
 	if (nb == 4)
 		conv_sp_to_dp(&u.f, &u.d[0]);
@@ -444,7 +477,8 @@ static int do_fp_load(int rn, unsigned long ea, int nb, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(do_fp_load);
 
-static int do_fp_store(int rn, unsigned long ea, int nb, struct pt_regs *regs)
+static int do_fp_store(int rn, unsigned long ea, int nb, struct pt_regs *regs,
+		       bool cross_endian)
 {
 	union {
 		float f;
@@ -470,6 +504,11 @@ static int do_fp_store(int rn, unsigned long ea, int nb, struct pt_regs *regs)
 			u.l[1] = current->thread.TS_FPR(rn);
 	}
 	preempt_enable();
+	if (unlikely(cross_endian)) {
+		do_byte_reverse(u.b, min(nb, 8));
+		if (nb == 16)
+			do_byte_reverse(&u.b[8], 8);
+	}
 	return copy_mem_out(u.b, ea, nb);
 }
 NOKPROBE_SYMBOL(do_fp_store);
@@ -478,7 +517,8 @@ NOKPROBE_SYMBOL(do_fp_store);
 #ifdef CONFIG_ALTIVEC
 /* For Altivec/VMX, no need to worry about alignment */
 static nokprobe_inline int do_vec_load(int rn, unsigned long ea,
-				       int size, struct pt_regs *regs)
+				       int size, struct pt_regs *regs,
+				       bool cross_endian)
 {
 	int err;
 	union {
@@ -493,7 +533,8 @@ static nokprobe_inline int do_vec_load(int rn, unsigned long ea,
 	err = copy_mem_in(&u.b[ea & 0xf], ea, size);
 	if (err)
 		return err;
-
+	if (unlikely(cross_endian))
+		do_byte_reverse(&u.b[ea & 0xf], size);
 	preempt_disable();
 	if (regs->msr & MSR_VEC)
 		put_vr(rn, &u.v);
@@ -504,7 +545,8 @@ static nokprobe_inline int do_vec_load(int rn, unsigned long ea,
 }
 
 static nokprobe_inline int do_vec_store(int rn, unsigned long ea,
-					int size, struct pt_regs *regs)
+					int size, struct pt_regs *regs,
+					bool cross_endian)
 {
 	union {
 		__vector128 v;
@@ -522,94 +564,105 @@ static nokprobe_inline int do_vec_store(int rn, unsigned long ea,
 	else
 		u.v = current->thread.vr_state.vr[rn];
 	preempt_enable();
+	if (unlikely(cross_endian))
+		do_byte_reverse(&u.b[ea & 0xf], size);
 	return copy_mem_out(&u.b[ea & 0xf], ea, size);
 }
 #endif /* CONFIG_ALTIVEC */
 
 #ifdef __powerpc64__
 static nokprobe_inline int emulate_lq(struct pt_regs *regs, unsigned long ea,
-				      int reg)
+				      int reg, bool cross_endian)
 {
 	int err;
 
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
+	if (!err && unlikely(cross_endian))
+		do_byte_reverse(&regs->gpr[reg], 16);
 	return err;
 }
 
 static nokprobe_inline int emulate_stq(struct pt_regs *regs, unsigned long ea,
-				       int reg)
+				       int reg, bool cross_endian)
 {
 	int err;
+	unsigned long vals[2];
 
 	if (!address_ok(regs, ea, 16))
 		return -EFAULT;
+	vals[0] = regs->gpr[reg];
+	vals[1] = regs->gpr[reg + 1];
+	if (unlikely(cross_endian))
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
@@ -617,13 +670,13 @@ void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
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
@@ -632,7 +685,7 @@ void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
 		hp = mem;
 		for (j = 0; j < size / 2; ++j) {
 			i = IS_LE ? 7 - j : j;
-			buf.h[i] = *hp++;
+			reg->h[i] = !rev ? *hp++ : byterev_2(*hp++);
 		}
 		break;
 	case 1:
@@ -640,20 +693,20 @@ void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
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
@@ -666,7 +719,9 @@ void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
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
@@ -688,13 +743,18 @@ void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
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
@@ -702,7 +762,7 @@ void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
 		hp = mem;
 		for (j = 0; j < size / 2; ++j) {
 			i = IS_LE ? 7 - j : j;
-			*hp++ = reg->h[i];
+			*hp++ = !rev ? reg->h[i] : byterev_2(reg->h[i]);
 		}
 		break;
 	case 1:
@@ -719,7 +779,7 @@ EXPORT_SYMBOL_GPL(emulate_vsx_store);
 NOKPROBE_SYMBOL(emulate_vsx_store);
 
 static nokprobe_inline int do_vsx_load(struct instruction_op *op,
-				       struct pt_regs *regs)
+				       struct pt_regs *regs, bool cross_endian)
 {
 	int reg = op->reg;
 	u8 mem[16];
@@ -729,7 +789,7 @@ static nokprobe_inline int do_vsx_load(struct instruction_op *op,
 	if (!address_ok(regs, op->ea, size) || copy_mem_in(mem, op->ea, size))
 		return -EFAULT;
 
-	emulate_vsx_load(op, &buf, mem);
+	emulate_vsx_load(op, &buf, mem, cross_endian);
 	preempt_disable();
 	if (reg < 32) {
 		/* FP regs + extensions */
@@ -750,7 +810,7 @@ static nokprobe_inline int do_vsx_load(struct instruction_op *op,
 }
 
 static nokprobe_inline int do_vsx_store(struct instruction_op *op,
-					struct pt_regs *regs)
+					struct pt_regs *regs, bool cross_endian)
 {
 	int reg = op->reg;
 	u8 mem[16];
@@ -776,7 +836,7 @@ static nokprobe_inline int do_vsx_store(struct instruction_op *op,
 			buf.v = current->thread.vr_state.vr[reg - 32];
 	}
 	preempt_enable();
-	emulate_vsx_store(op, &buf, mem);
+	emulate_vsx_store(op, &buf, mem, cross_endian);
 	return  copy_mem_out(mem, op->ea, size);
 }
 #endif /* CONFIG_VSX */
@@ -2731,6 +2791,7 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 	unsigned long val;
 	unsigned int cr;
 	int i, rd, nb;
+	bool cross_endian;
 
 	r = analyse_instr(&op, regs, instr);
 	if (r < 0)
@@ -2742,6 +2803,7 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 
 	err = 0;
 	size = GETSIZE(op.type);
+	cross_endian = (regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE);
 	switch (op.type & INSTR_TYPE_MASK) {
 	case CACHEOP:
 		if (!address_ok(regs, op.ea, 8))
@@ -2841,7 +2903,7 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 	case LOAD:
 #ifdef __powerpc64__
 		if (size == 16) {
-			err = emulate_lq(regs, op.ea, op.reg);
+			err = emulate_lq(regs, op.ea, op.reg, cross_endian);
 			goto ldst_done;
 		}
 #endif
@@ -2849,39 +2911,40 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 		if (!err) {
 			if (op.type & SIGNEXT)
 				do_signext(&regs->gpr[op.reg], size);
-			if (op.type & BYTEREV)
+			if ((op.type & BYTEREV) == (cross_endian ? 0 : BYTEREV))
 				do_byterev(&regs->gpr[op.reg], size);
 		}
 		goto ldst_done;
 
 #ifdef CONFIG_PPC_FPU
 	case LOAD_FP:
-		err = do_fp_load(op.reg, op.ea, size, regs);
+		err = do_fp_load(op.reg, op.ea, size, regs, cross_endian);
 		goto ldst_done;
 #endif
 #ifdef CONFIG_ALTIVEC
 	case LOAD_VMX:
-		err = do_vec_load(op.reg, op.ea, size, regs);
+		err = do_vec_load(op.reg, op.ea, size, regs, cross_endian);
 		goto ldst_done;
 #endif
 #ifdef CONFIG_VSX
 	case LOAD_VSX:
-		err = do_vsx_load(&op, regs);
+		err = do_vsx_load(&op, regs, cross_endian);
 		goto ldst_done;
 #endif
 	case LOAD_MULTI:
-		if (regs->msr & MSR_LE)
-			return 0;
 		rd = op.reg;
 		for (i = 0; i < size; i += 4) {
+			unsigned int v32 = 0;
+
 			nb = size - i;
 			if (nb > 4)
 				nb = 4;
-			err = read_mem(&regs->gpr[rd], op.ea, nb, regs);
+			err = copy_mem_in((u8 *) &v32, op.ea, nb);
 			if (err)
 				return 0;
-			if (nb < 4)	/* left-justify last bytes */
-				regs->gpr[rd] <<= 32 - 8 * nb;
+			if (unlikely(cross_endian))
+				v32 = byterev_4(v32);
+			regs->gpr[rd] = v32;
 			op.ea += 4;
 			++rd;
 		}
@@ -2890,7 +2953,7 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 	case STORE:
 #ifdef __powerpc64__
 		if (size == 16) {
-			err = emulate_stq(regs, op.ea, op.reg);
+			err = emulate_stq(regs, op.ea, op.reg, cross_endian);
 			goto ldst_done;
 		}
 #endif
@@ -2901,36 +2964,37 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 			err = handle_stack_update(op.ea, regs);
 			goto ldst_done;
 		}
+		if (unlikely(cross_endian))
+			do_byterev(&op.val, size);
 		err = write_mem(op.val, op.ea, size, regs);
 		goto ldst_done;
 
 #ifdef CONFIG_PPC_FPU
 	case STORE_FP:
-		err = do_fp_store(op.reg, op.ea, size, regs);
+		err = do_fp_store(op.reg, op.ea, size, regs, cross_endian);
 		goto ldst_done;
 #endif
 #ifdef CONFIG_ALTIVEC
 	case STORE_VMX:
-		err = do_vec_store(op.reg, op.ea, size, regs);
+		err = do_vec_store(op.reg, op.ea, size, regs, cross_endian);
 		goto ldst_done;
 #endif
 #ifdef CONFIG_VSX
 	case STORE_VSX:
-		err = do_vsx_store(&op, regs);
+		err = do_vsx_store(&op, regs, cross_endian);
 		goto ldst_done;
 #endif
 	case STORE_MULTI:
-		if (regs->msr & MSR_LE)
-			return 0;
 		rd = op.reg;
 		for (i = 0; i < size; i += 4) {
-			val = regs->gpr[rd];
+			unsigned int v32 = regs->gpr[rd];
+
 			nb = size - i;
 			if (nb > 4)
 				nb = 4;
-			else
-				val >>= 32 - 8 * nb;
-			err = write_mem(val, op.ea, nb, regs);
+			if (unlikely(cross_endian))
+				v32 = byterev_4(v32);
+			err = copy_mem_out((u8 *) &v32, op.ea, nb);
 			if (err)
 				return 0;
 			op.ea += 4;
-- 
2.7.4
