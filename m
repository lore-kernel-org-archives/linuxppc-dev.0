Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E33C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 14:53:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA39B218A1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 14:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA39B218A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LT9Q3Vl2zDqVC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 01:53:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=naveen.n.rao@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LT7X1GrNzDqSB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 01:52:04 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2FEd0fO130386
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 10:52:00 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2r8bru0vv7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 10:52:00 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 15 Mar 2019 14:51:58 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Mar 2019 14:51:55 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2FEpsra36110482
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Mar 2019 14:51:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E3ABA405D;
 Fri, 15 Mar 2019 14:51:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DC0EA4053;
 Fri, 15 Mar 2019 14:51:52 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.78.193.169])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Mar 2019 14:51:52 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH] powerpc: bpf: Fix generation of load/store DW instructions
Date: Fri, 15 Mar 2019 20:21:19 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031514-0012-0000-0000-00000303527B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031514-0013-0000-0000-0000213A552F
Message-Id: <20190315145119.2776-1-naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-15_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903150105
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
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Yauheni Kaliuta pointed out that PTR_TO_STACK store/load verifier test
was failing on powerpc64 BE, and rightfully indicated that the PPC_LD()
macro is not masking away the last two bits of the offset per the ISA,
resulting in the generation of 'lwa' instruction instead of the intended
'ld' instruction.

Segher also pointed out that we can't simply mask away the last two bits
as that will result in loading/storing from/to a memory location that
was not intended.

This patch addresses this by using ldx/stdx if the offset is not
word-aligned. We load the offset into a temporary register (TMP_REG_2)
and use that as the index register in a subsequent ldx/stdx. We fix
PPC_LD() macro to mask off the last two bits, but enhance PPC_BPF_LL()
and PPC_BPF_STL() to factor in the offset value and generate the proper
instruction sequence. We also convert all existing users of PPC_LD() and
PPC_STD() to use these macros. All existing uses of these macros have
been audited to ensure that TMP_REG_2 can be clobbered.

Fixes: 156d0e290e96 ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
Cc: stable@vger.kernel.org # v4.9+

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h |  2 ++
 arch/powerpc/net/bpf_jit.h            | 17 +++++------------
 arch/powerpc/net/bpf_jit32.h          |  4 ++++
 arch/powerpc/net/bpf_jit64.h          | 20 ++++++++++++++++++++
 arch/powerpc/net/bpf_jit_comp64.c     | 12 ++++++------
 5 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index c5698a523bb1..23f7ed796f38 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -302,6 +302,7 @@
 /* Misc instructions for BPF compiler */
 #define PPC_INST_LBZ			0x88000000
 #define PPC_INST_LD			0xe8000000
+#define PPC_INST_LDX			0x7c00002a
 #define PPC_INST_LHZ			0xa0000000
 #define PPC_INST_LWZ			0x80000000
 #define PPC_INST_LHBRX			0x7c00062c
@@ -309,6 +310,7 @@
 #define PPC_INST_STB			0x98000000
 #define PPC_INST_STH			0xb0000000
 #define PPC_INST_STD			0xf8000000
+#define PPC_INST_STDX			0x7c00012a
 #define PPC_INST_STDU			0xf8000001
 #define PPC_INST_STW			0x90000000
 #define PPC_INST_STWU			0x94000000
diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 549e9490ff2a..dcac37745b05 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -51,6 +51,8 @@
 #define PPC_LIS(r, i)		PPC_ADDIS(r, 0, i)
 #define PPC_STD(r, base, i)	EMIT(PPC_INST_STD | ___PPC_RS(r) |	      \
 				     ___PPC_RA(base) | ((i) & 0xfffc))
+#define PPC_STDX(r, base, b)	EMIT(PPC_INST_STDX | ___PPC_RS(r) |	      \
+				     ___PPC_RA(base) | ___PPC_RB(b))
 #define PPC_STDU(r, base, i)	EMIT(PPC_INST_STDU | ___PPC_RS(r) |	      \
 				     ___PPC_RA(base) | ((i) & 0xfffc))
 #define PPC_STW(r, base, i)	EMIT(PPC_INST_STW | ___PPC_RS(r) |	      \
