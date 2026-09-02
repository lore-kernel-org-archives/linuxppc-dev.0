Return-Path: <linuxppc-dev+bounces-26427-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0375BC61DFD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 05:06:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZW113t3fz2xyh;
	Wed, 02 Sep 2026 15:06:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788325605;
	cv=none; b=Lj74IBNMwdvs2sNGkipnMTqIuNfCFbSHyTosjFMLZux4g2fJZw7f1hXLISzTsGzgzs05YNe/3n3q8nYkujEfiJKUJqWUTCx8K+33Of886pJVDjua8UfJf9orj7C8fTabnobaHsZX8+Te61Qy8qqKarcCKyfhPL48UZ+Bn9bnKRGHK+0YmDtbUBmeEOwpmPRzjYxVMwbMRZ6gBR2dW/QukjO7sgv/OFtpWNTIuKmAcJrB8DNpFXx6GeI0zrzD2etTO64RSvKXlWdYTMpi8BWv4CK77yPDl0uF9+j6eiHecEGFPmIEr1KtYmpSpJslQM49/fwe3nmoK3iJ2mEXyFf+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788325605; c=relaxed/relaxed;
	bh=DPPTAa2S/PXoomf4wpOewqYFfcv//YzkJaqO1pFNE5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqE+O8zeUuXWRQgPgYr7liGNlLZkhJfgqh/Koq+pOFj2qBxREqBfwTPzrFD7iJarEIDD9aQ6WBB4cHB7zNHtxB7BskIY718wpUjwehU//6AFx29OQlogezMfwbfiDCHMlBDENrrwH/vL7RmL0cAEeKXT6fzBUsr/5kkN+170Df6vJgxfSJ/+n5FbxZP1B9xvKcFE64RnMYt8rNTWMbiqapslqV7y+nc2mEI2c6W2H3O3D5/1L+gXZrqAn2KGBHRyn3TotgBPkqyBbQShGI7622FaDNO5/Hjub+/tLXGtfldCfLdZGoiAYASmjEXq/lu1yBFVmCNJ+wtqUtV+6TClyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s7hkhWzB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s7hkhWzB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZW0z2DLfz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 15:06:42 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KWrIh2283937;
	Wed, 2 Sep 2026 05:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DPPTAa2S/PXoomf4wpOewqYFfcv//YzkJaqO1pFNE
	5k=; b=s7hkhWzBYH44PjL3gdmGb/uF3WmT+5JKG1Hrj4yT4ZGvjUR1roJM5uhcU
	Evk172li7i9XEw7N+NSnjcDJgOpw6jfNEx0rjgJlZ7wHyqKoSLJC96i6jFeYvriM
	qlrLK9ZJf7SBdngSpo+oio2gqBR/mKT/j7SHwGAQiO7Wjbw9lOr95vAfS1mpIVju
	a/NFjsfb0dV9hdCSwY4i1ReZYGLyy3xLC/ASOvJ4WGExkeoSPBZ5xiio/XpwcR0j
	RULHuxMx7NdRft4qPms27PIWsLoX8U4WbxskLl5PfAEtZbD21bhNshapLf5j/H2N
	3ahTguysRs9+7qD8YVbuLVwv72yGA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2tbx2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 05:06:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6824uIdK020403;
	Wed, 2 Sep 2026 05:06:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygfmx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 05:06:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68256WFd21758638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 05:06:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B979720043;
	Wed,  2 Sep 2026 05:06:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1746F20040;
	Wed,  2 Sep 2026 05:06:30 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.84.243.152])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 05:06:29 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: [PATCH] powerpc/entry: Fix double accounting of user time on interrupt entry
Date: Wed,  2 Sep 2026 10:36:28 +0530
Message-ID: <20260902050628.2553909-1-aboorvad@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a97aede cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=-reXXRCCwf4ccn4xzBkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MyBTYWx0ZWRfX1GXUWJSJAIZr
 Rb1aBUeaP1zuu2EdoYW/HJxQO9fI8kAJAN4MxwaIVA7aPj0YZfY2w1GrmerIWzjl3gZUxle2gYb
 CALRIBK9+flOBO5DrVkd3xbtSVtsMog=
