Return-Path: <linuxppc-dev+bounces-23990-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C4EC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 05:11:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxKgS2kQ4z2xlw;
	Fri, 10 Jul 2026 15:11:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783660292;
	cv=none; b=Rz3qyHT7SSw1unDcUgRMwCDJXGMybaMzm/9U5hcTFd/P4od5iH0PtJpFTAogzUYJwlNv1dER3eRDB4NGSVbA3vu2ITFNzx6HpvCEJ9PTtmUfGjk7+nmnsKF4EYzYCsXp1eC9F5hzM8sFir4S+OlegYTW294XEz+T0E1YrEU2AtW2MYxzivgW+mfrh05pStVQmZzK4DMyNiv0V2T74axUIqEU+vevX05OFA1r7+l0XD96g/YP1t6JSloBCNTQDdDqXAYeSYg35TG2GlHFTmgBEdHNk65r6RS/CWjBS7rcIrOt9Xol/hDl3C7G1ypd7RPlJBim9fRAEfXWlqepMKttwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783660292; c=relaxed/relaxed;
	bh=V70VbEj1ScjUchlU553r0Xd4F46LqK16+8IJ3ntbpQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQmgH5Y4j3VfQ5viqr5uAPOjLa+VKoghd45NeHK+VCfvHVDgn6n6mxMDJVO7Tli5MLuJUkbFLq3rvmTcAoUUkV7I3rKRIaDCpFvhL7i6/DGXQ8D84nQz12Y06/FfK2gohkqnE4MO5MelGviGGNu92uAftAMhDFYdWtIyx5tclM3DylOysLsuPWBreakS2LRskinHgVWBexNwsPz1etRAcWIYDi899LII1659QAew8bgj0/Xzf274rgmkDduZy9u3SXr999310YvUck5UCyKTrIGM2m4P2RGSI0lDSvLynnUaq40knOWtY0PmDiFnlTF1r8x87ohPoaWeTpmFLJBimw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ph4b7BZG; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ph4b7BZG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxKgR1Rw3z2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 15:11:30 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3nZq3075636;
	Fri, 10 Jul 2026 05:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V70VbE
	j1ScjUchlU553r0Xd4F46LqK16+8IJ3ntbpQM=; b=ph4b7BZGCLL6yb2U1Xwwcf
	xa+rUaUVswqAXodKI9w9TNoYs/ySVTgRVV1fS6f4nkR9tq/NE3wz2T21syNHazIc
	nLpTr2ncrtSfobNuf1flty6Yf8W+cCdO6EhWNYsn4lO9m8o42yL6XmO6hFmnq9O2
	WRNNEIN0EEo9LfZfeHgmuYF9YbR053pvpZUPVnGT3WCl7OfHyCFztPlYlaMJvzNe
	BgOWe6Wt05gIBOFHnSW8U4aSkjudNtu3ZBxqhT990FqyvHDpz1YYg2qwtDE16hDf
	HFuW3pmBuXRgTcWBoJFyheWmf8/VOcmasL+QaaL1j6UWw6oI26tcOianXAl+bFcQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknvett-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 05:11:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A54Z9L017949;
	Fri, 10 Jul 2026 05:11:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6yg4x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 05:11:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A5BJ3246596604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 05:11:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE2A42004B;
	Fri, 10 Jul 2026 05:11:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE01820040;
	Fri, 10 Jul 2026 05:11:16 +0000 (GMT)
Received: from [9.124.216.105] (unknown [9.124.216.105])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 05:11:16 +0000 (GMT)
Message-ID: <4bea3407-38e1-4d26-8293-7700266a24cf@linux.ibm.com>
Date: Fri, 10 Jul 2026 10:41:15 +0530
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
Subject: Re: [RFC PATCH 0/6] selftests/vfio: Add sPAPR TCE v2 coverage
To: David Matlack <dmatlack@google.com>
Cc: alex@shazbot.org, shuah@kernel.org, amastro@fb.com, rananta@google.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
 <akwyZvbv7Fg8mfB2@google.com>
 <afb9bf4d-2258-4731-a28e-7f4eaa01ee0b@linux.ibm.com>
 <CALzav=eB5NwrHNq4bm2ooSFmTtGk3sfUk7_k+iE+Kwm+Jc9LFA@mail.gmail.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <CALzav=eB5NwrHNq4bm2ooSFmTtGk3sfUk7_k+iE+Kwm+Jc9LFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a507efd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VLoToYxrrouXz2LH_DgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=0lgtpPvCYYIA:10
X-Proofpoint-GUID: tAg1fWFAaUvzJjsA7pe8fuK0DQwiFHBu
X-Proofpoint-ORIG-GUID: EXTPp-LVbDKqDrGZm3KQsmZ38b284kHs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA0MSBTYWx0ZWRfX8izeTpmsTxGu
 nWVnQNKBO1ZTeDwfFlNjh/cDemT4A9fOmhiQ8N5L6J2GA5RYCSzDY13MTjWaYn5mfwG5LGRLJJ3
 Ma8al5MRjZ4kEnQDhT/POgwjEqK9L6Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA0MSBTYWx0ZWRfX5OyXUVww4uyl
 61W4qVO7lzu/jl/O3Up+s4BKNnpmP0crFjUktkccodlVM1cv9RsS2K87kHxJdSAnRY52hyCKEWl
 /iXdn+yuQII5f8lGieEjL2gUovHi8RFE4sMag570K2TUgiSCn5M9CkkCbVGlSXmWz4Y346agTNm
 6njuUR6rLe/8VkbU85/cIIu9Xem7IVzVYvb5WGuumNwr6y9cd9m8zESHnM+vaj3u3HLgMJ0WONf
 hKH288NfPTN4Xd3m2VY3gnyJxtXI3EC2Rati1VkfYLdyBdVMmiF6ABDqAzIWVTQWF5wG7mtYEnU
 PrZRMexy/iXL7GLNBOw7xuAO3PRNxbgr45oUvRjmnmdIipyihVhCkFcUfJ5ScnhVIsxU1NwokVW
 suLbg1mknuUrvIlmabcf6+4xeWm9VIjzUTsolJYFKrqIEof5EAZnqCQydvxhO9fSml7Z2VRsm79
 +/1GDXuTBi2bh/BmUbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100041



On 09/07/26 9:21 PM, David Matlack wrote:
> On Thu, Jul 9, 2026 at 1:49 AM Narayana Murty N <nnmlinux@linux.ibm.com> wrote:
>
>>>> Feedback is requested from the VFIO and PowerPC communities on:
>>>> 1. whether the sPAPR TCE v2 helpers should remain in the common VFIO
>>>> selftest library or move into a sPAPR-specific test helper?
>>> Responded in the patch. Let's move to their own file.
>> Will do. v2 will have:
>>
>>     lib/iommu_spapr.c         — all sPAPR logic, compiled only on powerpc
>>     lib/iommu_spapr_stub.c    — empty stubs returning -EOPNOTSUPP,
>>                                 compiled on all other architectures
>>     lib/include/libvfio/iommu_spapr.h — declarations
> Just one small thing here: You can put all the stubs in iommu_spapr.h
> as static inlines, then you don't need the extra C file. e.g.
>
> #ifdef __powerpc__
>
> ... prototypes ...
>
> #else
>
> ... static inline stubs ...
>
> #endif
Sure, will follow the same.

regards,
Narayana


