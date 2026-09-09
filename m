Return-Path: <linuxppc-dev+bounces-26960-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66B2C79FBD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 15:54:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg53V0sTTz2yvT;
	Thu, 10 Sep 2026 01:54:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788969286;
	cv=none; b=hIlXkMvEbVoyzPbejBjRtUQrsBo0w0XLLdukZQBRy5nXkUBqYCJBUJoYqrvni4yrYA+/9DM92iDf3xlNnSFtcJbi+HiVcEv43p6phbZW8IbgivYq5OaFUaGDBTDkCCan/uQhLh4nHcc5x3qlbCss/yOpdAUZizIR+spE663pzDL/7zfRRDAKg1bCPpSIWGm+BrsIZ537v184c7QW4ExT4SF62mn5LK+ILNYr6tmxCyYTpWhC7VI3SVfQWCPhsgkdib6SC+wF8nx/bM7HGioCbnhqQToecPiHi9dScQ6lVbr2hTA+YTJBwpG+GPIeckTHCK+wwgbelj7vWv+/VGh93w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788969286; c=relaxed/relaxed;
	bh=gi7ysGFs76d77h8+hghhZQn9cu0rjkv/slXztI4qsuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAeYBazHqIboUNUAl4deTskb8nugwiaRkOVSZhyi5nxB5qXDLUOsYUI26khDAvtL4ZEz7bq/hn6vqleCc+KLbc8lsLYgEb/xKy1SYwXZ5DYuxhF5fv4o84a/JfSrIkUoxfQm8O3TaRfB5qft+zZd3czld4+F4e8YWmOMo7IP9/j0asrNe4QkvgWuB1f7C3hz2b0YYe3F8j7eHfFzEEn2hmLqGtXs/0HNU3D+lvjtyPj6O8lfnVn7+xE/4AytpZbV/OYuFIindBBqLq2EmdI9+ySSSMIYfD6wa8UN8mPmCuySvwVr4LCHEgIngyAZkeByaRzmG88gYHNbhx0E/2ujAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sDHfamFG; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sDHfamFG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg53T2vnQz2yvK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 01:54:45 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1c2p3817675;
	Wed, 9 Sep 2026 15:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gi7ysG
	Fs76d77h8+hghhZQn9cu0rjkv/slXztI4qsuY=; b=sDHfamFG2CoGd5RkzYgTZ+
	kkgPxPiaOpIW/s2cGs+TPVaJXbWkhIfpP8kSrcJ7A5YqsyMOX6K9AJ3BBHdqseUp
	z5W9T9GIRrNAFv3WAX9K1eEgfSr+3aoO9FzCQp3F0K4d7QxNmF0tTwdgtkEuj8wF
	ShyPMAMYlByrbPUb1/JKEM5Ik5J7QiZRCDzLn2zs8gilQgWzw+2ZwWBO1GYe25Mf
	7KqIW4ZcynHFOjazioDpUi7Po8GuydmoYyaMyPJqwJkOGFg5m0gw94ipY9K/34BY
	0TQ1msI0/63zrBZGBXsLN5Sh3rffBleZKUeAFN3tZc3koYKpYDHcX6UqFMdNwd0Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf46x5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 15:54:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689FfEMA028718;
	Wed, 9 Sep 2026 15:54:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yjxa2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 15:54:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689FsTrM49283546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 15:54:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3954520040;
	Wed,  9 Sep 2026 15:54:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6645D2004B;
	Wed,  9 Sep 2026 15:54:19 +0000 (GMT)
Received: from [9.61.255.18] (unknown [9.61.255.18])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 15:54:18 +0000 (GMT)
Message-ID: <ce08b0df-2859-428f-afe0-23848da35efc@linux.ibm.com>
Date: Wed, 9 Sep 2026 21:24:15 +0530
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
Subject: Re: [PATCH v2 04/22] selftests/coredump: discard the right amount
 after the coredump request
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>,
        Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Omar Sandoval <osandov@osandov.com>, Jacob Lalonde <jalalonde@fb.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
 <20260820-work-coredump-sparse-v2-4-ba32dd718c51@kernel.org>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260820-work-coredump-sparse-v2-4-ba32dd718c51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: YRLSf8zqLzgAsmOOvFaxTOyAu1vIvBmv
