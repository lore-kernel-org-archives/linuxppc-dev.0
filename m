Return-Path: <linuxppc-dev+bounces-24882-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCB3C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:59:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7wb72XCtz2yhD;
	Mon, 27 Jul 2026 20:59:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785149971;
	cv=none; b=lvIuKNpbiOglLNM91YirjuaG2ZogImq1hSpcwda4f0hdxrt2aNvn+qGT+oc8HuPQA8us0eBJwhUmsD/IMPRTkFMRI355Sy5nsQ0Kvwu56qVE5kXwdholqhROc9lbEYj0uy4eUI07BAdNNTKrnGxM498N8GUkBSXJTEnKHJIseAmQ+OQRjKR8YeZuvmRAGR7QQbDzQ/kyd6oEChIuBt33GkcsvAjYbmEsAUXa1Gg+LgZx4AZkFJNP/67AcaVV4sRqOX7bOJ/TvB18liYHRslBYIguiFAjjW1yDkdRK2X0YLwPzxoTqR2PaR8Guq0j8bSdPv0ORMJkpHHTXdGh/8Qaug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785149971; c=relaxed/relaxed;
	bh=VUnq0MRcGVbjRzqtzkwVG624df+X1hKJLudP5jeJR2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I55x9t22mp1yEngBKJd34i1I8x5do0HJaKjHdYGNbJtWr4oJXl8CvWxWFmCj9nF2KxZBeqZeY0zrix77jbfBQRLLULvW1quWsbBMDFBiGVMAAUB4EJp2k79WDypq38w3KP47JtTDsLYPsk2ZjxVPHEpOJpNtJkKaF2JeTPI0Oyu3nLC2mxLtAuuHJ3V1cQ/WzOlYOROPOjU4pXHUA8sqMQzngxkTnG6zDr8V7Zpfh7RntKw/BtcPomGpaZJeCnvz9KVpURxjbMxE935q/1lYhq1NGFIHzyRjzM/G//6mhL8zChnyiWS8YZRTwBEfRkd9yxDZi3AuD7oY5rFZ1vPD6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CtT/nMDF; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CtT/nMDF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7wb613SVz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:59:29 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAIjAU1956312;
	Mon, 27 Jul 2026 10:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VUnq0MRcGVbjRzqtzkwVG624df+X1hKJLudP5jeJR
	2Q=; b=CtT/nMDFrIyWXzrSvrXhhYXcNdCeM7qQ6n1ivnAmE8K6Zv1qov7UnCBOM
	1iQUQCf7cyv373S6OrTtwSdMMBiIDiWZbYuT6f4eOK/qiiHRBxN3GnbZZYSSb2N6
	e9U48FK7pJo9yHN9ccXuY7eQ/2VBafhwm+bbw482SaJ8ptGApyPMENSLq2VIugwA
	7x1jQxhHlehCY0YiK5eUJpTiY8k6alciFc8xkpHxdWqZZXAVEHUUnT/jwnx7uMxe
	Lf1X5u/yP8g8iYUOtZf25j8MdjbNEBNBBRE2jGP64YwQRn91A2O7ykEK6HECxWvG
	AIr5rrYSHboe+AsioklU9sppVXimA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xfkhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 10:59:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RAuNMo028347;
	Mon, 27 Jul 2026 10:59:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg4usk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 10:59:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RAx46x26280254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 10:59:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 791302008B;
	Mon, 27 Jul 2026 10:59:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F3A320083;
	Mon, 27 Jul 2026 10:59:02 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.bl1-in.ibm.com (unknown [9.123.13.162])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 10:59:02 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, segher@kernel.crashing.org, hbathini@linux.ibm.com,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v2] powerpc/irq: Fix missing r2 clobber in PCREL inline assembly
Date: Mon, 27 Jul 2026 16:28:52 +0530
Message-ID: <7c84fa5e24263d8247b4723118e6130d63b40912.1785131859.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-GUID: ZLbWoVapn89nIltNKAVQOSKh_yrFCGi4
X-Proofpoint-ORIG-GUID: KuLq4tfwNcoQGbQaXWShtgirGhXoL2kK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEwNSBTYWx0ZWRfXzwFIK/vpvf3z
 noUZSuX029rUbi/o+Z1HoyEfv/ZyHkNIyVoOpaEV3Iwcc/fvKLYXRRaW/vQ9biymrDP4FM6I8hB
 5nlnsqpN0iKd+9ymRI+Y6lDKrG/ARno=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6739fd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=Vt2AcnKqAAAA:8 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=mIWQ1yeg06SgcoFEzZ0A:9 a=v10HlyRyNeVhbzM4Lqgd:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEwNSBTYWx0ZWRfXz8yZoqBY2wMb
 sKEGroKGH1M0jBDb3LcFNKA4cqkezeAZR6xg+3nzI6/eV8JViaq0SOV+StL3lpWQHuuUnew/Cgb
 oJGcl+dIevewZEtLPZ56fC09VT4LtpV2n5CVBQ3yPYx2/HSSD2I2lAQzpLDI3JOrpvgwYvKO0rk
 vrR4j2n/FNTDetIC6+dRB6wvehOQGXCIJBZ1BH8xtGUc9YM+UtozijBYrv3D8XivrSszKYFOEnZ
 qvfKh5/hSFgQL93NeDwDAANKkvvzgnAYT2YM63HmiQtIjx4r5oolZMaOgB26h/Z3AtMADyqFviW
 69ZeiOhfRENv7hrs3nw746/t7OWv1UlK9RILwzf9TMa9knQXBUanMtAHpDRZciJawdPdBpngFzd
 c0TMdm2v3iehxvg0/MGa4BrT4L+n+5++7LGO8jnQ515Oypmkf9Mx/bft5HiHY1wJ+2KF9tO4OeS
 cYwneezjUOSRUCVX2bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270105

