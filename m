Return-Path: <linuxppc-dev+bounces-23771-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD4AC43602
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 07:01:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw8Cl351lz2ygX;
	Wed, 08 Jul 2026 17:01:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783494115;
	cv=none; b=jaTigy5kbQzJpKe7GiRlCSMZNH3ehIsz73ksPKW/U9uCb9kFBuIOMAEdiUmlblvDT4gc+qEhXl7WypNzuaBtc+uIHXbuSaECeTvKJCLB+oRoM+7ac4A2qLMEayK6l8WPMRjtzuBz5aAQSyljMSt9rx7MtUaBnZcHo3HkWEN1/wb4dm2q10KYQz2MyWG5LqxJ0EgkzRuEdy4wIbAK5BskgDGUQuhPnFWnwrlcAugxsRoF9obyWlThH/h5GyXauAuwG6YtkafmiwctKOu3j/kFWHAZyeCzMLmILsqHJV+7S2BvP88I56rq6c7MKOAad0tAOLrK1dG+qjcoytw0GWEOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783494115; c=relaxed/relaxed;
	bh=tlSCzq7tAckvaGb5Epq4YxWuV6DFOJs4JkORikwFt1o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V+iEsFz7jKwONCXmwqptOcdz+3qZajJreqeflqGnrPuWVWOi2umC3v0U63o644iDhleuPvb12/Ldn8gzrJO+EZh0VX+UsAVoBgizO8/qGYuFreM477JReq/TbR3x8nqO6SKZfavY/mihkV6/9bYFRNmLppSg3dPL9EzuQNGrs1sP7+TuTiAbGfqXBGEOgLDXwlslXoYp6/cwdnVgMHI+v65Sc9MXVKJaThlEz8NqF6y4Sgp2v+hGiNlcXz2MwqwMALsZHPbUncKQ+Qoxn4lmauxtlmSKA5S+zoiGVvbfqBGbfVw/1pgXTjDJJVhwk9sUK1ZcMM+bg5AgeE7Uz/7JWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oLv/pNsJ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oLv/pNsJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw8Cj5vZtz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 17:01:53 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667MmZOa820082;
	Wed, 8 Jul 2026 07:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tlSCzq
	7tAckvaGb5Epq4YxWuV6DFOJs4JkORikwFt1o=; b=oLv/pNsJaox34oLaY3htgj
	B3VUUjdSNdTeloJ5QsdxtK6VVoh4TMsam8WNv7k4P7azwz6/UPHOH4eV2vMH2uiE
	QMP2oqK0+wu4uUFlVMHSsPl7TsQPPidUY+Do3tMPhe59+OnUqp+eNoY1hms3nzL6
	JZKHsiQEaeLPApDgZSjEPV3UB3uBU755Kwve+iX/thaOrOEuVlTzDkO2rKwagQq0
	YjsqJqudT5pNFEfmIwWG67g6cqqfuYU98833gcOoOyLaZvO925dJxUwCxEpuSZRC
	MCx4KRSVwQHU6Fd7XzzMpDaBP3IqyYgzLn34L1cmg4L65T50hIhsgd8Gn8rRkguw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4u3y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 07:01:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6686nZUx009369;
	Wed, 8 Jul 2026 07:01:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y649d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 07:01:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66871bUZ11731554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 07:01:37 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D43458064;
	Wed,  8 Jul 2026 07:01:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 138D05803F;
	Wed,  8 Jul 2026 07:01:32 +0000 (GMT)
Received: from [9.123.3.209] (unknown [9.123.3.209])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 07:01:31 +0000 (GMT)
Message-ID: <198eac9f-3b77-4376-8ae6-9c0ae13d60cd@linux.ibm.com>
Date: Wed, 8 Jul 2026 12:31:30 +0530
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
Subject: Re: [PATCH v2 1/3] selftests/mm: handle EINVAL when configuring
 gigantic hugepages
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Miaohe Lin <linmiaohe@huawei.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1782811071.git.sayalip@linux.ibm.com>
 <3d394c8cd59fe380d4e2d13b051544f241918f07.1782811071.git.sayalip@linux.ibm.com>
 <ccba342f-1ed0-43fe-ac59-9b8bbfb168d4@kernel.org>
 <968b496a-a83e-491a-950c-3f6f975fa5f5@linux.ibm.com>
 <32a42e83-3e5e-4b00-b78c-d762094b9d76@kernel.org>
