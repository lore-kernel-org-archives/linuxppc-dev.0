Return-Path: <linuxppc-dev+bounces-19189-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629C7CC6B00
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 07:00:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmXmL6dpBz2ySk;
	Thu, 02 Apr 2026 18:00:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775113202;
	cv=none; b=Wfvb40BZ7ELOBkF90BU+dydxvckqAPFHx0mrhGrd7eoKPZOqhyzVbPvJVKQqcqrTpARPY/07hJWB4QqomduR1T/A8DdtIzWcA3nPqkMQqTc6HIq+iu6B5i3MJdWPQtnrLc08lunvnZro/iazBEAG2/2nuKn7ANs4rX9zTv7ltlKYgdf7gviKqMmS3tkishIIw5eDgNDBglBy/nXqTQlF1Gbgw/SZfKEiOUSfyBbPr0Rjz4enqQGQYGl/GZjfIFIdQWf0EBvJhzMwVNqxm4oQgrHBpBvpjs9vxgrjchxt4sD/nAFXF6L3JyiSa5e89Cqw2po2e5Ky1QIVx3PByjdv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775113202; c=relaxed/relaxed;
	bh=g9lHFdT/4a2Nmji3esrNHN41u6kgv2wWacp4OAjXPmQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KGrJCwTNsyLpLavo1bZnJPHAMugc7DXieiUhLzegykFG7QjREyy1BK0LaaLBMkAo1iGGCwjlYhoVG4hL8pqjSkKxuOKhIVhQB7CiZz6KXGgDXnSBqpEhuKBjzNVfs0dl9EZxgUtFKQhGgQa/K8LDsKLn+RS9Kjaa5izuC2KzyQt4fjIAZ/U9eAAH+RXsAIbITAnNibp+VOh79KBaZJFwAVD5ArCcTKNQPKde6uCIh5IUG/cKFxrouM5WdNwqpXXqvPDYgYlk9rJUToMHV6eYiJn7YYzyB6WsF0FCY0yIrN8A9LLHCVEqFSEJnrI4WPS74eCIgkgncSOvvEHKyomp0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LpmVkUw+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LpmVkUw+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmXmK3B8Dz2xln
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 18:00:00 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631KTqkw3487166;
	Thu, 2 Apr 2026 06:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g9lHFd
	T/4a2Nmji3esrNHN41u6kgv2wWacp4OAjXPmQ=; b=LpmVkUw+GhRwIyfiN7Izek
	8wcTZXuAfu5PlbBsqFG7RRdJfxSm83zrC6d7J//FrsBxLcxasUZagbh9RPnnBzkn
	DQ3mqcr2kR32mad9zvoUdLK4fjDT0eeYq9+JCMMs4kE17+yCw6xTZqMwr0DfcfQM
	sRM1NWs3oGVLC8IC+eEOHf4p7IHhQ/k5RfwACm8RCRxXQ+NZZxRUoZrDTEm4NU6e
	p5NXMnXiijvuE/1D/KyogTDoAiZLD0dVTEaWc+2SpHTga7ryBFdJKPdNqKik3IJB
	Pm4N8kGx4W9+YCLDvyCHxixG0B+adliKHuua5PXrDbyhid9F9zLL5u4+0NadL5/w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g23qhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 06:59:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6326YFlV022291;
	Thu, 2 Apr 2026 06:59:48 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan90ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 06:59:48 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6326xlVD32572062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 06:59:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FC185805A;
	Thu,  2 Apr 2026 06:59:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42DD95803F;
	Thu,  2 Apr 2026 06:59:42 +0000 (GMT)
Received: from [9.124.211.187] (unknown [9.124.211.187])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 06:59:41 +0000 (GMT)
Message-ID: <c563e9ad-2e87-4d91-ab0e-f2afa77387cc@linux.ibm.com>
Date: Thu, 2 Apr 2026 12:29:40 +0530
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
Subject: Re: [PATCH v3 09/13] selftests/mm: skip uffd-wp-mremap if UFFD
 write-protect is unsupported
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1774591179.git.sayalip@linux.ibm.com>
 <5bc0fe27cdd316ef6f776bf9b52b6c0de4bef54f.1774591179.git.sayalip@linux.ibm.com>
Content-Language: en-IN
In-Reply-To: <5bc0fe27cdd316ef6f776bf9b52b6c0de4bef54f.1774591179.git.sayalip@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69ce13e6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Ikd4Dj_1AAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=X_KCTOUB8Lo47miopUAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _PKXl_TFP9s8I2DLHw3-X6DosxfFph5V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA1OSBTYWx0ZWRfXzClFUfw9yQ1K
 mS1M24R0Wl1zjNTReKRTJXi2ZL5bYLTAsQSMc5GAR3FHWkenF84klAAgrMAEPzc80g28QfQskxE
 kWC3BytAk24o48Hzfg8mGnWx8PCFm2RyXBGsh9ozkhvQsg4Ha2kKNCYgrx8db8GOKHMzhGica6t
 TQY+K0IZuKUVLC+MrvYDVxct3tUxWaI4/guWSCvRORoePZmhgCmftrNhzNVlJ8OX2CisyQ+ZlKQ
 JkbLT3kxj/3lOB0KqshddGiDUdntaa0FpABnMDDd1QZyoynVQyBSbbhQaebUWosirEeL1YI6jGq
 6yUKt9b0q0MEWN0pQhSfNUjManVAsgf0hTro1BtJGBuAGo14DegAmZt9mCNJkm7VMx2YEAZ+ECZ
 snVINASbaK3rX3JD6i09xD7z3AsFx2nvH91B/V0vwOujEJJqzWKNKsvIvk8XLG+otjTEJiR+4s7
 v/bq1Jma+BkcXbz+2Pw==
