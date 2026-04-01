Return-Path: <linuxppc-dev+bounces-19174-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18581076387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 17:34:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmBtG5446z2yjV;
	Thu, 02 Apr 2026 04:33:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775064838;
	cv=none; b=XitISBM/odiouAhPFCsbzYHTn6Jur7H0RZ7wa1qIyHvriuapgSXQgfJCpyLs0TPlIhu7gkcEyl3Qgdj1z+MvrtGKZhu4jLkWICNNPGWQhDNpIbKAItxPVTQhOLDcakMGoY6EoBDYA1NNe92UerJfOKEeiydc3RU7+YX82tiIzU3M2w4bBkVdFlk2oMy4AT+LuMaOA2FYnVPrab5lr3nicz9qhQMKmEw8FVXMzfNHqk87b+Ws1H6GFSi39lnRi7+tFEOT3v2WhIHwW0Nomk+qGkt+uyLwqBDn6BlidFatCVOgTLzh0ngeGfLFFZE06Twj9ASx4EBjZM4ucxY6ZzBzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775064838; c=relaxed/relaxed;
	bh=rSqaC2HS6F3jm0Ha+Zxiv2wIM9/dauwd7UVnyK3ZjbE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O7PVnajiBxUpnWWANT6OGrYOF8aEH+SHCx479X5HEtAzgE/7zHqNbMgzFRhjM3Vuf6HBM89f29/a76IUECQYFj+aNeZ3bRb/MBBgJq73dN/zNFgIG8WFqMWQHgtrPuTTXjpSBJ0ChmA3EjdUIbd17bL4PVRluXqYYMD3oqPoy5HQwND+gtsSotb12v5PXnww7UCX9DWS9irFdFm09FQhyDlOiaPlYENWJhDUkI45ucZJlmFsjkT/U8qTYpAVSDT5aewMgHcQEIHMlIT4KPhcAmMleGRQ12sNcywC8kIKVr143UI80x5GKgivgKEUrXqMfoBxVdkpYiR4oxbgjvaKrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o1DVKJC0; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o1DVKJC0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmBtF0986z2yj3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 04:33:56 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631AVPX0505649;
	Wed, 1 Apr 2026 17:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rSqaC2
	HS6F3jm0Ha+Zxiv2wIM9/dauwd7UVnyK3ZjbE=; b=o1DVKJC04XxVqWAtIzvm4Q
	LvBKhissxWZgbfjOMM41uOIN40Vbf7jf8rD5RxfPQpQ8rxnwmMJCTWMrjuTec8f4
	O+LXOFaX5MtNt9OwkYdW8m5/6Tlsy7A6TacUJeiTkHJtHOmepgg79JpyRxZTRkq7
	22pxvXhguFyk2/LGs0FlKOYyGjBQAG75lFktzcBkT0rVrvhXrU/5NgrEGB9s+np1
	YtSPbsKbjeZaQHj3bQ1K5izuMlXdtOlQP6iru4ZV7/lJbr2hksjo5YyawNOt3rud
	Ux2zjYfchNL/r75AR4k3CvwZBrqhXbNZ/YjQ8/6tx+1qqoA3TibcvbJ+gjo8d+hA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g21fg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:33:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631FYUVo022165;
	Wed, 1 Apr 2026 17:33:43 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan6pjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:33:43 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631HXhgG26673892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 17:33:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C00458052;
	Wed,  1 Apr 2026 17:33:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36C5558056;
	Wed,  1 Apr 2026 17:33:38 +0000 (GMT)
Received: from [9.39.18.42] (unknown [9.39.18.42])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 17:33:37 +0000 (GMT)
Message-ID: <f8934e88-5b88-456d-affd-e29e2f78b6cf@linux.ibm.com>
Date: Wed, 1 Apr 2026 23:03:31 +0530
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
From: Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH v3 11/13] selftests/mm: fix double increment in linked
 list cleanup in compaction_test
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1774591179.git.sayalip@linux.ibm.com>
 <4c47a2ebbc41f90c7a0cb3f8b34106b2b64296f6.1774591179.git.sayalip@linux.ibm.com>
 <b6d211e1-233e-4079-a8b9-6682e12077ba@linux.ibm.com>
 <5684cab6-d5a6-4de9-9545-f8cae775d825@kernel.org>
