Return-Path: <linuxppc-dev+bounces-19284-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BEFE85388
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 17:41:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnQyL27tDz2yjp;
	Sat, 04 Apr 2026 04:41:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775238106;
	cv=none; b=UYwMus3rOO9ygLU18iEyDOtGF7FMA1SFryq8k1DkP3c8tQM8rVWOeckkbYJmMzjAesUDmWHpKt+nupEKDBJhMWUSuQyRGoglzPs09WhwSVW2xMgWaOgCP3nRjB16sR00RQJf4x99aDsEbHYtEd/BWbpJO1AjqxYaN+x3Qnz3OtrFlUTF1fn170K7kTQS5UeHwm+BYU7VMLKct9sLiU4FDxWKzRuMRH1i2N2N9lvC1ceLr5FnyPOO1n8B6dTbYNwtWGo6b79D2VB0oozreEfCYvKOHCgDYSV4IA7c4C9mTuaMrZTpNx5hiO74vDwWrdV2tDhHInJ89cicFVn8WZULzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775238106; c=relaxed/relaxed;
	bh=SN7zsG2ScCpIacyjlZ3u4/94eWE+weu3dkGlkVIEV/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJPZJGXFo45TYM4as4KswxMcaVDgJMzisDKjfzBvq1nyNewFRzlakQvSOcFaV3z/so/DKcX6CaCDC+dMxLMISupPOCGecj6no5pL4EPUW2U3aTCBAQGIYgseIBE46UpVzY4rbul9fMgzP/TUCF2qjmSAXvYD0aCezyfWdJXCn+uE0v/0usilRrVu/f2bLXcajXKoq6hdkyD7C/F1Xv1o8UJDyUVCw4fIcCfN69kciphCasLHyvinF8jtWx9kTR8nhtJ9Cf9mtgIFqrfzT8t7XaCukQ6DynHBjzd/jUWiRaObT7sYGhZt4wwLL06E9o9gp9G7mjfVWWcPlHIKboL+FA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=smzJ/XWD; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=smzJ/XWD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnQyK1QYVz2yjn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 04:41:44 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6333pq0C337199;
	Fri, 3 Apr 2026 17:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SN7zsG
	2ScCpIacyjlZ3u4/94eWE+weu3dkGlkVIEV/g=; b=smzJ/XWDfOUPHCGidISTNV
	L/C1g26RBv4tDqNMI4T/VSCxRtQlFje3/ylo+L1szf1Yzzy1+NdTQOKzCwO3ZBDt
	PLvUui3RkE0C0mtzjMOaKgT1iJsP9zsR+oWe8gd/+p1fZ1xxvhOQKDMZJWLryOsT
	5WZ3eUNZ/cdrIklkn1h51w3UsPD7cisxYBW+VyPNvjOTZTv+2fjcEXZr/ahGyz+1
	fNusO7slpM6NM2qrUjRYvSMT3zquXdZVuCIsx5ITtkqa66aW77hb/eXkdJThb+aS
	Jv4JZEwTCthlGtb3oJbW8lHPoULgsIojfQJVwKJUSmUZIYhnptOgjzZox5H4KzMg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msgk56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 17:41:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 633DZWjL022165;
	Fri, 3 Apr 2026 17:41:33 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tanewhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 17:41:33 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 633HfWmK51052844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Apr 2026 17:41:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BEE35805C;
	Fri,  3 Apr 2026 17:41:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2BF658058;
	Fri,  3 Apr 2026 17:41:26 +0000 (GMT)
Received: from [9.124.211.212] (unknown [9.124.211.212])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Apr 2026 17:41:26 +0000 (GMT)
Message-ID: <f0905481-3ed3-49e6-a25d-4b58dca7493c@linux.ibm.com>
Date: Fri, 3 Apr 2026 23:11:25 +0530
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
Subject: Re: [PATCH v3 08/13] selftests/mm: ensure destination is
 hugetlb-backed in hugepage-mremap
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
        "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1774591179.git.sayalip@linux.ibm.com>
 <3b6ffba238a4b59de891acf896fa25d7d3193228.1774591179.git.sayalip@linux.ibm.com>
 <ee15d52f-45df-415b-b0d9-3d267d147e5c@kernel.org>
 <b590a17c-13ed-45f4-9f51-ac662d00e7bf@lucifer.local>
 <066a146b-7dbb-408e-bbc0-542bdcdd6681@linux.ibm.com>
 <86889304-c450-491c-8c06-48ca9c973531@kernel.org>
 <0a1befae-1037-4bbe-b976-352ef4607d2a@lucifer.local>
