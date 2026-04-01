Return-Path: <linuxppc-dev+bounces-19177-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D22810FCAD2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 20:46:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmH810hk9z2yjV;
	Thu, 02 Apr 2026 07:46:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775076369;
	cv=none; b=hCmI1McD4wHmnCI+AMQ/H0Y/agnuCpSX9qnDe8UPvb/XWh9QDIg5iJyS8OD2JIsWniK/sLda/mUIwwu2hXqkCp4rZJi+eYSm+VjRuiJgKEPLGAuX1vxZotrOa6CeyOrDQpT6vzLbTUzMs/1bGXfzHXsRgV2bGDy9aJ9+Wkc37kO0Vpd9b1Clu9+ppcmoXmnWTbFB2s2YbHYC0UMgOaIdR34BCWnYoO9ZuN/eYKfvN3308YYI+YdxmJJJLPcCTkLMhNkc+m2jnxmsBcBaJ6lOla9E3KJvG/rW9uINz4L+Y4Fmo3bUcl9i5eeUGE8cocEy5cOaaYXxWmwDfQNIHjPr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775076369; c=relaxed/relaxed;
	bh=RWruVUI1tyA0IagjZ+3lclFkCSQNagbCICLF95nwFe4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PUd2ux81LQ0pAbClUv4V90sABD+xonfjRNs4FjdMBHv1mR6iOR+MxSa/7NKdu1OqbMrYrLKZCLOUm+0/LaBBg8BSjefqk++0WVxwEhWIkRLtEzFch4slsPp3HcpFeysC7slxd2Bud7XaU2XqogIAUoGN80QKUo4xYZH4I1BPeQqp1CyZvde+jPiKOd1HnLubXApPZZPkGxKWfJMbfwp+Qx4rrlmIUtZNYYwtD5rSNTE5QSRquhUWIC8XJT0qE6xKmXFHKqa6yxTTICuYk8ouDC6YoXlBjjX8c3LF44fxh3a8/aJI8/ADax14tK+yzduUEtRhq2u5GkPy/b6T372t1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E7b6l/2Q; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E7b6l/2Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmH8007fPz2yhZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 07:46:07 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631AjOUb015098;
	Wed, 1 Apr 2026 20:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RWruVU
	I1tyA0IagjZ+3lclFkCSQNagbCICLF95nwFe4=; b=E7b6l/2QjZCkcKJ5G4G/yI
	hK9FUV+8cIkcFYWGWsXdUJG9JFH2o0hURCYLGsttdJMwHxUp0BmjOPrddiIhTJBf
	JSI/aGGaWDK57MvekGVsXmjXF43WZ+YgR/eWbrEYJGU4x+eBOJ0e1RCTAPAizUvH
	LNKFbXVymu7GR2aJk/aB00teaB43zhUraGE3IQr/JL0BKicELbB5GeqpBRV7syMa
	FCPytU46RU4XoR2Sy5i9LRlIhshepaDecbeL5XoBO1FLlbYMktAfVIiqcZJpL0b/
	atvkCs90EAZ7CdXunmqS3oejFRPhJDZpEt1cpeSBr7Z+U0+JxByfRkfaIAC13fAQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3a4p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 20:45:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631Id5q2021709;
	Wed, 1 Apr 2026 20:45:55 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasqk58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 20:45:55 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631Kjsf427984504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 20:45:55 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D426458052;
	Wed,  1 Apr 2026 20:45:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CE1458062;
	Wed,  1 Apr 2026 20:45:50 +0000 (GMT)
Received: from [9.124.211.138] (unknown [9.124.211.138])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 20:45:50 +0000 (GMT)
Message-ID: <20a95f92-57f9-44cc-bc40-8110dd562998@linux.ibm.com>
Date: Thu, 2 Apr 2026 02:15:48 +0530
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
Subject: Re: [PATCH v3 06/13] selftest/mm: adjust hugepage-mremap test size
 for large huge pages
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
 <fd252496169a91c80e339910978f21c3f4aac9f7.1774591179.git.sayalip@linux.ibm.com>
 <4e859cfa-db79-4676-9509-81a2140db3f3@kernel.org>
Content-Language: en-IN
In-Reply-To: <4e859cfa-db79-4676-9509-81a2140db3f3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ImgjBi1YotGdXNs22t1V0XVsv_SW0sfH
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cd8404 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Ikd4Dj_1AAAA:8
 a=VnNF1IyMAAAA:8 a=pPYpmyHQdkSp_mSMAUoA:9 a=pz4v2tEdkw714-FJ:21
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PTslfsCMgxc-PgvVTdlUoFhCgIDowRJo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE5MSBTYWx0ZWRfX/vpITs/nmC19
 /HYzZkKvv7DnQZZjAVg/dqj9D4Ya0Zju+8RAbNF7ZC79P24cqL0i3Xl7aFvXeSah2TSCS2iLMKe
 Elu5RqPslaih4wdGEbIep85pvivsUFShFgT2nDqAQveRt/W6etlcGJfHwwKTbxhnUU1YHxVyzZB
 KV1ZQ0n5qrEwUxd8Tl4BkXe5Wx47/eqF2sDLN/3zzJp0UN6dw9YNP/bU0LSK5rncvL3FawzE06A
 o+5XjA5b1rzjhNrvTlmLXLgXjpejj+osr0A9E77Q8VjdSDiazL0lhoO4cwvr0poO1G2hJK+XLuY
 5a1MnnIouHfdYFflzxwgXSOaPP43O4bzx+SvZK565CPcKlV7rOICa4GhubHZ+mqm6K2YTwXz00a
 KVSI0Ijm3/KXSS8w/UG2++nO6DyGUREGBVIZzf0qBIlmemvJ6EUu4uQa4lCf1DFxMVGlnKlof8A
 ekT1kBhoZnFXhujbR4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010191



