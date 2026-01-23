Return-Path: <linuxppc-dev+bounces-16211-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BC2D72342
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jan 2026 07:40:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dy8x81dzBz2yF1;
	Fri, 23 Jan 2026 18:40:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769154044;
	cv=none; b=UzIOzurIIstZO4r9AFH19qPEF9KnotTugrqVY9ISa5h3Bs38xk8/+IXnLPYJx8r5iq1o/6YsEjCFLT+UEByQByW80nY6+hi+yyB+VnWmYyRtIZxFnw1mz+hWiZyolUifChykNxCs5r7dB3zoNzaYXeJnE9maTkD7s4zLjmP08ozLiQtqO6DPkiOinDpyTpouHYzc86EX3K87fVxGliRfH+AUpIrLs6PsrnpQ50iJQuGqexU/59Vdluz+PBc6giUPturCPm8p6pozZ2lInDbhtBaDF+q5iTOaWiwVNskTwfD3cRpBy+uYjBMfAEJzPE/ztAIBRiuK5YYJACMSdLsNzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769154044; c=relaxed/relaxed;
	bh=B96eqxBiTo98pHzqabXyu4MFkhh6JhjrUmi6hCNa5VE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lInwvIX8pLkom5XwB5JmW/bq5oKhTW5u2tB9IUA4S7NSA5kk6l9HR8k94OStQ1bImLQ4+pC+ATElEusijEP/u13Wa3G85mH9lAPJdkHjpfpTTPohT6TOqeqXBFOPoBLtr5v6mdKbG9QFvTysA3gNGeNK+B5v96clQuVDna/wS93UE4uvR6jv1hIX6wjVu24H/2Yvt8tcmxeBhHogTe62znU++FhzSAvoujMl+QI9FpeuEjpkNg5PVIfCHRgOzn0QeOEFriJLtaivEBYid3sw9xLFiz5Zo6BtnZPIz6y2vLSQQHWJLYU1xzJp9CQi9zFxrXK8H3XRqQ+FzRG4QbznyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=F3toyvyN; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mkchauras@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=F3toyvyN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mkchauras@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dy8x73xYxz2x9M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2026 18:40:43 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MLCbOf006864;
	Fri, 23 Jan 2026 07:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B96eqxBiTo98pHzqa
	bXyu4MFkhh6JhjrUmi6hCNa5VE=; b=F3toyvyNMTKejqlY6jCZyZigfI2Q5EoHG
	atSpPp9DT6PMoBywKrYv4KQs66wYuIYDQaoUtl15UZGc9sw31D7ZPUud00COVe/I
	OLGUPmoyrBFNox4wCssmso3DExOImqM48kHeiuOcWuDbeGPZPMpvfmmTXljNKYpp
	43v/Kidg2sfVKCZP3McJys+y5FnC/B9IAG0L2gCwCV9xlYZzgWmXWoaSwybWFgaP
	2AxmCda3AYFA13Wn7zOZEY0faC+c4dtVgjhnyLp83yxur7bwa/Us5BC9A+2TBO6A
	fpv0AJgSSxyhEzLpmFL9Lx6Tt+zpbJh42X3Dr6UmKgTqf09NIE6qQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23senpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 07:40:19 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60N7aBEf022230;
	Fri, 23 Jan 2026 07:40:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23senp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 07:40:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N6G4oS016668;
	Fri, 23 Jan 2026 07:40:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4yfxhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 07:40:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60N7eDub32637298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 07:40:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AE252004F;
	Fri, 23 Jan 2026 07:40:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 269792004B;
	Fri, 23 Jan 2026 07:40:08 +0000 (GMT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com (unknown [9.124.222.171])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 07:40:07 +0000 (GMT)
From: Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com,
        andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
        oleg@redhat.com, kees@kernel.org, luto@amacapital.net,
        wad@chromium.org, mchauras@linux.ibm.com, thuth@redhat.com,
        ruanjinjie@huawei.com, sshegde@linux.ibm.com,
        akpm@linux-foundation.org, charlie@rivosinc.com, deller@gmx.de,
        ldv@strace.io, macro@orcam.me.uk, segher@kernel.crashing.org,
        peterz@infradead.org, bigeasy@linutronix.de, namcao@linutronix.de,
        tglx@linutronix.de, mark.barnett@arm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH v4 5/8] powerpc: add exit_flags field in pt_regs
