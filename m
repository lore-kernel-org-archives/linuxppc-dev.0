Return-Path: <linuxppc-dev+bounces-23231-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AEEC43327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 20:21:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqZKh3v8zz2yQL;
	Wed, 01 Jul 2026 06:21:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782850872;
	cv=none; b=ZuKW+DlZIY0B4VZOYq7S2FS1tVZXepEB5Cj43+6z4mpGmP3hLs2MN9iwBqw9o+/5Elp3ybHeOgbbnT7h+q4VTphtV6Qnfo6LZ+nvJZKjM5FWX8jX5kENPZ/ObkWcBqNWW/ZJF4Hu8mYLLxtJ6j4RN+qCN6BUJ5fj3tXlKXoLeuoY1Ua9x+3WoBBwACj9vqUJQ4cl2RqBDz7QMTNOgX5ay8rNLtYF+LYc8mOt7GnPvDPDK3rsVIWCcM2tXAoV9IkjtcLHsnE9h/YhUfd/2mDeXfSo9v1+KuBuFvkDjK1E4tOXW1qfczhwquCtsHnE5Q4VWxA/2zdrEsaWneT/PhJaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782850872; c=relaxed/relaxed;
	bh=MN1zYNlRIrvCMl8w1g003MYRSSHOfGU46ywAOytAXzc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iiQaB/7HmHUr4gwNZRjO89vbqw4pNclzGGYGRhgCkYePMLYDmvT/Vq5zVj2/cmiI9TC9e3lPlmI4Nt1zOx0DKu5LIbVEENr7stevHKQXJpYxIX4QxDbNGLcqStvdFuz5IKeZMFzMXoh/89eP4IhvjCKaUl+jIvBIvp4l1Zzm9H57y8XuRim6Zu5rpnKUl8UeGBhelqTpfW/L+MlgVPg8dD5zwd/fseWN5zbdU0HeEYW+1MpKU3mYDf4U+MAylKlt69mgguWHshkdMTh/fGTzRscw+kyBR4w9RuUcvThDubS+YhrdzF9hAdpFi1zSsUzWMu9b2w9HJdaqdugK5u2qcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WW1TeXhK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WW1TeXhK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqZKg5NTMz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 06:21:11 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJIIvf2957033;
	Tue, 30 Jun 2026 20:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MN1zYN
	lRIrvCMl8w1g003MYRSSHOfGU46ywAOytAXzc=; b=WW1TeXhK+/+9vIQhysV5qC
	Gp/sOcyXt+OWJEtcXUH63Ug7Lv+8w2LzM8M9WzuAA1qpXi0oNd81bXP9v37uDMSY
	1NAuO+xbKnPl+EUkOQ37WT2NTz5RLT0d6HyzYH0oN6w9yCsuKpyqbWTJfpRz1GYN
	3b14bFTxWP8TlvZ3cMPsh1i3QXp46KVIss0nQ989kNGup7WaMzlWaGKdgoN5lhPg
	cpXOqyypRIAA8kmCENiKDUz01qorM9nAaAyiYqn03ttZBCU673PbFFIKNH2+ZQ60
	HcA/A6WWgc2gZIF7wD2BzVSiQgOhQWH8yLmo6snhXYToK5BIExZr+Fx2VNadG7hg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe10fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 20:20:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UKJhUM009636;
	Tue, 30 Jun 2026 20:20:54 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhybuwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 20:20:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UKKrUY57541116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 20:20:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1CFD58058;
	Tue, 30 Jun 2026 20:20:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 708D358057;
	Tue, 30 Jun 2026 20:20:48 +0000 (GMT)
Received: from [9.124.209.216] (unknown [9.124.209.216])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 20:20:48 +0000 (GMT)
Message-ID: <968b496a-a83e-491a-950c-3f6f975fa5f5@linux.ibm.com>
Date: Wed, 1 Jul 2026 01:50:46 +0530
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
Content-Language: en-IN
In-Reply-To: <ccba342f-1ed0-43fe-ac59-9b8bbfb168d4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: xyESTlO6dMLM7YcVtcvMAvaTwyluwrzX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE5NiBTYWx0ZWRfXwYC8CEf3+t4o
 KiyjGor5a04mKsKTRf7jX4eo4mzRJu2/C7NwJEzG02V/mIlZGyLO4Qi7Kj5lxnkISK5P++UhwT+
 ImE/iurNuaTVuSm4F8y1I58k5E1Kufg=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a442528 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=m02x96YjSDSQiHbJXYIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE5NiBTYWx0ZWRfX5RrnGuMnjta0
 gdd5dAniw1EU9+cmYHg8yNafFjUwPFREIMD0JCAkW8PXv6mivlwxvxmMIx0RBLpUgYzMGWL8fa3
 3xvHbVtDMhYVr3AaEaow9hRPgC90b4Sub4ohZ7NmV7aLdh6SPuGLvPXVZ2j/JOJ5hBWx584AtIm
 nbfJoWdjjU/NFStaOj6WTxrfaHpvFa/H6M6EEB1x25vfBvgclmS/LNObzZilaf6wM4yv69gUSgA
 p5CZwQmyK52eUx0bRylexxEzEflIKRVz5fPBj5hr6j2uQifJfzk54/zlgyI6ORs5nkU8YJ9ZylN
 hsjti6jc1NtOX3jcbezDJEz2UylY+u/RXOifrm66ykPMy4htd8MwAp4ZLr/j5reiLCLhDYA0n12
 TRTphxp5I71/EYRWBtWYLSd9kBmmLmpe6NvMwFI/r5ZZUZlxgXgJBWbn7YbXYct2CIGpwBrtnod
 VLh+aHeglV0Cij6yYcQ==