@@ -65,7 +67,9 @@
 #define PPC_LBZ(r, base, i)	EMIT(PPC_INST_LBZ | ___PPC_RT(r) |	      \
 				     ___PPC_RA(base) | IMM_L(i))
 #define PPC_LD(r, base, i)	EMIT(PPC_INST_LD | ___PPC_RT(r) |	      \
-				     ___PPC_RA(base) | IMM_L(i))
+				     ___PPC_RA(base) | ((i) & 0xfffc))
+#define PPC_LDX(r, base, b)	EMIT(PPC_INST_LDX | ___PPC_RT(r) |	      \
+				     ___PPC_RA(base) | ___PPC_RB(b))
 #define PPC_LWZ(r, base, i)	EMIT(PPC_INST_LWZ | ___PPC_RT(r) |	      \
 				     ___PPC_RA(base) | IMM_L(i))
 #define PPC_LHZ(r, base, i)	EMIT(PPC_INST_LHZ | ___PPC_RT(r) |	      \
@@ -85,17 +89,6 @@
 					___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_BPF_STDCX(s, a, b)	EMIT(PPC_INST_STDCX | ___PPC_RS(s) |	      \
 					___PPC_RA(a) | ___PPC_RB(b))
-
-#ifdef CONFIG_PPC64
-#define PPC_BPF_LL(r, base, i) do { PPC_LD(r, base, i); } while(0)
-#define PPC_BPF_STL(r, base, i) do { PPC_STD(r, base, i); } while(0)
-#define PPC_BPF_STLU(r, base, i) do { PPC_STDU(r, base, i); } while(0)
-#else
-#define PPC_BPF_LL(r, base, i) do { PPC_LWZ(r, base, i); } while(0)
-#define PPC_BPF_STL(r, base, i) do { PPC_STW(r, base, i); } while(0)
-#define PPC_BPF_STLU(r, base, i) do { PPC_STWU(r, base, i); } while(0)
-#endif
-
 #define PPC_CMPWI(a, i)		EMIT(PPC_INST_CMPWI | ___PPC_RA(a) | IMM_L(i))
 #define PPC_CMPDI(a, i)		EMIT(PPC_INST_CMPDI | ___PPC_RA(a) | IMM_L(i))
 #define PPC_CMPW(a, b)		EMIT(PPC_INST_CMPW | ___PPC_RA(a) |	      \
diff --git a/arch/powerpc/net/bpf_jit32.h b/arch/powerpc/net/bpf_jit32.h
index dc50a8d4b3b9..21744d8aa053 100644
--- a/arch/powerpc/net/bpf_jit32.h
+++ b/arch/powerpc/net/bpf_jit32.h
@@ -122,6 +122,10 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 #define PPC_NTOHS_OFFS(r, base, i)	PPC_LHZ_OFFS(r, base, i)
 #endif
 
+#define PPC_BPF_LL(r, base, i) do { PPC_LWZ(r, base, i); } while(0)
+#define PPC_BPF_STL(r, base, i) do { PPC_STW(r, base, i); } while(0)
+#define PPC_BPF_STLU(r, base, i) do { PPC_STWU(r, base, i); } while(0)
+
 #define SEEN_DATAREF 0x10000 /* might call external helpers */
 #define SEEN_XREG    0x20000 /* X reg is used */
 #define SEEN_MEM     0x40000 /* SEEN_MEM+(1<<n) = use mem[n] for temporary
