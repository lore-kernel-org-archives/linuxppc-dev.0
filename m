Return-Path: <linuxppc-dev+bounces-26460-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D380C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 07:41:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbBNZ47G7z2yqq;
	Thu, 03 Sep 2026 17:41:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788421262;
	cv=none; b=KSCmE2ChtKTcpWtCRUzd/7jfGJj136qCKUhMjC48TMs3LgI5H2qzmsFCqhx9va6cFm6pFQJY8CvtR8fJ3H1TxJB0YRTsPRofrMEVovpde2QOkUr8d+xPrnzxlWzJE+ni4zoIv8Bb3EQwoYq16dYQoK1g8ekq9t1hBQ1e/9y/OsChbYEzoVSVc898aubFRVoQ8lkBG5RiKvLaOzltJ32Tdk0F74MRrNr0sOFO8at0oVsbl6ZCDM307vqLiwymlu8GUnRY2R1gt7M4xuN0AUd+4EkoYUzV1OP6Ra6enOh3M46oS1bwtVzL+et5g7pRt1HKDGJ0IltGHmjiXFV66bvc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788421262; c=relaxed/relaxed;
	bh=vRTd/8a33hd5qOF6XBwWdNxS8C1jMe9pjy8c3asLvHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ipe5/W9h3FXrrae+wetvO0Bd9S/8jiFRHWNo61jwXii/NRu2ugbzEm/mU4dl1ocuYHsnrPRAWZlvFjCMsOC9/jKFX8paZ11drhbYx349HIjWK6PYBaH1oV7NpTkwmp0IRsPEYnoPM0D6ZJ27x3nwdlBeTjh9RH93mSUutw0GynKXtuW/FvtpGA6OOcreVO2YFArELy9wfCPJ0Qrqvt1YUdPo3KlKykUjFRaDhRE7kd6Rl8jZ5Ce818kSN/sLgM2H7aAlWfJwHhiudVQLGcTaxVrHMGbiaieO6xB6xs4O7c4+zDUUfHjGI6eEfMByZkKI5xba3Evs1pxa+jKwqtMiow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KKtx0fuS; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KKtx0fuS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbBNY1cl4z2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 17:41:00 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361npR311826
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2026 07:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vRTd/8a33hd5qOF6XBwWdNxS8C1jMe9pjy8c3asLv
	HU=; b=KKtx0fuSj7RoL+s0cW1/gi8Adu7OpQojamIY7mVUc5TSfwLV8771OzYBh
	RCD+l0jle0dFEbHvgEhh3PjM5cqpxJwRbdkXfcPC4N3qDcOCG0WZG5V4jBA91Jsd
	Jt3JJpXDlhGA9q+Lnas86bo/87ktvLiJ7Tqagr8ueOkjt2zuhFpgPl3VCS4N4KlO
	k2Dctcr19p8QY3NcNoFpvNdbv6MlwS4flggHXVkqDfAR08CoMcL9tKL/hhv7s6Wu
	M3nqa0rBERb8jESFlTJlqXSyfvGC/7IZ0plmtUDdgXFvlWq9X++piu3+mKbd/Hz5
	IaLyWMX6NDxFiSZBFA9Cv5Hv1eEbA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rkncx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 07:40:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6837QOEb006805
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2026 07:40:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqprtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 07:40:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6837emw043188518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 07:40:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 070A12004D;
	Thu,  3 Sep 2026 07:40:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EC0920043;
	Thu,  3 Sep 2026 07:40:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.26.133])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 07:40:46 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com
