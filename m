Return-Path: <linuxppc-dev+bounces-18831-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D5910A88F1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 18:01:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhWmz02Fcz2yZc;
	Fri, 27 Mar 2026 05:01:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774548098;
	cv=none; b=ipstiN+KuA6T/MzNDDyGPrkBv253p39YhbOl2cqCE6PukmDjB8TfP1wwPN5OiUM+4m2+0Owedf0rE+ZEav0JnDhNZy8wbXviy0hH+o1sdQ1Q4FrsVK8uxoOzX3Cqf9Ph/KWvzMV2n0W+oV3iiLnoysZhOeKKzuQ/wtPPmSA78W6D1k8gKWB8HZ8/ZDNfX9/EiQ1Vkj40XGiYhmuhbgpk7CI9NnLwnEtWGyg0Ys/wUNhiw6hr1O3c2Gcq+WVlfD2j207IucEpzN63Z9S2SYKfHSEGBsrdUJDVxzj7xv4yl/FCtH4B3AARSmVg3BkLzS99hYiy1h5qWk+c2X4ZE7C23A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774548098; c=relaxed/relaxed;
	bh=qSUnD1397Zp9inDfLVskQJVGRWrzZd3vpYhC+uxeKwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxloqjPCRwwwdeatjTiVsDsdbvsYd6bxO8W6w68LHKqj0pWY0OO1QpQOpjcJLKsUd7UeF1e/6yHHiSXf7dxp1IP9AnU8K6SVm8TJEu2PbaAgwbO89WhVwuLBTBc9dLmILxCQZJXMZdVeb7mapmMOp2ojwt7I3000G9hK9+HO6SQ5vukH/3E92ja3EkI6MWBvKxW3tH/tKfWEZrl8SS6cPw7uJtMXIjiF5lR0fB1vk5t/OqGZnL9lV/VQp+FSRPtJBsnvfN3d4QlhgzGIKVNUj0o87NSQrbHc5JCz05TuPagd7RVi9/cG9OkcfxQVB4JAZTnWiBgwzWugdGd2Uteflw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EBeFYv+j; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EBeFYv+j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhWmx2KMGz2yVL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 05:01:36 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q685vW3481709;
	Thu, 26 Mar 2026 18:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qSUnD1
	397Zp9inDfLVskQJVGRWrzZd3vpYhC+uxeKwI=; b=EBeFYv+j/aODVnq9lrPG+8
	aNOZT5Bm/Ezk0JS3MdTI0H/lP7+pHbnVwUMlRA5C2WOTtjuq/uO9fsPlEiaMSR1U
	uMC4aU77pS63ldWAtbL98p0G36lqVUIG4oy+rVIQwpz0kgjYND8pNulejDrs+SyC
	qJs+o7k8g9+xbpwCELqd/D8N/lPwdel+qR7pWUkf72wE6NznXdwGEE70AMl+ZD8E
	3sYbK50hEpNPYPK+bUWuvY2h0FzdGNlC0J4UNLlvkJ5PEz4X+9Cty0cfDLo4SknD
	JlGpLFo/yfIeqQZSL6XVt+BstHeyyve7Gn19LIFEKulwvhWejMaMuFiqbOsE8ZnA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqpkcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 18:01:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QGw9vJ004407;
	Thu, 26 Mar 2026 18:01:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2buec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 18:01:18 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QI1H0c13042414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 18:01:17 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC67058043;
	Thu, 26 Mar 2026 18:01:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93BE558055;
	Thu, 26 Mar 2026 18:01:13 +0000 (GMT)
Received: from [9.39.28.25] (unknown [9.39.28.25])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 18:01:13 +0000 (GMT)
Message-ID: <e6f03352-4f09-4238-a47a-6d4e84101a6c@linux.ibm.com>
Date: Thu, 26 Mar 2026 23:31:10 +0530
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1773305677.git.sayalip@linux.ibm.com>
 <ed23ff57a80881c9d087d22709862af40addf49b.1773305678.git.sayalip@linux.ibm.com>
 <457dddf1-04ec-4d1e-8640-b04997fac4f1@kernel.org>
 <0e9cea41-7c49-446a-b67b-256584960516@linux.ibm.com>
 <20260324165606.d75200ac0e5458a5ffb83d5d@linux-foundation.org>
