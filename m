Return-Path: <linuxppc-dev+bounces-21312-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F2BCD5BA4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 09:14:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLjQH3CHPz2xSN;
	Thu, 21 May 2026 19:13:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779354839;
	cv=none; b=OiQrFW0eyoXpRPY70ynME8R4qCKRlnbHuSpfCGjTsTJhTXWbPWhtVS4CxaJk2XK4jI9ws2ysRCCnhnq2cDgqFhp9bOmEZkARtZlIHZLVJ4o3YmW3TwsZf6kSBeUz4XNWtQCp4dguL2/I2gJOI792w1BPZo4Bdh4GOy/fgp7fBEk/oqtBmQ9ihd4JW9sa+/MtDBEdbbhqV0GdHpotLzJRFSbbWvTXbMY1EVaC2SSKAcpUlVQB9G5f0IoFNnbztqG9sH+sUhbTMAAyh22jLs6cGbwqnicB+781udZgAX86BQrqyyTKp/huwHTfVHD5uGVopEwnqeI9rTrX1AF/fTVa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779354839; c=relaxed/relaxed;
	bh=OevyjTu9FiHf2CLX090f6Fl/3bswf0qDQG/sp+fQ7zg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KdzAp/oiwP4VpoZanpi8NgLVhM+7clwLLYaRbRSK0smgnjgOZIEf6J8ZQ4F7hp5cWGXSpwGAzEV3oTG/h6AzfKN7zNUpMN6WUVgcM3I5XoE+bQHSrMSxBpUvaCOetxvmgcN+1f6MMUfiQNcTieIQs63q9FFCrWE2wDCv0wGYZ3Ql1CDj80J97Gzuq3xKTM6XCY8dybLYE/qgWOxmONWINEc6dkh6NHFxYGLj8/pXOIzX5E5TpStrdcZZAQXNBWNILbNydzRXK3oOZ3BkrcbFQYr23LMl4IuZha5OYarK+rIa4uxqEXbyxIFr2dSdRo1DXXdwLtLYiEUDb+jTR+ijqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OKqUzPnh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OKqUzPnh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLjQG1gDMz2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 19:13:57 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KJ8bo31588176;
	Thu, 21 May 2026 09:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OevyjT
	u9FiHf2CLX090f6Fl/3bswf0qDQG/sp+fQ7zg=; b=OKqUzPnhznUoDQSmPi9Vma
	m/Jt/P0O62RFr6XuEAeTto1ilU+XOVRHbiFPT60g6GgTFUiucBoPCXvpedr5+nr7
	aE/VoYW+fekw9XWuXJ6H3kvKa2n6TCxjuNHeXp6f6mxiRjgqkmAyESwqlN9vHd4N
	PyV1sfYvRDzUoqe+8Joa47JNkAtFoKdpS4km7yssIP59/NgO/jQkcXyDG7URxVui
	8qSsbGGgTQHYuxol1rlhsWDnA/1TOxtn8aAviD+PyJbWE24seN9e61silVElBVSf
	Y+UDcGMp/9rx9CR2YQ4smnuqQDs2wqAIH++/7Gm/OHJdGY5MAHGwkaF2OIEHsrLg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8mvq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 09:13:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L998Nj001114;
	Thu, 21 May 2026 09:13:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gk403-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 09:13:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L9DgLZ48496976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 09:13:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13F9658054;
	Thu, 21 May 2026 09:13:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B81FB58050;
	Thu, 21 May 2026 09:13:36 +0000 (GMT)
Received: from [9.123.3.209] (unknown [9.123.3.209])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 09:13:36 +0000 (GMT)
Message-ID: <88202b56-1dc5-43e2-9d1f-a0823a9531f0@linux.ibm.com>
Date: Thu, 21 May 2026 14:43:35 +0530
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
Subject: Re: [PATCH v7 11/13] selftests/mm: skip uffd-stress test when
 nr_pages_per_cpu is zero
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Miaohe Lin <linmiaohe@huawei.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1779296493.git.sayalip@linux.ibm.com>
 <0707e9a0f1b3dd904c4a069b91db317f9c160faa.1779296493.git.sayalip@linux.ibm.com>
