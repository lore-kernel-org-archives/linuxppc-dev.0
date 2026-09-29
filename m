Return-Path: <linuxppc-dev+bounces-28482-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C521CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 09:56:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvD8t3Jkmz30PJ;
	Tue, 29 Sep 2026 19:56:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790675790;
	cv=none; b=kVDxOiPELSZB2xaAQwCnB+l+IYVZHCTcJr0/xLXUsPLDQCM0QFBBa6G73t+FJxOML6gppE3atj3UrtJ7KcDk9I2iMm5L8FjIlJ61U6QJ6j7yRhSGEBfR85B5CmCQeZbQ9O7h2vl2cw839xB9I8Y0QbJZmfz896BAsRjzUFgnYOQmTwcfP3ghQmTPvX1ohkIrwVSbm/Yk9xX57+Kb4CtwDmbsv5vkWXklxMO43uVa0fuqnFxvMZk7XoZ+WWAGPML//efAtV7FSBOtHfz07AQLJfeuFj5xsggYbYSNVjzZ66GzQnHLLdW/M0tQOc7SK6KAutySHXQ09usL+iXKnx+2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790675790; c=relaxed/relaxed;
	bh=4FWPvM8OqTdj+zRb7fwobf1fN91xUUhfgAHWArW4fm0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JgA0gTcwb4BTcRLiFtugaxlbl37e6jX14goHHFMXGF0ZK1Av8mQUcFXFLz3N42ycC57RtT5DZSDUBIg4SdTVg0xCm8uQbfwgAYGC0n4Fp4haxkzxgfhKconeZm8uLMyJYL3f9QkFje4jMSeX6ofRZjLoHRUBQfCVvYzaI0q/QfZbUIIXoT8Ro6n2/Es0GbmtQMvsIr3ecORpCmVR/dT8Z5S1zX9ecPgwWuGt4l/kLjcVA+XU6mRqTCw5IF6387GNn7WzqFGuagKwAoVPFGlQHAHn3XYNOFURZGkdL6uUX5vNZGE+X5MbzC8KytE6sTW1A5ifNoG6/HmFvwJuA+BE5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D9CWepRq; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D9CWepRq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvD8s5XWcz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 19:56:29 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46WSa1210059;
	Tue, 29 Sep 2026 06:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4FWPvM
	8OqTdj+zRb7fwobf1fN91xUUhfgAHWArW4fm0=; b=D9CWepRqAJyohb0ntba2Ww
	UZkFcZuaIo6lrLGYvNkcubM4QLsnlzMunCs0kLK8SrRUWOT/HroB0MtKfd/dXvCQ
	vvS5QtOZgqhDyTBmxD7Mo7vfUcMqHiW8ge6gjRQJrz9wesqExEbxw1ArItsisKLV
	IGlbia7jXH8ZIXze9DlNqDz1lFlHFSn8VbM0azxfkOzy7Tc+Hfh8N8H6QU5oY5VK
	9a3lcfFGd/wI8YJpxymFBvK5g13y9DHt5N/893yTHuLtTsoo6gmwb0Cz+lM0Q+Ku
	xJsUidEEOEGLxHe1AQOAj5xbN0V1N4rqGIMCEM9RxmokAAGZLtJ+SV6KqyeSliRg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr5jud-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 06:45:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T4I4AL1188915;
	Tue, 29 Sep 2026 06:45:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhghdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 06:45:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T6jNKn23265656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 06:45:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D41CA58062;
	Tue, 29 Sep 2026 06:45:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5110258059;
	Tue, 29 Sep 2026 06:45:23 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 06:45:23 +0000 (GMT)
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
Date: Tue, 29 Sep 2026 12:15:23 +0530
From: jyoti <jyoti@linux.ibm.com>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, sourabhjain@linux.ibm.com
Subject: Re: [PATCH] powerpc/mpic: Fix memory leak of mpic on error paths
In-Reply-To: <arTs9bM5sOz0CDch@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260924063010.188642-1-jyoti@linux.ibm.com>
 <arTs9bM5sOz0CDch@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Message-ID: <8362e541252efe26f71d651585ebeaa0@linux.ibm.com>
