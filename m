Return-Path: <linuxppc-dev+bounces-19158-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4D91076382
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 14:32:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm6s800tsz2yhY;
	Thu, 02 Apr 2026 01:32:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775053963;
	cv=none; b=ENvcgviZxi+dyewZa7Ny4SwPhUQQqQHVcH+XPLLiDyYAHP3+TFK7/oOhV1TGdntszLAn29PpuH8sFtLcQcvz5HXLfAoON8vaMw9fDyQGL3uoJV7cZNRvC82TeIPEd2H52o3XtHVggzyyIT0MGFkaMi1l5Ptl5rAcIxUQRuwz/XtQMdgTyOVWJyodBFBFMETWCDr6weq5upwDemdiPXxPUvl4FpNJxfy9camSDwVDoT0i0Z/PHwBuLyVL4xiixwS9jDxENGqx0c+WWCNiJt3ZzSs9HxSfGtnTyH6nA8EOFnDxHobde++8lMN7QGfkz/6xXaplTlBw/ZzgzRiVjXUHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775053963; c=relaxed/relaxed;
	bh=XCjnqfzND3siMSjdM7ztAg0ApusfOuj9tUAMFjr53ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YoayB6uMir8oMQXtpa/6dqMWQgI62n3+QbE8l4+ohHJE6L5MtX5EEVH344zLIMVchN6kQLFaK29ivP5+AwNFF4woeTF9lRygADbHLoaJ2oYuDRhMuSgX+2uVsQvsM+16LXREsad/7W75XSe5nqhmK4NNugfsoBp84uFr+3El7C9Xvd/qGb8SknVo2+5Olv3HRKWUbtoktV+DetGGFEqhLsA0GCTnJOR2o43qr8P6Qpe4xR6MkGRDZuPEkUply0ouyxuebxICBJtHqA2hNufbcS5yvp2r6uXEjsw3d7/2kbudvnWG/Ax+Rq3TKo6yyxEE8xpo/j768+m5ILRaVUxSrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lUexXE+/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lUexXE+/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm6s70jmxz2yVM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 01:32:42 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631CXfGr169440;
	Wed, 1 Apr 2026 14:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XCjnqf
	zND3siMSjdM7ztAg0ApusfOuj9tUAMFjr53ZY=; b=lUexXE+/iv7l23MV8dz9Oz
	0XEzCy1FXjw990EAmF7E/gNcymfqYhA2gRKKmxaU7hRkeOctQb/qbb8PRYLUHUlS
	TFbSPFYkM8cRfGpSq5sdSifV/QAj4jpichXMmuolEJNvKWR25kU1ZzOPbusdYD7l
	cpmgv6tsDFNcO7T0P9+ungV07c705ctfMR4zS2hWLRh0wJfX6gVkOhaCWMiIxqEK
	BUhuPsLDMqzVHf53A68y6p/qszDRo2uAQbD2F9NcW3SKVl0JYfKhdE8jrbYl2VbJ
	IiO5jRjFT8cLyrWZYPERMKcB7oVaTi1BLTu3aejyrH6KfGd2zMuowFYf4P8ok+hw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q38m3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 14:32:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631BjPRO022291;
	Wed, 1 Apr 2026 14:32:29 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan5yx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 14:32:29 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631EWS3X1770044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 14:32:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB54C58054;
	Wed,  1 Apr 2026 14:32:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 563F25803F;
	Wed,  1 Apr 2026 14:32:23 +0000 (GMT)
Received: from [9.39.18.42] (unknown [9.39.18.42])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 14:32:23 +0000 (GMT)
Message-ID: <b6d211e1-233e-4079-a8b9-6682e12077ba@linux.ibm.com>
Date: Wed, 1 Apr 2026 20:02:14 +0530
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
Subject: Re: [PATCH v3 11/13] selftests/mm: fix double increment in linked
 list cleanup in compaction_test
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1774591179.git.sayalip@linux.ibm.com>
 <4c47a2ebbc41f90c7a0cb3f8b34106b2b64296f6.1774591179.git.sayalip@linux.ibm.com>
Content-Language: en-IN
From: Sayali Patil <sayalip@linux.ibm.com>
In-Reply-To: <4c47a2ebbc41f90c7a0cb3f8b34106b2b64296f6.1774591179.git.sayalip@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: N46Buve6LLjOY-8cEDx28LKGk35wp2Te
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cd2c7f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Ikd4Dj_1AAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=_rQTWCYq3bkPLdup__cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: q70nen16mzFyUJWl05e4U8Txb9r8jnvY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEzMyBTYWx0ZWRfXxVz1MwK3oBRi
 b593UD/1bwhpKB6ZGc+V1gyY5N3wSUvdD6PIJn+ip4X0z5qBlhU4hTlwJjq0CjZiI6pqhhTzRZE
 oZCOtFPMjtQABspSqebRFvaMc2MRFCCmxOT+sWTHuGHFHcSk3I6ont3eeHT3219qcn32cHaHkS7
 ld8RA5ofe1bmWjrzf1XeSzQ1rQgQhwgl/SqZz16H7KXl2G7USFCtI/5Fs4SKb3goyPIP3rXts4M
 IrkXoL3Jz8bKPQOLExNaj+QM5on8Oh8nz1rb2tF6lE6WxrzoKtB8+gkJ8LxEAsp5WlIGIXpXTla
 9rH06kriLngXUJaPRfyv/GkAzcJ5UsuqFBDUcgi7Z+nEAMySwe8e5l/i96J+BTxw1NUlt5hEu8l
 aQDZIukCAk9RSqribHSDgd4gqa5gN46CV8QT/XlEdPOj0przE/HgR+O5D3TIOfrVZJAn+RUmFbq
 W8iifSNYOHfP21RDdYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010133


On 27/03/26 12:46, Sayali Patil wrote:
> The cleanup loop of allocated memory currently uses:
>
>      for (entry = list; entry != NULL; entry = entry->next) {
>          munmap(entry->map, MAP_SIZE);
>          if (!entry->next)
>              break;
>          entry = entry->next;
>      }
>
> The inner entry = entry->next causes the loop to skip every
> other node, resulting in only half of the mapped regions being
> unmapped.
>
> Remove the redundant increment to ensure every entry is visited
> and unmapped during cleanup.
>
> Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/compaction_test.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
> index 30209c40b697..f73930706bd0 100644
> --- a/tools/testing/selftests/mm/compaction_test.c
> +++ b/tools/testing/selftests/mm/compaction_test.c
> @@ -263,9 +263,6 @@ int main(int argc, char **argv)
>   
>   	for (entry = list; entry != NULL; entry = entry->next) {
>   		munmap(entry->map, MAP_SIZE);
> -		if (!entry->next)
> -			break;
> -		entry = entry->next;
>   	}
>   
>   	if (check_compaction(mem_free, hugepage_size,

Sorry, this change is not valid.

The goal of this test is to verify the kernel’s ability to compact
unevictable (MAP_LOCKED) pages. The loop is intentionally written to
unmap every other chunk, thereby creating fragmentation with locked pages
before check_compaction() is invoked.

With the proposed change (removing the double increment), the loop ends up
unmapping all allocated locked pages instead of leaving a fragmented
pattern. This results in memory being effectively unfragmented.

I will send v4 without this patch.

Thanks,
Sayali