X-Proofpoint-ORIG-GUID: PqQIfZCw_cvbMYTbclLmQsh_ECd9ocEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300196



On 30/06/26 16:15, David Hildenbrand (Arm) wrote:
> On 6/30/26 11:32, Sayali Patil wrote:
>> Some MM selftests attempt to configure the amount of
>> HugeTLB pages of different sizes by writing to nr_hugepages.
>>
>> PowerPC hash MMU pSeries systems advertise gigantic hugepage sizes
>> but do not support runtime allocation of such pages, writes
>> to the corresponding nr_hugepages file fail with -EINVAL.
>> This causes the test to bail out even though the failure is due
>> to a platform limitation rather than the
>> functionality being tested.
>>
>> Treat -EINVAL from the sysfs write as a skipped configuration request
>> and continue running the test instead of failing.
>>
>> Before patch:
>>     -------------------------
>>     running ./hugetlb-madvise
>>     -------------------------
>>     TAP version 13
>>     1..1
>>       [INFO] detected hugetlb page size: 16777216 KiB
>>       [INFO] detected hugetlb page size: 16384 KiB
>>      ok 1 MADV_DONTNEED and MADV_REMOVE on hugetlb
>>      Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>>      Bail out! /sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages
>>      write(0) failed: Invalid argument
>>      Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>>      [FAIL]
>>
>> After patch:
>>     -------------------------
>>     running ./hugetlb-madvise
>>     -------------------------
>>     TAP version 13
>>     1..1
>>      [INFO] detected hugetlb page size: 16777216 KiB
>>      [INFO] detected hugetlb page size: 16384 KiB
>>     ok 1 MADV_DONTNEED and MADV_REMOVE on hugetlb
>>     Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>>     /sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages
>>     write(0) failed: Invalid argument
>>     [PASS]
>>
>> Fixes: 27477b28b74f ("selftests/mm: hugepage_settings: add APIs to get and set nr_hugepages")
>> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
>> ---
>>   .../testing/selftests/mm/hugepage_settings.c  | 32 ++++++++++++++++++-
>>   .../testing/selftests/mm/hugepage_settings.h  |  1 +
>>   2 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/hugepage_settings.c b/tools/testing/selftests/mm/hugepage_settings.c
>> index 2eab2110ac6a..ce38ae3da01a 100644
>> --- a/tools/testing/selftests/mm/hugepage_settings.c
>> +++ b/tools/testing/selftests/mm/hugepage_settings.c
>> @@ -422,6 +422,36 @@ static void hugetlb_sysfs_path(char *buf, size_t buflen,
>>   		 size / 1024, attr);
>>   }
>>   
>> +void hugetlb_write_num(const char *path, unsigned long num)
>> +{
>> +	int fd, saved_errno;
>> +	ssize_t numwritten;
>> +	char buf[21];
>> +
>> +	sprintf(buf, "%lu", num);
>> +
>> +	fd = open(path, O_WRONLY);
>> +	if (fd == -1)
>> +		ksft_exit_fail_msg("%s open failed: %s\n", path, strerror(errno));
>> +
>> +	numwritten = write(fd, buf, strlen(buf));
>> +	saved_errno = errno;
>> +	close(fd);
>> +	errno = saved_errno;
>> +
>> +	/* Treat EINVAL as a skipped configuration (e.g., unsupported gigantic pages) */
>> +	if (numwritten < 0 && errno == EINVAL) {
>> +		ksft_print_msg("%s write(%s) failed: %s\n", path, buf, strerror(errno));
> 
> Should we even print anything here? Rather confusing. It's just like we cannot
> allocate anything (no memory).
> 
> In general, you are copy-pasting a lot of write_num()+write_file() content,
> which is really suboptimal.
> 
> All you want is an option for write_num -> write_file to skip on -EINVAL, correct?
> 
> There are not that many write_num / write_file users ...
> 

Hi David,

Yes, all I need is to ignore the expected -EINVAL when attempting to
configure gigantic hugepages via nr_hugepages.

I looked at extending write_num()/write_file() for this as in v1
(https://lore.kernel.org/all/8bfa921e30eb94072685103f6496784aa23bb166.1782365671.git.sayalip@linux.ibm.com/),
but these helpers are shared by several other selftests.
For example, write_file() is used by split_huge_page_test setup and by
khugepaged tests for drop_caches, and is also used for various THP and
khugepaged settings where -EINVAL would indicate a genuine setup
failure. This concern was also raised during the v1 review.

Because the expected -EINVAL is specific to gigantic hugepage runtime
allocation, I kept the handling local to the hugetlb setup path rather
than changing the semantics of the common helpers.

I also agree that printing a message is not particularly useful in this
case, and we can simply return without emitting any output.

Please let me know if you would prefer a different approach.

Thanks,
Sayali

