Return-Path: <linuxppc-dev+bounces-19028-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10261061B1B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 19:21:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl1Lj1vyfz2xT6;
	Tue, 31 Mar 2026 06:21:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774898461;
	cv=none; b=Lnzn/jG42nmduitlCu7Pcmb8SlQz9MJL9vS11/ulDmGrJh6SP+BH60CLvNXfZw6qwe6yZnE7kgmUnoep85S910UAHYvN/aS9s6M5blyJoooVoYSjfzPaRmvnVpEeofmPVwz2bDVCXQJzZJWaE0GWo1rMtMu4Uau6gaxmQ69Ta+fHTUEuQF4FEqQkbFq8UJFQKMAJFwueaMStsCa+Rc2PhoXFPfTmRH3bPnhEEqeL6OceaXKrNQR+4lsNWtg8Y3B2NGZZre8vFYqH+V6IHziQ8GbH3YlkyMkBb+w/lo+GSizskCoAtbrqnhibpspFctDyT9tZvyfFzLIS7HfUKOV4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774898461; c=relaxed/relaxed;
	bh=WQTHjQmRHQvnnAals4FgnOvYl813B4AR+xav05TL2I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLy6E2J7WbwG6uEXpKoPV2zGYIVTSh82kUr39qph8hIVqqbo+QZ3wGHP0hfL5oN6YKC7O7gn/0Kl6XSvJN1Ei7kAdFJaepNQMCOqlHdKgmYnMZE/V25aOn1cH0k6U8WjVlPr5e4zEg8b6sCzTEQf3DVW9u/NUmOJmfNSV6pWaPFMDXrxdGM3L3BlYjKEmCYKW+Fa4d5/C5jEhKQEFb4URjIaZ/xHoO1IOmwrToECOK/W2EhLlFefeFFao4KE90Ofn2k3WZ+3MaWOTxOHL2OkXJYuJNwjS6q7Ua0ijKXvBewgl1Dt3NLqaOEQ92QEqjoi+50x60aZBmIMVCHZvCiTJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n1Jz+Dho; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n1Jz+Dho;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fl1Lh3KKRz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 06:21:00 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UCdMXN3518860;
	Mon, 30 Mar 2026 19:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WQTHjQmRHQvnnAals4FgnOvYl813B4AR+xav05TL2
	I4=; b=n1Jz+DhoarhIuoKJrbcSekjqHp7DzcbPqqsCqQuxu3cQ1gAihhqSI5Vwm
	7b7O+SeaTkbUPXOzs9PxUEft1enGc7MARb4MXFzRC3oAJmt+0Y2PXlMrS1vB2tEv
	DHNEjsHwV26NQpCUYryGmMkj6hhGalgLJKPntEUnF/RsiTZ+DBw/amImLGJB+4dg
	+4bDYRw7DqujvkfDJDWuORaQPYdwdSAglacS3f1lcEa5aobAxmUqLapSr43wJrB/
	dA2EfyB6W7ZzIlS78DqsMbf+rQ8mqQD5gPh6CNjYsPCaoMryCASke3q4N0kRomYP
	rbQ1OLshmE0jiwD2tJzFLBe3VaV6w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q30a6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 19:20:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62UEsO8Q022271;
	Mon, 30 Mar 2026 19:20:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tamx4yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 19:20:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UJKdPE48234932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 19:20:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07BA92004D;
	Mon, 30 Mar 2026 19:20:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7916120040;
	Mon, 30 Mar 2026 19:20:37 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 19:20:37 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v5 1/2] powerpc64/bpf: Implement JIT support for private stack
Date: Mon, 30 Mar 2026 19:20:33 -0400
Message-ID: <20260330232034.44776-1-adubey@linux.ibm.com>
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
X-Proofpoint-GUID: U0JzjsdA2ub83SF3OPWAk2fbUctDplQw
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cacd0c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=A8mRDSlWM7J1pTn1j8wA:9
X-Proofpoint-ORIG-GUID: U0JzjsdA2ub83SF3OPWAk2fbUctDplQw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE2MSBTYWx0ZWRfX+k1gxar4XrQh
 /4TPOhBtzIjgzJzSapN6D9JMO14BoNsES0Wh87CTEK9LGGc391VrvsPhMUcXf0R9BQ4RBm+PYz8
 UXCwu+69M17qL6z5qJqAGktsN7QJqhYREuAX1HC9h4uPk7h63oHQwerfnVroJQtBu7uipVlnB+L
 Y3udYpr3zIoZQtYGZ2P9AkWWxsViwv0DG80LT1oyWlbDch4ZmN1BD0579hI3SOBEl98D4DnLhrV
 xzsjTNXNr7Lrs95vPCR1txNa74Lktmktso5pf2O9ukYmqQ+erf+HYKWUyE8VaiaaOjjld7lez0S
 kMKcpOIyHtxiUMb1bD4HIcIGOSPaHzMc3EhRghVJwbvgxX/tUCuF+x4hylng3KNdMc6licqCY/Y
 V+kyea4v0q53GOqZS0HqrRRBDeKk9h3QeoVw1U7Q/0Tma/lJOSK9CcXvWdWuBLWJdOEw/iIB7Wm
 IFOuLqzOahjwTGgbdQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300161

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

v4->v5:
  Rebasing over latest changes
v3->v4:
  Added new field to fix priv_stack allocation
v2->v3:
  Fix ci-bot bug targeting clobbered NVRs on stack rollback
v1->v2:
  Fix ci-bot warning for percpu pointer casting
  Minor refactoring

[v4]: https://lore.kernel.org/bpf/20260226031324.17352-1-adubey@linux.ibm.com
[v3]: https://lore.kernel.org/bpf/20260226005440.9570-1-adubey@linux.ibm.com
[v2]: https://lore.kernel.org/bpf/20260225153950.15331-1-adubey@linux.ibm.com
[v1]: https://lore.kernel.org/bpf/20260216152234.36632-1-adubey@linux.ibm.com

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        |  6 ++
 arch/powerpc/net/bpf_jit_comp.c   | 97 +++++++++++++++++++++++++++++--
 arch/powerpc/net/bpf_jit_comp64.c | 29 ++++++++-
 3 files changed, 124 insertions(+), 8 deletions(-)

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
index c5e26d231cd5..8101e098d125 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -183,6 +183,22 @@ void bpf_jit_realloc_regs(struct codegen_context *ctx)
 {
 }
 
+static void emit_fp_priv_stack(u32 *image, struct codegen_context *ctx)
+{
+	/* Load percpu data offset */
+	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R13,
+			offsetof(struct paca_struct, data_offset)));
+	PPC_LI64(bpf_to_ppc(BPF_REG_FP), (__force long)ctx->priv_sp);
+	/*
+	 * Load base percpu pointer of private stack allocation.
+	 * Runtime per-cpu address = (base + data_offset) + (guard + stack_size)
+	 */
+	EMIT(PPC_RAW_ADD(bpf_to_ppc(BPF_REG_FP),
+			bpf_to_ppc(TMP_REG_1), bpf_to_ppc(BPF_REG_FP)));
+	EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), bpf_to_ppc(BPF_REG_FP),
+			PRIV_STACK_GUARD_SZ + round_up(ctx->priv_stack_size, 16)));
+}
+
 /*
  * For exception boundary & exception_cb progs:
  *     return increased size to accommodate additional NVRs.
@@ -307,9 +323,16 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
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