X-Proofpoint-GUID: Det6qLESaqsdiuzk7q3rG57lGmI0CNFh
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa18138 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=9XybDkHhOahZXpspZ08A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfX+ylvdHX5HKLS
 cYPZpa0eaoRG+YEirsH9P8p7ZQqqy1AX+LT03PBoNx+pjNzvrdPD/BXCxM3Uq+fYFLTCy/UlFjy
 WIvDQIZdUmBOgA7pfGGPWdHoefd0CNA31SvySJ74xSMTAQ4Iqy2+4vu1NsBZ4snUGwuZNcJ0Mev
 VESFjaxveCXTNGMQIjwlzO4mZ3VbKH5I4LAVsNGr5ZmmDLYisuzfqM/IbjAhZvpJSauNipvwMib
 B0R0i5lB8nTzlwrvwDVa0xENC0dXNgQJ29ATyvPx3LNYcz69QbdCjwPgxnLirtxvn4JjsjDx9nw
 Jecqq/dG1UbB4EfE/Y0zZnwEkJ1H/9rrrEEzzhQqe4pSi7mfrSDeiU6SRfuwpk4n2yMNTYxvcXA
 lJslZmzTvmT5fBuzJL0u23iGpJgtstIRn34bgUp8HE52Dn6ETRDgKduQuMw8rF4XWHEU99hR1Ki
 Ml/eHNR7eWD5vZ+IheQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfX7zByKMl4hvbv
 BsMorIwgW0uHJIC+0iy0bMdStEXM18UuiwYNWfaYyrKA3vBxU+hJQPy4HZFUewh+g4NZpKVmJnA
 WiR1RQwG+BGy0n44x3dmrxBE0qIfHr0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090173


On 20.08.2026 4:39 AM, Christian Brauner wrote:
> read_coredump_req() gets the leftover wrong twice.
>
> It takes the absolute difference of the two sizes, so a test binary that
> knows a larger struct coredump_req than the kernel sends tries to discard
> bytes that were never sent. And it hands recv() sizeof(buffer) instead of
> the number of bytes it wants. So MSG_WAITALL waits for a whole page.
> Either one blocks until the kernel closes the socket. Which it won't
> because it is waiting for the coredump ack...
>
> It's benign today because struct coredump_req hasn't grown. But let's fix
> it for the future. Compute the leftover as what the kernel sent beyond
> what was consumed.
>
> Fixes: 59cd658eaf40 ("selftests/coredump: add coredump server selftests")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   tools/testing/selftests/coredump/coredump_test_helpers.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
> index 2a20faf9cb0a..524fa5370593 100644
> --- a/tools/testing/selftests/coredump/coredump_test_helpers.c
> +++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
> @@ -235,10 +235,10 @@ bool read_coredump_req(int fd, struct coredump_req *req)
>   	fprintf(stderr, "Read coredump request with size %u and mask 0x%llx\n",
>   		req->size, (unsigned long long)req->mask);
>   
> -	if (user_size > kernel_size)
> -		remaining_size = user_size - kernel_size;
> -	else
> +	if (kernel_size > user_size)
>   		remaining_size = kernel_size - user_size;
> +	else
> +		remaining_size = 0;
>   
>   	if (PAGE_SIZE <= remaining_size)
>   		return false;
> @@ -250,7 +250,7 @@ bool read_coredump_req(int fd, struct coredump_req *req)
>   	if (remaining_size) {
>   		char buffer[PAGE_SIZE];
>   
> -		ret = recv(fd, buffer, sizeof(buffer), MSG_WAITALL);
> +		ret = recv(fd, buffer, remaining_size, MSG_WAITALL);
>   		if (ret != remaining_size)
>   			return false;
>   		fprintf(stderr, "Discarded %zu bytes of data after coredump request\n", remaining_size);
>
-- 
Thanks and Regards
R.Nageswara Sastry


