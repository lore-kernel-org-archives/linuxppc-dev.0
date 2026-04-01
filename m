Return-Path: <linuxppc-dev+bounces-19122-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430601076372
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 06:32:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flwCP6KFPz2ySY;
	Wed, 01 Apr 2026 17:32:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775025169;
	cv=none; b=OKBeRhmHtI3J//kvrhVJK8dBrM4cHqpc2vBX4PfxCtlQTWXAQ1SWaX4fpGerQomS1l/ppsHJeoaTPPkKDDms3kGtfIQ/lIc1KFEUGaWjiV4XLr7PlF0OJw/ogu/fle8WMTZMRH2oPGFfuEk4+6ZaOMLDpUcdsR1ATNrRHfKGlOKFbWBbQ+BOW1ELFechVAL3X4R4aKUlz5PLs8tDpjiJhsewdct3fPK/Qlmra0jQpkraCfP/A6lP8p8mKqNWwpfNKwqiOP4zjpySPOs6HvISWSdyXQXfaFKX4cGVnuW5tfmyQRKg2Gy/Nuj2I3BX2VP0yw4LL6Sk+/plPniZXeTb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775025169; c=relaxed/relaxed;
	bh=Ht5y3I7lUy2pHx2eUv287Am35xnFtXoqqFDjibAg8O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4KHwWrVV26kta/Y5AJVCD2yhARJd0jzGhMDGJCCtoOAVnmD55kNaOoZIsenMPwI4FX1nws813xF7RRq28t34FYddTkGPPUY8kYav08UGINqCwyJVGFkBBiWYa5LW0IqP1PwdhRRBsiX4p2K15/QV7X5Cnb0AGW0NF8k/VWo+mP2IeiW5yRzJ1pZuyNQuByv/7umbZoYiQjqQFrvCk+Ogvsism2P4tLSM7+2SdAuaRf4lehHJExPxXcbqsuncLwWOPLjB52gp8kI9bbMaDN3X3U6Om5fjYDFcKqWOoTcqSYnV/yuUaM5WStmK35WtM4UTipHJI2vNNzoKkpR+fhC8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fFOCfr3u; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fFOCfr3u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flwCN35RDz2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 17:32:47 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VIY8c44187356;
	Wed, 1 Apr 2026 06:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ht5y3I7lUy2pHx2eUv287Am35xnFtXoqqFDjibAg8
	O0=; b=fFOCfr3uFvTEP1HLXiTjDVBfoZu89i38X4cqHxAY6hINu83sYLSs1Y2wL
	JOWMVKCCJSn21DhVbHrCTIaSRSF2DvW4RDjjhctrX7Dr4+iWEOXPBqP+UMAmzG/8
	s7+57zdNDo/T662py5WpkGrsDwzHZ79S363H2u+f1faIscldvibBOWwwB0p6Xtpz
	DzhX0tmSEFmSIHIxJMn91JEhHorggsegjibg1NvUWO830vg+Ilmac8IsXO8ERJeV
	x07XKcy6XrK+DJEGgHYbKJTrPpsRF1cfKRsVaLIdlK0JFfS2nRuabMmfNVLFvKyX
	fvtTKCq81Gm+cCHkd6I5+PaxqG3nw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms644c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 06:32:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63168efs006362;
	Wed, 1 Apr 2026 06:32:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy4g7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 06:32:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6316WR8A51904968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 06:32:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3897C2004B;
	Wed,  1 Apr 2026 06:32:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E8942004D;
	Wed,  1 Apr 2026 06:32:25 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 06:32:25 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v7 1/2] powerpc64/bpf: Implement JIT support for private stack
