Return-Path: <linuxppc-dev+bounces-25063-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1C4C531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:46:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dVs6YJpz2yrm;
	Thu, 30 Jul 2026 15:46:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390405;
	cv=none; b=eyk7JNrVNBN5Nx5ocx3e9JYEoZeLCTSGflnsBFM7KzSClhRRqwb9c0FfQf+QsK1BhNRPIGQjBGhJPSScsyHXNFTD614XL/5SVbC8MymWdqNOPZEVQXraLrTu7yBO4eWkBaRFFnFxnfr/e4m7f0DcCGQVc3eC/LWlj90VIKRMhje8iZYS8SjsuDWQ3Xh6xYfRITZH+CIEeVOzCw+wJCIBeLG3bAwnz/8uLl6Uhik74A6abpidtiVtnc+i7ExAxz2AxMR3mz9VOJ0Us6Wygkvk03JxvPD7caAwMk+vegSmJACP4YxsPOv4kX6qt3B4rDoipGGqq7BC/gw2y4CjehDRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390405; c=relaxed/relaxed;
	bh=F7JButPmqY93oJnyqKF37Unfz4D/8yGvykpyvEy4ncw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUThe67ZAWGLU0nwSTRQS+T02rRRqDh9xwi2WiOqxDcpEi1yCsJJGVzgg6gx6DMkNEdkBakKlzjt1KgJYPw7t4AVzBACJ0METuaXm4RucHhH08VVsGsdxY7mctkMQxreEeHs1pg5sU1LlsnN/o2GFgU7axJNgtW8n6QiOR+T76S6C57plhpl2O2ARUBZFTohX29tgRC/mMTXHADjs8WzHsVFUjdgt7gh+nK4CSXy8pF1Z2v1DHlpnn6y/Rgh2uotVC6LnJJnRtwiBbsGks5UCtVex6Csgzhr+M9KRVrPjji7uheKOPaI9T0wUL+bRePSYbIIHZWKI7gdRzuCxSo8rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PE1lEskG; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PE1lEskG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dVs1hSQz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:46:45 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3lYeM1933410;
	Thu, 30 Jul 2026 05:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F7JButPmqY93oJnyq
	KF37Unfz4D/8yGvykpyvEy4ncw=; b=PE1lEskGrccOIi4/VizXn39X9inhTkI8i
	RJVjEKWwBfR+Lt241EN3h1z0IgP8l/mFb6kOorrI8LJrA1M9Opu5Sg5wnbg8Z5j8
	PCizi8kKkVGcOwN0MF+2Ch2TigMxqbHhsGiKvt7WcVa/YnIhdQ8eaQZe+fUtMyTA
	64YimnVuvLj5KYUpskJ/44b6vBwf9fAh2RowAT7+kd9cga+oYGC7/vJ/hWKqCRKP
	rr20aUHUlSrlrWnMmQ0AqQ+/gRXEEP2VU24mQOEYDFrzeaxz8QRGTIcMnIYTgUK7
	wRirZli3x6BsVCdn+h0i2Q3dazNkyw1dw/5iiOVqkSzjxDj6476TQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xx7s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:46:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fGOb021842;
	Thu, 30 Jul 2026 05:46:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhhunu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:46:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5kF0j31588902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:46:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B6DB20043;
	Thu, 30 Jul 2026 05:46:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BE6A20040;
	Thu, 30 Jul 2026 05:46:12 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.bl1-in.ibm.com (unknown [9.123.13.162])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:46:12 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, hbathini@linux.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        skb99@linux.ibm.com
Subject: [PATCH v2 2/2] powerpc64/bpf: Fix build break for arch_bpf_timed_may_goto
Date: Thu, 30 Jul 2026 11:16:03 +0530
Message-ID: <f75e5aa911afb984a94c0e85d58b1be5fb428548.1785387718.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785387718.git.skb99@linux.ibm.com>
References: <cover.1785387718.git.skb99@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: qwAsLyK3WCLjOddTDikT6iJDPoDWSiEV
X-Proofpoint-ORIG-GUID: SdHJS_JpRU4nuJM6WBEpMzna7mzz4c6l
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX17BaoulcxSd3
 nGAFhn9pk0oTvgVChoNhqZWXcVKJS4jZjdhaLspN2nzVrm9rnP5rAF5nxgdm2bslTgu9H6ijDSF
 i0VB0XYeHV/3BPeiDW8bN4DcbYAFQRg=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6ae52e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=9jmqCVZ-90AupltRSVkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfXyKPcCpe5ng6g
 JCPx3qw+50pH+Gf82a8zw8v6Dwgt6xJP2jNRDlJs05VpNyIoMcI4gcjrHTthCB5+MHfGmWaINni
 uGb+D+CWbICaOVP0D2c1RtPU9xhhQcdJpKatxk0SdT/79G6yD5kk9p1I9Jle8tjJVKVVbJFWYlN
 G3e7enW7FFYVtaLXpwzCml/ZB+J1K+xZ4Nqf9l/8gtNvMN7Gw+KUI2WzWrhlNqFj1jY4i//zPXe
 xTLLCvTEXX1kMSLn86MhqSA++dShmuGlRhB2bXUsu2+JT1xFXDZ1X6RJ7WnE2xnJqjNPk1YnmcE
 rpj9/aAxYNZn14MuqQkPnSYf5pHNfopsVwcT9GNPc5zQliTr2w2NmU/UZh+nMgDrvc3qKEsjgKg
 SpziypKSJvWeOCJpdOJY14z6VksgplZ8qbd5tMkDWUxZsaa3xEr1a2kIOiPPkf9ywe05/NGciae
 EvvyzPnnOAqjESQkcmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300033

With CONFIG_PPC_KERNEL_PCREL enabled, calling bpf_check_timed_may_goto()
using a bl instruction results in a link-time failure:

arch/powerpc/net/bpf_timed_may_goto.o: in function `arch_bpf_timed_may_goto':
(.text+0x28): call to `bpf_check_timed_may_goto' lacks nop, can't restore toc

Use CFUNC() macro instead of direct 'bl' to properly annotate the call
to bpf_check_timed_may_goto(). On PCREL builds, CFUNC() expands to
'bl name@notoc', informing the linker that TOC restoration is not
needed, avoiding the "lacks nop, can't restore toc" linker error.

Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/net/bpf_timed_may_goto.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_timed_may_goto.S b/arch/powerpc/net/bpf_timed_may_goto.S
index 6fd8b1c9f4ac..84ecf6fa7f5d 100644
--- a/arch/powerpc/net/bpf_timed_may_goto.S
+++ b/arch/powerpc/net/bpf_timed_may_goto.S
@@ -36,7 +36,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	 * BPF_REG_FP is r31; BPF_REG_AX is r12 (stack offset in bytes).
 	 */
 	add     r3, r31, r12
-	bl      bpf_check_timed_may_goto
+	bl      CFUNC(bpf_check_timed_may_goto)
 
 	/* Put return value back into AX */
 	mr      r12, r3
-- 
2.54.0


