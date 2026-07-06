Return-Path: <linuxppc-dev+bounces-23631-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966D6C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:59:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv4FZ12kCz3bp7;
	Mon, 06 Jul 2026 22:59:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783313763;
	cv=none; b=miINa3JFbM+vZCSLNT89Xwx5FFmo0yHbBe412PgIajyyuJ1tKVHPuXMbPtPEseQAWL3rSTcYm8zOrUrOYEQuKTmcexuJH611NtsEg1/5zll5ncnQGsEHco9JcJMEPtbqiEtviiy55OY41D9YI7yfFxxvxqzl0flC6igI3rc9MoPPgC6FbMTLTnSHn9jqwpYqXm4DjImnXe4lBapxPLXEHmqcQJr0wZVGyvA0VU3F1GrFmMe4I5IVRUVbsPPLQCInsqbeovnk334WtGzkgZ82tBl00f36TxwqkWorQBbHGj9CQ4ggxGOGTlJWPyWczxGxy8yEdl3LmqHI7ZUtV7ua2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783313763; c=relaxed/relaxed;
	bh=JvLKKEyLLlv8tWw8qJtzyelBHieDthun419uycWn1Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DT9VMTcWcMLlcRfuONzGKhr3ch3tjScVTHxCV61Hn4678rHXSkMOk5aCaqsqTkA+fjy4fVF/Ayvkaob3JG0ydJutMcnwRIeQXD/u0+XzwHBgEicbV0IJAbca+sedZma8NZQgI5CgDL0QFDdzR2N1sbCIRO/AVCi91EYmMMkyOLQQJEfkq0DE1XVUCpf2zBv9Kkp1f3Ly+B7E6GOakkZ7IB1WLpwd8uRn5LVoWs5KugrNRyaWcBV9hZYbkF1e0RcUH4NZg0lDe+eFp4l+0arRT3B/ieluuuGCib/I4MrRi2QQlNEmWCcFkVlC6C/GOntHOXVK9Vf5O8CmuoaX051vFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BtuYZphI; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S7K46m9g; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ekansh.gupta@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BtuYZphI;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S7K46m9g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ekansh.gupta@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtsWP4Gdyz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 14:56:00 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66642PwP3461233
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2026 04:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JvLKKEyLLlv8tWw8qJtzyelBHieDthun419uycWn1Dc=; b=BtuYZphIK7UnAPPa
	qYGHPuM+VD3C6WvezTLdqIjiYVGHLzNLv6RSapQqEJ2excDEyUkD/0AEcWQjp5ej
	4HI3bMiV8UCRYHw/YXMP72BUtTB2CANb5/xl2wJKaV5lc87Ax6wEFDsEhbUsTXur
	RNx2Hm91I1sPL4Fp17l4JFxQuB37ZPnouzzUHhLqbWpMJkm6xOuGNEQuSB8vkr4v
	iHs+mInjL3lcrCXDe3aaUW3MnfspbyT4APEA3ecMXRsbeK03HAVvm7fbyNR3ckpu
	4lDTqZIfECL8APV6bvyHqU87nPrqklBdw7zS2B0zT/os5ltI50S9QbhC5yDZwUWY
	z7D7UA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf847sh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 04:55:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37e5ef8299fso2307736a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 21:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783313757; x=1783918557; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvLKKEyLLlv8tWw8qJtzyelBHieDthun419uycWn1Dc=;
        b=S7K46m9gfIyDzi257J0GS95okhY4FFQ1pKrh5j0krcSz608idvdgGdn+86n9DnIh+7
         5cGFYRmn3by2cq7H/9rCKrm4W+SQlH52vCWJ7V8lA+JuOvFghEP5KBpKt8h5abGKljE8
         t8CHM+ZdQ6kff/1Ouv4dngDyNulw8JV/x6E9vDEl0kOIfJ6+2SWoeHwOcTXB9+rQ5tt8
         s6cNwZvD7Ogf2fx4MoyXW+tZdua0aDLHsGjE3sToIlk0v/4oYn/Zy7Q5DIhFpEwwsxRY
         LPrFkVMhQKMZjL4bafFbbFRPbkCc46GBUoD/0GnDXaBQU4yadPzt773xUwK4xuFty3/4
         6VRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783313757; x=1783918557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvLKKEyLLlv8tWw8qJtzyelBHieDthun419uycWn1Dc=;
        b=fgH6NLggRJ5uEIdiePyYMwh5CN8t/iLYhf3evHV5lBHDDxFT2RmmR5uo4gjblMM8KL
         taoVzP0TavwsjC8zPRsy6icSl/FkgjYWDfL73KgbE4V0ShG4XBHg0LQkC1FOr7yTWSzJ
         KJ6qY4XYnmp9ttV+rSr3KOuu6rJ7V8uTPoMn0WdKXcla0zPD4vxVAhtHZkaCjvaACIIG
         smswf4s4AkJGV7Uhm4adrypIkebmGXlfYsHxf3+/G2Q8+yID6WE5ZM6NBzgxVf9zc2EJ
         lDZnkFZbeTtzN+WRzxT5FvkV7vUX7P2T8VmTb5CFTA8KbsEk9rx2XxiHI1WV6CuQdlr3
         iqFg==
