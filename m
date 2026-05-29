Return-Path: <linuxppc-dev+bounces-21722-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF0ACD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 13:52:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRlDS01wGz2ySg;
	Fri, 29 May 2026 23:52:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780062775;
	cv=none; b=ZiMI6Wywb/h/nwbjq6jrZMQu7CYcV8nhR9w1KtxnpnXcaRMJrRtHa8v09tNqTEcfja/hjrcsgTPwsK4v+7Ur1aBTRF/U5x6v5tcHzS66eZ0cXW/FBVYhcgszKdjwvFvMAOWSeTe8GffShwqf6KQhqrMIfv/9gCeDZ6dke94PGkPOnzalrIFZ48lWxlNCI+ZUhNOQQZtdBGdhUhEI771vd4ZL/d9ZMueTwwmY729klIS6+L4NjyEslSjXSjPtbsqojUSnI8BKRTqzFlmOU7CeduGGD9cRph5hkgtmsVAlLc1wup7izTCepEAZUYmRErHeLvSSoC+mVBZFmAJ8IBZyUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780062775; c=relaxed/relaxed;
	bh=v6tSeFw3xOoCHYBHVcs075rlQPMCg0Hk5WCeRicZvOU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gYrrzxd6siFUOMsa5UCccPIAn0d5qIQevjKnPHbq38OCa+q1EMMhHvYZDi/O1OtNSk/f3FN03BTvWKv+eNnSlfkFxq5uONO/Ii2JVXk0JMQjiyKrSKlcitvBwQPr6hyooHwI7E64eCnrgAfg45eBG2NUFlykywMuUbFlkjHG0fU+y7NEGOqrSIELuqvFX7RiuYyMcT/9wXxoPw/lwf0oPGF51KUP8W+XTleIQvO7bbRCaq+P3fstmzlwZWTd1Wff3jK3IOnADyHg8Fz1e74t3+bOqP77GeFZxSjOj3+fnW0A97pP10lu4VhAFVrA5VlEKbmwaCZYJp94wLuhcNC28Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CnCar2uh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CnCar2uh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRlDQ6jCyz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 23:52:54 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TBtRvt2777177;
	Fri, 29 May 2026 13:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=v6tSeFw3xOoCHYBHVcs075rlQPMC
	g0Hk5WCeRicZvOU=; b=CnCar2uhVHeE9qo0qBFKON6EKpb5E7y8ZnjiDBKS+a80
	AT77v/VdVMEdV0QzWi0qDOtSipqqiMb3AuhQ2aIMsC2wwfbi4USmP1se/4LrEVCN
	L04vHe9lHaUM54C6Lbw2XfqUl2c+ktMPFoflgLEazIHL4q6NkvVS9blL5ihuEcFO
	zpVog2qIdx/wArjABGOFUZzi0luGu7qbmyBfvDKujUzZ5PKzxckRvFpfqSgo1Eg9
	fA3arkxO81l6PN9BLPa3wag96fgCoEYaPp+Bo9xU4a4Jsk0zRW7i8HVPl7wpnLA2
	xVwcCND8+INz437IdMR2XuYDnHZlziOZ7I6oY7iotg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889gjwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 13:52:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TDd96s020547;
	Fri, 29 May 2026 13:52:37 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbdub4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 13:52:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TDqavw59507010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 13:52:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 367C858050;
	Fri, 29 May 2026 13:52:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A776758045;
	Fri, 29 May 2026 13:52:31 +0000 (GMT)
Received: from [9.61.247.63] (unknown [9.61.247.63])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 13:52:31 +0000 (GMT)
Message-ID: <d6cb7128-3cff-4a9f-ac9e-410009b2890e@linux.ibm.com>
Date: Fri, 29 May 2026 19:22:29 +0530
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
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: bpf <bpf@vger.kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [mainline] selftests/bpf: struct_ops_assoc test hangs indefinitely on
 PowerPC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NO92FGkBQqdUYgI90IARzL4agbYXgZUZ
X-Proofpoint-GUID: NO92FGkBQqdUYgI90IARzL4agbYXgZUZ
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a199a26 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=qbdj7LMxSyKbK4Z0454A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEzNiBTYWx0ZWRfX7t+dZM0TSu5D
 3qAm0nC6CYXaMArtVipIak4kI6TbSkgJTcUF8FTyggDm5F6ze67SbfvN2+K5my5klbCCTzlpxpq
 /zyJ0Ttt0Vxkh8DiMCBtlByjgl4PDLBdUuiSeofXNH+fZOkxV9Z8vywhIH0QJthhoqcmtoWNFxd
 1X/S2LbXoMirr9av38B4ThsHPNMZCLgnEAzUDU9NA+rLmR/5B/cX6gVAwqjR00tg83wivQ3FWXE
 Bttr7NJZZoik0fpcDBkBSIx2A08v26mcG348abhe7D4fKmNHcT1mh3fG885boE0AUwwCIUcbyhH
 4tgaJ0O9xk+Nn34vGqxonLtASVVG0GU7HIiEDmj5BwhgGW3Lua9sNMIyuA1OHePPFkK7YS5ePDc
 FjeqetL9sjkjhe/K5pCVS7Y6Wy9cSWwPTeAO1J/Ta6Lca2XQv5ZQBcbVX1IpVK5T5RfaM6rCJun
 trbdtQsZSdMeK1gOtLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290136

Greetings!!!

The struct_ops_assoc/st_ops_assoc_in_timer selftest hangs indefinitely on
PowerPC, spinning in sched_yield() until watchdog timeout.

**Test Failure:**

./test_progs -t struct_ops_assoc
WATCHDOG: test case struct_ops_assoc/st_ops_assoc_in_timer executes for 
10 seconds...
WATCHDOG: test case struct_ops_assoc/st_ops_assoc_in_timer executes for 
120 seconds, terminating with SIGSEGV
#445     struct_ops_assoc:FAIL


**Architecture:** PowerPC 64-bit (ppc64le)
**Kernel:** 7.1.0-rc5-00149-g8fde5d1d47f6

**Symptoms:**

Test hangs indefinitely in infinite loop, repeatedly calling sched_yield():


Stack trace:
./test_progs(crash_handler+0x34)
linux-vdso64.so.1(__kernel_sigtramp_rt64+0x0)
/lib64/libc.so.6(__sched_yield+0x2c)  ← stuck here
./test_progs() [0x105ae220]
./test_progs(test_struct_ops_assoc+0x88)
./test_progs(main+0x7ac)



If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



