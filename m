Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s0Yh5XyJzF1Hr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 16:57:12 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4O6sIeX058991
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 02:57:09 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j5ny7p8c0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 02:57:09 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Thu, 24 May 2018 07:57:07 +0100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com, jakub.kicinski@netronome.com
Subject: [PATCH bpf-next v4 03/10] bpf: powerpc64: add JIT support for
 multi-function programs
Date: Thu, 24 May 2018 12:26:47 +0530
In-Reply-To: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
In-Reply-To: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527143877.git.sandipan@linux.vnet.ibm.com>
Message-Id: <276195c876926b3d431b35877bb81a418167bc60.1527143877.git.sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds support for bpf-to-bpf function calls in the powerpc64
JIT compiler. The JIT compiler converts the bpf call instructions
to native branch instructions. After a round of the usual passes,
the start addresses of the JITed images for the callee functions
are known. Finally, to fixup the branch target addresses, we need
to perform an extra pass.

Because of the address range in which JITed images are allocated
on powerpc64, the offsets of the start addresses of these images
from __bpf_call_base are as large as 64 bits. So, for a function
call, we cannot use the imm field of the instruction to determine
the callee's address. Instead, we use the alternative method of
getting it from the list of function addresses in the auxiliary
data of the caller by using the off field as an index.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
v3:
 - Fix memory leak for jit_data when we fail to allocated addrs.
 - Remove unnecessary bpf_jit_binary_lock_ro() call.
---
 arch/powerpc/net/bpf_jit_comp64.c | 76 +++++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index e4582744a31d..f1c95779843b 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -268,7 +268,7 @@ static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32
 /* Assemble the body code between the prologue & epilogue */
 static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 			      struct codegen_context *ctx,
-			      u32 *addrs)
+			      u32 *addrs, bool extra_pass)
 {
 	const struct bpf_insn *insn = fp->insnsi;
 	int flen = fp->len;
@@ -724,11 +724,25 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 			break;
 
 		/*
-		 * Call kernel helper
+		 * Call kernel helper or bpf function
 		 */
 		case BPF_JMP | BPF_CALL:
 			ctx->seen |= SEEN_FUNC;
-			func = (u8 *) __bpf_call_base + imm;
+
+			/* bpf function call */
+			if (insn[i].src_reg == BPF_PSEUDO_CALL)
+				if (!extra_pass)
+					func = NULL;
+				else if (fp->aux->func && off < fp->aux->func_cnt)
+					/* use the subprog id from the off
+					 * field to lookup the callee address
+					 */
+					func = (u8 *) fp->aux->func[off]->bpf_func;
+				else
+					return -EINVAL;
+			/* kernel helper call */
+			else
+				func = (u8 *) __bpf_call_base + imm;
 
 			bpf_jit_emit_func_call(image, ctx, (u64)func);
 
@@ -876,6 +890,14 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 	return 0;
 }
 
+struct powerpc64_jit_data {
+	struct bpf_binary_header *header;
+	u32 *addrs;
+	u8 *image;
+	u32 proglen;
+	struct codegen_context ctx;
+};
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 {
 	u32 proglen;
@@ -883,6 +905,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	u8 *image = NULL;
 	u32 *code_base;
 	u32 *addrs;
+	struct powerpc64_jit_data *jit_data;
 	struct codegen_context cgctx;
 	int pass;
 	int flen;
@@ -890,6 +913,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	struct bpf_prog *org_fp = fp;
 	struct bpf_prog *tmp_fp;
 	bool bpf_blinded = false;
+	bool extra_pass = false;
 
 	if (!fp->jit_requested)
 		return org_fp;
@@ -903,11 +927,32 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		fp = tmp_fp;
 	}
 
+	jit_data = fp->aux->jit_data;
+	if (!jit_data) {
+		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
+		if (!jit_data) {
+			fp = org_fp;
+			goto out;
+		}
+		fp->aux->jit_data = jit_data;
+	}
+
 	flen = fp->len;
+	addrs = jit_data->addrs;
+	if (addrs) {
+		cgctx = jit_data->ctx;
+		image = jit_data->image;
+		bpf_hdr = jit_data->header;
+		proglen = jit_data->proglen;
+		alloclen = proglen + FUNCTION_DESCR_SIZE;
+		extra_pass = true;
+		goto skip_init_ctx;
+	}
+
 	addrs = kzalloc((flen+1) * sizeof(*addrs), GFP_KERNEL);
 	if (addrs == NULL) {
 		fp = org_fp;
-		goto out;
+		goto out_addrs;
 	}
 
 	memset(&cgctx, 0, sizeof(struct codegen_context));
@@ -916,10 +961,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
 
 	/* Scouting faux-generate pass 0 */
-	if (bpf_jit_build_body(fp, 0, &cgctx, addrs)) {
+	if (bpf_jit_build_body(fp, 0, &cgctx, addrs, false)) {
 		/* We hit something illegal or unsupported. */
 		fp = org_fp;
-		goto out;
+		goto out_addrs;
 	}
 
 	/*
@@ -937,9 +982,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 			bpf_jit_fill_ill_insns);
 	if (!bpf_hdr) {
 		fp = org_fp;
-		goto out;
+		goto out_addrs;
 	}
 
+skip_init_ctx:
 	code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
 
 	/* Code generation passes 1-2 */
@@ -947,7 +993,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		/* Now build the prologue, body code & epilogue for real. */
 		cgctx.idx = 0;
 		bpf_jit_build_prologue(code_base, &cgctx);
-		bpf_jit_build_body(fp, code_base, &cgctx, addrs);
+		bpf_jit_build_body(fp, code_base, &cgctx, addrs, extra_pass);
 		bpf_jit_build_epilogue(code_base, &cgctx);
 
 		if (bpf_jit_enable > 1)
@@ -973,10 +1019,20 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	fp->jited_len = alloclen;
 
 	bpf_flush_icache(bpf_hdr, (u8 *)bpf_hdr + (bpf_hdr->pages * PAGE_SIZE));
+	if (!fp->is_func || extra_pass) {
+out_addrs:
+		kfree(addrs);
+		kfree(jit_data);
+		fp->aux->jit_data = NULL;
+	} else {
+		jit_data->addrs = addrs;
+		jit_data->ctx = cgctx;
+		jit_data->proglen = proglen;
+		jit_data->image = image;
+		jit_data->header = bpf_hdr;
+	}
 
 out:
-	kfree(addrs);
-
 	if (bpf_blinded)
 		bpf_jit_prog_release_other(fp, fp == org_fp ? tmp_fp : org_fp);
 
-- 
2.14.3