On 01/04/26 19:40, David Hildenbrand (Arm) wrote:
> On 3/27/26 08:16, Sayali Patil wrote:
>> The hugepage-mremap selftest uses a default size of 10MB, which is
>> sufficient for small huge page sizes. However, when the huge page size
>> is large (e.g. 1GB), 10MB is smaller than a single huge page.
>> As a result, the test does not trigger PMD sharing and the
>> corresponding unshare path in mremap(), causing the
>> test to fail (mremap succeeds where a failure is expected).
>>
>> Update run_vmtest.sh to use twice the huge page size when the huge page
>> size exceeds 10MB, while retaining the 10MB default for smaller huge
>> pages. This ensures the test exercises the intended PMD sharing and
>> unsharing paths for larger huge page sizes.
>>
>> Before patch:
>>   running ./hugepage-mremap
>>   ------------------------------
>>   TAP version 13
>>   1..1
>>    Map haddr: Returned address is 0x7eaa40000000
>>    Map daddr: Returned address is 0x7daa40000000
>>    Map vaddr: Returned address is 0x7faa40000000
>>    Address returned by mmap() = 0x7fffaa600000
>>    Mremap: Returned address is 0x7faa40000000
>>    First hex is 0
>>    First hex is 3020100
>>   Bail out! mremap: Expected failure, but call succeeded
>>   Planned tests != run tests (1 != 0)
>>   Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>>   [FAIL]
>>   not ok 1 hugepage-mremap # exit=1
>>
>> Before patch:
>>   running ./hugepage-mremap
>>   ------------------------------
>>   TAP version 13
>>   1..1
>>    Map haddr: Returned address is 0x7eaa40000000
>>    Map daddr: Returned address is 0x7daa40000000
>>    Map vaddr: Returned address is 0x7faa40000000
>>    Address returned by mmap() = 0x7fffaa600000
>>    Mremap: Returned address is 0x7faa40000000
>>    First hex is 0
>>    First hex is 3020100
>>   Bail out! mremap: Expected failure, but call succeeded
>>   Planned tests != run tests (1 != 0)
>>   Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>>   [FAIL]
>>   not ok 1 hugepage-mremap # exit=1
>>
> 
> Why are there two "Before patch" in here?
Thanks for pointing that out, Let me fix it in the next version.
> 
>> After patch:
>>   running ./hugepage-mremap 2048
>>   ------------------------------
>>   TAP version 13
>>   1..1
>>    Map haddr: Returned address is 0x7eaa40000000
>>    Map daddr: Returned address is 0x7daa40000000
>>    Map vaddr: Returned address is 0x7faa40000000
>>    Address returned by mmap() = 0x7fff13000000
>>    Mremap: Returned address is 0x7faa40000000
>>    First hex is 0
>>    First hex is 3020100
>>    ok 1 Read same data
>>   Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>>   [PASS]
>>   ok 1 hugepage-mremap 2048
>>
>> Fixes: f77a286de48c ("mm, hugepages: make memory size variable in hugepage-mremap selftest")
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
>> ---
>>   tools/testing/selftests/mm/run_vmtests.sh | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>> index afdcfd0d7cef..eecec0b6eb13 100755
>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>> @@ -293,7 +293,18 @@ echo "$shmmax" > /proc/sys/kernel/shmmax
>>   echo "$shmall" > /proc/sys/kernel/shmall
>>   
>>   CATEGORY="hugetlb" run_test ./map_hugetlb
>> -CATEGORY="hugetlb" run_test ./hugepage-mremap
>> +
>> +# If the huge page size is larger than 10MB, increase the test memory size
>> +# to twice the huge page size (in MB) to ensure the test exercises PMD sharing
>> +# and the unshare path in hugepage-mremap. Otherwise, run the test with
>> +# the default 10MB memory size.
> 
> PMD sharing requires, on x86, a 1 GiB area with 2 MiB hugetlb folios.
> 
> How does doubling sort that out?
> 
> Also, why the magic value 10mb?
> 
> 
Hi David,
Yes, 1GB huge pages are mapped at the PUD level and are not involved in 
PMD sharing, as huge_pte_alloc() skips sharing for sizes other than 
PMD_SIZE.

The issue here is due to an unaligned memory size on a 1GB mapping.
This leads munmap() to fail at an unaligned address, causing the 
subsequent expected-to-fail mremap() to unexpectedly succeed.
The default memory size for this test is 10MB.

Aligning the size to a multiple of 1GB avoids this failure, but it is 
not related to PMD sharing. I will update the description in v4 to 
reflect this more accurately.

I will also update the test code directly to align the memory size to 
the huge page size, rather than modifying run_vmtests.sh.

Thanks,
Sayali

