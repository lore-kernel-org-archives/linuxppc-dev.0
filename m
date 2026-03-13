Return-Path: <linuxppc-dev+bounces-18175-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D443105F7AE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 14:26:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXRcZ2fDZz3cGw;
	Sat, 14 Mar 2026 01:26:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773411982;
	cv=none; b=B+RJARelsOrtWTL8PktcNYKdQXJQADLQUoZHxanJk44EsRFEDqXaTSW4BE0SnXdb6alV/+VR/ZzO6bcTB5y2RDvkllBzT3yibnaUGfZ1iLsng6I8IwB0kEMD5X7GzHUA5IJPn94yBD1+E2rPB/7D8FZxbXUfYWGt4uMO0bEcVH0rKrUPMLce4boJDTMGAjsOeEROg5mELlyMjC/5xMA2OrbJUeuNueRmAtdGC4YTSxBPxlOHxJAh7oodfgUPxdVDkFLhhVk7xPzG87vjpuETCmgu4khE1A6H/8pywhCYbQTX2WpYmEjXGb/9TZ9SiMv4glaLlgKW9T4FFDkTV36mLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773411982; c=relaxed/relaxed;
	bh=cHgUOdstFRXEITYlGgY3DjCI5zusFpP4mQmBTm8g4tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VL1NEZ6c/QNDZdqUZjSlOEAQDsHLVhX4X9SS1QaJTYgVhJPIS/2oGG7fRqlf4N2rbRgGs/tgi7z59bMSbeDJwj34Wyh/sM2hunm7V52hPd5o0Qg2PtK178wJJ9RdAtMK4u6RZumX39qZU1DBWA6ee1sFm+iGaEKYoIZf1D+9dUMB+WCmgJ6KNWAxHgqdm/Zh0cVOKIbSCBl0nlunPFLqPcEV7jox9z5ZjY3IuWzVteGC5993qagYaCc72UqT0z+Xi6YjCC/Sdfy+dV30/xBiEiWVLEkt98ru2jHNAMDqLTJRaQnWwvlek0z6Krv3sDZdqJcCXhiK5jU44pb4cy7OHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PeAS+waH; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PeAS+waH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXRcY20SXz3cGS
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 01:26:20 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D70tIW2533623;
	Fri, 13 Mar 2026 14:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cHgUOd
	stFRXEITYlGgY3DjCI5zusFpP4mQmBTm8g4tE=; b=PeAS+waHZCe+gRpC7rst33
	/ypJ0yEBn6Sqly7InNjbZjZF4CMRZiasBvQ5gJVggi2tzT8N/BjCJABjQOU36om3
	s4p8KeSvUDs695WcC0C8jLCes95jxkT1Sz9r5PRRsMRjc0X5y5YYPWd/9PeENmBr
	RwiN06qLd2tXQWBJKjuW6ZonBdYNrKkjPj/Qc0lWuBDjig42lvJVIeNQiBZdJfii
	njPLOBmU6dh8OM3aGMZnG1bI7x1VURfDKrlm6/voMFSPm27vLULsR2isuJlQwHiJ
	IZje9zSqHc6iAFkyC+aWHGJnxAELndNy23qclzF3yKfEbNDoq6KUqE72mMUui9JQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh96fxv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 14:26:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DASuWI014748;
	Fri, 13 Mar 2026 14:26:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha8f042-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 14:26:07 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DEQ7OY24183498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 14:26:07 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EF4D5805C;
	Fri, 13 Mar 2026 14:26:07 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AB4458051;
	Fri, 13 Mar 2026 14:26:02 +0000 (GMT)
Received: from [9.39.23.217] (unknown [9.39.23.217])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 14:26:02 +0000 (GMT)
Message-ID: <0e9cea41-7c49-446a-b67b-256584960516@linux.ibm.com>
Date: Fri, 13 Mar 2026 19:56:01 +0530
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
Subject: Re: [PATCH v2 09/13] selftests/mm: skip uffd-wp-mremap if UFFD
 write-protect is unsupported
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1773305677.git.sayalip@linux.ibm.com>
 <ed23ff57a80881c9d087d22709862af40addf49b.1773305678.git.sayalip@linux.ibm.com>
 <457dddf1-04ec-4d1e-8640-b04997fac4f1@kernel.org>