X-Proofpoint-GUID: sJCAzj54eSGJ2M_geFmpHo6yBe2LRsGe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020059



On 27/03/26 12:46, Sayali Patil wrote:
> The uffd-wp-mremap test requires the UFFD_FEATURE_PAGEFAULT_FLAG_WP
> capability. On systems where userfaultfd write-protect is
> not supported, uffd_register() fails and the test reports failures.
> 
> Check for the required feature at startup and skip the test when the
> UFFD_FEATURE_PAGEFAULT_FLAG_WP capability is not present,
> preventing false failures on unsupported configurations.
> 
> Before patch:
>   running ./uffd-wp-mremap
>   ------------------------
>    [INFO] detected THP size: 256 KiB
>    [INFO] detected THP size: 512 KiB
>    [INFO] detected THP size: 1024 KiB
>    [INFO] detected THP size: 2048 KiB
>    [INFO] detected hugetlb page size: 2048 KiB
>    [INFO] detected hugetlb page size: 1048576 KiB
>   1..24
>    [RUN] test_one_folio(size=65536, private=false, swapout=false,
>    hugetlb=false)
>   not ok 1 uffd_register() failed
>    [RUN] test_one_folio(size=65536, private=true, swapout=false,
>    hugetlb=false)
>   not ok 2 uffd_register() failed
>    [RUN] test_one_folio(size=65536, private=false, swapout=true,
>    hugetlb=false)
>   not ok 3 uffd_register() failed
>    [RUN] test_one_folio(size=65536, private=true, swapout=true,
>    hugetlb=false)
>   not ok 4 uffd_register() failed
>    [RUN] test_one_folio(size=262144, private=false, swapout=false,
>    hugetlb=false)
>   not ok 5 uffd_register() failed
>    [RUN] test_one_folio(size=524288, private=false, swapout=false,
>    hugetlb=false)
>   not ok 6 uffd_register() failed
>   .
>   .
>   .
>   Bail out! 24 out of 24 tests failed
>    Totals: pass:0 fail:24 xfail:0 xpass:0 skip:0 error:0
>   [FAIL]
> not ok 1 uffd-wp-mremap # exit=1
> 
> After patch:
>   running ./uffd-wp-mremap
>   ------------------------
>   1..0 # SKIP uffd-wp feature not supported
>   [SKIP]
> ok 1 uffd-wp-mremap # SKIP
> 
> Acked-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/uffd-wp-mremap.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
> index 17186d4a4147..6edbd09f0ca6 100644
> --- a/tools/testing/selftests/mm/uffd-wp-mremap.c
> +++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
> @@ -19,6 +19,17 @@ static size_t thpsizes[20];
>   static int nr_hugetlbsizes;
>   static size_t hugetlbsizes[10];
>   
> +static void check_uffd_wp_feature_supported(void)
> +{
> +	uint64_t features;
> +
> +	if (uffd_get_features(&features) && errno == ENOENT)
> +		ksft_exit_skip("failed to get available features (%d)\n", errno);
> +
> +	if (!(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
> +		ksft_exit_skip("uffd-wp feature not supported\n");
> +}
> +
>   static int detect_thp_sizes(size_t sizes[], int max)
>   {
>   	int count = 0;
> @@ -336,6 +347,8 @@ int main(int argc, char **argv)
>   	struct thp_settings settings;
>   	int i, j, plan = 0;
>   
> +	check_uffd_wp_feature_supported();
> +
>   	pagesize = getpagesize();
>   	nr_thpsizes = detect_thp_sizes(thpsizes, ARRAY_SIZE(thpsizes));
>   	nr_hugetlbsizes = detect_hugetlb_page_sizes(hugetlbsizes,

AI review question:

> commit 22914640356d1eaf4e0a8a8b13ad71911d12db50
> Author: Sayali Patil <sayalip@linux.ibm.com>
> selftests/mm: skip uffd-wp-mremap if UFFD write-protect is unsupported
> This commit adds a check at startup to verify if the userfaultfd
> write-protect capability is present. It skips the test instead of reporting> false failures on unsupported configurations.
> > diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c> > index 17186d4a4147..6edbd09f0ca6 100644
> > --- a/tools/testing/selftests/mm/uffd-wp-mremap.c
> > +++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
> > @@ -19,6 +19,17 @@ static size_t thpsizes[20];
> > static int nr_hugetlbsizes;
> > static size_t hugetlbsizes[10];
>
> > +static void check_uffd_wp_feature_supported(void)
> > +{
> > +	uint64_t features;
> > +
> > +	if (uffd_get_features(&features) && errno == ENOENT)
> > +		ksft_exit_skip("failed to get available features (%d)\n", errno);
> If uffd_get_features() fails but errno is something other than ENOENT (for> example, EPERM when unprivileged userfaultfd is disabled), this check will
> evaluate to false and execution will continue.> > +
> > +	if (!(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
> Could this evaluate uninitialized stack memory?
> If uffd_get_features() fails and is bypassed by the previous check, the
> features variable will remain uninitialized. This might cause the test to
> falsely pass or fail depending on whatever data happens to be on the stack.> Should we initialize features to zero or exit on all uffd_get_features()
> failures instead?
> > +		ksft_exit_skip("uffd-wp feature not supported\n");
> > +}

Yes,If uffd_get_features() fails with an error other than ENOENT, the 
features variable would remain uninitialized, which could lead to 
undefined behavior in the subsequent check.

I will fix this in the next patch version.

Thanks,
Sayali

