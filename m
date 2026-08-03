Return-Path: <linuxppc-dev+bounces-25217-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9019EC55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 03:22:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD26f48rvz308Y;
	Mon, 03 Aug 2026 13:22:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785727354;
	cv=none; b=Bx6FoYvjO12Xh/3/gcGEHaWOMxs+i5+lpp2SuHtSq2MdeuEIypm5ogkdc92AIwVP0MkZJbmyITPXJ/zV93YK88BqilK0LDTnOsvvGLWfhaA/RJtHgzXazEc+Q1a/RIrTTMKiALCkRW+B6J/VKspIWx83t4k7q4Ab8Itl3c/N+dN3JktPKwGT3wEwnlMZKVFHtQgD5KMSVIf7ICc9i0URwcfvFXpYeVjppVjshgEsqMtflYw4wpOdWPm5jzZzlM8+kwUag74Uf8Z76p4MrL6aGPNjms+klTbG3mrbUyWE7/jtsRha7UdAsQDpDrzppQkoFLMcHamLOEElvlaDQoryXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785727354; c=relaxed/relaxed;
	bh=yzSt6hMrh3RSLncc9Cm4Xwrm2EvteSJyHV/NHU+icFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GxcqMYuOtTOVvdoV+Gdm6p3cNCv4TzFolNoKTYWH+zJGD4HsEcQby+cWJqSoaMv96UNnK3b7AOgFmHBUyD3VheU1QazqnmjNkxuzldzzCSSkQiK/RMZXn/2/GinkOpn+wTLMq/hiRV67Nqp0yMqXFHZS7ZuPvtgginwfMXNQdaSBpiTC0u6eAcajvHEY6A+xNp+mu5Dco9rD8Ii4VShRoQL75LTmHSb3U/C6Q4112DEbtKJahSz6eSY7m3unZgUObl9QFMFWYMwtEni3+OFPvz8qhOCV4a/HSn5N8hXdZaRAdh8viOMQqMqDMNoYgSZzkDp7tTZQxyZKyBuD065f1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tN3qr65c; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tN3qr65c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD26d3xFZz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 13:22:32 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672MpRGA281016
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 03:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yzSt6h
	Mrh3RSLncc9Cm4Xwrm2EvteSJyHV/NHU+icFc=; b=tN3qr65cLNL+poEzoLtgne
	Bw4V6X8mAj72uyXPjzeYI8zdGSXGpwIf77PSVDWSLGUSp5GDEh0nxR5YagOAjE/1
	e4Vnphu8V/d7MKfKdypFC4NAYncR85RptSKJhgcjaf1rK3nsPuGt2N6LcoM+A1ZH
	WxJeEYS5FX9uyZAtMg9gYydTBFG6Ya+WxeS0CWx3tTvYF+vlpM4wZINOapFtQb6S
	JFQrdJi8lBvCOYoU8yx625kUET5ceSxLEi+M57J5D+RjBiAIr5ZGh4+2C5NQECaX
	vNWMJW2auimS6ciGEEvfpHmIxAuEtjTpuFEJ5WiB3Wow2mfYauimTtSKDoUS3sxQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hemh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 03:22:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6733BG2i021610
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 03:22:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4juhfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 03:22:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6733MQYc7209370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 03:22:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB0C720043
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 03:22:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 144AB20040
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 03:22:26 +0000 (GMT)
Received: from [9.67.71.90] (unknown [9.67.71.90])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 03:22:25 +0000 (GMT)
Message-ID: <181d7792-08f8-4cf2-9490-249de89a2428@linux.ibm.com>
Date: Mon, 3 Aug 2026 08:52:24 +0530
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
Subject: Re: [PATCH 1/4] powerpc/pseries: Limit PVR list to 16 entries for CAS
 negotiation
To: linuxppc-dev@lists.ozlabs.org
References: <20260729145405.3230272-1-mahesh@linux.ibm.com>
 <20260729145405.3230272-2-mahesh@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260729145405.3230272-2-mahesh@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAyNSBTYWx0ZWRfX3szlcW1OKDsj
 tKhoh1a8CyI/ylc3ylHwPip0tiobIOqo5WuH/XaSarWeObWy+GcI/ea9QC9NIlU/nUMYMdcXY2l
 osy74NEWUSQG6hh59BTTW9bBAaYnb6A=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a700975 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=hIFiSi9fJzWY2G4LvAcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAyNSBTYWx0ZWRfX0q1ZksqCj4B8
 rGlCdrgYRA6tq2sXc7pYSH0iFEmsTy8l6zo3c2IoKfJER4JcA//dMCg+dAimXTGxMhJq1FTcMR+
 t/i+VXXnlJzWqW1VCsIU/P2OYmeF0ZtnDAguCCILp3Bn8cd5+iE3O/muCCq3IxQzU+TGjdEGa5t
 W3Ftc3bHQm9Koud9QTb/IGkg1+bKuUVhKE7GF2BF5ppSWaQ5tkji4JRIIaak4DkgYlhfjdkRMiA
 8DvUwPxKyrcmbPDuXfSJIxm9SQxyWbENEu9jzHYEAXX+C6NnMyoEYD4ENQ+Ta9C2HfIsJ9e8hHv
 jQDBL0HSE+HGKnWqN0tFSkenEYlujA0rmHDTloIEBHtKkEUcvf0+x7AbnIyX2zLaGUjFTs6TEPu
 0Xce5AviGKHgvdzDQ5Lq+bssr/AN1i+tqZ5RfKoEGeMFImjnD90XB/tO7liH/LHNHH/ZXLim+LX
 yaRLroN79Kem8ooqcpw==
X-Proofpoint-ORIG-GUID: BYL20RD7WrvMeUwRQCCG2xIbk90naYeN
X-Proofpoint-GUID: BYL20RD7WrvMeUwRQCCG2xIbk90naYeN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030025



On 29/07/26 20:24, Mahesh Salgaonkar wrote:

> +	if ((ARRAY_SIZE(ibm_architecture_vec_template.pvrs) > 16) &&
> +	    (PVR_VER(mfspr(SPRN_PVR)) <= PVR_POWER11))
> +		start_index = ARRAY_SIZE(ibm_architecture_vec_template.pvrs) - 16;



Hi Mahesh,

The literal 16 appears twice. Please define a named macro,
e.g.: #define CAS_MAX_PVR_ENTRIES 16

Thanks,
~ Nikhil