Content-Language: en-IN
In-Reply-To: <0707e9a0f1b3dd904c4a069b91db317f9c160faa.1779296493.git.sayalip@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4OSBTYWx0ZWRfX0NfPxMuPQdl8
 ZQEW9qTenAPbDx/m/wMEMbT71aF8Nrx90/1QHthXxmzys/O8PX+PZJa8c8Km+aCHWlnfl94BhRO
 p4dj+pxgQqaXY8c3+luxPdjK/DJ4hyP0JQ+upF4txAE4bKzFoLvWHXr0Bor94MaVoaIoLKEiPO/
 Vz4MNDmKfa3/GbRbB1+0aSTN+a1+cQAXxruJTAWjTxsrOTPR0kzih/YzKr0fYpWPLsDIoZ3ZugT
 OLYUjmYp2NM6cQxl6zvqvE6fGZw40XLIAuUesPFIMhfXcgo1cyOrLNAnjj7/zIXljBK5qPt91JG
 l5OlqmEzh7rymHqn5WGMxYOV0CGiWfW4726bau2MCrgwdZWq8Ug14SUbeuuF8pcQ5nkoZC52A+a
 34rEq4PYDPtGZPJ9SgQwPzllQEOwP/gjiwiQ1ciXoXZp2C6/EeuiXjhdZHJ/f8VH/R/l7mWH+40
 dE/HuLCtEjs6PD5BNJw==
X-Proofpoint-GUID: YBD6R_YN9_Ss56w9WvlauW_CAYGbIE73
X-Proofpoint-ORIG-GUID: nSLeMh-JvVOwp7mGCId-w65f2VJDqkvX
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0eccc8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Ikd4Dj_1AAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Bj7DDXi5LvTWgAAjYWoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210089



On 21/05/26 12:17, Sayali Patil wrote:
> uffd-stress currently fails when the computed nr_pages_per_cpu
> evaluates to zero:
> 
> nr_pages_per_cpu = bytes / page_size / nr_parallel
> 
> This can occur on systems with large hugepage sizes (e.g. 1GB) and a
> high number of CPUs, where the total allocated memory is sufficient
> overall but not enough to provide at least one page per cpu.
> 
> In such cases, the failure is due to insufficient test resources
> rather than incorrect kernel behaviour. Update the test
> to treat this condition as a test skip instead of reporting an error.
> 
> Fixes: db0f1c138f18 ("selftests/mm: print some details when uffd-stress gets bad params")
> Acked-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/uffd-stress.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index 43cc79590136..39e13e2078a9 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -489,9 +489,9 @@ int main(int argc, char **argv)
>   
>   	gopts->nr_pages_per_cpu = bytes / gopts->page_size / gopts->nr_parallel;
>   	if (!gopts->nr_pages_per_cpu) {
> -		_err("pages_per_cpu = 0, cannot test (%lu / %lu / %lu)",
> -			bytes, gopts->page_size, gopts->nr_parallel);
> -		usage();
> +		ksft_print_msg("pages_per_cpu = 0, cannot test (%zu / %lu / %lu)\n",
> +			       bytes, gopts->page_size, gopts->nr_parallel);
> +		return KSFT_SKIP;
>   	}
>   
>   	bounces = atoi(argv[3]);


Hi Andrew,
Can you please apply the below fixlet on top of this patch as suggested 
by Sashiko.

 From aa8f2eea63defd9b9c1342b83838f48e93e1b918 Mon Sep 17 00:00:00 2001
From: Sayali Patil <sayalip@linux.ibm.com>
Date: Thu, 21 May 2026 13:32:51 +0530
Subject: [PATCH] [fixlet] selftests/mm: use ksft_exit_skip() instead of
  KSFT_SKIP in uffd-stress

When nr_pages_per_cpu evaluates to zero, the test is skipped by
printing a message and returning KSFT_SKIP manually.

Replace this with ksft_exit_skip(), which prints the skip message
and exits with the correct skip status in a single helper, making
the code consistent with other selftests.

Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
  tools/testing/selftests/mm/uffd-stress.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c 
b/tools/testing/selftests/mm/uffd-stress.c
index 39e13e2078a9..3401dd6028f0 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -489,9 +489,8 @@ int main(int argc, char **argv)

  	gopts->nr_pages_per_cpu = bytes / gopts->page_size / gopts->nr_parallel;
  	if (!gopts->nr_pages_per_cpu) {
-		ksft_print_msg("pages_per_cpu = 0, cannot test (%zu / %lu / %lu)\n",
+		ksft_exit_skip("pages_per_cpu = 0, cannot test (%zu / %lu / %lu)\n",
  			       bytes, gopts->page_size, gopts->nr_parallel);
-		return KSFT_SKIP;
  	}

  	bounces = atoi(argv[3]);
-- 
2.52.0


Thanks,
Sayali

