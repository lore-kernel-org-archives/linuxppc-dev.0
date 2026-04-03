Return-Path: <linuxppc-dev+bounces-19285-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D1CE85388
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 17:41:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnQyQ5gzwz2ynh;
	Sat, 04 Apr 2026 04:41:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775238110;
	cv=none; b=PqciN+vlKIk7m9pN4AaSV966KgmS5lO/2hoMgikzdGcLk89Uh2PrPdlRR+V/zW5E06rsHhaf2ExY/03DNDvXV/yBJfniYTcGVwPu1S6rXW3ZG/E/LSWve+hLe/vK1O4MBd1hTo9Q/rUUQs7dYWx3hR0gjPkyoJ+MepWAH8Eia02K6RZkFPnbRHwHj+TFVl/9DhRSZf0lSCqS8q18EMHGrc92p/0NlCCQp90p56Syl8ivOJWg80mCzPB1zTZSBK3CGakcBNRssjQlOQZig62nbIF5YnGFDDtf34CCIrcJwPcAS63EAU8sQCl82IPFFlkPeoiyJcziNxdfa4eFw+apZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775238110; c=relaxed/relaxed;
	bh=XkxScTQSBH039AIlOz7s4kDxGFGT8EvumFs+M+Lv59s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mT2PKnQ5k545rCL90o6LZkxDTLKtsy6Xk2B7PxwrY/TYHJ7lM2ArjtPGGoLbFA9ed0EljKgkpx6pVscxSWdJUMrhHz+AC/hNlPewlqfgoa7dnAH54OQMwLOMDlwxwvlvGB1T8qFf5AuImZQtMywJJoQ84QxOdq/VC1gwgnrb+4F4cpG/MPqJXib3KeXyoBH+dhjE9YiMb+t66Rm7uZ0bkSuKPSddJ2DL9x7Fk6i1AmDmwYEm7oBZeYsO6j7USUT4j3fYOGGsRWMyLhCWeaRNZEzUvHr8NxooPAnCkkOuzQV3RSIIqbOWh/Byksy2UHaORbqVZguf/O07CeKLSpoI1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d7GbwScI; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d7GbwScI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnQyQ0CFvz2yjn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 04:41:49 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6339bDlG270868;
	Fri, 3 Apr 2026 17:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XkxScT
	QSBH039AIlOz7s4kDxGFGT8EvumFs+M+Lv59s=; b=d7GbwScI33XM97muP/sQQH
	5qqHFFGrHElotpalSLY9r/kORDfjrKTAaGWQWQN61zeW4go4wVSm3smFVNCJRScF
	EXKlVXxSJdfTlImO7aL7mI29hocZXihwf9s4f87O5enYVX6sbmQlLQoheziW9x8G
	1wCeq+HGxYc8ypqI1QhHnOuaOKrowRZsWvZJTJobIS3Dx303xncRxCXawO2qMrbG
	E0YwWoiXnmBzPokeWLL0832nchHvrPrbAYZTOLi+2pRT+KgChexqQzb4sIsLtY7v
	leB/FEl21at9my174AY2kFtKfCTegWcLElHhxQL7C8P3pLCKcxoCp0UKgefsnVaA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcrmyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 17:41:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 633D3UWp005947;
	Fri, 3 Apr 2026 17:41:38 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spyf0tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 17:41:38 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 633Hfcu319268314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Apr 2026 17:41:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55B115805B;
	Fri,  3 Apr 2026 17:41:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C286058058;
	Fri,  3 Apr 2026 17:41:32 +0000 (GMT)