Content-Language: en-IN
In-Reply-To: <32a42e83-3e5e-4b00-b78c-d762094b9d76@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: r3dXjv-RqikqydcFtavczmSqNEMVv7tV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA2MyBTYWx0ZWRfXwooKDUeozWUo
 H8QB9aQOVjbhX7YPyhQjrozwXzVLFZQkNq8mDVE9S0x4+uFWR1crOH57qFHBavHmwOgViy3J0nK
 rRCQ6Kdf+S2CzXucGF/YQPhCwzXOfuhN0puC2dsv0gBeIOsV8XPBRA2sOZMN0h9h/HLyb3IpcKa
 kl4ZuGegq07u2r0I5Uh1hR5nienVBEmuYyrvgp0dUSOaBTXLyFozcEYPDCdxJ9Lx7YLnGjDsWp7
 WMCeeIu7nDZ/1upERCrxoLhmhPXm573+KLWpAgmRDe9QbHuWhBKwM3Bq2cDp+OWMcnu4bhxhFjQ
 /WwNlcU6CB0hSX5MAkDnoVEGku5XZPOb51dEcD3nGycYzlXI8F3dcADfCuvZGXUEeYkX5iGwBi0
 9Wx3msNRm6IW1MxpRs4rsSRdSLuJhkwmwNpEQcuuMHI0wOsAJVGLZVa5PGowbNzjTRrzVgz/AYO
 UX9ok2Cm4+XD73DGEhQ==
X-Proofpoint-ORIG-GUID: yKrqzthyQVTlRAJNvd2CzFqN2bjXXBux
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4df5d3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=FC1D3BymJF1NogjcMuUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA2MyBTYWx0ZWRfX3IRK1JPVVoRO
 FP5L2axnfRFdgA6AOCn9fIix+rS5wjYGJHJ60al/DLo82FufFJUDJqB8N8JKt8f0hdGQJqUPD7Z
 mLQcaWAAJYJtHtAYkP4FSmffwx+FIDg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080063



