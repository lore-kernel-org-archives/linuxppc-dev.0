Return-Path: <linuxppc-dev+bounces-23196-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11BAC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 13:50:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqPg82H22z2ybQ;
	Tue, 30 Jun 2026 23:50:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782827444;
	cv=none; b=aR8PWYlVGChjtAZJppZfbhd/yNOwLaEKvgZ371DJoETMwnEugh4BjrINnbFUVkq9ws5SKI0gmzd+GWK1LB4Y3wNxleNS6e/5M6h3TLxi6bnH/l3V/OvPRzeamJUTfYFkrsXZX/x1QpiXvGLR7VtV4rsfpkrV8lE1NU0BMDnCMegjZr7sreqSNvxVQDit2gyDxPw/9UGRtLaVuXp16jAAtdyTqmouKt/MWebhycJfrhRIBY5OUeLfPULV2golX7pvic7kCTEkeAcZOdxUlXCioWKrCqNoA3eo+M5oK90W4BNX0CUNWyHuKkL0+DCVG2Z5OvkZCbUIkK4N71VNRMvZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782827444; c=relaxed/relaxed;
	bh=V40QtnZDhQBQa28QwJzOPXjsbSwis5CZKSxFgN4nazg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dchR01RvcpBhNe4GkD0eA+wv06ArtQomPN6VkfZDu3QBQzltyy5O3hTd6c9ORMISzQaOmXhBcSGoYx5FSHWaV+a+ZhEOSY8vH7p4/WqwGNqg/ePT1EyP/jTisXu6plE4rHG4QNS5/qNXpkjqh1lLWXpp/UHfjTSdAuFZMvYJvKTknwbXac6pVFAZ3wQtSMMzl8s+Vs4Om9wJulnfTn7GAjxT3ceMyTopaoM+mQM51b8D2+AkIoEk9iVF5JLAB2a3S7C96yascCFJBh/TgT6xEnfmPXApb/MC3o3glOJhaucfpeD11NTcg8iUywaAfdA6adr4n+X7EmPPIQWNk1E1bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UdExCywZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UdExCywZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqPg65Ty3z2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 23:50:42 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nE7w1581685;
	Tue, 30 Jun 2026 13:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V40Qtn
	ZDhQBQa28QwJzOPXjsbSwis5CZKSxFgN4nazg=; b=UdExCywZpYWCKvrSa4taD4
	/GtvZJ98jlFcBmkyiBuuoQc3BkVibNZH//T3jYCcnUXajUabAc6CCU9wx+QQEhRN
	4zTvycoMPT0/al04Zhq6tv77ymJ4i/Rx17jailtS0tgkoOZTVhSVGXWQWBrIEF4s
	qATC91RNkNMCqQgGzaDHJVn9+UjZ54FhFFBhY7zeW6VFzGGoXeGwxlUrcsAZVab1
	NJKwHsW4V3EiNM+Niistg9b+it2a00eMYuzRKxrBjRcjc9c9pcINvMrZATWvyOE+
	fPZn1vssaYAKVqU/iiZww3y0CzOEG4oF/2EQTuUXPruQx17GD392RebnKj8Jr5Xg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26q9xue0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 13:50:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UDnvbE032252;
	Tue, 30 Jun 2026 13:50:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhaeat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 13:50:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UDoN3E15794468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 13:50:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69D5B2004B;
	Tue, 30 Jun 2026 13:50:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4221420040;
	Tue, 30 Jun 2026 13:50:21 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 13:50:20 +0000 (GMT)
Message-ID: <c246ce30-73f5-4beb-a47b-e771f294842e@linux.ibm.com>
Date: Tue, 30 Jun 2026 19:20:19 +0530
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
Subject: Re: [PATCH v2] powerpc/powernv: Cache OPAL check_token() results
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: adityag@linux.ibm.com, chleroy@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mahesh@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        thuth@redhat.com
References: <20260626123534.396456-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260626123534.396456-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEyOSBTYWx0ZWRfXwbyAQEzI9OPG
 RAcXMirSizypn7RspXOOdECyZhaVmD7UnS/cDPMHPgaX/lTJWsn/SzAOMQ+xIlbHaHMXdErSy6C
 A+WawPbjnadoZzAYMA7ePen8JykEucqyr0WQ7KuRllmkMAsl+GFiVZm1O2BF6gkggxzVYwz3Tc+
 XnZGWqCzXX74cxlYDGt1NGWrRMB9bx1hjisPhOIg8noAVoj+zf74oOAET+QIOtCE9gljA7rw5WT
 KYcb3QsEjAlCo84wwkIkn7iZroYnXxxbca0qzVINGJUqO4Sr7aFHGBUQKeeJ9uOYMvVxA7HKKWM
 bR3OqFvhMrKqgSXWLR7rxRbKIg/4ZLVVFZxZx9iKZCDopuyGbJcsMiBCc2yw7fqTkQoFjCUO6Rm
 oH4p+8S548ZYS8Y251fKRERCTJuldhSdO8InNGkQYlvapqNQbrjVZ6V2OuMkKuN8nl2FVXZCYEy
 3KViRxGkMRjDrvw1xQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEyOSBTYWx0ZWRfX/LIVWUr7fSOE
 FhoS1N/sXeriW6dvWRiULsEz6DAkIsGKtzhTtZFkNgSCq42e5OKdS1/jlRUJHpcvoovw5Octgm7
 EAN0XsPtbqzWGQPa76PgtIGR6MNALK0=
