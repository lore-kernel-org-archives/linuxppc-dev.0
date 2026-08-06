Return-Path: <linuxppc-dev+bounces-25507-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633F3C56205
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:23:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGDd16p6Bz30B0;
	Fri, 07 Aug 2026 03:23:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786036981;
	cv=none; b=kXdE8bS0kkOetDwT+5dYsXdF+BMTJW4QVH2RthLxLcy0sMVIa5e3I7wbsGVHQbAN+kolRxXg+C7kNziqnWcBRAvpW0NIHGY5nIZFAUXwNj7jQg2Id+SOAwMGK0qCXpxLhJ6jDOF9g9M1iqlhD4ihGT2HUC4v7ehjfSzfVngUkviZSv/mtmwufM/aKhjeAFfa3Jm1Y5S3Pjiz3It45yC9wzfbXi9Oe0VP59G8VKXJsoYz8QUHlTnZnz0pWfoDCh+2mEzRg6B7ndhvoALzmlvu9YLr+cxy1q81gdqFgjzqytaNJjsptiIOvBrdfVqmkHy47SeXLN4tYLZu41QbcRlQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786036981; c=relaxed/relaxed;
	bh=ZkzLN6jNGwNCKRoBpMoMWfXE9BChgGKfAUaNh02PydU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lo9lv1x+CKcmmG7lRPrWhcOnhBjKMn3OZE3OzIrOx+xrHpiz8VjEiBJeV4deMGMYmzu660qHjp6vjxxMxmECmMjzV29jbhsDWTUclHnFnJbAoHipMDyYnL6df+hEBttbTOj6Os4L+rpVudM18hEwLehooyzYkMxvW+f8RZ72RA626SypSOOPcZoA24V1Z3liK4QydxiCK7BnwRb5hKg6XuwrjVeVzmo3mP2WcWJ33E3YpeE/OJfwP15b6XdXuNQn+R/1SgXjBw2FrMS/Q+Ywi6rkt97UCLItaZ+KH70bm3K+JyOXe0F0NhhjXtv+UicahUxwMF78eHHeSZtTUNHSJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bIGz+3eO; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bIGz+3eO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGDd11fvBz309r
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 03:23:00 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676HIISf3199729;
	Thu, 6 Aug 2026 17:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZkzLN6
	jNGwNCKRoBpMoMWfXE9BChgGKfAUaNh02PydU=; b=bIGz+3eOwCKi+U92ykVS4O
	xsANTDqq7deKJ3AIGbmAhGf7yH2iCjUZKDP8muTY9La7kwXlIxldSlqbCfGYxiEV
	uxvb4A0TwOHG2MSfi+aS6Eeu9OIOGSHVpQd6SXFg7mmduHaK5uCZ21Z4TLzTSPT7
	h7Q2GkE71DlPw4a4txn5Yhl54LRqsfB5w7UKN+zCQlLbA9WB0UKWOrmHK9lirsXt
	DX3xSYjP8QA8Y3KjGfX0exiHreecokqD3zfpcesRS1Zrk2i4WeVuyu6IowdAsk2j
	cmkBYeBRjW30fUvYE1HmgMIFTzNCmL/M6dxaOKMD/gV6wa5vD5mD4uGdOJkO+nbw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67j167a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:22:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HBFg3021547;
	Thu, 6 Aug 2026 17:22:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kc6b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:22:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676HMc3x38863150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:22:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AA1420040;
	Thu,  6 Aug 2026 17:22:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C25A52004D;
	Thu,  6 Aug 2026 17:22:35 +0000 (GMT)