On 01/07/26 14:18, David Hildenbrand (Arm) wrote:
> On 6/30/26 22:20, Sayali Patil wrote:
>>
>>
>> On 30/06/26 16:15, David Hildenbrand (Arm) wrote:
>>> On 6/30/26 11:32, Sayali Patil wrote:
>>>> Some MM selftests attempt to configure the amount of
>>>> HugeTLB pages of different sizes by writing to nr_hugepages.
>>>>
>>>> PowerPC hash MMU pSeries systems advertise gigantic hugepage sizes
>>>> but do not support runtime allocation of such pages, writes
>>>> to the corresponding nr_hugepages file fail with -EINVAL.
>>>> This causes the test to bail out even though the failure is due
>>>> to a platform limitation rather than the
>>>> functionality being tested.
>>>>
>>>> Treat -EINVAL from the sysfs write as a skipped configuration request
>>>> and continue running the test instead of failing.
>>>>
>>>> Before patch:
>>>>      -------------------------
>>>>      running ./hugetlb-madvise
>>>>      -------------------------
>>>>      TAP version 13
>>>>      1..1
>>>>        [INFO] detected hugetlb page size: 16777216 KiB
>>>>        [INFO] detected hugetlb page size: 16384 KiB
>>>>       ok 1 MADV_DONTNEED and MADV_REMOVE on hugetlb
>>>>       Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>>       Bail out! /sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages
>>>>       write(0) failed: Invalid argument
>>>>       Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>>       [FAIL]
>>>>
>>>> After patch:
>>>>      -------------------------
>>>>      running ./hugetlb-madvise
>>>>      -------------------------
>>>>      TAP version 13
>>>>      1..1
>>>>       [INFO] detected hugetlb page size: 16777216 KiB
>>>>       [INFO] detected hugetlb page size: 16384 KiB
>>>>      ok 1 MADV_DONTNEED and MADV_REMOVE on hugetlb
>>>>      Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>>      /sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages
>>>>      write(0) failed: Invalid argument
>>>>      [PASS]
>>>>
>>>> Fixes: 27477b28b74f ("selftests/mm: hugepage_settings: add APIs to get and
>>>> set nr_hugepages")
>>>> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
>>>> ---
>>>>    .../testing/selftests/mm/hugepage_settings.c  | 32 ++++++++++++++++++-
>>>>    .../testing/selftests/mm/hugepage_settings.h  |  1 +
>>>>    2 files changed, 32 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/hugepage_settings.c b/tools/testing/
>>>> selftests/mm/hugepage_settings.c
>>>> index 2eab2110ac6a..ce38ae3da01a 100644
>>>> --- a/tools/testing/selftests/mm/hugepage_settings.c
>>>> +++ b/tools/testing/selftests/mm/hugepage_settings.c
>>>> @@ -422,6 +422,36 @@ static void hugetlb_sysfs_path(char *buf, size_t buflen,
>>>>             size / 1024, attr);
>>>>    }
>>>>    +void hugetlb_write_num(const char *path, unsigned long num)
>>>> +{
>>>> +    int fd, saved_errno;
>>>> +    ssize_t numwritten;
>>>> +    char buf[21];
>>>> +
>>>> +    sprintf(buf, "%lu", num);
>>>> +
>>>> +    fd = open(path, O_WRONLY);
>>>> +    if (fd == -1)
>>>> +        ksft_exit_fail_msg("%s open failed: %s\n", path, strerror(errno));
>>>> +
>>>> +    numwritten = write(fd, buf, strlen(buf));
>>>> +    saved_errno = errno;
>>>> +    close(fd);
>>>> +    errno = saved_errno;
>>>> +
>>>> +    /* Treat EINVAL as a skipped configuration (e.g., unsupported gigantic
>>>> pages) */
>>>> +    if (numwritten < 0 && errno == EINVAL) {
>>>> +        ksft_print_msg("%s write(%s) failed: %s\n", path, buf,
>>>> strerror(errno));
>>>
>>> Should we even print anything here? Rather confusing. It's just like we cannot
>>> allocate anything (no memory).
>>>
>>> In general, you are copy-pasting a lot of write_num()+write_file() content,
>>> which is really suboptimal.
>>>
>>> All you want is an option for write_num -> write_file to skip on -EINVAL,
>>> correct?
>>>
>>> There are not that many write_num / write_file users ...
>>>
>>
>> Hi David,
>>
>> Yes, all I need is to ignore the expected -EINVAL when attempting to
>> configure gigantic hugepages via nr_hugepages.
>>
>> I looked at extending write_num()/write_file() for this as in v1
>> (https://lore.kernel.org/
>> all/8bfa921e30eb94072685103f6496784aa23bb166.1782365671.git.sayalip@linux.ibm.com/),
>> but these helpers are shared by several other selftests.
>> For example, write_file() is used by split_huge_page_test setup and by
>> khugepaged tests for drop_caches, and is also used for various THP and
>> khugepaged settings where -EINVAL would indicate a genuine setup
>> failure. This concern was also raised during the v1 review.
>>
>> Because the expected -EINVAL is specific to gigantic hugepage runtime
>> allocation, I kept the handling local to the hugetlb setup path rather
>> than changing the semantics of the common helpers.
>>
>> I also agree that printing a message is not particularly useful in this
>> case, and we can simply return without emitting any output.
> 
> We can either convert the functions to use flags, or hide it in some internal helpers, like the following:
> 
>  From 1b1b8ad51f1f0be469cb191736300254b9521fe4 Mon Sep 17 00:00:00 2001
> From: "David Hildenbrand (Arm)" <david@kernel.org>
> Date: Wed, 1 Jul 2026 10:45:16 +0200
> Subject: [PATCH] tmp
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>   tools/testing/selftests/mm/vm_util.c | 28 ++++++++++++++++++++++++----
>   tools/testing/selftests/mm/vm_util.h |  1 +
>   2 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 311fc5b4513eb..362070f817e9b 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -719,7 +719,8 @@ int read_file(const char *path, char *buf, size_t buflen)
>   	return (unsigned int) numread;
>   }
>   
> -void write_file(const char *path, const char *buf, size_t buflen)
> +static int __write_file(const char *path, const char *buf, size_t buflen,
> +		bool ignore_einval)
>   {
>   	int fd, saved_errno;
>   	ssize_t numwritten;
> @@ -735,14 +736,23 @@ void write_file(const char *path, const char *buf, size_t buflen)
>   	saved_errno = errno;
>   	close(fd);
>   	errno = saved_errno;
> -	if (numwritten < 0)
> +
> +	if (numwritten < 0) {
> +		if (ignore_einval && errno == EINVAL)
> +			return;
>   		ksft_exit_fail_msg("%s write(%.*s) failed: %s\n", path, (int)(buflen - 1),
>   				buf, strerror(errno));
> +	}
>   	if (numwritten != buflen - 1)
>   		ksft_exit_fail_msg("%s write(%.*s) is truncated, expected %zu bytes, got %zd bytes\n",
>   				path, (int)(buflen - 1), buf, buflen - 1, numwritten);
>   }
>   
> +static void write_file(const char *path, const char *buf, size_t buflen)
> +{
> +	__write_file(path, bug, buflen, /* ignore_einval = */ false);
> +}
> +
>   unsigned long read_num(const char *path)
>   {
>   	char buf[21];
> @@ -753,12 +763,22 @@ unsigned long read_num(const char *path)
>   	return strtoul(buf, NULL, 10);
>   }
>   
> -void write_num(const char *path, unsigned long num)
> +static void __write_num(const char *path, unsigned long num, bool ignore_einval)
>   {
>   	char buf[21];
>   
>   	sprintf(buf, "%lu", num);
> -	write_file(path, buf, strlen(buf) + 1);
> +	write_file(path, buf, strlen(buf) + 1, ignore_einval);
> +}
> +
> +void write_num(const char *path, unsigned long num)
> +{
> +	return __write_num(path, num, /* ignore_einval = */ false);
> +}
> +
> +void write_num_ignore_einval(const char *path, unsigned long num)
> +{
> +	return __write_num(path, num, /* ignore_einval = */ true);
>   }
>   
>   static unsigned long shmall, shmmax;
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index ea8fc8fdf0eb0..7799154b67eed 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -168,6 +168,7 @@ void write_file(const char *path, const char *buf, size_t buflen);
>   int read_file(const char *path, char *buf, size_t buflen);
>   unsigned long read_num(const char *path);
>   void write_num(const char *path, unsigned long num);
> +void write_num_ignore_einval(const char *path, unsigned long num);
>   
>   void shm_limits_prepare(unsigned long length);
>   void __shm_limits_restore(void);

Thanks, David. I've sent out v3 incorporating the suggested changes.
V3:https://lore.kernel.org/all/cover.1783446924.git.sayalip@linux.ibm.com/