Received: from [9.124.211.212] (unknown [9.124.211.212])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Apr 2026 17:41:32 +0000 (GMT)
Message-ID: <d48fe27a-75e6-4431-8a0a-427e79adc84e@linux.ibm.com>
Date: Fri, 3 Apr 2026 23:11:26 +0530
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
Subject: Re: [PATCH v3 07/13] selftest/mm: register existing mapping with
 userfaultfd in hugepage-mremap
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
 <b3a1760e4583340e767d4045b90784ee41c8773e.1774591179.git.sayalip@linux.ibm.com>
 <142f8c68-43c7-4a6a-bd2c-1c5ebda09b27@kernel.org>
 <7b6652f3-c994-4ef4-87a4-5473cd1254b7@linux.ibm.com>
 <a1527067-0d49-48dd-85c5-06b628471424@kernel.org>
Content-Language: en-IN
From: Sayali Patil <sayalip@linux.ibm.com>
In-Reply-To: <a1527067-0d49-48dd-85c5-06b628471424@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cffbd3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=mgfXflzu82Chz1Ycc7MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jyrK17GrSu3fk7v3w_MYtr3q3dtVP1Ud
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE1NCBTYWx0ZWRfX4L05kWTBg2oF
 YCgJXnPDx3h+vpsD7qvf5j1A+2q6dUnNBGWMNaXgqqs9CY5ZsN5T7L+JAOJBd9aD1cw1TmZjJBs
 XKiT7LbCE+aZmA+6SQYi2rQxt99/2RTZiTKCl8gjBoJ9Wpnhc0AUIpTfsouYHHz4e/XIC9Xujxo
 AUkpfgTZZGUVwrmvMC5owzLNCAG+XXyUB2K6tt7xgMuSpWHH1kBxrAPJbobpmcToLBhwjipmoPK
 3ulaeFeF07Bo6TJLt72eYsoAQQ33w3k69nYMQDXKDU/GW7C81y1rgad4xhh6x8kdMApGULU/Hut
 S2CF2ZTT3CA1G5e2CVpjzw4pD5fOSOPISBHOZpGmSfPFIZzYcoUpVDcXBmPrJmJksplf5ZdZtYv
 VDJGfHiI3HyC2tM19GoI05tx6cP1U4yu4YYUBbt14wh8n91JfIdrdspAZAuomdF/3jL7Y3rsQvd
 2lv0DDtooZyQrrYyRTw==
X-Proofpoint-ORIG-GUID: t7yKBDzj05PTTN_bQv44gKStj1pyEK9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604030154



