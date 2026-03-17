Return-Path: <linuxppc-dev+bounces-18291-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977FEF506CF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 06:00:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZhCM2D90z2yVP;
	Tue, 17 Mar 2026 17:00:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773727247;
	cv=none; b=MC10pg56L2RIGl5DHWcMRFu08WeH++Y6S/dlWX3xweZ6MTcBO9Ufn9fl8nHhWf3svGTl2FpSTRYqGVomiOqDLhUJ9BWFvTpgfRPGjwmijmEFgBOuk0cFLBo9cqO1CTEm9+75DCbiOT5+sI4w/GuNBnTAVwdEMCB218wbM5UoLeUkvmHTorN4jHSZsPoy6CUNs9Ja1DEkt9e56/s3t1rPx8NEAikctC7fDzYCmK15LRDGfd2e5lEc/SAqNjvv8UqGV4a2RhXDJh+bNWKGvHH2Qoajn+SumMmVwxRWXlMHYOzN/OiOzTTSd5N8+D1cg+0AUy/lRs9aTFgPAURZ1ZJgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773727247; c=relaxed/relaxed;
	bh=5Yjg5g/Ahc6j34B08hDY6aKdtXUYcqbFsbEYEzxC3OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=es9AtREkrAvp6oUrO6vIRIBf8hJnmZ9YDJE9YMbZXPWU9x1FD3d2VyigcdWav9GplSfYNrnxwhODm5+YGf5DnrGnZHYif3pVRjAgs7OMAA5wH5SWTGlW2G6Ad7LKRGYHzmHg1fbg1giBR5w4dHlrdntXNzTUb3fRTv4xpRqDKfX0m9oTK9uEGisv+/ky57Bg0oOpWzhUzFGraGjTphtIB+eAGKE9oHQM1GhOtgIuqvPtusJ6JdDqmS+okfX0hhcPeFKIWYHfQ4Gp4rRtLpkPxgkDUXaU5GupOPAQFe1h417XzCw/UVOii6g8an6GM006qFnzxfC1MXvLfA8hddMlbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=A/HXc1Yo; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=A/HXc1Yo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZhCL2FdTz2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 17:00:46 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GNNRLK3931551;
	Tue, 17 Mar 2026 06:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5Yjg5g
	/Ahc6j34B08hDY6aKdtXUYcqbFsbEYEzxC3OU=; b=A/HXc1YoYpQ8e0y0khcJx7
	YkJ1bo4JF3HC7EyuqyQsPGg0tVAynOUnVoxW3sRGBuQIGnLOHD4KFYg6TyzT/JJs
	RTXRW3emRR7IeCRym7NjxelfxZW8tIzCNAY3UNwml6l4SEMnKE2a0aUI5Wvb+xbC
	rX+Ii+6WnDueAhBDu41lq7K6jig1/z4UbfkVK7JcRubNz9WFC1Xy0+LsyKYfeS6c
	htpjOG6es0mDIeKkIA/UFFY1M647NOIKsbmuOPJqxH5mu0JgZkE6GgztZb4/gegQ
	xl1n3NSdAsp+wcr7UxknXAWLIB6eeX4MLHxbDytBWm8wmJsHbaztrVzbc8CSp1KA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyauas9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 06:00:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H5sKeJ005412;
	Tue, 17 Mar 2026 06:00:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s7xyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 06:00:32 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62H60VbG30409360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 06:00:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFBA958052;
	Tue, 17 Mar 2026 06:00:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B945C58050;
	Tue, 17 Mar 2026 06:00:26 +0000 (GMT)
Received: from [9.109.249.251] (unknown [9.109.249.251])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 06:00:26 +0000 (GMT)
Message-ID: <cf815c21-138e-44c8-986d-d8496503ee32@linux.ibm.com>
Date: Tue, 17 Mar 2026 11:30:25 +0530
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
Subject: Re: [PATCH v2 00/13] selftests/mm: fix failures and robustness
 improvements
Content-Language: en-GB
To: Sayali Patil <sayalip@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        David Hildenbrand
 <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko
 <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1773305677.git.sayalip@linux.ibm.com>
 <20260312150526.3662b2717b9a91776a2e43f5@linux-foundation.org>
 <1f944b56-acb6-44ee-8cc2-6031fcedaeaa@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <1f944b56-acb6-44ee-8cc2-6031fcedaeaa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA0NyBTYWx0ZWRfX+UdZtfvf5grV
 4145cssHg2Zlpgr4ZiB8zKRTrq5yXg7hPMvdvqWjwhroyurTRe1ut+wD0PuJec0919RNjAIREbE
 CoiKtyGwKHQwWEbClIC93aJ8ctkSiEBYQhrXjdw5+cB03EEc5bqsE/Cbw1PPSqgRSm31WP2k51n
 YzG44mJR2QNhcArUOKMCYffu/pnQ7+0EQm0zYwYGKHzaHFoQxMq5rpJcZ1cBlmTK2T4gDv6JLvZ
 pEwn/0LeqEYaRY8bq/tgEMEwGqH2N//4sNRWd1wx+V6j7DWL3Y6nIiT1cRrWMB3uVMC4QUkPvmE
 YXxb20OXEsZxEFgejEooJL/hMzBsSTulYdYJi+N2y0uRqVQX9c3XCMVBkPEzSBA5TU/dKDP1AAX
 AemShboyQQmrzXojp0TkMdW+n3pDzpGbsIkfH+aPPEpFF9xbv7kCEno+xk6NAsf+eORcCrwGsda
 Q4zIXMSr2uqFG62sbjQ==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b8ee01 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=v5kZQaA_ZERCB-NnuxkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cRTqZndxSEC7CgUEAR5nuNwsEFknjtV0
