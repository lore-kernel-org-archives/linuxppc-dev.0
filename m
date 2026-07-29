Return-Path: <linuxppc-dev+bounces-24995-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55110C54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 11:48:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h99Zx077Jz2xwP;
	Wed, 29 Jul 2026 21:48:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785325720;
	cv=none; b=gh6dbRYLVNZ0d2AujTX+z6P9bNb76JTPIlkSV0OBV1VKLBoychrdODE2IqlhCSjZ2FTake5OKwGBuvn7kjp6KqECLYOLQ3RbNAfdtAJcdflXoS9/gRU6RsbtEN5yAfpymwrMx4txB7eFfTMv+7u7J4ix3XDN5v/xDu0Z9ABFBmBtt8Ox2yucU8gw20jN95ySIbUmiTdpSQz1BR9SkLHclyG24iZAytW6EJS43hOrK4kSFFIwYUlrCZCnWqqjtptsDZdm2el0uia6V2tBjExgqXFE+kR8iix22G83Tu91wYnAyxQlTo++hsjf6ygXWDoLpNJyey6eqmE+b9qL13Q6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785325720; c=relaxed/relaxed;
	bh=BD+u6GdikIdL6XErOKj6ye47ll9xqp2oEDXsijEa4lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNLGEvQTXuHqhM/03iELP6g7wufXp5HZ/MvagHbG6R7HgdUKM1NaQrF1l1x+nd+nECQx7geeW9vzQnybzRVZgCJwaD+Hit6aqr0LTT7mis154k8rvb6c52fR21bUQ0U5/QcoIyHaOQCqCIeFoZmtrV2lpnEAGjMGJCtJiz8vmUBUnkmxT34pCizAoe21csKDDgN+s6/zslIpO08GYIWszH14y1oz2vzcJrkg2zjurQD2eVrHXgCSCkVokjHso9wwHC5fwiETmmO8fR7QtH7nz+yV8faTdpYa7zyLTJsQ916kdrI0JsxKWGYp1JcmXFxwORpFyiogju2eGdVX0tmemg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bBJsfzH5; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bBJsfzH5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h99Zv3ccWz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 21:48:38 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHjC53952900;
	Wed, 29 Jul 2026 11:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BD+u6G
	dikIdL6XErOKj6ye47ll9xqp2oEDXsijEa4lk=; b=bBJsfzH5HwG5Ag0f608i3T
	H7fXP1LwcHquxZGwJkHmlO00yjRF7bomOXm+W4aeP1UtXk42dqUx+uembHd6Si7X
	4gAhMtWPw+fznha7bvVsx4wnbV7cWOuyJAlj4D3/zJMOTT9xmHVL0fxABskQb/SE
	zXGLYMIIl50Md0M7PYZZgkp48sKx0VNOZjf9m9XWet5qZg6V7LxfVE4mb8L/fRUS
	Gt2CORfqEy75pNcRaUbzY8IOGjvJmsixPGw7kLrBbpm1P5Mk949is9PAlFWE3IjR
	LgAGO57N8ShrD3PwMw/o48hPaSCsXiR71jlbuqUF5ZqK1G5e3FT52m7f+SboGqWg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj9ndp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 11:48:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TBfIou022250;
	Wed, 29 Jul 2026 11:48:22 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y67tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 11:48:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TBmL5X29950524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 11:48:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 784F95805F;
	Wed, 29 Jul 2026 11:48:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91B0558053;
	Wed, 29 Jul 2026 11:48:17 +0000 (GMT)
Received: from [9.43.93.217] (unknown [9.43.93.217])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 11:48:17 +0000 (GMT)
Message-ID: <aa51485f-fea0-48e3-9b66-c18d39447a1c@linux.ibm.com>
Date: Wed, 29 Jul 2026 17:18:15 +0530
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
Subject: Re: [PATCH v2] powerpc/perf/hv-gpci: bound sysfs output with helpers
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Kees Cook <kees@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260417074825.22967-1-pengpeng@iscas.ac.cn>
 <20260424070103.1-hv-gpci-v2-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20260424070103.1-hv-gpci-v2-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5NyBTYWx0ZWRfX1TMG6VWmJ47X
 XVupkb94rnqhvJyvTMPeQzbdaaOz3RRGgdS1LofmRHJB3bllvyq95EUyj4fd28XV4s3BcbMDa8z
 BOWV14+G5Iss6+7bWpDCY+mDuQZCT2o=
