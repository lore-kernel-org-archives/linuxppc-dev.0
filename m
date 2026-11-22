Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFF6606A32C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hNx5Fwha
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXGwt0GsDz2yRF;
	Sun, 22 Nov 2026 15:55:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795323342;
	cv=none; b=GG36mIag7hvVtsdtcCLFYpw7n+fsU1FKxAXKnhIE8IWQioGqovgaBnK1JZlwyz4FQhVyYMvtrUUGKiSqNWmVexABpJQbYG2Gbyw4fW/fo1yVQiPIzMss25s3ngwKW2TG5C6tAGAoDfUSMAVtb6Alik8FoPiNJs3JfdfjuIFMHsCkNNQ3TLlWuo8TeCm8qoDamM6QC8R3BySjEDbGMdhpvIU9VK92ArtCrB/uSzOw17KlcCFSgiQVVPZ+rtml/7OGmfYTRD4RSaDB3qlJ4waJQFkOdf2CR/17b+iEENwtocmBYmMFId00v2Zw4CuIiEu4/r6G+Cai/VW6j7lTVMsN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795323342; c=relaxed/relaxed;
	bh=iRLqjygv2hDYSeqdM+xpW5LlsPFF+IyHh+AJw3x3SA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIIj0njejoOfB2aA5paRleqNTZWsn0xP2TiWDJ7UodzwMcszmOR9AV+CfFxZryOOhfmzIbVzvIOOmL+TP9btliDZ5GhygkLB2X+JJeM95Dt8tguZ8m1OsrR6FVlRyGlW5ke8vxs3+fIUi8twJjlPOnIe4yi+VNzNwfTimURPhjMfoYQwai5VHcqJo+rRfgHjjKgAEkzl2Pf93Ntsf5k3pm8Zv/PHoojVa4eXJK410J/eWc5pt9JOrNsZj9R6V1nRCVeIuCWUueDFL1/ctzqiRlau2Fd5vJ850C9unqQmI7E1THH8n9/9GSedFPZPLXVB2Mf1Wq4NgMUXu7/yUsnKpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hNx5Fwha; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hNx5Fwha;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXGws1G8dz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 15:55:40 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM44rQf3673191;
	Sun, 22 Nov 2026 04:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iRLqjy
	gv2hDYSeqdM+xpW5LlsPFF+IyHh+AJw3x3SA8=; b=hNx5FwhaZDFklLzx9F1oAi
	uwG5K+eQpBoFFL7Qn3kC5Ma48VCkRn1bkj4G8LL8COBDX7amRhp28DFR15/4x2vK
	W/KWFgB5dBGTcq3/sH/mxH+7yADpOwpQ/zaMcdlur1BHKuAWm+7yJx0oXnZ0qAlB
	r/YTMmuW70yL3SJL7WSQmy9qUYCDT5p1ju8Y6ndKJSRsZCPpO1pifMRO11Ugc+Z6
	D7nRbQYKPw0UQeeVv2sJ5vVh7Y/zkIvYahADZud0ViPSl+PFePgL5kOwrH6wlXgd
	Ih0UhfDEFxGuyvoHsy8JPHUCAwFqFr6IRNOhKFUMfzRxCS7oXPhFdhQliEsBuNXA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34guvum2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:55:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3nVPu810566;
	Sun, 22 Nov 2026 04:55:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h0hn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:55:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AM4tPuA28639744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Nov 2026 04:55:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6539B20049;
	Sun, 22 Nov 2026 04:55:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3BBD20040;
	Sun, 22 Nov 2026 04:55:20 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.90.96])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Nov 2026 04:55:20 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com,
        Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH v5 0/3] KVM: PPC: BookE: Fix boot hang on preemptible kernels
Date: Sun, 22 Nov 2026 10:25:19 +0530
Message-ID: <179532322367.92012.16546400865161170455.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118051419.783878-1-sshegde@linux.ibm.com>
References: <20261118051419.783878-1-sshegde@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b0275c2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=r65xZNbgYoIxgFmg-xoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfX+FhUVAV33WQH
 Jme8MeEvt9aPXTkcsrbJxA9SbWWbkj2erpVtw1vusRy9JSwN8tFyPa8qVshmCVZ30fhVpwwguy5
 qOriA4QEI2KDyEWfG0yYM/N4jEyvpok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfX/8T2QWjO/GlD
 XfcfUjqBctUuYf05qhgXLZXlZCPBJQBaqBZ6WuAN2N7T3fpdjlqwZC1P/Nszbjq15nAxMoj+iyf
 Kc9yCQONQ5MWQCIgn9NdQDNxKMp/M557YKkuxJc08A1zUHJgEQnkaYSjFMT6e6ka6//QvPvJhPO
 iRdqWZkC2R2XFzN4f355AxJPYx05OEexql5dXskfJ33RzJrUwpdB3UbaSnkQLAr9+fhImelQ0mr
 s8IN26zCNx/39tEWr8tyKbQx4noq02hhQcGICYlM8RsSRzqngbLKR2Bfjd8nQt8ZeghEr/hFrPm
 tIe209b8pP7EFnRH6y2nSf2ejRmuku/h6jINiYQd4FdIjqYHtLNKb1QC14ZeLuf2jH9tFc3zeyW
 id8wMIOjH+046GWBc/jVXW94sFjw8fKPttKWBoHYmtAvqMWH9YlRCExaRIQ4kWOv6TpNlEcmwcK
 dwZwyXDy0jcoja7nhgw==
X-Proofpoint-ORIG-GUID: y1uGyVD0I8JUD1Z1q-A2cMojlKBJ_raR
X-Proofpoint-GUID: dODFUbH4Wwny_1OwpgZBPJUEuS-C4MIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220018
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 10:44:16 +0530, Shrikanth Hegde wrote:
> Christian Zigotzky had reported that preemptible kernels don't boot on
> his FSL Cyrus+ board. The board freezes on running either full/lazy
> preemption and has been an issue for a while now (years!).
> 
> https://lore.kernel.org/all/b897b0fd-90f2-4215-bcd4-3714e497d773@xenosoft.de/#t
> More details in cover-letter of v2[1]
> 
> [...]

Applied to powerpc/fixes.

[1/3] PPC32: Fix hard_irq_disable to follow tracing and lockdep state
      https://git.kernel.org/powerpc/c/2672bdcc7857073722c4772831a24b14832ee88a
[2/3] KVM: PPC: BookE: Load FP and Altivec before enabling the interrupts
      https://git.kernel.org/powerpc/c/cf2e6ef0a39e0682d22292f1b9e9cd865482e86d
[3/3] KVM: PPC: Hard disable interrupts before guest entry
      https://git.kernel.org/powerpc/c/d0160f6470d1b8a4ce25d98bb8d1b0495a922d4f

cheers