In CONFIG_PPC_KERNEL_PCREL mode, r2 is no longer reserved for the TOC
pointer and is available as a caller-saved register [0].

Both call_do_irq() and call_do_softirq() use inline assembly to call
functions with stack switching, but fail to list r2 in their clobber
lists. This causes the compiler to assume r2 is preserved across these
calls, leading to register corruption when the called functions
(__do_irq and __do_softirq) clobber r2.

As a result of this kernel crash during interrupt handling is seen and
the kernel fails to boot:

BUG: Unable to handle kernel data access on write at 0xc000000404697638
Faulting instruction address: 0xc0000000000181ec
Oops: Kernel access of bad area, sig: 11 [#1]
NIP [c0000000000181ec] __do_IRQ+0x6c/0xc0

With older GCC, the compiler would conservatively allocate
callee-saved registers (like r31) for values spanning function calls,
accidentally avoiding the bug:

<__do_IRQ>:
00 00 00 60 	nop
a6 02 08 7c 	mflr    r0
f8 ff e1 fb 	std     r31,-8(r1)
f0 ff c1 fb 	std     r30,-16(r1)
2d 03 10 06 	pla     r31,53297316

...

3d e8 ff 4b 	bl      c0000000000165ac <__do_irq>
00 00 21 e8 	ld      r1,0(r1)
28 00 4d e9 	ld      r10,40(r13)
40 00 21 38 	addi    r1,r1,64
2a f9 aa 7f 	stdx    r29,r10,r31

With newer GCC 14, the compiler uses r2 for such values, exposing the
missing clobber specification:

<__do_IRQ>:
00 00 00 60     nop
a6 02 08 7c     mflr    r0
f0 ff c1 fb     std     r30,-16(r1)
f8 ff e1 fb     std     r31,-8(r1)
29 02 10 06     pla     r2,36252592     # c0000000022aadc0 <__irq_regs>

...

85 dc ff 4b 	bl      c000000000015ee0 <__do_irq>
00 00 21 e8 	ld      r1,0(r1)
28 00 2d e9 	ld      r9,40(r13)
30 00 21 38 	addi    r1,r1,48
2a 11 c9 7f 	stdx    r30,r9,r2

Fix this by adding r2 to the clobber list for both call_do_irq() and
call_do_softirq() when CONFIG_PPC_KERNEL_PCREL is enabled.

[0]: https://www.mail-archive.com/gcc-patches@gcc.gnu.org/msg313226.html

Fixes: 7e3a68be42e1 ("powerpc/64: vmlinux support building with PCREL addresing")
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
Changes since v1:
Addressed comments from Segher:
* Modified comments to "clobber may happen"

v1: https://lore.kernel.org/all/dc021f42afa10396052499cbeda1772e30b7ca64.1784530547.git.skb99@linux.ibm.com/

 arch/powerpc/kernel/irq.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index a0e8b998c9b5..b5343cfd6c9f 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -218,7 +218,12 @@ static __always_inline void call_do_softirq(const void *sp)
 		   [callee] "i" (__do_softirq)
 		 : // Clobbers
 		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
-		   "cr7", "r0", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
+		   "cr7", "r0",
+		  /* r2 may be clobbered by the callee when using the ELFv2 ABI */
+#ifdef CONFIG_PPC_KERNEL_PCREL
+		   "r2",
+#endif
+		   "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
 		   "r11", "r12"
 	);
 }
@@ -276,7 +281,12 @@ static __always_inline void call_do_irq(struct pt_regs *regs, void *sp)
 		   [callee] "i" (__do_irq)
 		 : // Clobbers
 		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
-		   "cr7", "r0", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
+		   "cr7", "r0",
+		  /* r2 may be clobbered by the callee when using the ELFv2 ABI */
+#ifdef CONFIG_PPC_KERNEL_PCREL
+		   "r2",
+#endif
+		   "r4", "r5", "r6", "r7", "r8", "r9", "r10",
 		   "r11", "r12"
 	);
 }
-- 
2.54.0


