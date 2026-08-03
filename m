Return-Path: <linuxppc-dev+bounces-25228-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68C6C5516F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 05:29:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD4wh4hyNz3078;
	Mon, 03 Aug 2026 15:29:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785734948;
	cv=none; b=heumGZJoVtzeYz9N99qzHRv2ekiaT8Y6NaU8Fmck/o2AnOU3x6Ug64IhlOt3vwgOOjelpARv3G7nsGrmB5QA9Mpq29T49y22svqV/05yGBZ/2AyjNXuDT3hsIvc1zvzqXy1n0Ltxicl9hzas17SRpANdKp7b1OBjiqt0L/6bMDHBIhRciLTrUkqMo6HYUA3iQRVU1tHohm3Fx1jowhiDWNnzGasnq945ajVSiOf9M/tgcBGkAdqyNl8cK/MWilyjGa+6nBxmY24or0kHN0gMv2xAFTDD8CzBgw0Z3jJaI57w16/zt9wwtk03ylQUO+wrSN8YHu5PjjfQQrKnN7Phkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785734948; c=relaxed/relaxed;
	bh=yxZM/K/jW4W7bLRSj/kLhPf9chwxUM4ZiSK5v9DLapI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VB47euZTYO6Hd/98BHoWt1krgtFKAWt74/7+/ulqOgHLyvG7CMGoH4kG9vIwEyqBIo4Q8tK645gsjmtI4YmeXuNkakJVYF0JYI2yx6UM3c7jbQttCCP5WvfnWV7TgUUDPmp6IgAVxGw5kTRaOUdXCSs9N6nQ7UgSJbOaP2qYw8oRwpYx1BTmygG2YQlCfFTKX6dGdUmF8q8kNfR9ZZvs4Rf3cuMvpFp8CQDkmt3vhTrRDWQOv8Gx1SUZLAcOvY49qwwHOG82tWKsLo1bs5Suwx6+tcyhqvSoDQ1GkjTV2WjpPkp+pwAnLrQjWlmHY863jOHJyfHZRzfG+1o1L0sfgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hozbzRi7; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hozbzRi7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD4wg3Y3Zz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:29:06 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmKJU224710;
	Mon, 3 Aug 2026 05:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yxZM/K/jW4W7bLRSj/kLhPf9chwxUM4ZiSK5v9DLa
	pI=; b=hozbzRi7a30Qkicw30K9SgoLbfKoiE1qXof0hPs9hBinKhI/spvflZZOP
	QfuCHPOBpK643adrlq9H9y/f5nxf5rNkAh3vM8mKhYoWfM9BH++6jEzHXR5WIcXk
	UtLzZYG6HNO3XnRHsiBnCi7dKPYdkfknmnbRynbBmCLdFXHGXvZVXN5w+Bsc4zMa
	czwvLLF69onq+mQ74l3fefcHTY2MGUZv8LyfhSKeKjM91osSONT1fK44ODAQHDsB
	F/53qVV4M1RF2h4TNOO9CHqgWuhcpbqXEN5l5U7GgnRtnY+0FEo1pHjN0M/5NwqE
	mIlY1KBRicMcqfWEeTUbSfL9gmqfQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3q0vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 05:28:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6735QOYE013505;
	Mon, 3 Aug 2026 05:28:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtybmt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 05:28:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6735Sl5q27001320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 05:28:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5735D20040;
	Mon,  3 Aug 2026 05:28:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4D0220043;
	Mon,  3 Aug 2026 05:28:44 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.bl1-in.ibm.com (unknown [9.123.13.162])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 05:28:44 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, segher@kernel.crashing.org, hbathini@linux.ibm.com,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v3] powerpc/irq: Fix missing r2 clobber in PCREL inline assembly
