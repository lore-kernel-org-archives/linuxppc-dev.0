Return-Path: <linuxppc-dev+bounces-18089-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954BAFED2EB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 08:31:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWgnF57FNz3cGv;
	Thu, 12 Mar 2026 19:31:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773304273;
	cv=none; b=LkrZf7BkyoK39a9vl5fITbOvxcbQxprm1a5yX3cFTGVRPMIaOvNjDgRz30dXxwD8mntQ72kCHTGVPY0QjaqN1ArZNEuUNeag2aWoNlkaRpjuHAE/TUPCbQIfQMa4IwvNJwWvKd0b7rXm5ZQFKLeY2pHg4IpwcMsLKjsiTx1v95pq7/aiZorKjGqmiv0HzKz/F0tXTX+xVzDjU5fjtJwxtEZhlt8vlXSHJcriwUeosn5yYcsLPnqhj8PZ3wyyhkc7yKeGvaccpiLL66sYRiCWncagb2RmW9tUfB9f8ey3h6Ohe3c67o5jeZHezr65g7cgGBn5MLMHRBemOMnfyw9boA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773304273; c=relaxed/relaxed;
	bh=JvAhpw64sb6p7/8okvMLyNvr9z9mM+51+ni+tdgHoww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVbj/6rGJy5vLiSlQ1+G8VLeMMjtfNzuRz/ttiE5txOJIa9CJEQmD1f0BxFOVjFALCGRt1gvEtgSSnovRji/9/aST1HIKUcuPYbEqkxoYzFjTRLk6lpxgnmeTEveC3rtGYRID5wzLphWb66YApJG5fJsYuY25J2p1BRu0EzKMmr++uBpKfpNOv+GReqoFTpGoZ6ZjIwUEnUfTZIZiCgLVx5v/Ocm61zBBpOpCtHs7bOlaM6kMlwsXxANzZoklTXwajyEPHK1BXKjR1PztGuaMo4vf53vn22+zI/L1s4RIZgbvNi/xEJOcY3rNwHD19SWrosU4aIYSXvU7RF/Kns1hA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OuhidDY+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OuhidDY+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWgnD6WLWz3cG5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 19:31:12 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMVqms2278406;
	Thu, 12 Mar 2026 08:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JvAhpw
	64sb6p7/8okvMLyNvr9z9mM+51+ni+tdgHoww=; b=OuhidDY+61eXWmLh0KYjEg
	r3svIkdpftQ56A8CHZb3gJ49vtaUJH83h/I8ZyFpC5B87FvQN0CvYNqK5ulVLWTo
	qQ78OlUIhESmV8Xe+Sc02m+GJ39lV6OIVzT2VP/S3BTGYbgzRENxHKumD+N8FrKN
	R7nBY5x5LOMyKkoKzwjlBv7/ieNhb13Qkcj+fr2RzuSIJaQIp8hoQw/353ZD56EE
	XhVxWEqT1Wpa+y8vDSGmxT4PCP3pt0RMNwbRgIRaVlIefwSMn5k22qCSXEWZ+Z0u
	qVP3f2icrUWSap9Y8mCKDWFQ8N9WYOeySnK6BW9EPVKdCu572GYMKjgY0mqzsq6Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91hqxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:31:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C4KSIp014667;
	Thu, 12 Mar 2026 08:31:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha89jta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:31:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62C8Ux4U50987490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 08:30:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BEA92004B;
	Thu, 12 Mar 2026 08:30:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A842120043;
	Thu, 12 Mar 2026 08:30:56 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.in.ibm.com (unknown [9.109.204.116])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 08:30:56 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>
Subject: [PATCH v3 1/2] powerpc/crash: fix backup region offset update to elfcorehdr
Date: Thu, 12 Mar 2026 14:00:49 +0530
Message-ID: <20260312083051.1935737-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312083051.1935737-1-sourabhjain@linux.ibm.com>
References: <20260312083051.1935737-1-sourabhjain@linux.ibm.com>
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
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: G8GgXSOym9hpKOi-8u5YErpyusrIWMMz
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b279c8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=qf4gfuq51q0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=tR4UYP6JrHl6jBHRX14A:9 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2OCBTYWx0ZWRfX5CwBfPhAbVAO
 XzM4IyLHsVZx2Syp23rOsjD6etOrsetZ9naG0w1JO3/MsnSUNj1RCWQkOSS/JGux7MyKHw9YjPH
 Qu6cqvi4j/vVyfVKYuH3uvx8pPLxTZIeDdD2HAA3sE/sZNxSY3fu6t+4Z+XBUB4SmidzLue/yap
 /K/DnzHa5nG+UPDWAewn/Uw9dKRMn7XawHTDOviGc/yeURrdF781bIkoQom7swcxl/Kz/rJc5OJ
 ciO7mtKIvwg33+8EXQBwKja9FMiCM64zAfdfIC3Zdyli2zPcWr7LlL2uvXRms/XAZUBqdgK9vNy
 vzBUP0fwjiF9Erc5HjjPePEOIXid4Ly2WL3zV6mpTu5NIydyZkqFYVwM/B6w4Q51IQLXSZ5LTRG
 BYW/SHKY/2mhAYWzGVtW7H/pKc0xUHj0URWOoD441suak+0kNZYkME4Zu9gnvMB7fgNwI9PvqML
 hwPkdlzKlqrx3dyjbwg==
X-Proofpoint-ORIG-GUID: r9KoPVkF4j2iTeFC_coROj8Jbkc7blpz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120068

update_backup_region_phdr() in file_load_64.c iterates over all the
program headers in the kdump kernel’s elfcorehdr and updates the
p_offset of the program header whose physical address starts at 0.

However, the loop logic is incorrect because the program header pointer
is not updated during iteration. Since elfcorehdr typically contains
PT_NOTE entries first, the PT_LOAD program header with physical address
0 is never reached. As a result, its p_offset is not updated to point to
the backup region.

Because of this behavior, the capture kernel exports the first 64 KB of
the crashed kernel’s memory at offset 0, even though that memory
actually lives in the backup region. When a crash happens, purgatory
copies the first 64 KB of the crashed kernel’s memory into the backup
region so the capture kernel can safely use it.

This has not caused problems so far because the first 64 KB is usually
identical in both the crashed and capture kernels. However, this is
just an assumption and is not guaranteed to always hold true.

Fix update_backup_region_phdr() to correctly update the p_offset of the
program header with a starting physical address of 0 by correcting the
logic used to iterate over the program headers.

Fixes: cb350c1f1f86 ("powerpc/kexec_file: Prepare elfcore header for crashing kernel")
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kexec/file_load_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index e7ef8b2a2554..e631cf2eda2c 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -391,7 +391,7 @@ static void update_backup_region_phdr(struct kimage *image, Elf64_Ehdr *ehdr)
 	unsigned int i;
 
 	phdr = (Elf64_Phdr *)(ehdr + 1);
-	for (i = 0; i < ehdr->e_phnum; i++) {
+	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
 		if (phdr->p_paddr == BACKUP_SRC_START) {
 			phdr->p_offset = image->arch.backup_start;
 			kexec_dprintk("Backup region offset updated to 0x%lx\n",
-- 
2.52.0


