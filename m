Return-Path: <linuxppc-dev+bounces-20937-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29985CD4851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 05:24:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGJff5rxMz2xlQ;
	Thu, 14 May 2026 15:24:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778736266;
	cv=none; b=VK7wJiKD5/4h7kxaZRhgjTufUNzNCj642EpO3QejU8QHsvzrR4+hpoKtbX3WvSoKipn94LdDW/V9Fw+B4EsvxDAnq3DdoYK4Zn1czz3oGVQUIopisBRChJ1V6Uj1WajOaZdCaQmLWEdvwDe+b0MvGJXfqcE31Pg+T7qcfDpXt0/ZpEDxj9OuUtjw9y1NHiK1MosWzX4y1wIW3rnrsXG87zGjvE0uuppgVxqpidhps3RrkF+ifOerE6Ewv9pGyTrfd6o1Xb1fpRvp7yPE/0Z4MGvqJSXSuDde0natlbGMRwXHcUyp6tghfkQ2HEOmcCPfGxoOS755Bfm4hXBkYzJgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778736266; c=relaxed/relaxed;
	bh=w/+E/hmaq0MdvVCJxIzMtRu3cZLVJl4r1hJxe6e+sa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxD4ZQmkRLPCRBSxJ6oTsQ9f/XfQ7WYHcytKNnO2i5hVx+BtA/OkCCbkmHdakUe9oyMTOaCxidPnpYDYtG4Z4aBzq5d2iPv+lLnq2Jnxh0UhYiPi8PKQPVvD9LUckBbUw6pQxKQyRRnl87SeIelgiZlffefTFdX/CVkvRblRHZ29K4ENsQwu2aZsabe0L/kWC2NiyBHW0YL5I/q7Tb1MZJBxzmhP813hLeXEVaYB5hFTfN9/GYqem7qitL0T539FOvcwpT+H4+zdLAqJicJ3/W8g40BfPaaWSfYQt6+tCBY/lfPD8BqLyp8IvcX4HV8h8V052JhW/bEe74EIsgW7GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SbvHPa5y; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SbvHPa5y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGJfd6pt6z2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 15:24:25 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DHI09a2760514;
	Thu, 14 May 2026 05:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w/+E/h
	maq0MdvVCJxIzMtRu3cZLVJl4r1hJxe6e+sa4=; b=SbvHPa5yO0JHmPK/SHOtKW
	q4D9iE9ahcEXCH8HGSvUAs73rpyww28TQA2/BhV3/JXi9NC9DhZQKgx1KBUC0SYB
	FV55k4YQBzRQnQuLrgPS+5tQdp/eBHdcXZ5IIAShmpHBhfMscrH2VAaCtBjEAMSs
	/E5iHPPMybHtPjGN5yyENkWa6VrghqWEyjGHWr3fwzgiiqbmKZVDBqWo8o1KPIzt
	4O2+YAMUZfhDBDJGw+MemXAIMgzJUh6YCdcaoTsfbdCjL0/tUbHSps+EdB5Kp/5o
	QZ+0wkXNV9bJHV3A7rKtP6PXFJwz1wLa+/OZTKHGyRh5RaBy0+nunV06G5wyr/hg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6th4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 05:24:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64E59URN028619;
	Thu, 14 May 2026 05:24:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgtysq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 05:24:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64E5O9Ih29229502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 05:24:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 964832004B;
	Thu, 14 May 2026 05:24:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0281520040;
	Thu, 14 May 2026 05:24:08 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 May 2026 05:24:07 +0000 (GMT)
Message-ID: <60e44383-0791-4d0a-8c16-41fb4f436e0b@linux.ibm.com>
Date: Thu, 14 May 2026 10:54:07 +0530
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
Subject: Re: [PATCH] powerpc/hv-gpci: fix preempt count leak in sysfs show
 paths
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Christophe Leroy <chleroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <20260508041256.3447113-1-aboorvad@linux.ibm.com>
 <5x4usp43.ritesh.list@gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <5x4usp43.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: b3bY_LRIoNQYJfxqWEZsIfjD8xGmUG4G
X-Proofpoint-GUID: btCnoQHbR8Ir3FPBUq5nUDUqdjiQ9i0o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA0OCBTYWx0ZWRfX8P+RDdsXryx9
 1xHtpc18CahqNG7kPLtXaWu+YMKxJ+4nDO+HofPWgqAzzBdaJVOjmzZKyDUUlW1SzwsHBMbBGUW
 pT3uAAyqjw+Jn6eihSV7Ku7qjJBrwIFS0QnWiLjZsMqVQJiO1i+QZCJM85KyjqkBlbWN4hmFkMs
 vrKNitfAPykQNr8p2r7Qyi0f4f6vZkqnjLq9XYCOW+AYjKbQVUcvr39Qg4hAxxEPKYXHRLlan5E
 6XClwu/2RiAIYeEDhZPa7OIT4G9UHLaVO4X96NhZQaU3EiQ7TXKGerYrpTYTAH2iik3yjiVJOqx
 Obq8/P3ZzyZg2e0Ic/D6HI8LMtRBwl/CWj6gjpDXdvwrOMogbbW9ZSK2y9pxwYQgFLufjwTKdIo
 VaEWgXIGky06m4ijAQJrayO45iT8ohSCr51Q8wpvg0v5AevtPfz+vnFYM3aovFkzspZESkQet2v
 PJiTto1i435RZ2giNsQ==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a055c7e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=0vG1zSKhuiwHglsLdNIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140048

Hi Ritesh.

> I guess, these would be the other kind of issues which might show up now,
> since powerpc is moved to CONFIG_PREEMPTION=y with lazy preempt as the
> default preemption mode. It will be nice to have some mechanism to catch
> these error handling paths where preempt counts might be getting leaked.
> 

There is CONFIG_DEBUG_PREEMPT=y which helps you to catch these issue
where count leak happens. Otherwise we only see end result, but not the culprit.


That said, we do have issues of not nesting with get_cpu/put_cpu in few places and
preempt_disable/preempt_enable in few return paths still.