Date: Mon,  3 Aug 2026 10:58:43 +0530
Message-ID: <10fc2cda485cd22e209a31d786bed1984bdf3982.1785732393.git.skb99@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a702714 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Vt2AcnKqAAAA:8 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=4i2Q9fFNS7QQDEBv3fsA:9 a=v10HlyRyNeVhbzM4Lqgd:22
X-Proofpoint-ORIG-GUID: 7MOnO8pmYby25hi360-8wyZzKpPkRQou
X-Proofpoint-GUID: jFnBi4CcyKzzA5eyiNuFAzDTWYSp99hr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA0NCBTYWx0ZWRfX43IHO+Ykn1mn
 UdoPUwkmYyxuzek2epKnynw1eJfOATNCKBrBF+ZdWbNkcp8zV1/tlsPYj3y7bVq4zYtEJB1JOSc
 2k7jpuftLpGJDbdjBa38bkP4RSwMVuY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA0NCBTYWx0ZWRfX4zU8ygbUdr8Z
 P2haCg1EizLeUOhNeTZHYVG28+8eFYKCsOsVa8l2Up31JKtVNlTjgmC1tKxzi9pdwOKf/OVbbzz
 KxLZNrYDhPzK0iQi/6DGhYSOqHH6pxNyoh7mCb4Er1L0pprOItoTcJJeRQiF+BGgr9MsMNYHgjG
 L8k0cSA8xNHWAm7EAELItpE4ni/b1Gg7SQdphHyKsMFmMZyAVMAle6NlCqjuFvGg6aeGF0eghks
 7NyZchvdPB/zEVO8mhRY0Dsm5s9sFNl6pVT+craLDnve0ABxi8GnNrhR2pXSYjSpX/TQyHH2zOp
 cnzzf0NWgycXUEhmq8o9GkPZNv//Zdn0q/Fyn2EUPaiTqzwB2GYDICyuIZeXSw9xnHr9G4TQ/4w
 +kV6srCT033QGohd5/b8j34Mcv7MLmRu5Mk86WwKPui1clDCZxV5CIXcGk/bfdkGOz5RD3WU64T
 0BTlUcVCwuUODsn4qSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030044

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
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---

Changes since v1:
Addressed comments from Segher:
* Modified comments to "clobber may happen"

v1: https://lore.kernel.org/all/dc021f42afa10396052499cbeda1772e30b7ca64.1784530547.git.skb99@linux.ibm.com/

Changes since v2:
Addressed comments from Christophe:
* Modified comments.
* Adjusted the clobber list change to minimize number of small lines.

v2: https://lore.kernel.org/all/7c84fa5e24263d8247b4723118e6130d63b40912.1785131859.git.skb99@linux.ibm.com/

 arch/powerpc/kernel/irq.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index a0e8b998c9b5..cb010830c1c4 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -217,8 +217,12 @@ static __always_inline void call_do_softirq(const void *sp)
 		   [sp] "b" (sp), [offset] "i" (THREAD_SIZE - STACK_FRAME_MIN_SIZE),
 		   [callee] "i" (__do_softirq)
 		 : // Clobbers
-		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
-		   "cr7", "r0", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
+		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7", "r0",
+		  /* r2 may be clobbered by the callee when using PCREL mode in the ELFv2 ABI. */
+#ifdef CONFIG_PPC_KERNEL_PCREL
+		   "r2",
+#endif
+		   "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
 		   "r11", "r12"
 	);
 }
@@ -275,8 +279,12 @@ static __always_inline void call_do_irq(struct pt_regs *regs, void *sp)
 		   [sp] "b" (sp), [offset] "i" (THREAD_SIZE - STACK_FRAME_MIN_SIZE),
 		   [callee] "i" (__do_irq)
 		 : // Clobbers
-		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
-		   "cr7", "r0", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
+		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7", "r0",
+		  /* r2 may be clobbered by the callee when using PCREL mode in the ELFv2 ABI. */
+#ifdef CONFIG_PPC_KERNEL_PCREL
+		   "r2",
+#endif
+		   "r4", "r5", "r6", "r7", "r8", "r9", "r10",
 		   "r11", "r12"
 	);
 }
-- 
2.54.0