Date: Fri, 23 Jan 2026 13:09:13 +0530
Message-ID: <20260123073916.956498-6-mkchauras@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073916.956498-1-mkchauras@linux.ibm.com>
References: <20260123073916.956498-1-mkchauras@linux.ibm.com>
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
X-Proofpoint-GUID: Z0DOHKyWIf7TUDiVz_KZIDbrmZn-ldJ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1NSBTYWx0ZWRfX63DDZlzSUdRJ
 ZfgOP4BwRqgqDJYwCOx6ozJ8J8jj+/zaqvNfZyaHvdNpTD151C+OCnJRfQpMx+lUjMIkpH+U3S2
 2Tsqqp87JCw6saL8Ea4CNra1HCg+N9bf4wJNI8mU9+QFwvBv6WyFUazX6N6egN3DKUS16iF4GL4
 Ao74DkBYgEQSGMKKDg0HJm/e0cF5z5IIO1WRHlJDSgLpKvHJeV3LbEX2kceffZailZN4cSsxe/9
 n/tX9zxdrbpqXaOd658heVGongn3lrdRW3LKiIFoL2206Lh+hx4zJDNxUio+wA7xfxfbDFNAqQr
 RONSmUNjho6CVtxw5adjHdfhHhRYp1GX2PZwMbrGn+yJk69JaWNFIUhnfl5hWDYy7U1Mg5p4Gga
 dCnELYz1YLzbafDVnNBIjHeD46j4mcWLdxwOd2UK/UdBtRrrHl2Lh5nDYQ1Geea3EY1Gk91GcqM
 yICZAeazwUuO7aYd3Ew==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=697325e3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=wNVWKEKBPlwGkIktZH8A:9
X-Proofpoint-ORIG-GUID: EJsRJh1CGK2KQJfwhIF5-bniCn4dDvkX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230055

From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>

Add a new field `exit_flags` in the pt_regs structure. This field will hold
the flags set during interrupt or syscall execution that are required during
exit to user mode.

Specifically, the `TIF_RESTOREALL` flag, stored in this field, helps the
exit routine determine if any NVGPRs were modified and need to be restored
before returning to userspace.

This addition ensures a clean and architecture-specific mechanism to track
per-syscall or per-interrupt state transitions related to register restore.

Changes:
 - Add `exit_flags` and `__pt_regs_pad` to maintain 16-byte stack alignment
 - Update asm-offsets.c and ptrace.c for offset and validation
 - Update PT_* constants in uapi header to reflect the new layout

Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
---
 arch/powerpc/include/asm/ptrace.h      |  3 +++
 arch/powerpc/include/uapi/asm/ptrace.h | 14 +++++++++-----
 arch/powerpc/kernel/ptrace/ptrace.c    |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 94aa1de2b06e..2e741ea57b80 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -53,6 +53,9 @@ struct pt_regs
 				unsigned long esr;
 			};
 			unsigned long result;
+			unsigned long exit_flags;
+			/* Maintain 16 byte interrupt stack alignment */
+			unsigned long __pt_regs_pad[3];
 		};
 	};
 #if defined(CONFIG_PPC64) || defined(CONFIG_PPC_KUAP)
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 01e630149d48..a393b7f2760a 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -55,6 +55,8 @@ struct pt_regs
 	unsigned long dar;		/* Fault registers */
 	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
 	unsigned long result;		/* Result of a system call */
+	unsigned long exit_flags;	/* System call exit flags */
+	unsigned long __pt_regs_pad[3];	/* Maintain 16 byte interrupt stack alignment */
 };
 
 #endif /* __ASSEMBLER__ */
@@ -114,10 +116,12 @@ struct pt_regs
 #define PT_DAR	41
 #define PT_DSISR 42
 #define PT_RESULT 43
-#define PT_DSCR 44
-#define PT_REGS_COUNT 44
+#define PT_EXIT_FLAGS 44
+#define PT_PAD 47 /* 3 times */
+#define PT_DSCR 48
+#define PT_REGS_COUNT 48
 
-#define PT_FPR0	48	/* each FP reg occupies 2 slots in this space */
+#define PT_FPR0	(PT_REGS_COUNT + 4)	/* each FP reg occupies 2 slots in this space */
 
 #ifndef __powerpc64__
 
@@ -129,7 +133,7 @@ struct pt_regs
 #define PT_FPSCR (PT_FPR0 + 32)	/* each FP reg occupies 1 slot in 64-bit space */
 
 
-#define PT_VR0 82	/* each Vector reg occupies 2 slots in 64-bit */
+#define PT_VR0	(PT_FPSCR + 2)	/* <82> each Vector reg occupies 2 slots in 64-bit */
 #define PT_VSCR (PT_VR0 + 32*2 + 1)
 #define PT_VRSAVE (PT_VR0 + 33*2)
 
@@ -137,7 +141,7 @@ struct pt_regs
 /*
  * Only store first 32 VSRs here. The second 32 VSRs in VR0-31
  */
-#define PT_VSR0 150	/* each VSR reg occupies 2 slots in 64-bit */
+#define PT_VSR0	(PT_VRSAVE + 2)	/* each VSR reg occupies 2 slots in 64-bit */
 #define PT_VSR31 (PT_VSR0 + 2*31)
 #endif /* __powerpc64__ */
 
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index c6997df63287..2134b6d155ff 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -432,6 +432,7 @@ void __init pt_regs_check(void)
 	CHECK_REG(PT_DAR, dar);
 	CHECK_REG(PT_DSISR, dsisr);
 	CHECK_REG(PT_RESULT, result);
+	CHECK_REG(PT_EXIT_FLAGS, exit_flags);
 	#undef CHECK_REG
 
 	BUILD_BUG_ON(PT_REGS_COUNT != sizeof(struct user_pt_regs) / sizeof(unsigned long));
-- 
2.52.0


