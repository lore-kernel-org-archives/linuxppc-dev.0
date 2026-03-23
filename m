Return-Path: <linuxppc-dev+bounces-18611-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715BDEC01A9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 08:53:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffRlq11wXz2ySb;
	Mon, 23 Mar 2026 19:53:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774256007;
	cv=none; b=XVgbrQE0WZQxlFSiZdaGoXwXMmjyyakad4efaEcBefqeIdcjz73+X+LWcN1o6JqHUrrb9jQEnNHrjl4BEdneYWmsWYJare2PMeuDXSGzEip+i2sn3pSXCK25jc7C0weCYm708VJd5QJDHG8CVt4c2/4cERystAcMx3OY9u1KbuFkBoN8AjO3HkQnDeVzDjOei9Og+Dlu2BIjaDkIAMq/dCIA/Q9hBAMxc9ViiUPyNQGTltGh4ToYLlbGUroS2tNXBkS5KwKHNEDtuajaLagoYSuMaYaHHyzkbBvfi6/s91IWE2o97ZLNt9Y9jPgas58vASSfoL9o5ZDjI8dT+O3GeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774256007; c=relaxed/relaxed;
	bh=DR9LUmWUR9exj2wJr9jxKL2NOIt/iKzdjwAN3yICP28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7Ks71ga2XTA1HBxcH67r4V2iPGSeeXE76zhIJXwSDP4mkoeq9c6liIavHB0oXtYgP8u2IGtn7Gzj3PsASdvdNsJtQMAqNyZJDPyT+PJcobOjssBe+vDdN0LdgrRLzezeGoCFNCXeNIS9I/JQ2MG9ntYS11468k7mTeUwlv58XlAeutJhohGO0x80RRH4b5eHtNNTmv2WoniPxMe4LqIbVOemlgNA5MkrRwrJCJXdC5pU2Cb+Au28NOZhsPeawcnfljzpsyCOPA4NXca9V9HfAt4a3yaMn0Vfkb/CS3k7bgK/mKUpkiZ/0zDo3LZ4YkYT6rLIKqTTJSDfvF/1R4NVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a+bs9O7X; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a+bs9O7X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffRln63J7z2xly
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 19:53:24 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MJUVB9506491;
	Mon, 23 Mar 2026 08:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DR9LUm
	WUR9exj2wJr9jxKL2NOIt/iKzdjwAN3yICP28=; b=a+bs9O7XuXL8JikIWKwT4C
	Dj+HjnZZHINfjHURe3AMhi9x1jTZBZugvzteJVzIM3hfM/zIf2ULHN62gR03ciV+
	Ovlrlqt8Vsmem4f+H8nboVLQn92Wt9Gpr/r5+8cZEYE4Hm/ZA6Tl6og1OJAfEc4o
	hmxN9F5e/2q5SvI6lQqhH4zdL5ptpnryX30e6BdVNzl3ZTy4l4Tw9raZuVYoYXbN
	NZi1v3UqI+d2P+uUbXeG5YS9gZTCJ3891glKLfVwOwSA2PH0HCM2tlTlONQz8BhO
	8UzaB8WobSraIbZgxruI9Rjj+RI1ebEDD8PS22Wkaunv67mACnMumduNbdghxC5Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq62ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 08:53:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N73JhD009118;
	Mon, 23 Mar 2026 08:53:11 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nncp0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 08:53:11 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62N8r9f126477134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 08:53:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F86C58060;
	Mon, 23 Mar 2026 08:53:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DDB258056;
	Mon, 23 Mar 2026 08:53:03 +0000 (GMT)
Received: from [9.61.247.60] (unknown [9.61.247.60])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 08:53:02 +0000 (GMT)
Message-ID: <b99af481-a75a-4db5-9c51-92eee0b6b464@linux.ibm.com>
Date: Mon, 23 Mar 2026 14:23:01 +0530
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
Subject: Re: [PATCH 1/2] powerpc/kdump: fix KASAN sanitization flag for
 core_$(BITS).o
Content-Language: en-GB
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260321053121.614022-1-sourabhjain@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20260321053121.614022-1-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 60tYBCLMejC0qMsbMHmGAP8BvdF7x_fO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA2NyBTYWx0ZWRfXxw7btvvjj5hs
 wGjHR/JhBZi1YfQuaHNmmMpA2b6zXLhCxYpg7OOjLE/6P5e+NXoZ6HIqlwptwOWdfXeCzqwCidY
 ZCuDgSCEgFbMk4zRpGT1GQyCdsbntzr36Qa1KdZdUQeRWgyBFac+Oq3g+Xiolf7RcS7hECWV00g
 ycMWvVFuvUTZFbfQEiJ1t3wx1l+a3tk9Gm7Bkl3gyni1qhloghwdtN1agtjzxwoXuCDEhENJ+GQ
 JNYI+3Nz77Sc6fx6p+Bx+pOgdYYG9qUIZ6TsZVeQGw4pFqGqDAf7xSJSye64tB+eHtK0W3NcWeV
 9ya1mzagd1m+8FCtlahXcyRIY+rVtdyzNmw63pCTWYmTu9pJ7agHF8TE0H0RQjjmJD9UHk/YF4z
 DKXa13bWJXOLyeGkrxC3etAYa3dvRGvr015b5iM9Z5pgZD4dq6xHCkdcRmxbL8K6twE8Hl7ZHyP
 hpFuu/KjY3EHxIhjphw==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c0ff78 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JuTF4qcAAAAA:8 a=pGLkceISAAAA:8 a=ZSZbnnKFPOSW3gtc0DAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=WlT8qwTXB_Kj6um4hl3b:22
X-Proofpoint-GUID: KfqCBUHr9RfKHwEOUQGq4AuQqnMw4nN_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230067


On 21/03/26 11:01 am, Sourabh Jain wrote:
> KASAN instrumentation is intended to be disabled for the kexec core
> code, but the existing Makefile entry misses the object suffix. As a
> result, the flag is not applied correctly to core_$(BITS).o.
>
> So when KASAN is enabled, kexec_copy_flush and copy_segments in
> kexec/core_64.c are instrumented, which can result in accesses to
> shadow memory via normal address translation paths. Since these run
> with the MMU disabled, such accesses may trigger page faults
> (bad_page_fault) that cannot be handled in the kdump path, ultimately
> causing a hang and preventing the kdump kernel from booting. The same
> is true for kexec as well, since the same functions are used there.
>
> Update the entry to include the “.o” suffix so that KASAN
> instrumentation is properly disabled for this object file.
>
> Fixes: 2ab2d5794f14 ("powerpc/kasan: Disable address sanitization in kexec paths")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/1dee8891-8bcc-46b4-93f3-fc3a774abd5b@linux.ibm.com/
> Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Daniel Axtens <dja@axtens.net>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---


This patch fixes the reported issue. Please add below tag.


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


>   arch/powerpc/kexec/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
> index 470eb0453e17..ec7a0eed75dc 100644
> --- a/arch/powerpc/kexec/Makefile
> +++ b/arch/powerpc/kexec/Makefile
> @@ -16,4 +16,4 @@ GCOV_PROFILE_core_$(BITS).o := n
>   KCOV_INSTRUMENT_core_$(BITS).o := n
>   UBSAN_SANITIZE_core_$(BITS).o := n
>   KASAN_SANITIZE_core.o := n
> -KASAN_SANITIZE_core_$(BITS) := n
> +KASAN_SANITIZE_core_$(BITS).o := n