Date: Wed,  1 Apr 2026 06:32:14 -0400
Message-ID: <20260401103215.104438-1-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ccbbff cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=A8mRDSlWM7J1pTn1j8wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA1MyBTYWx0ZWRfX1aLs8KzBjDOZ
 Q5ORE1oKKvSfufb7QPuA3qklDcdgbqZnFchbeCK+bFzVm2f1flQShm4Xw1S2EqabJyGKdetM+Uz
 DI0dExDhg7ka401iHBHBQZLSUyHhys8m9YsERhY1K8yw45EUqUptmGejLo7cxRivAwEp8Ktxgas
 mTrVLST9iYqEtrKCm76qcuxEYp/pwWe6C57bP3sPCAM4Z3S7bho5aaso8BafVREqgORAswd0Ou/
 f/VHFCCVoS1ACatluX83OrvsAMzGnbt9AtxZAblepDhlf7dXfdyXLwoqilpR4/JiaLRFkoc+dYw
 d4TobMwX3f6VjJI5BHap80VkKlp/Hc6yIToDMlmesy8q3QEqb7jfhiS5lSzoOKnHR9WOxWOBVv4
 zMzEgTslCiL2grEkbfhvh6SHykuPIhSAiwJDoxvVm5eCkPi7Aet/1veVHfB17X3kfVymrgREls7
 qK1teu27FtnePoIno4w==
X-Proofpoint-GUID: zXASUtDI995Awp9vz-SeS3Rmgyal53Df
X-Proofpoint-ORIG-GUID: zXASUtDI995Awp9vz-SeS3Rmgyal53Df
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010053

From: Abhishek Dubey <adubey@linux.ibm.com>

Provision the private stack as a per-CPU allocation during
bpf_int_jit_compile(). Align the stack to 16 bytes and place guard
regions at both ends to detect runtime stack overflow and underflow.

Round the private stack size up to the nearest 16-byte boundary.
Make each guard region 16 bytes to preserve the required overall
16-byte alignment. When private stack is set, skip bpf stack size
accounting in kernel stack.

There is no stack pointer in powerpc. Stack referencing during JIT
is done using frame pointer. Frame pointer calculation goes like:

BPF frame pointer = Priv stack allocation start address +
                    Overflow guard +
                    Actual stack size defined by verifier

Memory layout:

High Addr          +--------------------------------------------------+
                   |                                                  |
                   | 16 bytes Underflow guard (0xEB9F12345678eb9fULL) |
                   |                                                  |
         BPF FP -> +--------------------------------------------------+
                   |                                                  |
                   | Private stack - determined by verifier           |
                   | 16-bytes aligned                                 |
                   |                                                  |
                   +--------------------------------------------------+
                   |                                                  |
Lower Addr         | 16 byte Overflow guard (0xEB9F12345678eb9fULL)   |
                   |                                                  |
Priv stack alloc ->+--------------------------------------------------+
start

Update BPF_REG_FP to point to the calculated offset within the
allocated private stack buffer. Now, BPF stack usage reference
in the allocated private stack.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---

v6->v7:
  Handle SMP case when setting frame pointer
  Pickup Acked-by and Tested-by tags
v5->v6:
  Remove unused label
v4->v5:
  Rebase over latest branch
v3->v4:
  No change
v2->v3:
  Enable testcase using __powerpc64__ instead of __TARGET_ARCH_powerpc,
  to prevent it getting invoked on powerpc32
v1->v2:
  No change

[v6]: https://lore.kernel.org/bpf/20260331080309.173612-1-adubey@linux.ibm.com    
[v5]: https://lore.kernel.org/bpf/20260330232034.44776-1-adubey@linux.ibm.com
[v4]: https://lore.kernel.org/bpf/20260226031324.17352-1-adubey@linux.ibm.com
[v3]: https://lore.kernel.org/bpf/20260226005440.9570-1-adubey@linux.ibm.com
[v2]: https://lore.kernel.org/bpf/20260225153950.15331-1-adubey@linux.ibm.com
[v1]: https://lore.kernel.org/bpf/20260216152234.36632-1-adubey@linux.ibm.com

 arch/powerpc/net/bpf_jit.h        |  6 ++
 arch/powerpc/net/bpf_jit_comp.c   | 97 +++++++++++++++++++++++++++++--
 arch/powerpc/net/bpf_jit_comp64.c | 31 +++++++++-
 3 files changed, 126 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 7354e1d72f79..a232f3fb73be 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -178,8 +178,14 @@ struct codegen_context {
 	bool is_subprog;
 	bool exception_boundary;
 	bool exception_cb;
+	void __percpu *priv_sp;
+	unsigned int priv_stack_size;
 };
 