Content-Language: en-IN
From: Sayali Patil <sayalip@linux.ibm.com>
In-Reply-To: <0a1befae-1037-4bbe-b976-352ef4607d2a@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cffbce cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=qm_7xFvvd-ZT-DRSKOsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE1NCBTYWx0ZWRfX1VHUKzgO50IW
 zvSScUYH15e61j8Mv/U00EaX/WTpP05OR2CYzs8NKhgM+GO3Uj4KwE3TvlPw8diHp36rvvTanHG
 xijcOQaNkXR5wwTpnHo5g67lJpmeAH9pFMr9wiZYtIPt23DZWKyoLkJaDEeV+YOV3QvFG2/tTj0
 sow/eEbTFcu0VNa2ROV5kbculLiViT+036AuUWiJGCVydzCnIBg9s7K2t5CqI2oGNFq+DepgpAL
 Lcq5KGksob+yDhcHt+gH5EmlGwdNPEtOfB7aMKM9uwwXkT0fiYns2qEsOIvchQO+gV1gaVVtOwF
 /VMGxdkl9p7wFtwz7uEpoMuiJw+dNlPF6lg6bdBXl+x7WuDZ9d1CtFXTKpE3C/+eALxp5ZRN58Q
 SyNxLVRhdmsFdHBcARWdh/mxIdNyLQyFfH6fku+nFyGj4HCbrF9NpbNsVrPvfpFvv7X30GSZeUw
 0uIPfLIS+p/RPJ+DgwA==
X-Proofpoint-GUID: NkR5wdTsKaLFNCkn1t8m49sbou6P4J0W
X-Proofpoint-ORIG-GUID: FiviqhHb2Gp9AyqAPb-0lbZGviYveWRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030154



On 02/04/26 14:35, Lorenzo Stoakes (Oracle) wrote:
> On Thu, Apr 02, 2026 at 09:33:29AM +0200, David Hildenbrand (Arm) wrote:
>> On 4/1/26 22:39, Sayali Patil wrote:
>>>
>>>
>>> On 01/04/26 20:10, Lorenzo Stoakes (Oracle) wrote:
>>>> On Wed, Apr 01, 2026 at 04:21:55PM +0200, David Hildenbrand (Arm) wrote:
>>>>
>>>> OK so digging in:
>>>>
>>>> mremap -> ... -> vrm_set_new_addr() -> get_unmapped_area() -> ... (in
>>>> ppc arch
>>>> code) -> slice_get_unmapped_area():
>>>>
>>>> unsigned long slice_get_unmapped_area(unsigned long addr, unsigned
>>>> long len,
>>>>                        unsigned long flags, unsigned int psize,
>>>>                        int topdown)
>>>> {
>>>>      ...
>>>>      /* bunch of checks */
>>>>
>>>>      /* If we have MAP_FIXED and failed the above steps, then error out */
>>>>      if (fixed)
>>>>          return -EBUSY;
>>>>
>>>>      ...
>>>> }
>>>>
>>>> Is presumably where we hit the issue.
>>>>
>>>>>
>>>>> That is weird. An mremap(MREMAP_FIXED) is really just an munmap() +
>>>>> move.
>>>>
>>>> Yeah the weird bit I guess is that we _still_ invoke
>>>> get_unmapped_area() but
>>>> with MAP_FIXED set to indicate that we want the specific address, so it's
>>>> subject to the above checks.
>>>>
>>>>>
>>>>> Are we sure this is not some actual problem in the hugetlb
>>>>> implementation?
>>>>
>>>> It seems the 'slices' check sees if the _target address_ has an
>>>> equivalent page
>>>> size, presumably hugetlb-mandated, and fails if they're not
>>>> equivalent, so this
>>>> change is just accounting for that.
>>>>
>>> Yes, this change accounts for that by ensuring the destination is
>>> created with MAP_HUGETLB so it has the same page size as the source.
>>
>> Okay, weird, so it's the right thing to do to cover all odd arch behavior.
>>
>>>>
>>>>>
>>>>>
>>>>> But then the test suddenly requires more hugetlb pages, no? I don't see
>>>>> a good reason for the MAP_POPULATE, really. It will be discarded
>>>>> either way.
>>>>
>>>> Yeah I'm not sure about the MAP_POPULATE being all that important here.
>>>>
>>> As far as I understand, without MAP_POPULATE, memory accesses would
>>> trigger userfaults, and since the test is single-threaded and has no
>>> background handler for the uffd, it would deadlock. MAP_POPULATE ensures
>>> the test runs correctly by prefaulting all pages, but please let me know
>>> if I’m mistaken.
>>
>> So you are saying the test would deadlock if you are not adding
>> MAP_POPULATE? If so, please double check if that is actually the case.
>>
>> And if it's actually the case, please carefully document that in the
>> patch description, and probably as a comment above the MAP_POPULATE usage.
> 
> Do keep in mind MAP_POPULATE is not _guaranteed_ to work :)
> 
> For guaranteed populate you need madvise(..., MADV_POPULATE_[READ/WRITE]) or to
> directly fault in.
> 
>>
>> --
>> Cheers,
>>
>> David
> 
> Cheers, Lorenzo
> 
Thanks David and Lorenzo for the input.
I tested without MAP_POPULATE and the test works fine without it.
I will remove it in the next version.

Thanks,
Sayali

