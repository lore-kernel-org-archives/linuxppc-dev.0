Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zccKL5yfzzF18D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 23:03:18 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w18BY0it091371
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Feb 2018 07:03:16 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g0jjbj82a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Feb 2018 07:03:16 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Thu, 8 Feb 2018 12:03:14 -0000
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@fb.com, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com
Subject: [RFC][PATCH bpf 2/2] bpf: powerpc64: add JIT support for
 multi-function programs
Date: Thu,  8 Feb 2018 17:33:06 +0530
In-Reply-To: <20180208120306.2568-1-sandipan@linux.vnet.ibm.com>
References: <20180208120306.2568-1-sandipan@linux.vnet.ibm.com>
Message-Id: <20180208120306.2568-2-sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds support for bpf-to-bpf function calls for the powerpc64
JIT compiler. After a round of the usual JIT passes, the offsets
to callee functions from __bpf_call_base are known. To update the
target addresses for the branch instructions associated with each
BPF_CALL, an extra pass is performed.

Since it is seen that the offsets may be as large as 64 bits for
powerpc64, we use the aux data associated with each caller to get
the correct branch target address rather than using the imm field
of the BPF_CALL instruction.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 77 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 0a34b0cec7b7..f31f22c8cb0b 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -290,7 +290,7 @@ static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32
 /* Assemble the body code between the prologue & epilogue */
 static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 			      struct codegen_context *ctx,
-			      u32 *addrs)
+			      u32 *addrs, bool extra_pass)
 {
 	const struct bpf_insn *insn = fp->insnsi;
 	int flen = fp->len;
@@ -299,6 +299,10 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 	/* Start of epilogue code - will only be valid 2nd pass onwards */
 	u32 exit_addr = addrs[flen];
 
+	/* List of callee functions - will only be valid for the extra pass */
+	struct bpf_prog **callee = fp->aux->func;
+	u32 callee_cnt = fp->aux->func_cnt, callee_idx = 0;
+
 	for (i = 0; i < flen; i++) {
 		u32 code = insn[i].code;
 		u32 dst_reg = b2p[insn[i].dst_reg];
@@ -746,11 +750,17 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 			break;
 
 		/*
-		 * Call kernel helper
+		 * Call kernel helper or bpf function
 		 */
 		case BPF_JMP | BPF_CALL:
 			ctx->seen |= SEEN_FUNC;
-			func = (u8 *) __bpf_call_base + imm;
+			if (insn[i].src_reg == BPF_PSEUDO_CALL && extra_pass)
+				if (callee && callee_idx < callee_cnt)
+					func = (u8 *) callee[callee_idx++]->bpf_func;
+				else
+					return -EINVAL;
+			else
+				func = (u8 *) __bpf_call_base + imm;
 
 			/* Save skb pointer if we need to re-cache skb data */
 			if ((ctx->seen & SEEN_SKB) &&
@@ -970,6 +980,14 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
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
@@ -977,6 +995,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	u8 *image = NULL;
 	u32 *code_base;
 	u32 *addrs;
+	struct powerpc64_jit_data *jit_data;
 	struct codegen_context cgctx;
 	int pass;
 	int flen;
@@ -984,6 +1003,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	struct bpf_prog *org_fp = fp;
 	struct bpf_prog *tmp_fp;
 	bool bpf_blinded = false;
+	bool extra_pass = false;
 
 	if (!fp->jit_requested)
 		return org_fp;
@@ -997,7 +1017,28 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
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
@@ -1010,10 +1051,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
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
@@ -1031,9 +1072,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 			bpf_jit_fill_ill_insns);
 	if (!bpf_hdr) {
 		fp = org_fp;
-		goto out;
+		goto out_addrs;
 	}
 
+skip_init_ctx:
 	code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
 
 	/* Code generation passes 1-2 */
@@ -1041,7 +1083,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		/* Now build the prologue, body code & epilogue for real. */
 		cgctx.idx = 0;
 		bpf_jit_build_prologue(code_base, &cgctx);
-		bpf_jit_build_body(fp, code_base, &cgctx, addrs);
+		bpf_jit_build_body(fp, code_base, &cgctx, addrs, extra_pass);
 		bpf_jit_build_epilogue(code_base, &cgctx);
 
 		if (bpf_jit_enable > 1)
@@ -1062,15 +1104,30 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	((u64 *)image)[1] = local_paca->kernel_toc;
 #endif
 
+	bpf_flush_icache(bpf_hdr, (u8 *)bpf_hdr + (bpf_hdr->pages * PAGE_SIZE));
+
+	if (!fp->is_func || extra_pass) {
+		bpf_jit_binary_lock_ro(bpf_hdr);
+	} else {
+		jit_data->addrs = addrs;
+		jit_data->ctx = cgctx;
+		jit_data->proglen = proglen;
+		jit_data->image = image;
+		jit_data->header = bpf_hdr;
+	}
+
 	fp->bpf_func = (void *)image;
 	fp->jited = 1;
 	fp->jited_len = alloclen;
 
-	bpf_flush_icache(bpf_hdr, (u8 *)bpf_hdr + (bpf_hdr->pages * PAGE_SIZE));
+	if (!fp->is_func || extra_pass) {
+out_addrs:
+		kfree(addrs);
+		kfree(jit_data);
+		fp->aux->jit_data = NULL;
+	}
 
 out:
-	kfree(addrs);
-
 	if (bpf_blinded)
 		bpf_jit_prog_release_other(fp, fp == org_fp ? tmp_fp : org_fp);
 
-- 
2.14.3