X-Proofpoint-ORIG-GUID: SLsX5aD1fvWtZd2d9sDaZZoJWVaibaia
X-Proofpoint-GUID: 4Yw6hTYzjKnPjDFI3SkvLQetp17k_l4g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MyBTYWx0ZWRfX6RNilKgF4o4I
 F4ssTrQB2jOiTRIjTJRPhRN0j4qard7XJI7Yz5zBoJjG9AVe5vFWCl+P1gJAP3K2LrFhCtaWbVi
 v6/aLseOQfkxfnD1/B2FLqfjplKYpkuvVoN0MPVHSFozIglPuhB98/C4ACeaPKPu+ZbZ8EQSWGS
 8t9wT1NEwjpcam+x7Y0d1spFdSmbgUVOJBOQPAlNrWjkStnWt4QP8TjgKiW5faapLJK51aBxbF0
 qdobVuuRuBBXe/S+96zmDUTY5mMw91WE/w6lQyh2Sove5CFjk9GmAC+/8qNMwbHlOr4IHw1iwAO
 3ZaHLX5mOejDlEl9kftIDON44lf3OyqXF9sNWnRi0T6FazKToaRXIwI3yJN6aruBf7fnCtjYD/0
 xAa0JwyiHiQ517VTFU6fP5kxSJB1dvcgqMOqr+xIZGvWYv2wG5NeZLdlYewkEpT5l7df+vDB7en
 uydMRj0W/z/uaBLRC5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020043

Since the switch to generic entry, an interrupt taken from user mode
accounts user time twice: once in arch_interrupt_enter_prepare() and
again in arch_enter_from_user_mode(), which irqentry_enter() invokes
for the same interrupt:

  arch_interrupt_enter_prepare()
      account_cpu_user_entry()
  irqentry_enter()
    arch_enter_from_user_mode()
      account_cpu_user_entry()

account_cpu_user_entry() accumulates the time spent in user mode
since the last return to user space, so the second call charges the
same interval again.

With CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y this roughly doubles the
reported user time of any workload that takes interrupts. On a
pseries LPAR, ps/top show ~200% CPU for a single-threaded CPU-bound
loop, and time(1) reports user time about twice the elapsed time.

Remove the accounting from arch_interrupt_enter_prepare() and rely on
arch_enter_from_user_mode(), which runs for both syscalls and
interrupts. The duplicate account_stolen_time() call is removed the
same way.

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
Verified on a pseries LPAR (CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y),
7.3.0-rc1, single-threaded CPU-bound loop:

Before:

  $ python3 -c 'while True: pass' &
  $ sleep 3; ps -p $! -o pid,etime,time,pcpu
      PID     ELAPSED     TIME %CPU
     4980       00:03 00:00:06  210

After:

  $ python3 -c 'while True: pass' &
  $ sleep 3; ps -p $! -o pid,etime,time,pcpu
      PID     ELAPSED     TIME %CPU
     4951       00:03 00:00:03  105

 arch/powerpc/include/asm/entry-common.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index c5adb5006361..984294e62568 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -222,8 +222,6 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
 
 	if (user_mode(regs)) {
 		kuap_lock();
-		account_cpu_user_entry();
-		account_stolen_time();
 	} else {
 		kuap_save_and_lock(regs);
 		/*
@@ -426,6 +424,10 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
 #endif
 	kuap_assert_locked();
 	booke_restore_dbcr0();
+	/*
+	 * User and stolen time is accounted here for every entry from
+	 * user mode. The interrupt prepare hooks must not account again.
+	 */
 	account_cpu_user_entry();
 	account_stolen_time();
 

base-commit: fb442a6673ff1046bf67754957d95880fdb394b5
-- 
2.54.0


