Return-Path: <linuxppc-dev+bounces-24096-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29870C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 05:59:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzBbS4gWGz2xlv;
	Mon, 13 Jul 2026 15:59:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783922372;
	cv=none; b=Fy6+RHmJqKKsVLpvNpJOxx/Qh/xvW5y4pHU7WlqmYjwb/VjoFaoOkbCYC4SmNGunGfBZAqYZfGyxYVNELheU0aM1PRyidon7vBwnfoKvjVF7bL5pYFesljTyIEHjE43MCSj93zlnJyC2glNcj1KxT3QaIvEl3sWJnyb4er2fq1XGn0HPC0KgaIO4Ggw8XZUaxOt0HoK2x8pPuoxEBY1L5s4su4oL5VQq8at+ScNLTjoNmjzzuvJ0iih3kqjaS3hEBnagCGhIU6/JaARg06ekZc7kee2qlxbaiIGqwK5JphFqJCfjeUFwfF2VKR+G/HByVa4Sx/7+qWCMwDPjPyHf4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783922372; c=relaxed/relaxed;
	bh=NQGmSLjz8OekUiFBHyJb/1zvyn7NuBWdUzEly6xuVG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+ej5bXXjHBIa3S+g5+le0iZo2axvmQ8UPObzxMaYXHUJGLSW0wvDAojkUiLmqQLyJH0/mRVh2OZFdF3ZFOPry20KOnNiPADDOjInoVLgrFvb/7S4ye2esc6kPAnup6iGNlfqPceUKQzjrWUyZZUYOnwhJZyn6bhlYaPBpoENQUHpyCbniJaE8+FsVSfqIGNw/uIOpMD7dRaM22THf1nolSUTD34lLeSe0+1/DiOMTKVQJ5B7I6UVRXj42mX8AhY9cVAa+IM75VwR+Wk9qc/sx7C2yI79F/4QWQWSKd5YgLe6+oQGwdtdbnYdwNwQdiYmtlMwWI8rVHrLmjb8U2rmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=flOktqwq; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=flOktqwq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzBbR5VzKz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 15:59:31 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3Boa51283829;
	Mon, 13 Jul 2026 05:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NQGmSL
	jz8OekUiFBHyJb/1zvyn7NuBWdUzEly6xuVG0=; b=flOktqwqRvX0qFJyNVk98Y
	xd3fEf6b33kBVxUGVARSF4dIPIq93UZsAr/Mvgu1/5lr8vbV+GMJtFma+/+1jG3G
	OsPN5V7P4VRzXULLgUJHSpfgE7wsSWhvjrYojPnlMQaDjTru5TwDRwbuBrO/SdxV
	ITiTiSPQgPixMsw2BG+rB1/jWGLin9ioGMX9WBzFDLer7YhY55ni4LwkmyboL6FX
	RmvnfGIqRc7lQrv3PYqs6jKmy8WFzuCC6n2tuRj70rON3lYQXRN3VIrY+Ci1RuWH
	JyTL5qxsFGf1KbnSeHVDJV26MDTQaMTQZVU3w/RA+AteMxFLYdGgYJhFgtPXtfPw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fber86vj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 05:59:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D5nfsZ006359;
	Mon, 13 Jul 2026 05:59:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jm9ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 05:59:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D5xHBp30081552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 05:59:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E93FE20049;
	Mon, 13 Jul 2026 05:59:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30C9220040;
	Mon, 13 Jul 2026 05:59:14 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 05:59:13 +0000 (GMT)
Message-ID: <91e04278-aa90-4cbc-aeb4-f4663bf1f058@linux.ibm.com>
Date: Mon, 13 Jul 2026 11:29:12 +0530
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
Subject: Re: [PATCH v2 0/3] powerpc/crash: protect kdump from active watchdogs
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, stable@vger.kernel.org
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
 <mrvvv515.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <mrvvv515.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA1NyBTYWx0ZWRfX10ZIAYzDAvYb
 4FQRuFa1dtTCxN57HqagOPTecHS+e7Da/EWiNSMeDMuIDk9YfdTK1SozvacakSb5Q1Va+o/k6zF
 8uYZD/9/O4pRUh3kxhAAfm42EGk5s5KbvLK46dqQ4MHYv85UMfk09uEp8Aj9EKCltRO0OOWF1du
 Qf8bBbsnFe0bmWEsU6d8z1fcfMvkOtAFuLpc1sviN2sZg9GFIoNLSw8AAA2LpsXskGp5DFBLw+Q
 wkK5yUstT/iSZattuJ2/rHidi+CW7/XH41JE/eZv2GLKLvHTkwsDgDb1iz66b/b5izZGBfoxm6J
 Ksyxj+ERycxB31C24jQklA8O2W7BVMhDxEdkfArnJt8K5xSQZcYHDysf7oAozM2agN6BJf/mwS2
 8ToEtOWKJzWkR57jLw3xMDX39L5u6gRzC27kCatba5VauMJRSxW5YwfsTao3eo6d4pF3iZWpRB+
 zu5lWKRz71DKhEJ0AfQ==
X-Proofpoint-ORIG-GUID: QNfa4UZDELKHg7oMWgpF1vxmwACJTdHP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA1NyBTYWx0ZWRfX4L6Q+dce14RH
 oOdP44hwBfDqBrXBJhyqHCeiwjadzZm6aIdpNZtTLQDqs/pAykP9pT3NSKlReAS4NUDjuIjzJr5
 xhH2ifBdx0J8LY+i6OaRVa2pnS//uVQ=
X-Authority-Analysis: v=2.4 cv=TpzWQjXh c=1 sm=1 tr=0 ts=6a547eba cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=mxXqI5Gt1W863cXGw_MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: souf_10N6rLF5rpALs4ycEFTec1Hipmu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130057



On 13/07/26 10:51, Ritesh Harjani (IBM) wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> Changelog:
>> ==========
>>
>> v2:
>>   - Move H_WATCHDOG definitions to a common header for shared use
>>     across pseries code. 1/3
>>   - Added a new patch to handle pseries watchdog device registration
>>     failure. 2/3
>>   - Stop active watchdogs in crash hanlder. 3/3 Ritesh
>>   - Add suggested-by tag 1/3 & 3/3
>
> Reviewed the changes and mostly looks good with some minor nits added to
> the individual patches.
>
> Small request -
> Could you please also update test results with v3 in your changelog
> (since you mentioned we are able to reproduce the issue easily with your
> test code).

I tested this fix with the program I shared in cover letter. The watchdog
was successfully stopped even when H_WATCHDOG is called form crash
handler.  I will share my test details in v3 cover letter also.

>
>
> aah one other thing I just noticed since you are ccing stable and you
> added a Fixes tag in patch-3.
> Patch-3 alone cannot be easily backported now due to patch-1 and
> patch-2. There must be a way to define the dependencies if you are
> looking for backporting the fix patch to stable tree, please check that
> and follow that accordingly in v3.

I thought about that as well, but since they are part of the same patch 
series,
I assumed they would be picked together. However, I don't think that 
will work
in all cases.

I checked the older commits and noticed that a backport note was added. 
I think
we can do the same for the fix patch. I'll add a note indicating that the
following patches should be backported first:

powerpc/pseries: Move H_WATCHDOG definitions to a common header
powerpc/pseries: Handle and log pseries-wdt registration failures

Since these patches are not upstream yet, I'll refer to them by their 
commit titles.

Does that look good to you?

- Sourabh Jain

