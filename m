Return-Path: <linuxppc-dev+bounces-28177-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7133BC9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 06:48:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrhB205Yrz2y2J;
	Fri, 25 Sep 2026 16:48:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790318921;
	cv=none; b=coUIGzIDCdv98skLvPct0a2Udgm70Lma81zuspD8pHMlWtzbfSvvSCbOC5+F1Uge0hPfJchxrGwCeDP2CDF7/NLC+YZ6B6nfzyyDArIN6FrNsmX1V4dAwE+hGEWKJhfe1E3hMxGES8lWzCRzm1vGcKbDiEdKQT69nP+DHohM7LkEs6uuCkE0Dae1GhGc9DkPTxqcWHKP3Sq+fqg+QFgtFEQugvu+pW+2ezmxo7aMwAgfIdFwfiWK5It5qD6OhlaOa472hh5rvsTISlwkg6yg86Y9AgJiN7ytPn5CQ2LEhSDl551a9uc7vO5604/0p6H0YcgtJTery3ENH38iMZhf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790318921; c=relaxed/relaxed;
	bh=BaD1WhIvjbYFRzWbPP4r9VA6M2K53iLy5ER309mNOZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccW5rbspEdGk8pWHkBlIMIcCbyjpBIqx8855AVxkqqaYpu1xpFsHNJFgzQ8UoOGRJt24Jq50xv2T9b2E4mgkgFvkkDBayf3zdxXW3xpV4UI3YYbQSl9Zydl0WTyKDkNFVtzjAJPE0BiJFBMbIVUC/VnEWd4xt0yNP8HimUtSpMwc1vBuoCfXrjd2iTQ4gWN6rWLS3Ea8XzjHZUhUR3keohymGDxEwBG/aYMsYS6JcwbTjWyAv2IMsNJkrDhg5fCCcQKo8n/WREylYltwu9ULVLwtNWdd5QrKfBCuktlyqtaq7CUTMSUx0/y3szCwWxqEhP49p5ITy3yfFuGfBIEJYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YlMuo9gm; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YlMuo9gm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrhB05nKbz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 16:48:39 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4adX0103282;
	Fri, 25 Sep 2026 06:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BaD1Wh
	IvjbYFRzWbPP4r9VA6M2K53iLy5ER309mNOZg=; b=YlMuo9gmrDhjJTECS1G6Cy
	iuzFyytDFZTkii24z1zg1RnOSRyUTkPOI+7Y+tEhdxalmHEm/skXx/dayj0qo5FA
	EVQ/ioIDZt5102H3CPA8/dsl4WiSAU3/fhw1h0U0f04BaVT8BLcPh5AkiFRU2Az1
	3QMjXh8VGUWmgH+XAQo0lckf8nAf9ojfNI/wJH92wA1tJYYlEc8UVeb3xBNREHNM
	LqM0ZZmL4ebbZwgu9LS84DB7KlRy0X0vNX1RNsUMYn+d68wAx/stbZ8f2vXGLkTM
	Ea9hKTDUqKyZf7UzY0hRGObOM4dexd+jsTUmZnzW0SIM3xWcjesKq4A8GS0TCIPA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvmqj6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:48:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lSpl3296974;
	Fri, 25 Sep 2026 06:48:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qsdub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:48:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P6mJYw38994380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 06:48:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72DBD20043;
	Fri, 25 Sep 2026 06:48:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BEB420040;
	Fri, 25 Sep 2026 06:48:18 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 06:48:17 +0000 (GMT)
Message-ID: <ff767954-a8c0-49eb-94f1-8f0b9419498c@linux.ibm.com>
Date: Fri, 25 Sep 2026 12:18:17 +0530
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
Subject: Re: [PATCH] powerpc/rtas_flash: Use scnprintf() in
 rtas_flash_read_num()
To: Thorsten Blum <thorsten.blum@linux.dev>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260722162816.156697-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260722162816.156697-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ZHsTgbjEkx9uYEU5MSnOXzYIyEqAjbsE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfX9fZkFfv+NLUS
 7uKtXC8iliOVpFFxCNnN2hjmYq5RR4r2LXd7Ypc8gUxXDyP1lpVR8du94Nnha9UFGU+kaP/fWso
 pM3IKUPwg6BsIRcXgM65lrD+unMHbL0=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab61936 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=NKNl3_LDKE-7nIAXPEwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tK6TSA63-ryta480CZLHU9GUv3hCqT1W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfXyLEUhadzr0KZ
 9hOMEpbLS1kGWJ+aZ1w6WmSUSqWr1ka8ayB++9JT7yu53nlhGgaSFHtiNEbCbceCxjP2gOJ/ose
 FTU10w8HlYojTiRHh99dHMNhlHY4QK7BmNPtAk4PXhagzQqk10TaJt5mAetyVTV/Ig+QY5CJWzw
 nE/8sp8EQkmiZAsjYyJZ8HiurhEFwKOxzj9Xh6ckzQHwn1QXQqTrY2cL3IWAW0N3q0oyHYU0PTl
 4jTLUGjvUvC2zKTsG2t5u5FqPj8GjeLOtilJAYumbarENEil2d8hEc/SwkhdC5YLL6JCI+PJWRR
 aT98Ns52DQBo7q4wrfsAB2Qu7BsrvCYCF48ZDyKW3L7Dt1iUHxlbYD8EOOAzCVKZGNMDNgjRAsj
 B0ADcq7bIG4PBhS/7Iw57bXdCvOQb4rpzUrXCVTAqjc5Evzn1xM2sj6F2UXKmzzC1NAKOBKxoch
 viyN3i1KxBEW6rSj8cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250026



On 22/07/26 21:58, Thorsten Blum wrote:
> Use scnprintf() and its return value to avoid a separate strlen() call.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   arch/powerpc/kernel/rtas_flash.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
> index 583dc16e9d3c..aff8a67e274f 100644
> --- a/arch/powerpc/kernel/rtas_flash.c
> +++ b/arch/powerpc/kernel/rtas_flash.c
> @@ -291,6 +291,7 @@ static ssize_t rtas_flash_read_num(struct file *file, char __user *buf,
>   {
>   	struct rtas_update_flash_t *const uf = &rtas_update_flash_data;
>   	char msg[RTAS_MSG_MAXLEN];
> +	size_t len;
>   	int status;
>   
>   	mutex_lock(&rtas_update_flash_mutex);
> @@ -298,8 +299,8 @@ static ssize_t rtas_flash_read_num(struct file *file, char __user *buf,
>   	mutex_unlock(&rtas_update_flash_mutex);
>   
>   	/* Read as number */
> -	sprintf(msg, "%d\n", status);
> -	return simple_read_from_buffer(buf, count, ppos, msg, strlen(msg));
> +	len = scnprintf(msg, sizeof(msg), "%d\n", status);
> +	return simple_read_from_buffer(buf, count, ppos, msg, len);


Though there is no real buffer overflow issue here, it is a good idea to
convert sprintf to scnprintf. This change helps avoid calling strlen on the
same buffer.

Changes looks good to me. Feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>


>   }
>   
>   /* We could be much more efficient here.  But to keep this function

