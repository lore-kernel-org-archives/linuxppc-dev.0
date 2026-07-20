Return-Path: <linuxppc-dev+bounces-24446-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E029C44521
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 07:14:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3WwS2lhkz2xm3;
	Mon, 20 Jul 2026 17:14:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784531656;
	cv=none; b=b9/gFCEPx2iC6n+LmlTITFuUuzZAAmFz95efU+pnoBZKV/WGwbwIRqMFCt9323yEURyqEnZY0kq4i98625n7TksUFZxCGzIwwVgAiuhkLQHKKH3bmCsQz4C62SHQmsqt+GfKtmu8ooLpo3hwCy4ysJsuECJ1hy4Mn2UU7kXpKAUpzcY6xk3NB7/xmlXcSPizWPcvsUdWS4OPCRO+KIBrvQnna8KU48DvOh/QW6IVjBenPCKDwmjjjfNkviRd/EQj8HKTxWsTje0PTz4HGYKtNh4DYJDd0n+mblEZmhbTAHZlqi69Kuisck3xh1kOApsAAwoXC4X6mHK80pRO8cOP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784531656; c=relaxed/relaxed;
	bh=pAaUtZNmpRfoGv8bXIRkYLhTd/cf4mRLU/Y8Dr/TvU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKMbXw4ip8skJNxCFwMTWopPSRNm9hajGoQ9qITHcgbTMzZKLEr0zJ8d7aTKK95BJZb5AggEdd/bHoazcrDA3IC3HSNnSN9Wgur7Qe08DZ3TQTZ2ex7gapknvkc+Gzs1WL25BjrxSf5AI2LmthmIl9CY4sHlUDoWzxyXnT0/rXoGoYJvzMfe/vm9zPRT5QjBndw+CQ1Xhv5BcnCy7KGXWEmZuivzmny6HKTMTU63Epr/GsQxfyw8YClVjOAxbFJkDSwtyRa48VWyB+vCmcpXX9XO0KpfsMPUsGnCDg1/zh0kHSf7ebsHUTMvDZcN54h13SLHOoRiU49jkgn3EemKTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OU4sqlgH; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OU4sqlgH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3WwQ1vBXz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 17:14:13 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6gCeU1471307;
	Mon, 20 Jul 2026 07:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pAaUtZNmpRfoGv8bXIRkYLhTd/cf4mRLU/Y8Dr/Tv
	U4=; b=OU4sqlgH/bzFXYkMj7UREElzeVG7WjN1NrRWBfaZUDsze77mhMiyzERSc
	KOL6lBfXkveZLLqRhTD1scvPcWUbE+8SywMMpMmHIk/+fJZusDAg8RUQG+GOkBVS
	4INk2BrPc4K7RWbFoWh4ubMVcIC/gKTNOxOvt1zdaVKZYVRRFYuoCq0gcUDkr80x
	BY78XqTr8R0BEbOOupiFsgHqiuC5JexJRXFYMrAiIYvWLcerTc2AKd/+HulpbWbS
	PYysLqWWWjWXyykVNNcFpgEtx69Ac9NNeH3THnz2UoUChyJkJyM3F1H+ET2mWrd2
	zgRvVfh3/nEeFEKNQ3+c23attjIrg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790p842-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 07:13:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K74cdt020366;
	Mon, 20 Jul 2026 07:13:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g4anv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 07:13:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K7DpuP57016780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 07:13:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7113720040;
	Mon, 20 Jul 2026 07:13:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F09B52004B;
	Mon, 20 Jul 2026 07:13:48 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.16.91])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 07:13:48 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, hbathini@linux.ibm.com, venkat88@linux.ibm.com,
        yeswanth@linux.ibm.com
Subject: [PATCH] powerpc/irq: Fix missing r2 clobber in PCREL inline assembly
Date: Mon, 20 Jul 2026 12:43:47 +0530
Message-ID: <dc021f42afa10396052499cbeda1772e30b7ca64.1784530547.git.skb99@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: YX3XWUcUQqlrp_QnmSJ2iwxtY1luX4ch
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5dcab4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=Vt2AcnKqAAAA:8 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8
 a=mIWQ1yeg06SgcoFEzZ0A:9 a=v10HlyRyNeVhbzM4Lqgd:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA3OCBTYWx0ZWRfX+dxrVq3Z2h4Q
 oP456RwG0MCr9cdMUfuZEMKjWtzesQEpF+/lcx7O+YuC5tIVo9xhgr7LBpTcgfU8GS247sy+ayr
 UjIpxP2YWM/toF988U8tr5i2BrLWPJA=
X-Proofpoint-GUID: I3o90qVe9dwAVifHQoZ7YRUpTALCswvR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA3OCBTYWx0ZWRfX5GgXKXR1kob7
 VMhbw+gnegAdc7paWq34+wyRWi+V+MPDb/BQx88TjO0MFhSqBArR7sAb2s9CbrgaS0pJoOGh0mi
 +Vt74qx65SBIEupUZ1iHu8lpprJ39+tgYG/TNklYmbrHgdzSVGN5ZuzUJ7AHLBLvjy8HmMZH/SA
 lwVDwF9tdv8y4EZy0CMlIFwrWj08TbXceUZC8gdusVINOgulcmVjpjNwXrGmbrYj85djb8LP1cE
 3BiLuhrVOvnN8gzktD1gbVRmgOEvQlH9Jz4lWkQUP5Ka0A6P5e4+d8zbe+JiolwWIVuBOgRLO5J
 2Ao+F3OLYvuRuuC9WgF5Lh2CkkV+WKZXq4donQwHIPCSPt2GNksWOHsrntdtKp4YDVWNAIez0pv
 eImDrhal0uULKYKHpbbCurpdVBfvxIntu8ZYorKfY7vj/tt1ErbKgg44rTdR8t84w8nh4vJZyQX
 zfMWN2gtzsFhwheRQzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200078

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
 arch/powerpc/kernel/irq.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index a0e8b998c9b5..26df38bdd334 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -218,7 +218,12 @@ static __always_inline void call_do_softirq(const void *sp)
 		   [callee] "i" (__do_softirq)
 		 : // Clobbers
 		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
-		   "cr7", "r0", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
+		   "cr7", "r0",
+		  /* r2 is clobbered in PCREL mode */
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
+		  /* r2 is clobbered in PCREL mode */
+#ifdef CONFIG_PPC_KERNEL_PCREL
+		   "r2",
+#endif
+		   "r4", "r5", "r6", "r7", "r8", "r9", "r10",
 		   "r11", "r12"
 	);
 }
-- 
2.54.0


