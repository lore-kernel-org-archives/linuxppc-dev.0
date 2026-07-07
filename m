Return-Path: <linuxppc-dev+bounces-23676-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82298C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 07:07:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvXNG6qv7z3brx;
	Tue, 07 Jul 2026 17:07:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783408030;
	cv=none; b=OBOFNfzHVsWw/OVxhTYtK6OF0/W5MW8lukxsxZLUme6LYeLyuvPWawsICRbpgga34IPHf+DGGheKQ/DlHtupJKs/Ch1ujb6mbB++oXMOSGxQZxWF+TXpOt2aqjRc1UXxAv3UYgcDNG16RXHHqp5Boit61pq6cV/VQJNvLvW6Bz0z5i3ZoGMczpX5//Z6SahbaRIFWVVyMue7LWqdKnGLBFy0boUlkRqK6itVMbPGMXSFPjsErAbZk3VkAP2WDSqr+59WWFh8SIOVgMZNQ36xvBSBDwPyJbofxHc2o+z06Ui/kUFoAHR2gM4YivPl87rK+iunuDUGQsbHzeJv+QZVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783408030; c=relaxed/relaxed;
	bh=D0alyHRNn3bHlBUPf8UEhU1ORKl+yRMFH5glIFoQBY4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 Cc:From:In-Reply-To; b=SR1WhuKJ88FjeyxYJgY2Q6slARC3TV7ifegEG5IipK40duaKmCaxNN4IEqcr/yUbFT0p7FFwIIoF9h3zvH2AKacHuq7zE2619M+Stvra4ysAgvV7hbNVwfwvNzRrQwbkC+TOTYpUWb03ssIGl76zVvNM+bjfC3ostXeo8IsqeG/mfBTexi0tvaK1v5MxYCITsz5DXj+4lzWZ/1J9pWnaHhcMODjAMzF249SX5LuGB8WeVJ+ajeRtUvyvPGz7TLil4IMnuB5WmSt4DIlJFgKRYLNJHoj7TXLfElPWg1rPnftYiSFoZ+hkAcAfm/EUKSdtoZdMa+agc3zgaq8hl7+4vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kRJkxBzp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kRJkxBzp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvXNF6BhPz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 17:07:09 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6674InRV1631340
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jul 2026 07:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=D0alyHRNn3bHlBUPf8UEhU1ORKl+yR
	MFH5glIFoQBY4=; b=kRJkxBzpSLlYEBjbNNsbNAXy9i5kk/tRN/zQ/3qJqSiMD1
	50zf6BMzcHsyfXKI736eJemg9iuPOHlZ7UQ8q8ym/2pCDaNQmALfHMJlendO0fF3
	r5rILHpSw7N8qJMcbMJw6/Oe6NoQoP8vdt2UMV6gJOZzszrlZQx1dpqDAI1PiDXN
	Zh44i0Y8FOc9d4Nlqz67euWphaG9JIz/ZFryT+uh8gMTDhKAJN22Ft2fSc8Wqnrm
	TfG5NuULXYeZc+As9n/lMjF5fF2pTliM6Qf7+Y8FDWHGVvG7Ta9Vk1iEwCNbv6Xc
	AdiAO3+JL7+SCBgH1LQv1sZuBw7fP0NBBd12BA0w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsp2qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 07:07:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66774aCD010981
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jul 2026 07:07:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk1f03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 07:07:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6677721p48562528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 07:07:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1348F20049;
	Tue,  7 Jul 2026 07:07:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82D1B2004D;
	Tue,  7 Jul 2026 07:07:00 +0000 (GMT)
Received: from [9.67.174.189] (unknown [9.67.174.189])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 07:07:00 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------DDvA9Bl9Fi0k0055kNDkeYN2"
Message-ID: <1be96e32-ac9c-4160-9f2b-23eb29c22893@linux.ibm.com>
Date: Tue, 7 Jul 2026 12:36:58 +0530
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
To: linuxppc-dev@lists.ozlabs.org, Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260626123534.396456-1-shivangu@linux.ibm.com>
Content-Language: en-US
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260626123534.396456-1-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m0EsXGsPXBAP6s7ZabdvAx4CrZsfyWeW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfX/oAkgMv2zQpm
 Ed0jvNMJ8bCgnNG3ZsqhgO3pH7evoDcZ7ZlvnHnSKVMWioD43Q7QJaicmuv8FBJjd5VsVo3d1SF
 5PEB6iycUAEs1o4w+uZuquT4QTSO/7U=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4ca59a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=r77TgQKjGQsHNAKrUKIA:9 a=6jT34AcC9rcdydElSecA:9
 a=QEXdDO2ut3YA:10 a=VnNF1IyMAAAA:8 a=KdL_Wlk17mrYi_Q3vSQA:9
 a=p6pgkoT_UOwxKcN3:21 a=_W_S_7VecoQA:10