diff --git a/arch/powerpc/net/bpf_jit64.h b/arch/powerpc/net/bpf_jit64.h
index 3609be4692b3..47f441f351a6 100644
--- a/arch/powerpc/net/bpf_jit64.h
+++ b/arch/powerpc/net/bpf_jit64.h
@@ -68,6 +68,26 @@ static const int b2p[] = {
 /* PPC NVR range -- update this if we ever use NVRs below r27 */
 #define BPF_PPC_NVR_MIN		27
 
+/*
+ * WARNING: These can use TMP_REG_2 if the offset is not at word boundary,
+ * so ensure that it isn't in use already.
+ */
+#define PPC_BPF_LL(r, base, i) do {					      \
+				if ((i) % 4) {				      \
+					PPC_LI(b2p[TMP_REG_2], (i));	      \
+					PPC_LDX(r, base, b2p[TMP_REG_2]);     \
+				} else					      \
+					PPC_LD(r, base, i);		      \
+				} while(0)
+#define PPC_BPF_STL(r, base, i) do {					      \
+				if ((i) % 4) {				      \
+					PPC_LI(b2p[TMP_REG_2], (i));	      \
+					PPC_STDX(r, base, b2p[TMP_REG_2]);    \
+				} else					      \
+					PPC_STD(r, base, i);		      \
+				} while(0)
+#define PPC_BPF_STLU(r, base, i) do { PPC_STDU(r, base, i); } while(0)
+
 #define SEEN_FUNC	0x1000 /* might call external helpers */
 #define SEEN_STACK	0x2000 /* uses BPF stack */
 #define SEEN_TAILCALL	0x4000 /* uses tail calls */
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 4194d3cfb60c..21a1dcd4b156 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -252,7 +252,7 @@ static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32
 	 * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
 	 *   goto out;
 	 */
-	PPC_LD(b2p[TMP_REG_1], 1, bpf_jit_stack_tailcallcnt(ctx));
+	PPC_BPF_LL(b2p[TMP_REG_1], 1, bpf_jit_stack_tailcallcnt(ctx));
 	PPC_CMPLWI(b2p[TMP_REG_1], MAX_TAIL_CALL_CNT);
 	PPC_BCC(COND_GT, out);
 
@@ -265,7 +265,7 @@ static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32
 	/* prog = array->ptrs[index]; */
 	PPC_MULI(b2p[TMP_REG_1], b2p_index, 8);
 	PPC_ADD(b2p[TMP_REG_1], b2p[TMP_REG_1], b2p_bpf_array);
-	PPC_LD(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_array, ptrs));
+	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_array, ptrs));
 
 	/*
 	 * if (prog == NULL)
@@ -275,7 +275,7 @@ static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32
 	PPC_BCC(COND_EQ, out);
 
 	/* goto *(prog->bpf_func + prologue_size); */
-	PPC_LD(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_prog, bpf_func));
+	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_prog, bpf_func));
 #ifdef PPC64_ELF_ABI_v1
 	/* skip past the function descriptor */
 	PPC_ADDI(b2p[TMP_REG_1], b2p[TMP_REG_1],
@@ -606,7 +606,7 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 				 * the instructions generated will remain the
 				 * same across all passes
 				 */
-				PPC_STD(dst_reg, 1, bpf_jit_stack_local(ctx));
+				PPC_BPF_STL(dst_reg, 1, bpf_jit_stack_local(ctx));
 				PPC_ADDI(b2p[TMP_REG_1], 1, bpf_jit_stack_local(ctx));
 				PPC_LDBRX(dst_reg, 0, b2p[TMP_REG_1]);
 				break;
@@ -662,7 +662,7 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 				PPC_LI32(b2p[TMP_REG_1], imm);
 				src_reg = b2p[TMP_REG_1];
 			}
-			PPC_STD(src_reg, dst_reg, off);
+			PPC_BPF_STL(src_reg, dst_reg, off);
 			break;
 
 		/*
@@ -709,7 +709,7 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 			break;
 		/* dst = *(u64 *)(ul) (src + off) */
 		case BPF_LDX | BPF_MEM | BPF_DW:
-			PPC_LD(dst_reg, src_reg, off);
+			PPC_BPF_LL(dst_reg, src_reg, off);
 			break;
 
 		/*
-- 
2.20.1