Content-Language: en-IN
In-Reply-To: <5684cab6-d5a6-4de9-9545-f8cae775d825@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cd56f9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Ikd4Dj_1AAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=T6nULJMaX99D9d00DIAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Bxer0GwKb5xpt3tAX3oiBerSsEtjsxnZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE2MiBTYWx0ZWRfXzEISyrtqStlA
 hNkcbo7yzW2GQIQlG/T++H5n5nbP9R4jBNPLST6vVhS0DrgKsrqn9FT6HkVY/ip1FchAa3/SLMl
 KtPoBJcHbTL157FOIpjzDMq0ytao+4spNvl9bCbLTdzKwtVyL4VgqLI2+WScV1BTmtyMjS9L6Vj
 kwe44k4cuZ4BTzzlv2FQdD9ytLMhoDWFzrc5nqQyHpXhEEN2Gyih5VhWoe26aHMR36iVWy6dsVQ
 zZiWJpH/ckXojBJZwOoLcpOYp2QLtRj3IYONhTkJ+8olYpEUpFpFaO85uHSBxLD9MDiRtPze2oP
 uR9WdL9QrlU+cSU0/fLvpR5MDQpt1kl9Puyp10hbaLabexZqJYewwFd4GzE9Hlj4Z0QdAONKp9k
 FZOHRpiRtOXRbJZ7TZtr3cxKjuDHfHv2/mJD3kY3SJTbAtJxbPEpBj67f66RlDs6/2VUSQ+P/CB
 V4OX2hHq/vbPwVps/jg==
X-Proofpoint-GUID: aqf5EXqq0VS2xdQNbf1Bhqhvgccm-WRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010162



On 01/04/26 20:09, David Hildenbrand (Arm) wrote:
> On 4/1/26 16:32, Sayali Patil wrote:
>>
>> On 27/03/26 12:46, Sayali Patil wrote:
>>> The cleanup loop of allocated memory currently uses:
>>>
>>>       for (entry = list; entry != NULL; entry = entry->next) {
>>>           munmap(entry->map, MAP_SIZE);
>>>           if (!entry->next)
>>>               break;
>>>           entry = entry->next;
>>>       }
>>>
>>> The inner entry = entry->next causes the loop to skip every
>>> other node, resulting in only half of the mapped regions being
>>> unmapped.
>>>
>>> Remove the redundant increment to ensure every entry is visited
>>> and unmapped during cleanup.
>>>
>>> Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
>>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
>>> ---
>>>    tools/testing/selftests/mm/compaction_test.c | 3 ---
>>>    1 file changed, 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/
>>> testing/selftests/mm/compaction_test.c
>>> index 30209c40b697..f73930706bd0 100644
>>> --- a/tools/testing/selftests/mm/compaction_test.c
>>> +++ b/tools/testing/selftests/mm/compaction_test.c
>>> @@ -263,9 +263,6 @@ int main(int argc, char **argv)
>>>          for (entry = list; entry != NULL; entry = entry->next) {
>>>            munmap(entry->map, MAP_SIZE);
>>> -        if (!entry->next)
>>> -            break;
>>> -        entry = entry->next;
>>>        }
>>>          if (check_compaction(mem_free, hugepage_size,
>>
>> Sorry, this change is not valid.
>>
>> The goal of this test is to verify the kernel’s ability to compact
>> unevictable (MAP_LOCKED) pages. The loop is intentionally written to
>> unmap every other chunk, thereby creating fragmentation with locked pages
>> before check_compaction() is invoked.
>>
>> With the proposed change (removing the double increment), the loop ends up
>> unmapping all allocated locked pages instead of leaving a fragmented
>> pattern. This results in memory being effectively unfragmented.
> 
> Ahhh, we should really make that clearer in a comment. I missed it myself :(
> 
yes, let me add a comment to clarify this and send it in v4.

