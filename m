Return-Path: <linuxppc-dev+bounces-26159-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AE8C61DBD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 05:38:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWRxw6zlNz2xT6;
	Fri, 28 Aug 2026 15:38:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787895508;
	cv=none; b=X4wPDPMqueWK4nk2gFtAS3ayrE4syo3jy5fUVupeKGPb6Sa9PFVUvbw9uT8Dts4rP5DB1AnxzgRBP8ND8AHTot6XqmyJyQ026fJjrplxu9ZROqzxdKsUTMVw6eLauQZpOOP81uAXMVPyElA1eC4fT1B3gCjoa3ltFqbq+KdP7BlAa+Hf1CI7AnHRYrNgiRIsVbglaMklEc3LxOnK/5itvEEUIu11X6twQ1jgLg9dytVvspSMGietvZ54kLfRXmz9gRTQ1em2h7BXzjNuFgh5McsGAC6WhbnsNBxLtK/3Psy50Tvr9HudeSThzPaK8w2XajjK4y6jKuBM4RbeEuFB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787895508; c=relaxed/relaxed;
	bh=6sUoVMoFxrfHJCoNmlApumU2Hg28uQs/VGvgkEyEp7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKIV0SNU8kJmOrI3teNMt+JhL2mNIUXKE4eHx/vMx/xk/5pRuuTWGHZh+CNcnwWKXbGtsl3HoWZdC+9gk7kE83gRAsGnJW8Y32b531dBWuGFPK83Mbr3Wsk/tZy39Ofctzqn1L9p02Q+BDzr5JO+MS+14ZJLqyj3Dn7R16xG9Q8rMASh49NP8r4bKuBh89A4DEjtcWXJ30ytPcFjiGqprfuooJaR01KCbq6VSllJP+FDrt7vLEBsz9sgXrFvAMu4gV+TqRz++Co6O7ufZ5Zv4aRsn45AlYQRUFQtJdX7f9ER4XxDU1YEHBaNqse24PdICsygBozU9yaTocY595frBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kdCIIEim; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kdCIIEim;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWRxw057Xz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 15:38:27 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67S22xTJ3688606;
	Fri, 28 Aug 2026 05:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6sUoVMoFxrfHJCoNmlApumU2Hg28uQs/VGvgkEyEp
	7E=; b=kdCIIEim0OjaBCLSqG0PPtRZNKZsY0LhDA3T1JoI9qOZWDNRnA0ThJnhU
	CFteGpNvaph8r6VDoNUYA9MOteSLL4lrKFPBL50RXJhmw7bHY357VdSuZMsZQNec
	N+Ac08sTToVejorpm8Sq82wuKiJdEf8Tk0e0vCKqnyW5BlUKeE/PEsM+L1vkMYzu
	5c+yyjgYP5FWK61BLQn64ROdo5YedvjSjEyjW8fA9tHHg+qfvcpnBm/OLTBEeElN
	3Aeci6yKnt9B3OLZVBTC1AQa9kv8za6pDvgOckgzi06CqQi3VZ+J60S6lfCV0YV4
	HOBwFc1jQ9UvSrxn18CCR1I+BheAw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726f240r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 05:38:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5QKsn013439;
	Fri, 28 Aug 2026 05:38:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3kcga9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 05:38:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67S5cIO752429140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 05:38:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB4C420040;
	Fri, 28 Aug 2026 05:38:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9485320043;
	Fri, 28 Aug 2026 05:38:15 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.23.28])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 05:38:15 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: tglx@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, linux-kernel@vger.kernel.org, chleroy@kernel.org,
        sbhat@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH] powerpc/entry: Clear TIF_SYSCALL_RET before syscall error return
Date: Fri, 28 Aug 2026 11:08:11 +0530
Message-ID: <20260828053811.1042300-1-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a911ecf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=9LtnQKmw8N2LNxAaoRgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA0NSBTYWx0ZWRfXzvVe72u3ORHh
 rwxDJQYY+u09XIWFDB4jzM3jt6Q1xwL/8U6Fi3BWlOc9GrRFqvvjcz1WW8r9CO8rSm6V9tmdn6r
 nrRhRy8v3EdQRkpAGY9vHsrVVqmeKrg=
X-Proofpoint-GUID: kAeXcJ71knUp0ddX_mtcGjEC5-YqlAG5
X-Proofpoint-ORIG-GUID: OwMzcmJVHOrxPdN_w33fQJk6HikXmKVu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA0NSBTYWx0ZWRfX+qFbffDRptja
 2cVkB+ZzwLO8Ut9ONjVY2tT/F/TG8OSG8oaz9LrXxMBtDrEzqRI3ePIbXIBKBUh5BKchqWWhGOF
 jxqToeDn/U7lRr7k4v4PVbyTjNkbXOeb43Y0Zx3bHZ4I6H8FMVWCNKJxm0rj+/uuQE49RuEy3G5
 HDQit8BAcOVfPIHZxS91db346J+kuireB3YG4aVh1PTaGmFhXf9PQuIu02e4XAo85sSbuy7fx84
 e5t7icmXKuOoZep14bjrBNefSTKZFWwN4kNTAGNL518XveHpx8HZsnKvF8pD53h8kA8+vgkC9+G
 WhIkRg2sDLPeCPVOd8LZybfWtI+GCABQvwwfGeebH4h5O42+YSzo1ZdpWtMsIsV1nu76aDnM+b9
 5NdvzqA0A1vqmCvwF3m0mWi9MPel0ZvHWj50LFD1j7d8Kaq12DitAlZEGYaQqclhinMuHCemIU1
 Kqy5tFUYN8TPIEEmVMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280045

Shivaprasad reported a boot failure due to userspace processes crash on
abort() from libc.so.6. It was bisected to merge request
commit '3424d8c18a7d ("Merge tag  'core-entry-2026-08-17' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")'

Upon checking the merge, when syscall_enter_from_user_mode_randomize_stack
fails, which could happen when a tracer like seccomp or ptrace intercepts
and skips the syscall, the code returns to userspace immediately without
clearing the intermediate flag which was set.

When the next syscall is made, it immediately aborts the valid syscall
since the flag is still set. Hence clear the flag on occurrence of first
failure.

Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Closes: https://lore.kernel.org/all/e301014d-568f-4ed5-bc64-b8a85ca0b1e1@linux.ibm.com/
Fixes: 3424d8c18a7d ("Merge tag 'core-entry-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
PS: I have kept the block below since earlier code was checking it
regardless of result of syscall_enter_from_user_mode. If it turns out
to be a redundant, it can be removed later.

 arch/powerpc/kernel/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index 4916c205c4bb..fbefe1927b10 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -18,8 +18,10 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 	long ret;
 	syscall_fn f;
 
-	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0)))
+	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
+		clear_thread_flag(TIF_SYSCALL_RET);
 		return syscall_get_error(current, regs);
+	}
 
 	if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))
 		return syscall_get_error(current, regs);
-- 
2.47.3


