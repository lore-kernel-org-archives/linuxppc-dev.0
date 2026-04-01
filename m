Return-Path: <linuxppc-dev+bounces-19140-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693F9D35170
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 10:11:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm14409Y8z2ygY;
	Wed, 01 Apr 2026 21:11:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775038307;
	cv=none; b=KuoAh7QuCxv4UnsEzEyKS+gKXM8dZK7FE//33d1ZvCXGlww/ga03ZmIP5bxiRDOc9+Hfo3IuM+o+nQNroX72NTEhBbMsFyaYGHZOwkFqcGX8SHXMtaiAahychbKMSGPXTeRhwbdW6g7fIU2ACpGXQWQJwXDEsJGrNmKUukr3XFg6mwm9PXgz+xzQGRBnozduHc0rKfqlmBdCEUA/AIK4+jxAiY2BU85Fn1pHVWuF1lHWN2yakL9kgFXdWmN2Hi795ELpbS4wkEhKGI3AQGF1+RKxjBU09H7MUpmE1GCEjoT55yWk3vqpn50n8pvbB3yYGzxycVu7LKiMziytl3OqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775038307; c=relaxed/relaxed;
	bh=3mUbcxbKwm7xaMSKR/4qBN3+wZHiqAb74ixt34rZCpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFpglNxYyGJlspB9axq1P5sib+5JEeTsVrdqTzW9bgKdlisXLRuIK/v7k5V70c0xMleHxbJ85ttJLJm2S6Dmc/SkfrxaPa/SlbWkAjXR2XigSLNj15bjZkMzre5xFEBE0MzBMyfHuiqL0am+kMiM/e4KqVmQGB/Hf19gxxNbYlQWtiSYIblngc2di+Uc56doELqqvelj20bX6DyhwkJ13wDdDRvGzNjyWt3X+uPNkvSyU3LBb/BGBtadBeTBy8obangBjnxEplKgjcUD0ADhz9TnLDhEnvcqwtGoA6x5oC+nKJcXinBJQDSjTXjLXNd6kj14JlD9vbECzNI1saTj6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mnLkOP4v; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mnLkOP4v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm1423z9Zz2xpk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 21:11:45 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VIV9Js201661;
	Wed, 1 Apr 2026 10:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3mUbcxbKwm7xaMSKR/4qBN3+wZHiqAb74ixt34rZC
	pY=; b=mnLkOP4vD7nndw6VtV+l4PBrfu4VT747tNdPt/bs3T7hdCwDAIUzzuqkq
	tB1x76w/8dtc54jILHK04tgz8Y1rS2iu931SObDhwvcRmAg+c5hwTvYddFhXvi+o
	g6Ql17N1f6nONsfwnKECGW8GbZwPjOhKI0ABlIwA7wxOrNnkyii5NUFknjmu+lVX
	Uc8JykD6e4Yfm8Xz7y6lru2mPi8H0N8RBfvKLmD4pPRYdBCiP/NxFOpRG5VBm0+f
	mjkeA3WqT4tsesG3LgL3ipcSeDdlnDDd10s4R3ckhd3fJXtfnHFH5xFb64TVUtMR
	8SzYJCinkeywYAEm0FceixUuVqQcA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcew7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 10:11:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6317Qwlq014339;
	Wed, 1 Apr 2026 10:11:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkmyrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 10:11:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631ABODQ49152472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 10:11:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EF1D2004B;
	Wed,  1 Apr 2026 10:11:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 264162004D;
	Wed,  1 Apr 2026 10:11:22 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 10:11:21 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v3 1/2] powerpc64/bpf: Implement fsession support
Date: Wed,  1 Apr 2026 10:10:42 -0400
Message-ID: <20260401141043.41513-1-adubey@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ccef51 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=p8F4Ghc8BiBnGImhoNcA:9
X-Proofpoint-GUID: 1SAEDdbf5vHIk4kktIS0UPI61OTR8Bj4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA4OSBTYWx0ZWRfXyyRbNbQ8O/9d
 wMGZtWZQzwAy6odR4ylaKrplDbmlPeY8xMJd9isszxtDJ2srY7d5s2yBOJqf/6cIU51AcowCgsh
 UL0bh5eElLZAWUNQNigUi26Oz5111qckwXTplGzWIoUseX2SJyWUbFV1bJA6h5MwCuLCBd3FgsA
 ff5wxfeweq9jOTrBWJULdC+OEjdz0jhDVpaIv7YVxvWwdqWy9tbXZTY6gbJNo/gt7+di3yAWlZb
 DLa5Eo1tu41weN0fjtPTCPymk0wme7l46DSENhBc4GPY9C6+Mk6KacgDA3vpvFxAODlrlJroqzG
 Jj03rfd/dU5n1/6XcialGyjasVTLx3lucpvhdSJfymRzTSpUs7itbeaUIn8UFJLwtrrVVPguEYr
 Ht63BXLDl7rmbYX/4ZR80uPzE8eokSGjPJu7Ug0SKEcEdwEVEF92p/YNnWxjvWvCbfxvf0x+rtS
 une/hykPhvKZcJ9SxkQ==