Content-Language: en-IN
From: Sayali Patil <sayalip@linux.ibm.com>
In-Reply-To: <20260324165606.d75200ac0e5458a5ffb83d5d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Wgdjz0iWAZ5Gq1bxAzv-z7Cif8__vkRg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyNyBTYWx0ZWRfXz7fQB5fcglC2
 y2SxH0yxzQZaQ1eeQnvSdKaa5MALDMceEq0+fjCDLfsKUVIv7kCQNETwTzkAzldnQiu9WJaMsrU
 8XEXbSdEUa9olxB/hGpFR01i8TtawRrDvSmJw1SU4ZbMSnePIMJdhQiznJKooVmx6o0INzPK91O
 euDSEoYCckKklrv1qf4D9vl33wHnmzJett7SpJshEWLjpFV4DdyQfpqJMxG63x8AFeTCgYGIc1n
 3LyS1Afg6iTqpLd6sM2erF9ayWujv2FVX/PROyoPeZyH8Sxwa4LxlfJiJC2pk9pRX52Zd4gLiQ+
 uBQxgFeJRvOfijdyUsubvOceiWJTMwW4FczLPcd6lCldLpUiV0tRWI28c4nLU8DNjIgACcLGFiM
 KB9tv+q9RGkdl9Va3dFFEegEBNHVyZTMe6wHeyjNMG9zahfv67Cpz3IIJjElFVz0++pMDfS3QHa
 smS66mFC8CO0DISw/ag==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c5746f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=YyDBODbz2JAAnCrYoEcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sD7t1P8T7SXxYhdPnjCwUf4tl7Jf37vN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260127


On 25/03/26 05:26, Andrew Morton wrote:
> On Fri, 13 Mar 2026 19:56:01 +0530 Sayali Patil <sayalip@linux.ibm.com> wrote:
>
>>> Because right now it reads as if it would be returning a bool.
>>>
>>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>>>
>> Thanks for the review. I'll rename it to
>> "check_uffd_wp_feature_supported()" in the next version.
> There was no next version.  I added this:
>
> --- a/tools/testing/selftests/mm/uffd-wp-mremap.c~selftests-mm-skip-uffd-wp-mremap-if-uffd-write-protect-is-unsupported-fix
> +++ a/tools/testing/selftests/mm/uffd-wp-mremap.c
> @@ -19,7 +19,7 @@ static size_t thpsizes[20];
>   static int nr_hugetlbsizes;
>   static size_t hugetlbsizes[10];
>   
> -static void uffd_wp_feature_supported(void)
> +static void check_uffd_wp_feature_supported(void)
>   {
>   	uint64_t features;
>   
> @@ -347,7 +347,7 @@ int main(int argc, char **argv)
>   	struct thp_settings settings;
>   	int i, j, plan = 0;
>   
> -	uffd_wp_feature_supported();
> +	check_uffd_wp_feature_supported();
>   
>   	pagesize = getpagesize();
>   	nr_thpsizes = detect_thp_sizes(thpsizes, ARRAY_SIZE(thpsizes));
> _
>
Hi Andrew,
I have some updates to [PATCH v2 04/13] selftests/mm: fix cgroup task 
placement and tolerance in hugetlb_reparenting_test.sh, as Venkat 
reported failures with the current version.

Should I send a v3 of the full series, or just a fixup patch for 
hugetlb_reparenting_test.sh? Also, if you prefer a v3, should I include 
above fix for 
selftests-mm-skip-uffd-wp-mremap-if-uffd-write-protect-is-unsupported as 
well?

Thanks,
Sayali