Content-Language: en-IN
From: Sayali Patil <sayalip@linux.ibm.com>
In-Reply-To: <457dddf1-04ec-4d1e-8640-b04997fac4f1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExMiBTYWx0ZWRfXyFrqHXKrDTlG
 bzQvlTv3Cb2GKRRUrNjAU6EuIDJ461ZhAr/WMhxlpJSDafWfDGonUbvbiQNF9xdVvPuIzEeS8HA
 apyqevWK40VZEbtnabkDiEE92kH3VR/xbJMWtbS0s0Uou9SPKcIqJwP5JzGFsB9Xk4nkxapF3k8
 vKAqtr8/43BK3DQXMOOEo0SwiRdyyShmPOv41cWERTzUxLAoBhMB+JZvrbSQNqlC6840avUtqw8
 2rXOBboz9w/JSBsFJ0umqNOZ01FHDJDEroX3uCbLe0wnTM4caXPSlcOOhXbA2iQ28oEvuZwwXtS
 updEWv4IpJLxckm3U6xkvKnkkzznaj+1Cl3GtawakHiMSSHNhvX87VnNVdQwlSCUmjpAiSFFfSt
 VjMChdvegxscTvl0BIS2uwxir/rJsV/cxoer8fCoU6Oxc0+a+/nGTwfWhanQlnX2MVfs+rwTA/D
 mS+yql/XKIykP0JGJpw==
X-Proofpoint-ORIG-GUID: BzLx54M8v8O-Pi911du9xGBNDUIkuQC0
X-Authority-Analysis: v=2.4 cv=RLO+3oi+ c=1 sm=1 tr=0 ts=69b41e80 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Ikd4Dj_1AAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=PItrhlCilDZ6J6cGNoIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wqVStvOSDOc9kufZk6OpbR-pzgZSWe-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130112


On 12/03/26 18:20, David Hildenbrand (Arm) wrote:
> On 3/12/26 13:25, Sayali Patil wrote:
>> The uffd-wp-mremap test requires the UFFD_FEATURE_PAGEFAULT_FLAG_WP
>> capability. On systems where userfaultfd write-protect is
>> not supported, uffd_register() fails and the test reports failures.
>>
>> Check for the required feature at startup and skip the test when the
>> UFFD_FEATURE_PAGEFAULT_FLAG_WP capability is not present,
>> preventing false failures on unsupported configurations.
>>
>> Before patch:
>>   running ./uffd-wp-mremap
>>   ------------------------
>>    [INFO] detected THP size: 256 KiB
>>    [INFO] detected THP size: 512 KiB
>>    [INFO] detected THP size: 1024 KiB
>>    [INFO] detected THP size: 2048 KiB
>>    [INFO] detected hugetlb page size: 2048 KiB
>>    [INFO] detected hugetlb page size: 1048576 KiB
>>   1..24
>>    [RUN] test_one_folio(size=65536, private=false, swapout=false,
>>    hugetlb=false)
>>   not ok 1 uffd_register() failed
>>    [RUN] test_one_folio(size=65536, private=true, swapout=false,
>>    hugetlb=false)
>>   not ok 2 uffd_register() failed
>>    [RUN] test_one_folio(size=65536, private=false, swapout=true,
>>    hugetlb=false)
>>   not ok 3 uffd_register() failed
>>    [RUN] test_one_folio(size=65536, private=true, swapout=true,
>>    hugetlb=false)
>>   not ok 4 uffd_register() failed
>>    [RUN] test_one_folio(size=262144, private=false, swapout=false,
>>    hugetlb=false)
>>   not ok 5 uffd_register() failed
>>    [RUN] test_one_folio(size=524288, private=false, swapout=false,
>>    hugetlb=false)
>>   not ok 6 uffd_register() failed
>>   .
>>   .
>>   .
>>   Bail out! 24 out of 24 tests failed
>>    Totals: pass:0 fail:24 xfail:0 xpass:0 skip:0 error:0
>>   [FAIL]
>> not ok 1 uffd-wp-mremap # exit=1
>>
>> After patch:
>>   running ./uffd-wp-mremap
>>   ------------------------
>>   1..0 # SKIP uffd-wp feature not supported
>>   [SKIP]
>> ok 1 uffd-wp-mremap # SKIP
>>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
>> ---
>>   tools/testing/selftests/mm/uffd-wp-mremap.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
>> index 17186d4a4147..73d53a4da389 100644
>> --- a/tools/testing/selftests/mm/uffd-wp-mremap.c
>> +++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
>> @@ -19,6 +19,17 @@ static size_t thpsizes[20];
>>   static int nr_hugetlbsizes;
>>   static size_t hugetlbsizes[10];
>>   
>> +static void uffd_wp_feature_supported(void)
> Likely that function should be called
>
> "check_uffd_wp_feature_supported()"
>
> Because right now it reads as if it would be returning a bool.
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>
Thanks for the review. I'll rename it to
"check_uffd_wp_feature_supported()" in the next version.