X-Forwarded-Encrypted: i=1; AHgh+RpiGidQ0ZAUoClpyqGmlbuhsYbGG0lQgNllNa9sJm9DIEZasAQDtddgwVbCohwRhq4ksSSyowhWzdTTqdo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxu9UsojORLPR/2zgv/r7cNAXV7NFebo4732D/RxcCpbC3drRqP
	6U7uqbn9QrGUvo6XHeQysvPn1p2NCxDF4PA9i+bjhyOxnicxCzZY9Mb7HwgpVtI1SEppKp1xqjk
	FNM0FotNTaM/GKYC5TJ9YjITdPwZkD3u/P6OO0GVe9C9qr/HeE24yetZiRT2bst4YeAtR
X-Gm-Gg: AfdE7cmnDbAEC2S8F7NShjwiPzspfbIzv0GttFzgXW3vwGGtYRzaHY4aGTDn+M0Hy5p
	WEnL2jLCR3f5G90vxG2hQoIkXV1iNXaMftoRVa243b3/a5+ks+mugdWUNwOgqkjLplaE3Rn6arB
	ywA3Rgd0KX5SJZRn5dJTGv8dyvzc43qQWNZakZNs4zkUDkNILRdpYDqrKwa+MoRxLiBI39zaKZC
	O2u2/I0vpdSHw8aQOkHNIqh2l+Ub/Iff6KEKW5vzB8qrxcTpPo7K0LXeFnCUQqEuNDE9as7dKI4
	1i8iyDrLw+C+mOH6/I5M4JZXhRecM50RZxctVk+eyPdDuV9buHNTzZV5Lt46I2c423NuMNK16n4
	L23MlnWeTRUk/6uD3brSumOQJ+zMleA3GTXee4g0e
X-Received: by 2002:a17:90b:35cf:b0:381:9b7b:35e5 with SMTP id 98e67ed59e1d1-382800d1a6emr8328725a91.4.1783313756495;
        Sun, 05 Jul 2026 21:55:56 -0700 (PDT)
X-Received: by 2002:a17:90b:35cf:b0:381:9b7b:35e5 with SMTP id 98e67ed59e1d1-382800d1a6emr8328696a91.4.1783313755987;
        Sun, 05 Jul 2026 21:55:55 -0700 (PDT)
Received: from [10.204.78.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3114fe08b1bsm12946548eec.26.2026.07.05.21.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 21:55:55 -0700 (PDT)
Message-ID: <95e8281c-91e9-4444-8b83-ea87243122c9@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:25:47 +0530
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
Subject: Re: [PATCH 40/42] misc: fastrpc: Use
 devm_of_reserved_mem_device_init()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        sound-open-firmware@alsa-project.org,
        Srinivas Kandagatla <srini@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <20260705194019.2565498-8-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260705194019.2565498-8-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aZbG6EWlv7UuI0PNTwBYNR2Iix2bUtmO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA0NSBTYWx0ZWRfX1FJaEvJjWbug
 4Py7guMuoEcF+nfv7zZRXY4UHhDB4YJFf7kCUEAQ+0J1K5hDTE2Guj16PwCzJHMm73RYDf0DcO0
 20MixPOKiMtESPKLSMWLQNUPk4o92Kg=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4b355d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ee02QKOXNWxg8IJ2rEsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: aZbG6EWlv7UuI0PNTwBYNR2Iix2bUtmO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA0NSBTYWx0ZWRfX1uicpppAkXr5
 ZkjLrdl9H8LHWcfmt3X/3QjJgB09AZLh2kxXwVOQWCJSI4NIEmBMl6IP7U5F8iDi+TJUTBzEMbs
 BnJ9E4NXI+/6yfdtnfoRamaMJ2D99OSROCijm6K7Ra9gQekNCA7xXIusBnwePXFOOBcWA0FxSQ0
 dRgQcOq8c+dTqGI9SZxQLsuz2bF0ABs81tdvuUszmzcRiWNH6B4ofPKWl6wxRlCY7kujAiqsQgL
 ZsxfgcKZ7dYdvijkz7ccnuojV9PJLzzK9Smba2cADZzuXUhW0S1yXqRy/lkKlcfbzDdeMKWhI1T
 CYKKnDHGNp4ILImXxrKtsmpLUDkvSxniXtmzGelp+m1XEj3+hilvZ3NgXVFEZn6qdWAzj7EEJI7
 5KB/tgZhYErOWY6AsuSmhe7C+mRQZFbnhPIEnaWA8R8bH93+lmN4j1gT7YAlsogSEMPbeOgrmNK
 CVIRsPq74g4TVkhW94w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060045

On 06-07-2026 01:10, Mukesh Ojha wrote:
> Use the devres-managed devm_of_reserved_mem_device_init() to ensure
> the reserved memory region is released on device removal, fixing a
> missing of_reserved_mem_device_release() in fastrpc_rpmsg_remove().
nit: I see this change is also fixing fastrpc_rpmsg_probe() early
failure leaks as well as -EPROBE_DEFER retry paths which could be added
to the commit message.

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d86e79134c68..c4e05b0db527 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2396,7 +2396,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		return -EINVAL;
>  	}
>  
> -	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
> +	if (devm_of_reserved_mem_device_init(rdev))
>  		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
>  
>  	vmcount = of_property_read_variable_u32_array(rdev->of_node,