X-Sender: jyoti@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfXxc2ynKGVwenF
 E32dzuI1D7EVOn1CLdOZZ/dlhZWIZPrbpDJvlV8zOuXPOfvZR2p/WZNWfSmu8nvNvNUfZDUECGh
 ckDktY6YvbbUUyqfJXVvcTADnpsA0QSXmUbl9aK9+fBreUI7RJidU9a0qBcP4Nuu9m0tf233Vze
 JJKI3L7E41kt2QdX+v5cXDVUAvvDXR6JS1ZWIWFnHXzGToGKI2J5cGko7q2mfaZdrgbF9N1jkfE
 qPOxISeQYSZ0c+SPzhNwGQLUoMkStu6MYtUAkcAj7NKBVF6WHsQNlLhmPkuzdtJh+q5XmxV+Zsq
 3ZMHTGX45OXdHlQdQMurnPjCDOwvOtS+enzrUBwv0wgYaI9MbYeGPX1gTlvXKt3vmOv+L5vl+Aw
 IfMHVd8LVaHjUzG326VRQGXa85B2eoyyVfHYNtXjUwww8fakXQjgTiSc/w47LDdCsUJrQuKQ0Mj
 LjMwoB9ZJpojAhvFE+g==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abb5e86 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=nDypmBHfwMd7Jn3RUKwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Qs8B0oe2fHEomKyyEg_tsVrekhDqj121
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX0nagKVNwkYGu
 8MNAFLKFO8OYG6sHz+tpZJ3gjMmokjyPlq2hrKFxlSx8nyHDEB5/OLRsy93nmSCfAPyB7tL+OB7
 bgrfDFr39px1/A/gCPEI+oRCoz46iOA=
X-Proofpoint-GUID: X3eW3sPrn7KaXxjLwNsQyNOheBiFdg-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290026

On 2026-09-24 14:58, Mukesh Kumar Chaurasiya wrote:
> On Thu, Sep 24, 2026 at 12:00:10PM +0530, Jyoti Gupta wrote:
>> mpic_alloc() allocates struct mpic (and optionally the protected
>> sources bitmap) but does not free them when mpic_setup_error_int() or
>> irq_domain_create_linear() fails, leaking the memory.
>> 
>> Initialise mpic to NULL and free the bitmap and the mpic in the common
>> error path before dropping the device node reference. The register
>> mappings are not released here.
>> 
>> Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
>> ---
>>  arch/powerpc/sysdev/mpic.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
>> index 6e8fa94985f3..e777b33f170d 100644
>> --- a/arch/powerpc/sysdev/mpic.c
>> +++ b/arch/powerpc/sysdev/mpic.c
>> @@ -1221,7 +1221,7 @@ struct mpic * __init mpic_alloc(struct 
>> device_node *node,
>>  				const char *name)
>>  {
>>  	int i, psize, intvec_top;
>> -	struct mpic *mpic;
>> +	struct mpic *mpic = NULL;
> We don't need this initialization. We initialize it later again.

Agree

>>  	u32 greg_feature;
>>  	const char *vers;
>>  	const u32 *psrc;
>> @@ -1488,10 +1488,6 @@ struct mpic * __init mpic_alloc(struct 
>> device_node *node,
>>  						 intvec_top,
>>  						 &mpic_host_ops, mpic);
>> 
>> -	/*
>> -	 * FIXME: The code leaks the MPIC object and mappings here; this
>> -	 * is very unlikely to fail but it ought to be fixed anyways.
>> -	 */
>>  	if (mpic->irqhost == NULL)
>>  		goto err_of_node_put;
>> 
>> @@ -1527,6 +1523,9 @@ struct mpic * __init mpic_alloc(struct 
>> device_node *node,
>>  	return mpic;
>> 
>>  err_of_node_put:
>> +	if (mpic)
>> +		bitmap_free(mpic->protected);
>> +	kfree(mpic);
>>  	of_node_put(node);
>>  	return NULL;
>>  }
>> --
>> 2.55.0
>> 
>> 
> Do we need a fixes tag for this?
> 
Agree


Thanks,
Jyoti