+/* Memory size & magic-value to detect private stack overflow/underflow */
+#define PRIV_STACK_GUARD_SZ    16
+#define PRIV_STACK_GUARD_VAL   0xEB9F12345678eb9fULL
+
 #define bpf_to_ppc(r)	(ctx->b2p[r])
 
 #ifdef CONFIG_PPC32
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index a62a9a92b7b5..2018260f56c6 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -129,25 +129,60 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
+static void priv_stack_init_guard(void __percpu *priv_stack_ptr, int alloc_size)
+{
+	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
+	u64 *stack_ptr;
+
+	for_each_possible_cpu(cpu) {
+		stack_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
+		stack_ptr[0] = PRIV_STACK_GUARD_VAL;
+		stack_ptr[1] = PRIV_STACK_GUARD_VAL;
+		stack_ptr[underflow_idx] = PRIV_STACK_GUARD_VAL;
+		stack_ptr[underflow_idx + 1] = PRIV_STACK_GUARD_VAL;
+	}
+}
+
+static void priv_stack_check_guard(void __percpu *priv_stack_ptr, int alloc_size,
+								struct bpf_prog *fp)
+{
+	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
+	u64 *stack_ptr;
+
+	for_each_possible_cpu(cpu) {
+		stack_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
+		if (stack_ptr[0] != PRIV_STACK_GUARD_VAL ||
+			stack_ptr[1] != PRIV_STACK_GUARD_VAL ||
+			stack_ptr[underflow_idx] != PRIV_STACK_GUARD_VAL ||
+			stack_ptr[underflow_idx + 1] != PRIV_STACK_GUARD_VAL) {
+			pr_err("BPF private stack overflow/underflow detected for prog %s\n",
+			bpf_jit_get_prog_name(fp));
+			break;
+		}
+	}
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 {
 	u32 proglen;
 	u32 alloclen;
 	u8 *image = NULL;
-	u32 *code_base;
-	u32 *addrs;
-	struct powerpc_jit_data *jit_data;
+	u32 *code_base = NULL;
+	u32 *addrs = NULL;
+	struct powerpc_jit_data *jit_data = NULL;
 	struct codegen_context cgctx;
 	int pass;
 	int flen;
+	int priv_stack_alloc_size;
+	void __percpu *priv_stack_ptr = NULL;
 	struct bpf_binary_header *fhdr = NULL;
 	struct bpf_binary_header *hdr = NULL;
 	struct bpf_prog *org_fp = fp;
-	struct bpf_prog *tmp_fp;
+	struct bpf_prog *tmp_fp = NULL;
 	bool bpf_blinded = false;
 	bool extra_pass = false;
 	u8 *fimage = NULL;
-	u32 *fcode_base;
+	u32 *fcode_base = NULL;
 	u32 extable_len;
 	u32 fixup_len;
 
@@ -173,6 +208,26 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		fp->aux->jit_data = jit_data;
 	}
 
+	priv_stack_ptr = fp->aux->priv_stack_ptr;
+	if (!priv_stack_ptr && fp->aux->jits_use_priv_stack) {
+		/*
+		 * Allocate private stack of size equivalent to
+		 * verifier-calculated stack size plus two memory
+		 * guard regions to detect private stack overflow
+		 * and underflow.
+		 */
+		priv_stack_alloc_size = round_up(fp->aux->stack_depth, 16) +
+							2 * PRIV_STACK_GUARD_SZ;
+		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_size, 16, GFP_KERNEL);
+		if (!priv_stack_ptr) {
+			fp = org_fp;
+			goto out_priv_stack;
+		}
+
+		priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_size);
+		fp->aux->priv_stack_ptr = priv_stack_ptr;
+	}
+
 	flen = fp->len;
 	addrs = jit_data->addrs;
 	if (addrs) {
@@ -209,6 +264,19 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	cgctx.is_subprog = bpf_is_subprog(fp);
 	cgctx.exception_boundary = fp->aux->exception_boundary;
 	cgctx.exception_cb = fp->aux->exception_cb;
+	cgctx.priv_sp = priv_stack_ptr;
+	cgctx.priv_stack_size = 0;
+	if (priv_stack_ptr) {
+		/*
+		 * priv_stack_size required for setting bpf FP inside
+		 * percpu allocation.
+		 * stack_size is marked 0 to prevent allocation on
+		 * general stack and offset calculation don't go for
+		 * a toss in bpf_jit_stack_offsetof() & bpf_jit_stack_local()
+		 */
+		cgctx.priv_stack_size = cgctx.stack_size;
+		cgctx.stack_size = 0;
+	}
 
 	/* Scouting faux-generate pass 0 */
 	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
@@ -306,6 +374,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		}
 		bpf_prog_fill_jited_linfo(fp, addrs);
 out_addrs:
+		if (!image && priv_stack_ptr) {
+			fp->aux->priv_stack_ptr = NULL;
+			free_percpu(priv_stack_ptr);
+		}
+out_priv_stack:
 		kfree(addrs);
 		kfree(jit_data);
 		fp->aux->jit_data = NULL;
@@ -419,6 +492,8 @@ void bpf_jit_free(struct bpf_prog *fp)
 	if (fp->jited) {
 		struct powerpc_jit_data *jit_data = fp->aux->jit_data;
 		struct bpf_binary_header *hdr;
+		void __percpu *priv_stack_ptr;
+		int priv_stack_alloc_size;
 
 		/*
 		 * If we fail the final pass of JIT (from jit_subprogs),
@@ -432,6 +507,13 @@ void bpf_jit_free(struct bpf_prog *fp)
 		}
 		hdr = bpf_jit_binary_pack_hdr(fp);
 		bpf_jit_binary_pack_free(hdr, NULL);
+		priv_stack_ptr = fp->aux->priv_stack_ptr;
+		if (priv_stack_ptr) {
+			priv_stack_alloc_size = round_up(fp->aux->stack_depth, 16) +
+							2 * PRIV_STACK_GUARD_SZ;
+			priv_stack_check_guard(priv_stack_ptr, priv_stack_alloc_size, fp);
+			free_percpu(priv_stack_ptr);
+		}
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
 	}
 
@@ -453,6 +535,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return IS_ENABLED(CONFIG_PPC64);
 }
 
+bool bpf_jit_supports_private_stack(void)
+{
+	return IS_ENABLED(CONFIG_PPC64);
+}
+
 bool bpf_jit_supports_arena(void)
 {
 	return IS_ENABLED(CONFIG_PPC64);
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index c5e26d231cd5..6670d8c69ade 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -183,6 +183,24 @@ void bpf_jit_realloc_regs(struct codegen_context *ctx)
 {
 }
 
+static void emit_fp_priv_stack(u32 *image, struct codegen_context *ctx)
+{
+	PPC_LI64(bpf_to_ppc(BPF_REG_FP), (__force long)ctx->priv_sp);
+	/*
+	 * Load base percpu pointer of private stack allocation.
+	 * Runtime per-cpu address = (base + data_offset) + (guard + stack_size)
+	 */
+#ifdef CONFIG_SMP
+	/* Load percpu data offset */
+	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R13,
+		offsetof(struct paca_struct, data_offset)));
+	EMIT(PPC_RAW_ADD(bpf_to_ppc(BPF_REG_FP),
+		bpf_to_ppc(TMP_REG_1), bpf_to_ppc(BPF_REG_FP)));
+#endif
+	EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), bpf_to_ppc(BPF_REG_FP),
+			PRIV_STACK_GUARD_SZ + round_up(ctx->priv_stack_size, 16)));
+}
+
 /*
  * For exception boundary & exception_cb progs:
  *     return increased size to accommodate additional NVRs.
@@ -307,9 +325,16 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 	 * Exception_cb not restricted from using stack area or arena.
 	 * Setup frame pointer to point to the bpf stack area
 	 */
-	if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP)))
-		EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), _R1,
-			STACK_FRAME_MIN_SIZE + ctx->stack_size));
+	if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP))) {
+		if (ctx->priv_sp) {
+			/* Set up fp in private stack */
+			emit_fp_priv_stack(image, ctx);
+		} else {
+			/* Setup frame pointer to point to the bpf stack area */
+			EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), _R1,
+				STACK_FRAME_MIN_SIZE + ctx->stack_size));
+		}
+	}
 
 	if (ctx->arena_vm_start)
 		PPC_LI64(bpf_to_ppc(ARENA_VM_START), ctx->arena_vm_start);
-- 
2.52.0