X-Proofpoint-GUID: s1ibAG87dMVFeUSaQDvQX7BrXjbf_x5r
X-Proofpoint-ORIG-GUID: R_5O5bLaMogExC6J127ghpaNxH5ogRf3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5NyBTYWx0ZWRfX3aVCw+HUZRX+
 etSuHwwfBUoY7OPhA9KiTQmz09rE2x0LsO1f60R8j2dtyZJyOyUvGYnU2/bQ90p8CstsdwKnPlP
 BvoSs3CFWxDR264EQNdxDxd731ZETl52IvcYPhW1qVOIQ56ehRcCTh0I+EdCZDl1hgrp5T20n9S
 uqziH0sWAgn+r95FlVJhQxK5iNGUZ68vAUYVMkgve0YvphLiYua5US2c5WCuV3SbIcfmvWSJK0Q
 NgVx0gfmQDUA2v772FOumo5M5iP0VL2+bMBXXFh8pO2nCQOc2oz9x//hdHc+irfJfRM/Tc+J1OI
 FwwTJEzELSURNCOzBZlFO0uaiH4OQSgEZ0GMnzF0BVrPyzzjddaikj7q8oUsHCLHI4VZFfXBXCQ
 XOItN852wSRc052GSBaLkQZ7ZlzDC925lFjROwM/x89ZIi6vvx8/wv5XwZJ00JyAeTPn62k+jCU
 X6T50/b9UhUT1Y4kQpQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a69e887 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=l68EZY392IGl-1xb1WsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290097