On 02/04/26 13:01, David Hildenbrand (Arm) wrote:
> On 4/1/26 16:43, Sayali Patil wrote:
>>
>> On 01/04/26 19:48, David Hildenbrand (Arm) wrote:
>>> On 3/27/26 08:16, Sayali Patil wrote:
>>>> Previously, register_region_with_uffd() created a new anonymous
>>>> mapping and overwrote the address supplied by the caller before
>>>> registering the range with userfaultfd.
>>>>
>>>> As a result, userfaultfd was applied to an unrelated anonymous mapping
>>>> instead of the hugetlb region used by the test.
>>>>
>>>> Remove the extra mmap() and register the caller-provided address range
>>>> directly using UFFDIO_REGISTER_MODE_MISSING, so that faults are
>>>> generated for the hugetlb mapping used by the test.
>>>>
>>>> This ensures userfaultfd operates on the actual hugetlb test region and
>>>> validates the expected fault handling.
>>>>
>>>> Before patch:
>>>>   running ./hugepage-mremap
>>>>   -------------------------
>>>>   TAP version 13
>>>>   1..1
>>>>    Map haddr: Returned address is 0x7eaa40000000
>>>>    Map daddr: Returned address is 0x7daa40000000
>>>>    Map vaddr: Returned address is 0x7faa40000000
>>>>    Address returned by mmap() = 0x7fff9d000000
>>>>    Mremap: Returned address is 0x7faa40000000
>>>>    First hex is 0
>>>>    First hex is 3020100
>>>>   ok 1 Read same data
>>>>   Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>>   [PASS]
>>>>   ok 1 hugepage-mremap
>>>>
>>>> After patch:
>>>>   running ./hugepage-mremap
>>>>   -------------------------
>>>>   TAP version 13
>>>>   1..1
>>>>    Map haddr: Returned address is 0x7eaa40000000
>>>>    Map daddr: Returned address is 0x7daa40000000
>>>>    Map vaddr: Returned address is 0x7faa40000000
>>>>    Registered memory at address 0x7eaa40000000 with userfaultfd
>>>>    Mremap: Returned address is 0x7faa40000000
>>>>    First hex is 0
>>>>    First hex is 3020100
>>>>   ok 1 Read same data
>>>>   Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>>   [PASS]
>>>>   ok 1 hugepage-mremap
>>> Okay, so we tested mremap() of something that is not even hugetlb.
>>>
>>>> Fixes: 12b613206474 ("mm, hugepages: add hugetlb vma mremap() test")
>>>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>>> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
>>>> ---
>>>>   tools/testing/selftests/mm/hugepage-mremap.c | 21 +++++---------------
>>>>   1 file changed, 5 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
>>>> index b8f7d92e5a35..e611249080d6 100644
>>>> --- a/tools/testing/selftests/mm/hugepage-mremap.c
>>>> +++ b/tools/testing/selftests/mm/hugepage-mremap.c
>>>> @@ -85,25 +85,14 @@ static void register_region_with_uffd(char *addr, size_t len)
>>>>   	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1)
>>>>   		ksft_exit_fail_msg("ioctl-UFFDIO_API: %s\n", strerror(errno));
>>>>   
>>>> -	/* Create a private anonymous mapping. The memory will be
>>>> -	 * demand-zero paged--that is, not yet allocated. When we
>>>> -	 * actually touch the memory, it will be allocated via
>>>> -	 * the userfaultfd.
>>>> -	 */
>>>> -
>>>> -	addr = mmap(NULL, len, PROT_READ | PROT_WRITE,
>>>> -		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>> -	if (addr == MAP_FAILED)
>>>> -		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
>>>> -
>>>> -	ksft_print_msg("Address returned by mmap() = %p\n", addr);
>>>> -
>>>> -	/* Register the memory range of the mapping we just created for
>>>> -	 * handling by the userfaultfd object. In mode, we request to track
>>>> -	 * missing pages (i.e., pages that have not yet been faulted in).
>>>> +	/* Register the passed memory range for handling by the userfaultfd object.
>>> /*
>>>   * ...
>>>
>>> While at it.
>>>
>>>> +	 * In mode, we request to track missing pages
>>>> +	 * (i.e., pages that have not yet been faulted in).
>>>>   	 */
>>>>   	if (uffd_register(uffd, addr, len, true, false, false))
>>>>   		ksft_exit_fail_msg("ioctl-UFFDIO_REGISTER: %s\n", strerror(errno));
>>>> +
>>>> +	ksft_print_msg("Registered memory at address %p with userfaultfd\n", addr);
>>>>   }
>>>>   
>>>>   int main(int argc, char *argv[])
>>> Yes, that code is extremely weird. I wonder if this was some
>>> copy-and-paste from other uffd test code.
>>>
>>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>>>
>>>
>> Hi David,
>>
>> Yes, the test operates on hugetlb mappings created with
>> |MAP_HUGETLB | MAP_POPULATE|and sets up userfaultfd. Consequently,
>> registering it with |UFFDIO_REGISTER_MODE_MISSING| does not result in
>> any userfaults.
>>
>> Originally, the helper function created a separate anonymous mapping and
>> registered it with userfaultfd instead of the address supplied by the
>> caller. However, the test operates on hugetlb mappings, and the registered
>> anonymous mapping is never used in the |mremap()| path being exercised.
>>
>> Would it be better to remove userfaultfd registration entirely from this
>> test, since that path is not actually being tested?
> 
> If it's tested with your change now (which I think that's what
> happenes), this is fine.
> 
> It was just very weird before, because it tested something fairly unrelated.
> 
Thanks for the review. Yes, tested with this change and it behaves as 
expected now.