X-Proofpoint-GUID: QqEnxBv7prVZSU7_0faEq2rnx8bANsdn
X-Proofpoint-ORIG-GUID: Fmlgi0iKBe3ArwGkWMDzX9BZVMqYPBuF
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a43c9a4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WfwhWZzrCc7k46VYY-MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300129



On 26/06/26 18:05, Shivang Upadhyay wrote:
> `opal_check_token()` function is used to determine if a specific
> OPAL firmware call is supported on the current platform. This check
> is performed frequently during boot and runtime, resulting in
> unnecessary firmware calls for the same token values.
>
> Add a caching layer for the opal_check_token() OPAL call to avoid
> repeated firmware calls for token availability checks. This reduces
> firmware call overhead during boot.
>
> Testing with buildroot images shows OPAL calls reduced from
> 35578 to 28983, before console bring-up.

My testing shows similar statistics.

As per my testing, the upstream kernel (without this patch) at commit
840ef6c78e6a2f694b578, compiled with powernv_defconfig, shows ~7K
CHECK_TOKEN OPAL calls to boot the kernel and reach the console.

With this patch included, there are only 8 CHECK_TOKEN opal calls.

There is a significant reduction in CHECK_TOKEN OPAL calls
with this patch. Thanks for working on this improvement.

The changes look good to me. Feel free to add:

Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
> Changelog:
> * v1: https://lore.kernel.org/all/20260601112520.161605-1-shivangu@linux.ibm.com/
>     - implemented tri-state check as suggestd by Sourabh.
>     - made the implementation more clear.
>
> ---
>   arch/powerpc/include/asm/opal.h            |  1 +
>   arch/powerpc/platforms/powernv/opal-call.c |  2 +-
>   arch/powerpc/platforms/powernv/opal.c      | 30 ++++++++++++++++++++++
>   3 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 0a398265ba04..e7e11479122b 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -156,6 +156,7 @@ int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
>   int64_t opal_pci_poll(uint64_t id);
>   int64_t opal_return_cpu(void);
>   int64_t opal_check_token(uint64_t token);
> +int64_t opal_check_token_call(uint64_t token);
>   int64_t opal_reinit_cpus(uint64_t flags);
>   
>   int64_t opal_xscom_read(uint32_t gcid, uint64_t pcb_addr, __be64 *val);
> diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
> index 021b0ec29e24..00325c189e69 100644
> --- a/arch/powerpc/platforms/powernv/opal-call.c
> +++ b/arch/powerpc/platforms/powernv/opal-call.c
> @@ -207,7 +207,7 @@ OPAL_CALL(opal_validate_flash,			OPAL_FLASH_VALIDATE);
>   OPAL_CALL(opal_manage_flash,			OPAL_FLASH_MANAGE);
>   OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
>   OPAL_CALL(opal_resync_timebase,			OPAL_RESYNC_TIMEBASE);
> -OPAL_CALL(opal_check_token,			OPAL_CHECK_TOKEN);
> +OPAL_CALL(opal_check_token_call,		OPAL_CHECK_TOKEN);
>   OPAL_CALL(opal_dump_init,			OPAL_DUMP_INIT);
>   OPAL_CALL(opal_dump_info,			OPAL_DUMP_INFO);
>   OPAL_CALL(opal_dump_info2,			OPAL_DUMP_INFO2);
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 1946dbdc9fa1..1e9cb5271ee7 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -1125,6 +1125,36 @@ EXPORT_SYMBOL_GPL(opal_flash_read);
>   EXPORT_SYMBOL_GPL(opal_flash_write);
>   EXPORT_SYMBOL_GPL(opal_flash_erase);
>   EXPORT_SYMBOL_GPL(opal_prd_msg);
> +
> +/**
> + * opal_check_token - Check if an OPAL call token is supported
> + * @token: OPAL token number to check
> + *
> + * Returns 1 if supported, 0 if not.
> + */
> +int64_t opal_check_token(uint64_t token)
> +{
> +	static u8 token_cache[OPAL_LAST];
> +	enum {
> +		SUPP_UNKNOWN = 0,
> +		PRESENT,
> +		ABSENT
> +	};
> +
> +	if (token > OPAL_LAST)
> +		return 0;
> +
> +	if (token_cache[token] == SUPP_UNKNOWN) {
> +		/* Do the actual opal_call here */
> +		if (opal_check_token_call(token)) {
> +			token_cache[token] = PRESENT;
> +		} else {
> +			token_cache[token] = ABSENT;
> +		}
> +	}
> +
> +	return (token_cache[token] == PRESENT);
> +}
>   EXPORT_SYMBOL_GPL(opal_check_token);
>   
>   /* Convert a region of vmalloc memory to an opal sg list */