X-Proofpoint-GUID: m0EsXGsPXBAP6s7ZabdvAx4CrZsfyWeW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfX2+gOJ0dZ63xK
 0uHXhf1wMi64Md/0/JBPv415M4Ap2rqFkrNhsK7pausKRGcFce2edz7wee3XI3WpxbJTacWrmvu
 a/gVXSTM+d1nLEEvHOXxGD0MRGR2g1s35M7YDEZm+7X0ZmH8LRvZSRCKKRZhTvx35mAbzPmrc1m
 8uhN6wZ9iUDiMIJt8cvtQ3421y2yLSPRntvYkz+UaKRT7PhvWluzBuKNaeQrL4M/ZhOYjT766Ga
 9hWxE5n141EJISxPpG1vx7EWGqL4Xmq3aCVIC1Cjh2+fGckashayfclB7xTYYNFTHtCxUbeXQde
 7SfbTIzl2AS13O3Td2yACJRmwTwq2nUx+KDZkUCjr5yYj8XVmzX00S1UH/C/5vgypBAM0dLbF1G
 NgY7n8IHo4mvtjd8pyYVufP1GBRx75wVruloSsPWR+JRic8QlocVxLJPQAi/IxnvCZy5P9tVjDH
 MJmw4QlNGa9S/6tEj1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070064

This is a multi-part message in MIME format.
--------------DDvA9Bl9Fi0k0055kNDkeYN2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 26/06/26 18:05, Shivang Upadhyay wrote:
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

Hi Shivang,
Thanks for the v2 patch. This is a great optimization and definitely 
helps reduce unnecessary overhead. I have one small suggestion.

You can wrap the if (token_cache[token] == SUPP_UNKNOWN) check, as well 
as the if (token > OPAL_LAST) check above it, with unlikely(), since 
this function is in the hot path. Out-of-bounds tokens are very rare, 
and after the cache is populated, the SUPP_UNKNOWN condition is expected 
to be false in almost all cases. Wrapping these checks with unlikely() 
will help the compiler optimize branch prediction.

Thanks,
~ Nikhil

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
--------------DDvA9Bl9Fi0k0055kNDkeYN2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <div class="moz-cite-prefix">On 26/06/26 18:05, Shivang Upadhyay
      wrote:<span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
      cite="mid:20260626123534.396456-1-shivangu@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 1946dbdc9fa1..1e9cb5271ee7 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -1125,6 +1125,36 @@ EXPORT_SYMBOL_GPL(opal_flash_read);
 EXPORT_SYMBOL_GPL(opal_flash_write);
 EXPORT_SYMBOL_GPL(opal_flash_erase);
 EXPORT_SYMBOL_GPL(opal_prd_msg);
+
+/**
+ * opal_check_token - Check if an OPAL call token is supported
+ * @token: OPAL token number to check
+ *
+ * Returns 1 if supported, 0 if not.
+ */
+int64_t opal_check_token(uint64_t token)
+{
+	static u8 token_cache[OPAL_LAST];
+	enum {
+		SUPP_UNKNOWN = 0,
+		PRESENT,
+		ABSENT
+	};
+
+	if (token &gt; OPAL_LAST)
+		return 0;
+
+	if (token_cache[token] == SUPP_UNKNOWN) {</pre>
    </blockquote>
    <br>
    <p>Hi Shivang,<br>
      Thanks for the v2 patch. This is a great optimization and
      definitely helps reduce unnecessary overhead. I have one small
      suggestion.<br>
      <br>
      You can wrap the if (token_cache[token] == SUPP_UNKNOWN) check, as
      well as the if (token &gt; OPAL_LAST) check above it, with
      unlikely(), since this function is in the hot path. Out-of-bounds
      tokens are very rare, and after the cache is populated, the
      SUPP_UNKNOWN condition is expected to be false in almost all
      cases. Wrapping these checks with unlikely() will help the
      compiler optimize branch prediction.<br>
      <br>
      Thanks,<br>
      ~ Nikhil</p>
    <blockquote type="cite"
      cite="mid:20260626123534.396456-1-shivangu@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">
+		/* Do the actual opal_call here */
+		if (opal_check_token_call(token)) {
+			token_cache[token] = PRESENT;
+		} else {
+			token_cache[token] = ABSENT;
+		}
+	}
+
+	return (token_cache[token] == PRESENT);
+}
 EXPORT_SYMBOL_GPL(opal_check_token);
 
 /* Convert a region of vmalloc memory to an opal sg list */
</pre>
    </blockquote>
  </body>
</html>

--------------DDvA9Bl9Fi0k0055kNDkeYN2--


