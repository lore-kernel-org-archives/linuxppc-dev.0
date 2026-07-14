Return-Path: <linuxppc-dev+bounces-24191-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD327C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 08:05:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzsLk1Scpz2y7W;
	Tue, 14 Jul 2026 18:05:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784016350;
	cv=none; b=DVML+ypUYxTGxh32c1fcBgwkygMcmGWkBhBhp6hVw7UTZC9Eujdm9CUOLmNhSvDpShbWyqA6n3wib6JF97ZHrVEA5PVWMXcPajQQMDGpT2qU3SQCu2EBLV9AZ9sJROmgg6FilXM9OZ6mp/ui1S0Uq3YyCOiuBMoVKzK2KQpKh/DkH1YkR43I5trmXw308bcGSlUncmO3kZZsaKFR52c4AApDi1vTO3FUPVauJ00tbP+3+0H1cYoqCZokOdtav5QDLenkusY4Rj/kqdw0QGGDaj0BFsB9itYIKPHyk4DlvS0iI8Yujq2IGWF0Pke0EFQ2LkO1gxb44egeodzrb7qlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784016350; c=relaxed/relaxed;
	bh=Wllpo+Ct2E0PJkevq3rM61R6xvtSI8oIVPJOoNCBdyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWlnT+bzko87S7bOqAfu1Zj/D8a+2XkNFtFa9j8jXRBSfioGZQgWRATydqou3Jo0jciUyLFnBio0+kMIzSLvkE5GKr7HaelF2QQgnNlZciXWvoSSmevxaCwH4MPmwUp1qvqboem/zygRqaz7OELqP67F+BdRY7zXcNbBdYZxS++WbF1ZA3m+yRZnhzmKEhUkNp35RXHJLwPdP5wTrB7syiivCBab2VN2NslObVdltT6q8Nnw4yHsEUWeg8pDh33AeZbaak/ulyQhCxhPEhqnfr/tW8/3x2QCGdqMeFY+m3y2Et6imXBSP8+UxPi7QOwpw7MxZ8mGA8FY8aXn857V0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BlpYMD2e; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AxhrMegb; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=srinivas.kandagatla@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BlpYMD2e;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AxhrMegb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=srinivas.kandagatla@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzsLg6ynjz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 18:05:47 +1000 (AEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6SS1B3740539
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 08:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wllpo+Ct2E0PJkevq3rM61R6xvtSI8oIVPJOoNCBdyk=; b=BlpYMD2eAEdD3amM
	uVrb7n3swLYHkr2oSD1CFHrBa78CpTbdZviu8NHrZzAKapoYBasmUuK2H+Ykeelb
	b7tqxWY5iHwfbwM4WkXOh9Be8Zw9qGTW9VwN2R1l0e33F52tID1q079i+O4weyeR
	WbihyXu3wHm9juJcFx1KtHNICSwaNm3EPDnqy5g1ktLU/NjJFdLK30Cm9OUFsEKy
	ySvIrYdEMbMOHHBKwOY96dy/lLYQ6/8NCe0knWm/YR3e8m/WkEngy76H/Kz3U1lL
	nS4Deg4EVUQTuZq4wYUUyPZ6z3oMjpWF1UIKqBEwb7Xt9Q+GMKa3D9M0sB1/YDpp
	gMTWEw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdde08yf6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 08:05:43 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f0c46bfb6dso78720666d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 01:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784016343; x=1784621143; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wllpo+Ct2E0PJkevq3rM61R6xvtSI8oIVPJOoNCBdyk=;
        b=AxhrMegbU0nU+amwZEi7pKjZ4T6pPgcAtABxwD884+f4cfYgSKmNlBRsifbuY3hIp0
         Tj5mgKDHrFC5fFWK5GpdDCk3LAZ8NAJLn0h9OJ9NW5bn6RloHtS79YgWm0ckSm4eB4vn
         t0A1Ydtc6HbG2Gd15yxFecJncuP0bUniGJ6J/sQgLNa6cVuHwJyMzdqdAkDBNkyuFYtL
         NZPL1uin5B/yAqpvYrrUC8JE1MMIr9BcjQ2KuhpWFBrNxpEdaa7IZazqSHiUbp0B6FGJ
         8D0aPY8jKGEpa6UOV8ITADurjCd7bqoczYzmIrciNUBeoQpjTYjgv6Haeir2UtOw98lp
         E6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784016343; x=1784621143;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wllpo+Ct2E0PJkevq3rM61R6xvtSI8oIVPJOoNCBdyk=;
        b=ZBqNuCltYKByvMnua1paC4Yg3hPqzKQIO+wuWN5h2UxEhpvnc6TKc8YsvneJ5/gaqL
         L0POLVvYi8mPL/LLhXco8khA4f5rHoj8RiGy8G4ztvm7AFvY+WRBnuliDvGT1HlF/q/T
         7lEaci8ljVxVvURM+gk55ZRMviYeBKjLDBpKFOaNsi4FlM1hGiiUR6z9qTf+piVDsUGm
         SyyRnvPjhTg2eMFL00PQz+iPyqaM2AsFOaupnrckQwX7JDimvdLhYi9p8y9cGBEI+FWb
         3anVB8Yc8SNaNt0ycsK2FgYqYpWJC5C2JaNrBgdObxsMGrdDnSRt6Ndxuzz/gH+2uvFC
         +pCw==
X-Forwarded-Encrypted: i=1; AHgh+RqpdDER2+JIu/F1tolW+HYGG0wiBPTpj94AMg1nEZIokWEhJwLnhcz4lhDGmi5d86aiemJfjaXZ2IFyxCg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzUsojNswtlOeQN6o/S7V+NFJIJWDuJdCsAdylTgLvxcMg/yEPW
	0RLff31FLgmwit1Ik44QX0TAV9MK+j2VEzEoXMEPw2xAurhm2Xk7AU3RtNGDDaAf2e2+9LR/vpg
	NB79feYDDt7dnm+4giMtbdGSO1mCbIkUi1FTBVN5qmGlUKLrpbYGnrpzKbqeD3wVN/EvT
X-Gm-Gg: AfdE7clfbpleDq/lPg43xEJaFic/oNTbiccPOlWiCqp5Pgx96XI5JfrjEPSe6E38Dvm
	8UqZomD2rD/0FfVfUiI14RYG0iJb/IQ2k58UFTBOEzTT4UQTm7u4kJB0JwwNLhXlnwT7PZx5lew
	krQbhI8xs8l+NnDQkrisAYFm1/lPxz6r1ik4SLH0V6QUkr2Yaw14qPvmTn3iRABNHHcGvKtgcqz
	Sd87+PrMNvhQq/GowYzPs93GuqOrfvXZZWb4q1KqqQj0TmGjaI301dEApuemCBUPcKrKdCGqMjg
	CAGyIVpSgNP/DA/5DHIafRfkzq8PhR13XBNsmhW+NijGnIhY2KCSXuIGLzyaYz/GiHGZjNhTbmw
	Y3PKFtBbOzOlmESRf6xsqk/Y04mn6AqfSjxqdzg==
X-Received: by 2002:ac8:6f12:0:b0:51c:730:a587 with SMTP id d75a77b69052e-51cbf2ee752mr123336331cf.63.1784016343286;
        Tue, 14 Jul 2026 01:05:43 -0700 (PDT)
X-Received: by 2002:ac8:6f12:0:b0:51c:730:a587 with SMTP id d75a77b69052e-51cbf2ee752mr123336101cf.63.1784016342931;
        Tue, 14 Jul 2026 01:05:42 -0700 (PDT)
Received: from [192.168.68.109] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c1665727517sm53979966b.30.2026.07.14.01.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 01:05:42 -0700 (PDT)
Message-ID: <3492f6ff-84c2-4694-a677-500320cf1f5f@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 09:05:41 +0100
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
Subject: Re: [PATCH 13/14] ASoC: qcom: audioreach: use C-style "/*" comment
To: Randy Dunlap <rdunlap@infradead.org>, linux-sound@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        Charles Keepax
 <ckeepax@opensource.cirrus.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        patches@opensource.cirrus.com, Srinivas Kandagatla <srini@kernel.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <20260714014445.569992-1-rdunlap@infradead.org>
 <20260714014445.569992-14-rdunlap@infradead.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20260714014445.569992-14-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA4MiBTYWx0ZWRfX1nfZGEb9BEtx
 1tF5Kp2pj2zZUwtXsesGuBB4go8FUxiAPXo5CeCQuxNDSWYRrMPbI+7chF8bI7ulOHQqphqwqLc
 +qlZH9exvBD8Yq7j8aT/YNThyhOT5Ko=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA4MiBTYWx0ZWRfX+4vh1BKzUio6
 n+O5JM9djhSjQ8Z1GEOGgxwzcRLvg2Q7zAPhg+Ju1Low39InF+naOfC+1LA2CqkiVQzegDrJFyo
 AosdtavdMYLdpndbnkjLeAb3+xn19R1K/9DrHICZ1SM3aFpFdyNYQ0ICfObTNuePpbV8nfEJtRV
 LR/oMMoKETEppAAqlKlgXI7lZAlJthlTaxxWRlUkzJn5tO2Gzb8GRLayyCfluVTw2CwfBQyEHH6
 U0bwgR/33QxIzVwTgjtlnN+SGl4eKP1+JzNiETl/H9GVOHK3Y0QaUTS73GV5qzwUU24WTbpHgMN
 tCQCcLZsJu1q62yUsVWsJMM97h2k39vXNdUkjmwuIVBieaWUWRNmZcw9zh6Cz/YLiueotX/3GVp
 Q+J1ll4SDqk/jmyG7fgnd4Q3o0Evw/RSi9GF8626X1hZ847P5iDNn3F35/zE6qLABgsm5yC/Tkz
 KqHSrfF3zUgBeajMbvw==
X-Proofpoint-ORIG-GUID: pbrAIhncl7LGhYBr8m81Acs0Fr4Ml5d_
X-Proofpoint-GUID: pbrAIhncl7LGhYBr8m81Acs0Fr4Ml5d_
X-Authority-Analysis: v=2.4 cv=F/FnsKhN c=1 sm=1 tr=0 ts=6a55edd7 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=7jdjDwPJLlZbICA8FagA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140082



On 7/14/26 2:44 AM, Randy Dunlap wrote:
> Modify the "/**" to use "/*" instead since this is not a kernel-doc
> comment. This avoids all kernel-doc warnings in this header file:
> 
> Warning: include/uapi/sound/snd_ar_tokens.h:61 Cannot find identifier on line:
>  * %AR_TKN_U32_SUB_GRAPH_INSTANCE_ID:           Sub Graph Instance Id
> Warning: ../include/uapi/sound/snd_ar_tokens.h:62 Cannot find identifier on line: *
> Warning: ../include/uapi/sound/snd_ar_tokens.h:63 Cannot find identifier on line:
>  * %AR_TKN_U32_SUB_GRAPH_PERF_MODE:             Performance mode of subgraph
> Warning: include/uapi/sound/snd_ar_tokens.h:64 This comment starts with '/**', but isn't a kernel-doc comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

--srini
> ---
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Srinivas Kandagatla <srini@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> 
>  include/uapi/sound/snd_ar_tokens.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linext-2026-0710.orig/include/uapi/sound/snd_ar_tokens.h
> +++ linext-2026-0710/include/uapi/sound/snd_ar_tokens.h
> @@ -58,7 +58,7 @@ enum ar_event_types {
>  #define SND_SOC_AR_TPLG_FE_BE_GRAPH_CTL_MIX	256
>  #define SND_SOC_AR_TPLG_VOL_CTL			257
>  
> -/**
> +/*
>   * %AR_TKN_U32_SUB_GRAPH_INSTANCE_ID:		Sub Graph Instance Id
>   *
>   * %AR_TKN_U32_SUB_GRAPH_PERF_MODE:		Performance mode of subgraph