X-Proofpoint-GUID: aPR9dRKlnxe4-p9tKIl3u6q1blr5e4HN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170047


On 13/03/26 7:46 pm, Sayali Patil wrote:
>
> On 13/03/26 03:35, Andrew Morton wrote:
>> On Thu, 12 Mar 2026 17:55:27 +0530 Sayali Patil 
>> <sayalip@linux.ibm.com> wrote:
>>
>>> Hi all,
>>>
>>> Powerpc systems with a 64K base page size exposed several issues while
>>> running mm selftests. Some tests assume specific hugetlb 
>>> configurations,
>>> use incorrect interfaces, or fail instead of skipping when the required
>>> kernel features are not available.
>>>
>>> This series fixes these issues and improves test robustness.


Hello Sayali,


I still see, below test failure. Apart from this, everyting else is 
working as expected.


# # ------------------------------------------------
# # running ./hugetlb_reparenting_test.sh -cgroup-v2
# # ------------------------------------------------
# # cleanup
# #
# # Test charge, rmdir, uncharge
# # mkdir
# # write
# # Writing to this path: /mnt/huge/test
# # Writing this size: 26843545600
# # Populating.
# # Not writing to memory.
# # Using method=0
# # Shared mapping.
# # RESERVE mapping.
# # Allocating using HUGETLBFS.
# #
# # rmdir
# # uncharge
# # cleanup
# # done
# #
# #
# # Test child only hugetlb usage
# # setup
# # write
# # Writing to this path: /mnt/huge/test2
# # Writing this size: 26843545600
# # Populating.
# # Not writing to memory.
# # Using method=0
# # Shared mapping.
# # RESERVE mapping.
# # Allocating using HUGETLBFS.
# #
# # Assert memory charged correctly for child only use.
# # actual = 11 MB
# # expected = 0 MB
# # FAIL
# # cleanup
# # [FAIL]
# not ok 12 hugetlb_reparenting_test.sh -cgroup-v2 # exit=1


Regards,

Venkat.

>> Thanks, I updated mm.git's mm-new branch to this version.
>>
>>> ---
>>> v1->v2
>>>    - For "selftests/mm: ensure destination is hugetlb-backed in 
>>> hugepage-mremap":
>>>      update FLAGS definition to MAP_HUGETLB | MAP_SHARED | 
>>> MAP_POPULATE and
>>>      used it for mmap() calls as suggested during review.
>> That was a really small change (below).  It's better to wait a while
>> (half to one week) before resending an entire series.  So as to
>> hopefully accumulate more changes.
>>
>>
>>
>> --- a/tools/testing/selftests/mm/hugepage-mremap.c~b
>> +++ a/tools/testing/selftests/mm/hugepage-mremap.c
>> @@ -31,7 +31,7 @@
>>   #define MB_TO_BYTES(x) (x * 1024 * 1024)
>>     #define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
>> -#define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
>> +#define FLAGS (MAP_HUGETLB | MAP_SHARED | MAP_POPULATE)
>>     static void check_bytes(char *addr)
>>   {
>> @@ -121,23 +121,20 @@ int main(int argc, char *argv[])
>>         /* mmap to a PUD aligned address to hopefully trigger pmd 
>> sharing. */
>>       unsigned long suggested_addr = 0x7eaa40000000;
>> -    void *haddr = mmap((void *)suggested_addr, length, PROTECTION,
>> -               MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
>> +    void *haddr = mmap((void *)suggested_addr, length, PROTECTION, 
>> FLAGS, fd, 0);
>>       ksft_print_msg("Map haddr: Returned address is %p\n", haddr);
>>       if (haddr == MAP_FAILED)
>>           ksft_exit_fail_msg("mmap1: %s\n", strerror(errno));
>>         /* mmap again to a dummy address to hopefully trigger pmd 
>> sharing. */
>>       suggested_addr = 0x7daa40000000;
>> -    void *daddr = mmap((void *)suggested_addr, length, PROTECTION,
>> -               MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
>> +    void *daddr = mmap((void *)suggested_addr, length, PROTECTION, 
>> FLAGS, fd, 0);
>>       ksft_print_msg("Map daddr: Returned address is %p\n", daddr);
>>       if (daddr == MAP_FAILED)
>>           ksft_exit_fail_msg("mmap3: %s\n", strerror(errno));
>>         suggested_addr = 0x7faa40000000;
>> -    void *vaddr = mmap((void *)suggested_addr, length, PROTECTION,
>> -            MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
>> +    void *vaddr = mmap((void *)suggested_addr, length, PROTECTION, 
>> FLAGS, fd, 0);
>>       ksft_print_msg("Map vaddr: Returned address is %p\n", vaddr);
>>       if (vaddr == MAP_FAILED)
>>           ksft_exit_fail_msg("mmap2: %s\n", strerror(errno));
>> _
>>
>>
> Thanks for the guidance. I'll make sure to follow this approach from 
> next time.
>