Received: from [9.124.215.184] (unknown [9.124.215.184])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:22:35 +0000 (GMT)
Message-ID: <d93b4265-3ece-466d-b2a6-83f4bca43bed@linux.ibm.com>
Date: Thu, 6 Aug 2026 22:52:34 +0530
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
Subject: Re: [PATCH v10 4/8] selftest/bpf: Enable verifier selftest for
 powerpc64
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1785906979.git.skb99@linux.ibm.com>
 <84353363810b8d63e7933391f5c6a2ea46f348e3.1785906979.git.skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <84353363810b8d63e7933391f5c6a2ea46f348e3.1785906979.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfXxqlDoSW6ODnE
 mRdJwMpW/FBMgFOsbs3e/A4daUsB15vrSty7BIlIHl3w18mPpPchntLeFyrXGNzhncGXmnGgA1v
 xlhUPqcnUwSiDlEz0RnfTwEGYswgqPo=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a74c2e3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=PSicGNts6pCSyoP5NokA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX2w+4JDfLxwhK
 YkbucFPmt/AkYsVYn23f/s5bgatRjh1Oj6yxSmANgVCEXsp9S8ugQ1sQWJkm29rXo3QdwFnd6Rz
 mGXkjzc0qdyu5v9k1B84w7V+9fegpVo5ztiuS6Ro/ZEuZkJCegzkkFiOyKm5zwQQn4nnQqje8PK
 aLYvwyojFnJhGBGaNwDPig5G7MN98yYvgj9Ql9XNKou5SPUIGBb6ZU25yeU3I6aWAIQNNwOUgDg
 oc4i9kTLofEeGqK/4re4oMW0oozMnxM9WJTwCFVG1aZnkSeHxEVSMSAV9ZTv019KJTfMmV4PzZ9
 T92E4GO911S3YB+JnzXENU926BytDAWdDlOAn8G5UD6DRT1FimakNGdrYI7/Fi3rdH4V1okX+rK
 BHfEQP6utXcp0nFlXhG2+WDlCXOjVj3nQzt/mYGkfEOUIuSfcZOVPGoIw/EU+Sz12zEyr3LjwAX
 oGxNKklQDbW8WzWfzcQ==
X-Proofpoint-ORIG-GUID: LlHsD5TrwVl-MlZGffNHoQW5w4w5urou
X-Proofpoint-GUID: LlHsD5TrwVl-MlZGffNHoQW5w4w5urou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060135



On 05/08/26 11:37 am, Saket Kumar Bhaskar wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 

> This patch enables arch specifier "__powerpc64" in verifier

s/This patch enables arch specifier "__powerpc64" in/Enable 
"__arch_powerpc64" specifier in/


> selftest for ppc64. Power 32-bit would require separate
> handling. Changes tested for 64-bit only.
> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
> ---
>   tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
>   tools/testing/selftests/bpf/test_loader.c    | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index b0c441384f20..365008d1ed40 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -159,6 +159,7 @@
>   #define __arch_riscv64		__arch("RISCV64")
>   #define __arch_s390x		__arch("s390x")
>   #define __arch_loongarch	__arch("LOONGARCH")
> +#define __arch_powerpc64	__arch("POWERPC64")
>   #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
>   #define __load_if_JITed()	__test_tag("load_mode=jited")
>   #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 3ce32d134e2c..01b1420097d2 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -378,6 +378,7 @@ enum arch {
>   	ARCH_RISCV64	= 0x8,
>   	ARCH_S390X	= 0x10,
>   	ARCH_LOONGARCH	= 0x20,
> +	ARCH_POWERPC64	= 0x40,
>   };
>   
>   static int get_current_arch(void)
> @@ -392,6 +393,8 @@ static int get_current_arch(void)
>   	return ARCH_S390X;
>   #elif defined(__loongarch__)
>   	return ARCH_LOONGARCH;
> +#elif defined(__powerpc64__)
> +	return ARCH_POWERPC64;
>   #endif
>   	return ARCH_UNKNOWN;
>   }
> @@ -585,6 +588,8 @@ static int parse_test_spec(struct test_loader *tester,
>   				arch = ARCH_S390X;
>   			} else if (strcmp(val, "LOONGARCH") == 0) {
>   				arch = ARCH_LOONGARCH;
> +			} else if (strcmp(val, "POWERPC64") == 0) {
> +				arch = ARCH_POWERPC64;
>   			} else {
>   				PRINT_FAIL("bad arch spec: '%s'\n", val);
>   				err = -EINVAL;


