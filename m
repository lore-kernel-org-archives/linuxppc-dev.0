Return-Path: <linuxppc-dev+bounces-22120-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FF3CD6E6B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 08:29:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWvk94ccSz3bsM;
	Fri, 05 Jun 2026 18:29:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780648177;
	cv=none; b=nI/dr7uyBmFuTtM1LNQGiE1GEjGSjPZ1JDb/8lnNeYZ5c3dVQPRBkAy8sByyJzkEZZyNJPnuix2LduoTspgbWjFSR9BNtKD2U3fs10QY6kkN2lvdLc7G/Fexel24BkjYZDlCUhJ5bd0zwoLzsu7wr7FwxQyNpBSxyumbgyGU75wpKiXhvgA9I64RRIfJC8NGud9/uO0vHUi9wt/Omjk3K9OTZXdGeAnFA7qvB5rIFbkMlHAKY7jTOOjPvjZ6+UvymYMEdnCebBP4t5r1UOaHzaLZDI92qT4xEtOcnqzHiyEfXJZOsICRMqreCY40yS79LY3HW00+YCWr4aSAsU4Ngg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780648177; c=relaxed/relaxed;
	bh=d4hXaYe94B9/FFJ574qBSPONlF6wJ/38U7rXh2orgCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCzcNhT7PhtDvZNYv6RDaGYI/HwyWurdDy/xBtpWE6ozRQHsXarIUP1Tn1tDbB4uPgoo0LEdxpQ3bA3VZX1Hwmx+yH3Jollqv/h7EEfUKHop9Bdhzj2/qdFYRPgrZI6cbkg7pVBLnPOIMKYq3FaLefFwod5ulkTEVKFZsktKPuGbFmtzQRkO+IubiG78B38Ib2CENg5IUnvVa/zOWFqMAdlVYfO5ShCPYKse/+I5TMeQrKerbfDbzedx3xwFrH4fQqrV40+cJoz0+z2Kfmv0mMUtYZD0CBZq3b1NGU4cQNc7uG1BhzWWBI2pWV5lBhdTGHDs/RIbKqC9JU7I8xR9Bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BVqg3OqM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BVqg3OqM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWvk906x7z3brt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 18:29:36 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654NXin61360394;
	Fri, 5 Jun 2026 08:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d4hXaYe94B9/FFJ57
	4qBSPONlF6wJ/38U7rXh2orgCc=; b=BVqg3OqMKLWc46N6uwNgY0Y2f6XenAdL8
	lECsKRRR0nVm7mBMxvfrFmlkErJznhue75DQW7TM2kGvEXjmyxdU8k/UIGJa/e8X
	vMHokT+9r//MEGemhC5QGof1EaB2TTvb1lUZATKthV6R4liDOrnUaPf4MXRGUDQ/
	0splPNK68D/YHx5UyJ3EVzhG7HoKWPPPBaZDpTyZZFDttRg658ZtADL+UH9YYD4T
	iJgE36yZqZ4Xc2NVZrNTmUpMJxFTYikkwb4VClEEyA48eMMxJi/VjaZmXxF9NyHO
	T0qNj9yFGooZrmVa6J9DKTBPqzlZjlVbCp932Ueq7qem0OWEBe4TQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4knen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 08:29:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6558O7YO023761;
	Fri, 5 Jun 2026 08:29:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qs13b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 08:29:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6558TTev61538658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 08:29:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21AF620040;
	Fri,  5 Jun 2026 08:29:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F03F120043;
	Fri,  5 Jun 2026 08:29:26 +0000 (GMT)
Received: from aboo.bl1-in.ibm.com (unknown [9.123.14.187])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 08:29:26 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v3 3/3] powerpc/kexec: fix double get_cpu() imbalance in kexec_prepare_cpus
Date: Fri,  5 Jun 2026 13:59:12 +0530
Message-ID: <20260605082912.305100-4-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605082912.305100-1-aboorvad@linux.ibm.com>
References: <20260605082912.305100-1-aboorvad@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA3NyBTYWx0ZWRfX+YM7nanr4TyV
 tzqeKrKloUK6CerzETUZ6bRoRj3KjbpIkgxd2lZocgAQPYM8BOdDMInKqL4VFZ4ufYzoYkw+QfR
 WeTZXnH0CUr+P0nz74Fee4gqddW5up7KOSBgd2tQTMDtTwYGOIjRD9N/fG29/9v3f8A3OACDuCm
 aRU0qSpg4yGZVrJ/pYJSKHrFujlMHoTP35LHL1M7t9MNU4HTS9D7YaNVnd/X/9zWK9DKtC1FuV6
 FiTPkvJF1m48Gkfbl9CeNjFEPH0tp/XxnlSyDaZmbfFVChDwChinjqxP+dngyq/SlBzzL9HRboe
 xnw8ZAa1xOf0IPkDK4Bz4wj/uqchtWhqUzPxZxEd/IP69XF5j8C3rhLFcy6t+TUBjQ+vMmDHoZw
 KyokuQUOK66cxJ008l2BB7ptAUzquQ99fS2tOUiAdwQrb6c2jNhf6sYkLPXFOsvtAQQVA4UdAtj
 6geBXVBCLZYf5u7GLrQ==
X-Proofpoint-GUID: w1bjydGki8gRIEYyckWJTZvVLvAEEBmf
X-Proofpoint-ORIG-GUID: 6oPV2FUYmr39PCo5uZhBQnXQGYe7h1W_
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a2288ee cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=NZuQ31_9CfGeVvh8xa4A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050077

kexec_prepare_cpus_wait() calls get_cpu() internally to obtain the
current CPU id. kexec_prepare_cpus() calls kexec_prepare_cpus_wait()
twice -- once for KEXEC_STATE_IRQS_OFF and once for
KEXEC_STATE_REAL_MODE -- but only issues a single put_cpu() at the end,
leaving preempt_count elevated by one extra nesting level.

In practice the imbalance does not trigger a 'scheduling while atomic'
splat because the kexec path is a one-way trip: IRQs are already
disabled, no schedule() occurs after the leak, and
default_machine_kexec() overwrites preempt_count with HARDIRQ_OFFSET
before jumping into kexec_sequence() which never returns. However the
bookkeeping is still wrong.

kexec_prepare_cpus() calls local_irq_disable()/hard_irq_disable()
before invoking kexec_prepare_cpus_wait(), so the CPU is already pinned
and the get_cpu()/put_cpu() preempt_disable() bracketing is unnecessary.
Only the current CPU id is needed, so replace get_cpu() with
raw_smp_processor_id() and drop the now-unneeded put_cpu().

Fixes: 1fc711f7ffb0 ("powerpc/kexec: Fix race in kexec shutdown")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 arch/powerpc/kexec/core_64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 825ab8a88f18..58c13a59b93b 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -169,7 +169,7 @@ static void kexec_prepare_cpus_wait(int wait_state)
 	int my_cpu, i, notified=-1;
 
 	hw_breakpoint_disable();
-	my_cpu = get_cpu();
+	my_cpu = raw_smp_processor_id();
 	/* Make sure each CPU has at least made it to the state we need.
 	 *
 	 * FIXME: There is a (slim) chance of a problem if not all of the CPUs
@@ -267,8 +267,6 @@ static void kexec_prepare_cpus(void)
 	/* after we tell the others to go down */
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(0, 0);
-
-	put_cpu();
 }
 
 #else /* ! SMP */
-- 
2.54.0


