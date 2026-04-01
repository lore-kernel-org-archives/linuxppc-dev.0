Return-Path: <linuxppc-dev+bounces-19149-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9A4D2ED08
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 13:42:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm5lZ5yBWz2yhY;
	Thu, 02 Apr 2026 00:42:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775050970;
	cv=none; b=k6A+rA2o8PoVfz0yx03DYztDD5fXPnJUMVOdkpP2l2tgdnSwrsPJmeRf/pEtRKXpqWIwdrgfjw/SM4C3SszIM7TvmfZJwTAalipXHaLdiaMPWdDMBN/HcdzMl11q1RClqYUFG3xoqsWrAeMlXzLR6rBnAbUC4Lgm0yrsKSxgTGnhbMcwcKuot/BnE8gDDBDdstfKLNgKEdjwPgQXY5kqx/qg2dFPTebdFDvkc0+B6QNmkELWQtjXDft5z1aqVQKAfSzPNkzdJSFuCueMZsww1rpQlUNcBYEdSnCx45+QL6rPcp9EUhausbEHe6H7vbSRCflmnJy4E0SKbkRBXJikaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775050970; c=relaxed/relaxed;
	bh=runZcQ77qGZr+zXFQOHG4IyraY6zJgIY6sMAaFMFqlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C643qnwfPw8VTNCFxDefFK/yOe1SXkfWXn/to0Nlus4IZjQGh9YKPG6ltQ4LbaIb0V6tcm1K6okyKMR3orKGAUhwCIjnkH/6JEymu09lCldaG/220ivG7vDq3GQB9IZJF0YwEper+uBwF9pXTboAxSzslDywqnFeTZKs04AnzRVwJZ1aG4NJiCUOVPkA5KCVZgKJ8PBmZoymKs4pXoUxm36vDBx/KyQQVVp5Bqi9dafKbYRfYWU/Ya6uXnxP1AnvIiLfm2d3zbsW24vQJ6FkS4LYNseiDtSsRromkEB6FyCS6d2JAr/wW743CvYwwJ3bUd9k0JgKN1+9LpShLWVkDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N9x9yQt4; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N9x9yQt4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm5lY2BXbz2xd6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 00:42:48 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631AC5Qi119453;
	Wed, 1 Apr 2026 13:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=runZcQ
	77qGZr+zXFQOHG4IyraY6zJgIY6sMAaFMFqlE=; b=N9x9yQt4REDaxQJvct7j4y
	L/jkwPjXmtxejshRJ2ymESSKCjTFVG7Mdv/l20y6PrW4UQt+yLy07tIiS46/mKPN
	/0copgVvAMKYnbqL9vL/K96sPYyfDLmGR3Q3Hf+vrKfPVlcUoakxHJ7YCeW052fL
	tsgBNFq7WWtw8i6Xsge8tuMWb+QJjh3QEonvBvmDEwgbtqbKLJl4uMTPH6a9Vu21
	UrNldB8ve4kvq5TXBmDhOLd3jXV8f1oZc+H4hxV/53sbYPXpT73YXNBUo7qsuVuX
	uF0URywJgNqZynPxRCUVys+fWOUQtzlmZ9ksnK5D5gxdk7zQZDx6Iyb2GID5CW3w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms7jj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 13:42:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631CkV80030955;
	Wed, 1 Apr 2026 13:42:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjwkpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 13:42:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631DgWj329688512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 13:42:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB3B12004B;
	Wed,  1 Apr 2026 13:42:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9619420040;
	Wed,  1 Apr 2026 13:42:29 +0000 (GMT)
Received: from [9.39.17.213] (unknown [9.39.17.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 13:42:29 +0000 (GMT)
Message-ID: <82c2fcd1-1756-4f61-b4cd-f02767701737@linux.ibm.com>
Date: Wed, 1 Apr 2026 19:12:27 +0530
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
Subject: Re: [PATCH 1/2] powerpc/kdump: fix KASAN sanitization flag for
 core_$(BITS).o
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260321053121.614022-1-sourabhjain@linux.ibm.com>
 <tstzmm8o.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <tstzmm8o.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cd20ce cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=ZS8Cze6H77hOx2eYTWQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEyMyBTYWx0ZWRfX3+jwTK1+g18V
 FlKL0bLc29nFVtEusm4A5uvDGt/Ba5mFUL2TaYApiTJJlT7g1SeuOAlt/1/YU+UK52Z8lSi5jBu
 xuVAD38zDdCJTTzjNJGyMh52zTApQcDFmmCP3lL4f3kZmw3ncIWsSjHwpJhxhumXR7ciDKuD0Xe
 ty5wbWBG+6OciY6dFofS2/wbpmV3svXKSJqC08y0ox8dceUCbxoWVjBZCzBdQeyNs5APB8/dBlR
 b8bhODh3utVv+l+3V+9/brr6KgXnSoA2gSnYoc+roZfEFFKxY3GtBqkGI3Jt8NENoAU/rqK4e93
 NVXli9qZPitTrty1o1Hfrs10Dbc7xImTeORj4LaKMyBXtf2hIhjBskWWqn4HRL3fp1HbcQxERUp
 qhnYJSUq/H8GigiisMiHyjZ6msc+lmJB7fxODzIOfYya650jWMJxOjxW4fZyuJQwYEY5SukuZhQ
 b87Pjk+stNmXeny/M5g==
X-Proofpoint-GUID: QAzxBi8ufHn9eFfAN-OnSDBtKLCHKTvQ
X-Proofpoint-ORIG-GUID: 1Wf37R0I7A2NzsDYU8mrJ3KyzXQ0jlqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010123



On 29/03/26 07:26, Ritesh Harjani (IBM) wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> KASAN instrumentation is intended to be disabled for the kexec core
>> code, but the existing Makefile entry misses the object suffix. As a
>> result, the flag is not applied correctly to core_$(BITS).o.
>>
>> So when KASAN is enabled, kexec_copy_flush and copy_segments in
>> kexec/core_64.c are instrumented, which can result in accesses to
>> shadow memory via normal address translation paths. Since these run
>> with the MMU disabled, such accesses may trigger page faults
>> (bad_page_fault) that cannot be handled in the kdump path, ultimately
>> causing a hang and preventing the kdump kernel from booting. The same
>> is true for kexec as well, since the same functions are used there.
>>
>> Update the entry to include the “.o” suffix so that KASAN
>> instrumentation is properly disabled for this object file.
>>
>> Fixes: 2ab2d5794f14 ("powerpc/kasan: Disable address sanitization in kexec paths")
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Closes: https://lore.kernel.org/all/1dee8891-8bcc-46b4-93f3-fc3a774abd5b@linux.ibm.com/
> Nice catch. Indeed seems to be missed in the Fixes patch.
>
> I think you might want to Cc: stable too, so that it is auto backported
> to previous stable kernel releases too. The Fixes patch was added in
> v5.19 kernel, maybe we weren't testing KASAN + Kdump, but it's worth
> backporting to all stable kernel releases, IMO.

Yes, it is worth backporting this to the stable trees. I will update it 
in v2.

>
> LGTM, please feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>

Thanks for the review Ritesh.

- Sourabh Jain