X-Proofpoint-ORIG-GUID: 1SAEDdbf5vHIk4kktIS0UPI61OTR8Bj4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010089

From: Abhishek Dubey <adubey@linux.ibm.com>

Implement JIT support for fsession in powerpc64 trampoline.
The trampoline stack now accommodate session cookies and
function metadata in place of function argument. fentry/fexit
programs consume corresponding function metadata. This mirrors
existing x86 behavior and enable session cookies on powerpc64.

# ./test_progs -t fsession
#135/1   fsession_test/fsession_test:OK
#135/2   fsession_test/fsession_reattach:OK
#135/3   fsession_test/fsession_cookie:OK
#135     fsession_test:OK
Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---

This patch is rebased over https://lore.kernel.org/bpf/20260401103215.104438-1-adubey@linux.ibm.com

v2->v3:
  Rebased over latest changes
  Collected Tested-by tag
v1->v2:
  No change since v1

[v2]: https://lore.kernel.org/bpf/20260226041217.18059-1-adubey@linux.ibm.com
[v1]: https://lore.kernel.org/bpf/20260216155310.38457-1-adubey@linux.ibm.com

 arch/powerpc/net/bpf_jit.h        |  4 +-
 arch/powerpc/net/bpf_jit_comp.c   | 69 ++++++++++++++++++++++++++-----
 arch/powerpc/net/bpf_jit_comp64.c | 25 +++++++++++
 3 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index a232f3fb73be..f32de8704d4d 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -218,7 +218,9 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
 void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx);
 void bpf_jit_realloc_regs(struct codegen_context *ctx);
 int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
-
+void prepare_for_fsession_fentry(u32 *image, struct codegen_context *ctx, int cookie_cnt,
+								int cookie_off, int retval_off);
+void store_func_meta(u32 *image, struct codegen_context *ctx, u64 func_meta, int func_meta_off);
 int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass,
 			  struct codegen_context *ctx, int insn_idx,
 			  int jmp_off, int dst_reg, u32 code);
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 2018260f56c6..16d15ff3145a 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -540,6 +540,11 @@ bool bpf_jit_supports_private_stack(void)
 	return IS_ENABLED(CONFIG_PPC64);
 }
 
+bool bpf_jit_supports_fsession(void)
+{
+	return IS_ENABLED(CONFIG_PPC64);
+}
+
 bool bpf_jit_supports_arena(void)
 {
 	return IS_ENABLED(CONFIG_PPC64);
@@ -812,12 +817,16 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 					 struct bpf_tramp_links *tlinks,
 					 void *func_addr)
 {
-	int regs_off, nregs_off, ip_off, run_ctx_off, retval_off, nvr_off, alt_lr_off, r4_off = 0;
+	int regs_off, func_meta_off, ip_off, run_ctx_off, retval_off;
+	int nvr_off, alt_lr_off, r4_off = 0;
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	int i, ret, nr_regs, retaddr_off, bpf_frame_size = 0;
 	struct codegen_context codegen_ctx, *ctx;
+	int cookie_off, cookie_cnt, cookie_ctx_off;
+	int fsession_cnt = bpf_fsession_cnt(tlinks);
+	u64 func_meta;
 	u32 *image = (u32 *)rw_image;
 	ppc_inst_t branch_insn;
 	u32 *branches = NULL;
@@ -853,9 +862,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *                              [ reg argN          ]
 	 *                              [ ...               ]
 	 *       regs_off               [ reg_arg1          ] prog_ctx
-	 *       nregs_off              [ args count        ] ((u64 *)prog_ctx)[-1]
+	 *       func_meta_off          [ args count        ] ((u64 *)prog_ctx)[-1]
 	 *       ip_off                 [ traced function   ] ((u64 *)prog_ctx)[-2]
+	 *                              [ stack cookieN     ]
 	 *                              [ ...               ]
+	 *       cookie_off             [ stack cookie1     ]
 	 *       run_ctx_off            [ bpf_tramp_run_ctx ]
 	 *                              [ reg argN          ]
 	 *                              [ ...               ]
@@ -887,16 +898,21 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	run_ctx_off = bpf_frame_size;
 	bpf_frame_size += round_up(sizeof(struct bpf_tramp_run_ctx), SZL);
 
+	/* room for session cookies */
+	cookie_off = bpf_frame_size;
+	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	bpf_frame_size += cookie_cnt * 8;
+
 	/* Room for IP address argument */
 	ip_off = bpf_frame_size;
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		bpf_frame_size += SZL;
 
-	/* Room for args count */
-	nregs_off = bpf_frame_size;
+	/* Room for function metadata, arg regs count */
+	func_meta_off = bpf_frame_size;
 	bpf_frame_size += SZL;
 
-	/* Room for args */
+	/* Room for arg regs */
 	regs_off = bpf_frame_size;
 	bpf_frame_size += nr_regs * SZL;
 
@@ -995,9 +1011,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		EMIT(PPC_RAW_STL(_R3, _R1, retaddr_off));
 	}
 