Subject: [PATCH] selftests/powerpc/pmu/ebb: fix lost_exception_test hang with sched yield change
Date: Thu,  3 Sep 2026 13:10:36 +0530
Message-Id: <20260903074036.63309-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a99248a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=RsB2ROvZ0tSuVhxhQz0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2NiBTYWx0ZWRfX1YUUQ8TyLtTe
 MXCCsJURA2OaujbzoWdHtruBEVbzd/OlmaM/RaFUgsT4QGnfi1ZmcvP4oUnqYF6Odc8JMw3Tiyp
 Al2AsTS7PkPaly4c4QfjaxD0Fi1E0Xpo08kLYTOkQ61B7DcjZA+lgpeXKeBKptTcnBrXRNvS0Oc
 j5yBSCkVEwsjxY+Mge3zSxge897vZNCnaAtRXw+iCWUp/d+1Iba42D3IMK5Mfsw3jyJwwO6kHdA
 bRbw7c409xc85qeXEQQ0o9tiEi90tG998ktjU4qLCC/d3OV82T/wCDpgpzLNlyTMGsXozsAzABj
 /RvIfWkivLWUhsnb2lgJmXOmg23z3HeASmB7eXa1EUkFhjiwGmkpwQg40Xxw9fz7Dst7rUWtPoJ
 y8/Pf8PgVWj+Cu6sQ3Gifjz6NQtns1+Rx7B/HlRnIm3/uyG5peE/RYxOnga+zRw4ynbFo59i3Vq
 jg268i09lCnmLgilqQg==
X-Proofpoint-GUID: ieDVj4NtSGbTaNTj3O38J4P0UhoLEweZ
X-Proofpoint-ORIG-GUID: ieDVj4NtSGbTaNTj3O38J4P0UhoLEweZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2NiBTYWx0ZWRfXxYW6jwpQWRai
 m9VnS5YTR61xOLnR+X7CLUI2rF7zLtTz3vzkjkALKiPcr8riv4B+SzIfPPMk+c/urR46E3Hv4nA
 4SwbNLZUKeM7otF/agAqu2ATNL5ucmI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030066

commit 79104becf42b ("sched/fair: Forfeit vruntime on yield") changed
yield_task_fair() to only bump the deadline when the entity is eligible
(vruntime <= avg_vruntime). When the entity is ineligible the yield
becomes a complete no-op from scheduling perspective.

lost_exception_test calls sched_yield() 100,000 times per iteration to
race the EBB exception delivery with a context switch to the eat_cpu
companion process. After enough iterations the test process's vruntime
races ahead of avg_vruntime (each eligible yield bumps vruntime to
deadline, then advances deadline by one slice). Once ineligible,
yield_task_fair() does nothing: so the scheduler won't pick the
eat_cpu child. No context switch occurs, the PMAO race is never
triggered, and ebb_count stays at 0 forever causing the test to
hang until timeout.

Fix by replacing sched_yield() with nanosleep(0, 1ns). nanosleep() goes
through hrtimer_nanosleep() -> do_nanosleep(), which puts the task into
TASK_INTERRUPTIBLE and removes it from the run queue entirely. This
guarantees the scheduler picks the eat_cpu child, restoring the
context-switch guarantee the test requires. The 1ns duration is enough
to engage the hrtimer path while keeping the sleep effectively
instantaneous; the same race window between PMU overflow and context
switch is preserved.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 .../selftests/powerpc/pmu/ebb/lost_exception_test.c   | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c b/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
index ba2681a12cc7..9be5945f3b1f 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/mman.h>
+#include <time.h>
 
 #include "ebb.h"
 
@@ -22,6 +23,7 @@ static int test_body(void)
 {
 	int i, orig_period, max_period;
 	struct event event;
+	struct timespec ts = { .tv_sec = 0, .tv_nsec = 1 };
 
 	SKIP_IF(!ebb_is_supported());
 
@@ -57,10 +59,15 @@ static int test_body(void)
 		 * kernel to decide our timeslice is up and context switch to
 		 * the other thread. When we come back our EBB will have been
 		 * lost and we'll spin in this while loop forever.
+		 *
+		 * Use nanosleep(0) instead of sched_yield() to guarantee a
+		 * context switch to the eat_cpu child regardless of the
+		 * eligibility state. sched_yield() via yield_task_fair() may
+		 * become a no-op when the task is ineligible (vruntime ahead
+		 * of avg_vruntime), preventing the required context switch.
 		 */
-
 		for (i = 0; i < 100000; i++)
-			sched_yield();
+			nanosleep(&ts, NULL);
 
 		/* Change the sample period slightly to try and hit the race */
 		if (sample_period >= (orig_period + 200))
-- 
2.43.0