On 4/23/26 9:02 PM, Pengpeng Hou wrote:
> systeminfo_gpci_request() and
> affinity_domain_via_partition_result_parse() hex-encode hypervisor data
> into the single-page sysfs read buffer with sprintf(buf + *n, ...).
> Both helpers only check PAGE_SIZE after the formatting loops have
> already advanced past the end of the buffer.
>
> Add small helpers around sysfs_emit_at() for hex-byte and newline
> appends, and stop once the sysfs buffer is full. This keeps the repeated
> bounds handling local instead of open-coding it at each append site.
>
> Fixes: 71f1c39647d8 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show processor bus topology information")
> Fixes: a15e0d6a6929 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity domain via partition information")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v1:
> - refactor the repeated sysfs_emit_at() handling into helpers as suggested
>    by Christophe Leroy
>
> diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
> index 5cac2cf3bd1e..2f543f0671ba 100644
> --- a/arch/powerpc/perf/hv-gpci.c
> +++ b/arch/powerpc/perf/hv-gpci.c
> @@ -11,6 +11,7 @@
>   
>   #include <linux/init.h>
>   #include <linux/perf_event.h>
> +#include <linux/sysfs.h>
>   #include <asm/firmware.h>
>   #include <asm/hvcall.h>
>   #include <asm/io.h>
> @@ -129,11 +130,36 @@ static int sysinfo_counter_request[] = {
>   
>   static DEFINE_PER_CPU(char, hv_gpci_reqb[HGPCI_REQ_BUFFER_SIZE]) __aligned(sizeof(uint64_t));
>   
> +static int hv_gpci_emit_hex_byte(char *buf, size_t *n, u8 byte)
> +{
> +	int len;
> +
> +	len = sysfs_emit_at(buf, *n, "%02x", byte);
> +	if (len <= 0)
> +		return -EFBIG;
> +
> +	*n += len;
> +	return 0;
> +}
> +
> +static int hv_gpci_emit_newline(char *buf, size_t *n)
> +{
> +	int len;
> +
> +	len = sysfs_emit_at(buf, *n, "\n");
> +	if (len <= 0)
> +		return -EFBIG;
> +
> +	*n += len;
> +	return 0;
> +}
> +
>   static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
>   			u16 secondary_index, char *buf,
>   			size_t *n, struct hv_gpci_request_buffer *arg)
>   {
>   	unsigned long ret;
> +	int rc;
Concern here is that function return unsignerd long but patch is 
returning int,
so could break the caller.  Better way could be change function prototype to
return int and update all the caller.

Maddy
>   	size_t i, j;
>   
>   	arg->params.counter_request = cpu_to_be32(req);
> @@ -176,9 +202,14 @@ static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
>   	for (i = 0; i < be16_to_cpu(arg->params.returned_values); i++) {
>   		j = i * be16_to_cpu(arg->params.cv_element_size);
>   
> -		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size); j++)
> -			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[j]);
> -		*n += sprintf(buf + *n,  "\n");
> +		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size); j++) {
> +			rc = hv_gpci_emit_hex_byte(buf, n, (u8)arg->bytes[j]);
> +			if (rc)
> +				return rc;
> +		}
> +		rc = hv_gpci_emit_newline(buf, n);
> +		if (rc)
> +			return rc;
>   	}
>   
>   	if (*n >= PAGE_SIZE) {
> @@ -461,10 +492,14 @@ static ssize_t affinity_domain_via_domain_show(struct device *dev, struct device
>   	return ret;
>   }
>   
> -static void affinity_domain_via_partition_result_parse(int returned_values,
> -			int element_size, char *buf, size_t *last_element,
> -			size_t *n, struct hv_gpci_request_buffer *arg)
> +static int affinity_domain_via_partition_result_parse(int returned_values,
> +						      int element_size,
> +						      char *buf,
> +						      size_t *last_element,
> +						      size_t *n,
> +						      struct hv_gpci_request_buffer *arg)
>   {
> +	int rc;
>   	size_t i = 0, j = 0;
>   	size_t k, l, m;
>   	uint16_t total_affinity_domain_ele, size_of_each_affinity_domain_ele;
> @@ -483,27 +518,40 @@ static void affinity_domain_via_partition_result_parse(int returned_values,
>   	 */
>   	while (i < returned_values) {
>   		k = j;
> -		for (; k < j + element_size; k++)
> -			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
> -		*n += sprintf(buf + *n,  "\n");
> +		for (; k < j + element_size; k++) {
> +			rc = hv_gpci_emit_hex_byte(buf, n, (u8)arg->bytes[k]);
> +			if (rc)
> +				return rc;
> +		}
> +		rc = hv_gpci_emit_newline(buf, n);
> +		if (rc)
> +			return rc;
>   
>   		total_affinity_domain_ele = (u8)arg->bytes[k - 2] << 8 | (u8)arg->bytes[k - 3];
>   		size_of_each_affinity_domain_ele = (u8)arg->bytes[k] << 8 | (u8)arg->bytes[k - 1];
>   
>   		for (l = 0; l < total_affinity_domain_ele; l++) {
>   			for (m = 0; m < size_of_each_affinity_domain_ele; m++) {
> -				*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
> +				rc = hv_gpci_emit_hex_byte(buf, n, (u8)arg->bytes[k]);
> +				if (rc)
> +					return rc;
>   				k++;
>   			}
> -			*n += sprintf(buf + *n,  "\n");
> +			rc = hv_gpci_emit_newline(buf, n);
> +			if (rc)
> +				return rc;
>   		}
>   
> -		*n += sprintf(buf + *n,  "\n");
> +		rc = hv_gpci_emit_newline(buf, n);
> +		if (rc)
> +			return rc;
>   		i++;
>   		j = k;
>   	}
>   
>   	*last_element = k;
> +
> +	return 0;
>   }
>   
>   static ssize_t affinity_domain_via_partition_show(struct device *dev, struct device_attribute *attr,
> @@ -514,6 +562,7 @@ static ssize_t affinity_domain_via_partition_show(struct device *dev, struct dev
>   	size_t n = 0;
>   	size_t last_element = 0;
>   	u32 starting_index;
> +	int element_size, rc, returned_values;
>   
>   	arg = (void *)get_cpu_var(hv_gpci_reqb);
>   	memset(arg, 0, HGPCI_REQ_BUFFER_SIZE);
> @@ -546,10 +595,16 @@ static ssize_t affinity_domain_via_partition_show(struct device *dev, struct dev
>   	 * to buffer util we get all the information.
>   	 */
>   	while (ret == H_PARAMETER) {
> -		affinity_domain_via_partition_result_parse(
> -			be16_to_cpu(arg->params.returned_values) - 1,
> -			be16_to_cpu(arg->params.cv_element_size), buf,
> -			&last_element, &n, arg);
> +		returned_values = be16_to_cpu(arg->params.returned_values);
> +		element_size = be16_to_cpu(arg->params.cv_element_size);
> +		rc = affinity_domain_via_partition_result_parse(returned_values - 1,
> +								element_size, buf,
> +								&last_element, &n,
> +								arg);
> +		if (rc) {
> +			put_cpu_var(hv_gpci_reqb);
> +			return rc;
> +		}
>   
>   		if (n >= PAGE_SIZE) {
>   			put_cpu_var(hv_gpci_reqb);
> @@ -578,10 +633,15 @@ static ssize_t affinity_domain_via_partition_show(struct device *dev, struct dev
>   	}
>   
>   parse_result:
> -	affinity_domain_via_partition_result_parse(
> -		be16_to_cpu(arg->params.returned_values),
> -		be16_to_cpu(arg->params.cv_element_size),
> -		buf, &last_element, &n, arg);
> +	returned_values = be16_to_cpu(arg->params.returned_values);
> +	element_size = be16_to_cpu(arg->params.cv_element_size);
> +	rc = affinity_domain_via_partition_result_parse(returned_values,
> +							element_size, buf,
> +							&last_element, &n, arg);
> +	if (rc) {
> +		put_cpu_var(hv_gpci_reqb);
> +		return rc;
> +	}
>   
>   	put_cpu_var(hv_gpci_reqb);
>   	return n;