-	/* Save function arg count -- see bpf_get_func_arg_cnt() */
-	EMIT(PPC_RAW_LI(_R3, nr_regs));
-	EMIT(PPC_RAW_STL(_R3, _R1, nregs_off));
+	/* Save function arg regs count -- see bpf_get_func_arg_cnt() */
+	func_meta = nr_regs;
+	store_func_meta(image, ctx, func_meta, func_meta_off);
 
 	/* Save nv regs */
 	EMIT(PPC_RAW_STL(_R25, _R1, nvr_off));
@@ -1011,10 +1027,28 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			return ret;
 	}
 
-	for (i = 0; i < fentry->nr_links; i++)
+	if (fsession_cnt) {
+		/*
+		 * Clear all the session cookies' values
+		 * Clear the return value to make sure fentry always get 0
+		 */
+		prepare_for_fsession_fentry(image, ctx, cookie_cnt, cookie_off, retval_off);
+	}
+
+	cookie_ctx_off = (regs_off - cookie_off) / 8;
+
+	for (i = 0; i < fentry->nr_links; i++) {
+		if (bpf_prog_calls_session_cookie(fentry->links[i])) {
+			u64 meta = func_meta | (cookie_ctx_off << BPF_TRAMP_COOKIE_INDEX_SHIFT);
+
+			store_func_meta(image, ctx, meta, func_meta_off);
+			cookie_ctx_off--;
+		}
+
 		if (invoke_bpf_prog(image, ro_image, ctx, fentry->links[i], regs_off, retval_off,
 				    run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET))
 			return -EINVAL;
+	}
 
 	if (fmod_ret->nr_links) {
 		branches = kcalloc(fmod_ret->nr_links, sizeof(u32), GFP_KERNEL);
@@ -1076,12 +1110,27 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		image[branches[i]] = ppc_inst_val(branch_insn);
 	}
 
-	for (i = 0; i < fexit->nr_links; i++)
+	/* set the "is_return" flag for fsession */
+	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
+	if (fsession_cnt)
+		store_func_meta(image, ctx, func_meta, func_meta_off);
+
+	cookie_ctx_off = (regs_off - cookie_off) / 8;
+
+	for (i = 0; i < fexit->nr_links; i++) {
+		if (bpf_prog_calls_session_cookie(fexit->links[i])) {
+			u64 meta = func_meta | (cookie_ctx_off << BPF_TRAMP_COOKIE_INDEX_SHIFT);
+
+			store_func_meta(image, ctx, meta, func_meta_off);
+			cookie_ctx_off--;
+		}
+
 		if (invoke_bpf_prog(image, ro_image, ctx, fexit->links[i], regs_off, retval_off,
 				    run_ctx_off, false)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
+	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		if (ro_image) /* image is NULL for dummy pass */
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 6670d8c69ade..d9038c468af6 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -179,6 +179,31 @@ static int bpf_jit_stack_offsetof(struct codegen_context *ctx, int reg)
 	BUG();
 }
 
+void prepare_for_fsession_fentry(u32 *image, struct codegen_context *ctx, int cookie_cnt,
+				int cookie_off, int retval_off)
+{
+	EMIT(PPC_RAW_LI(bpf_to_ppc(TMP_REG_1), 0));
+
+	for (int i = 0; i < cookie_cnt; i++)
+		EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, cookie_off + 8 * i));
+	EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, retval_off));
+}
+
+void store_func_meta(u32 *image, struct codegen_context *ctx,
+					u64 func_meta, int func_meta_off)
+{
+	/*
+	 * Store func_meta to stack at [R1 + func_meta_off] = func_meta
+	 *
+	 * func_meta :
+	 *	bit[63]: is_return flag
+	 *	byte[1]: cookie offset from ctx
+	 *	byte[0]: args count
+	 */
+	PPC_LI64(bpf_to_ppc(TMP_REG_1), func_meta);
+	EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, func_meta_off));
+}
+
 void bpf_jit_realloc_regs(struct codegen_context *ctx)
 {
 }
-- 
2.52.0


