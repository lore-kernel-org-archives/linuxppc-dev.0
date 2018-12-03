Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F85C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 12:24:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA72A20878
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 12:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA72A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437kh22nByzDqQf
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:24:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sandipan@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437kcc5pB5zDqN8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2018 23:21:20 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB3CEhGA124342
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Dec 2018 07:21:15 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p535k4773-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 07:21:15 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Mon, 3 Dec 2018 12:21:09 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 3 Dec 2018 12:21:07 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB3CL6Wx35455176
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Dec 2018 12:21:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51161A405B;
 Mon,  3 Dec 2018 12:21:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23202A405F;
 Mon,  3 Dec 2018 12:21:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.195.22.129])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  3 Dec 2018 12:21:04 +0000 (GMT)
From: Sandipan Das <sandipan@linux.ibm.com>
To: daniel@iogearbox.net, ast@kernel.org
Subject: [PATCH bpf] bpf: powerpc64: optimize JIT passes for bpf function calls
Date: Mon,  3 Dec 2018 17:51:04 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 18120312-0008-0000-0000-0000029C21C7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120312-0009-0000-0000-000022067A4A
Message-Id: <20181203122104.6746-1-sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030117
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Once the JITed images for each function in a multi-function program
are generated after the first three JIT passes, we only need to fix
the target address for the branch instruction corresponding to each
bpf-to-bpf function call.

This introduces the following optimizations for reducing the work
done by the JIT compiler when handling multi-function programs:

  [1] Instead of doing two extra passes to fix the bpf function calls,
      do just one as that would be sufficient.

  [2] During the extra pass, only overwrite the instruction sequences
      for the bpf-to-bpf function calls as everything else would still
      remain exactly the same. This also reduces the number of writes
      to the JITed image.

  [3] Do not regenerate the prologue and the epilogue during the extra
      pass as that would be redundant.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 66 +++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 17482f5de3e2..9393e231cbc2 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -891,6 +891,55 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 	return 0;
 }
 
+/* Fix the branch target addresses for subprog calls */
+static int bpf_jit_fixup_subprog_calls(struct bpf_prog *fp, u32 *image,
+				       struct codegen_context *ctx, u32 *addrs)
+{
+	const struct bpf_insn *insn = fp->insnsi;
+	bool func_addr_fixed;
+	u64 func_addr;
+	u32 tmp_idx;
+	int i, ret;
+
+	for (i = 0; i < fp->len; i++) {
+		/*
+		 * During the extra pass, only the branch target addresses for
+		 * the subprog calls need to be fixed. All other instructions
+		 * can left untouched.
+		 *
+		 * The JITed image length does not change because we already
+		 * ensure that the JITed instruction sequence for these calls
+		 * are of fixed length by padding them with NOPs.
+		 */
+		if (insn[i].code == (BPF_JMP | BPF_CALL) &&
+		    insn[i].src_reg == BPF_PSEUDO_CALL) {
+			ret = bpf_jit_get_func_addr(fp, &insn[i], true,
+						    &func_addr,
+						    &func_addr_fixed);
+			if (ret < 0)
+				return ret;
+
+			/*
+			 * Save ctx->idx as this would currently point to the
+			 * end of the JITed image and set it to the offset of
+			 * the instruction sequence corresponding to the
+			 * subprog call temporarily.
+			 */
+			tmp_idx = ctx->idx;
+			ctx->idx = addrs[i] / 4;
+			bpf_jit_emit_func_call_rel(image, ctx, func_addr);
+
+			/*
+			 * Restore ctx->idx here. This is safe as the length
+			 * of the JITed sequence remains unchanged.
+			 */
+			ctx->idx = tmp_idx;
+		}
+	}
+
+	return 0;
+}
+
 struct powerpc64_jit_data {
 	struct bpf_binary_header *header;
 	u32 *addrs;
@@ -989,6 +1038,22 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 skip_init_ctx:
 	code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
 
+	if (extra_pass) {
+		/*
+		 * Do not touch the prologue and epilogue as they will remain
+		 * unchanged. Only fix the branch target address for subprog
+		 * calls in the body.
+		 *
+		 * This does not change the offsets and lengths of the subprog
+		 * call instruction sequences and hence, the size of the JITed
+		 * image as well.
+		 */
+		bpf_jit_fixup_subprog_calls(fp, code_base, &cgctx, addrs);
+
+		/* There is no need to perform the usual passes. */
+		goto skip_codegen_passes;
+	}
+
 	/* Code generation passes 1-2 */
 	for (pass = 1; pass < 3; pass++) {
 		/* Now build the prologue, body code & epilogue for real. */
@@ -1002,6 +1067,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 				proglen - (cgctx.idx * 4), cgctx.seen);
 	}
 
+skip_codegen_passes:
 	if (bpf_jit_enable > 1)
 		/*
 		 * Note that we output the base address of the code_base
-- 
2.17.2

